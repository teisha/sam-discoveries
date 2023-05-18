const fs = require('fs');
const path = require('path');
const esbuild = require('esbuild')

const functionsDir = 'sam-disco-lambdas';
const outDir = 'dist';
// const entryPoints = fs.readdirSync(path.join(__dirname, functionsDir)).map((entry) => `${functionsDir}/${entry}/index.ts`);
const entryPoints = ['index.ts'];

esbuild.build({
    entryPoints,
    bundle: true,
    outdir: outDir, // path.join(__dirname, outDir),
    // outbase: functionsDir,
    platform: 'node',
    sourcemap: 'inline'

})

