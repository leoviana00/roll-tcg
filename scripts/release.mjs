
import fs from 'node:fs';
import { execFileSync } from 'node:child_process';

function git(args) {
  return execFileSync('git', args, {
    encoding: 'utf8',
    stdio: ['ignore', 'pipe', 'pipe']
  }).trim();
}

function setOutput(name, value) {
  if (process.env.GITHUB_OUTPUT) {
    fs.appendFileSync(
      process.env.GITHUB_OUTPUT,
      `${name}=${value}\n`
    );
  }
}

function compareVersions(a, b) {
  const left = a.split('.').map(Number);
  const right = b.split('.').map(Number);

  for (let i = 0; i < 3; i++) {
    if (left[i] !== right[i]) {
      return left[i] - right[i];
    }
  }

  return 0;
}

function getRepositoryUrl() {
  if (process.env.GITHUB_SERVER_URL && process.env.GITHUB_REPOSITORY) {
    return `${process.env.GITHUB_SERVER_URL}/${process.env.GITHUB_REPOSITORY}`;
  }

  const remote = git(['remote', 'get-url', 'origin']);

  return remote
    .replace(/^git@github\.com:/, 'https://github.com/')
    .replace(/^https:\/\/[^@]+@github\.com\//, 'https://github.com/')
    .replace(/\.git$/, '');
}

function main() {
  const config = JSON.parse(
    fs.readFileSync('version.json', 'utf8')
  );

  const version = config.version;

  if (!/^\d+\.\d+\.\d+$/.test(version ?? '')) {
    throw new Error(`Versão inválida no version.json: ${version}`);
  }

  if (version === '0.0.0') {
    console.log('Versão inicial 0.0.0. Nenhuma release será gerada.');
    setOutput('release_created', 'false');
    return;
  }

  const tag = `v${version}`;
  const tags = git(['tag', '--list'])
    .split('\n')
    .filter(Boolean);

  if (tags.includes(tag)) {
    throw new Error(`A tag ${tag} já existe. Release cancelada.`);
  }

  const semanticTags = tags
    .filter((item) => /^v\d+\.\d+\.\d+$/.test(item))
    .sort((a, b) =>
      compareVersions(b.substring(1), a.substring(1))
    );

  const latestTag = semanticTags[0];

  if (
    latestTag &&
    compareVersions(version, latestTag.substring(1)) <= 0
  ) {
    throw new Error(
      `A versão ${version} deve ser superior à última versão publicada ${latestTag}.`
    );
  }

  const range = latestTag ? `${latestTag}..HEAD` : 'HEAD';

  const commits = git([
    'log',
    '--no-merges',
    '--format=%H%x09%s',
    range
  ])
    .split('\n')
    .filter(Boolean)
    .map((line) => {
      const separator = line.indexOf('\t');

      return {
        hash: line.slice(0, separator),
        subject: line.slice(separator + 1)
      };
    })
    .filter(({ subject }) =>
      !/^chore\(release\):/i.test(subject)
    );

  if (commits.length === 0) {
    console.log('Nenhum commit encontrado. Release não será gerada.');
    setOutput('release_created', 'false');
    return;
  }

  const repositoryUrl = getRepositoryUrl();
  const date = new Date().toISOString().slice(0, 10);

  const categories = {
    feat: '✨ Funcionalidades',
    fix: '🐛 Correções',
    docs: '📚 Documentação',
    refactor: '♻️ Refatorações',
    test: '🧪 Testes',
    build: '📦 Build e dependências',
    ci: '⚙️ Integração contínua',
    chore: '🔧 Manutenção',
    style: '🎨 Estilo'
  };

  const grouped = new Map();

  for (const commit of commits) {
    const match = commit.subject.match(
      /^(\w+)(?:\([^)]*\))?!?:\s*(.+)$/
    );

    const type = match?.[1] ?? 'other';
    const category = categories[type] ?? '📌 Outros';

    if (!grouped.has(category)) {
      grouped.set(category, []);
    }

    grouped.get(category).push(
      `- ${commit.subject} ([${commit.hash.slice(0, 7)}](${repositoryUrl}/commit/${commit.hash}))`
    );
  }

  let releaseNotes = '# ROLL TCG — Changelog\n\n';
  releaseNotes += `## ${tag} — ${date}\n\n`;

  for (const [category, entries] of grouped) {
    releaseNotes += `### ${category}\n\n`;
    releaseNotes += `${entries.join('\n')}\n\n`;
  }

  const changelogPath = 'CHANGELOG.md';

  const previousContent = fs.existsSync(changelogPath)
    ? fs.readFileSync(changelogPath, 'utf8')
        .replace(/^# ROLL TCG — Changelog\s*/i, '')
        .trim()
    : '';

  const finalContent =
    `${releaseNotes}${previousContent ? `\n${previousContent}\n` : ''}`;

  fs.writeFileSync(changelogPath, finalContent, 'utf8');

  setOutput('release_created', 'true');
  setOutput('release_tag', tag);

  console.log(`Changelog gerado para ${tag}.`);
  console.log(`Última versão publicada: ${latestTag ?? 'Nenhuma'}`);
  console.log(`Commits incluídos: ${commits.length}`);
}

try {
  main();
} catch (error) {
  console.error(`Erro durante a geração do changelog: ${error.message}`);
  process.exitCode = 1;
}
