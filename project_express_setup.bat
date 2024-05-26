:: @echo off
setlocal enabledelayedexpansion

:: Ask for the file path
echo Enter the file path where the application will be created:
set /p app_path=

:: Ask for the application name
echo Enter the application name:
set /p app_name=

:: Create main directory
mkdir "%app_path%\%app_name%"
cd "%app_path%\%app_name%"

:: Create subdirectories
mkdir public public\api public\scss public\src

:: Create files with the specified content
echo Creating files...

:: server.js
echo const express = require('express'); > server.js
echo const cors = require('cors'); >> server.js
echo const path = require('path'); >> server.js
echo const app = express(); >> server.js
echo const port = 3000; >> server.js
echo app.use(cors()); >> server.js
echo app.use(express.static(path.join(__dirname, 'public'))); >> server.js
echo app.get('/', (req, res) => { >> server.js
echo ^  res.sendFile(path.join(__dirname, 'public/index.html')); >> server.js
echo }); >> server.js
echo const server = app.listen(port, () => { >> server.js
echo ^  console.log(\`Server is running on http://localhost:%port%\`); >> server.js
echo }); >> server.js
echo if (module.hot) { >> server.js
echo ^  module.hot.accept(); >> server.js
echo ^  module.hot.dispose(() => server.close()); >> server.js
echo } >> server.js

:: .babelrc
echo { > .babelrc
echo ^  "presets": [ >> .babelrc
echo ^    ["@babel/preset-env", { >> .babelrc
echo ^      "targets": { >> .babelrc
echo ^        "node": "current" >> .babelrc
echo ^      } >> .babelrc
echo ^    }] >> .babelrc
echo ^  ], >> .babelrc
echo ^  "plugins": ["@babel/plugin-transform-modules-commonjs"] >> .babelrc
echo } >> .babelrc

:: tsconfig.json
echo { > tsconfig.json
echo ^  "compilerOptions": { >> tsconfig.json
echo ^    "target": "ES6", >> tsconfig.json
echo ^    "module": "commonjs", >> tsconfig.json
echo ^    "strict": true, >> tsconfig.json
echo ^    "esModuleInterop": true, >> tsconfig.json
echo ^    "skipLibCheck": true, >> tsconfig.json
echo ^    "forceConsistentCasingInFileNames": true >> tsconfig.json
echo ^  }, >> tsconfig.json
echo ^  "include": ["./public/api/**/*.ts", "./public/src/**/*.ts"] >> tsconfig.json
echo } >> tsconfig.json

:: webpack.common.js
echo const path = require('path'); > webpack.common.js
echo module.exports = { >> webpack.common.js
echo ^  entry: { >> webpack.common.js
echo ^    api: './public/api/api_base.ts', >> webpack.common.js
echo ^    base: './public/src/base.ts' >> webpack.common.js
echo ^  }, >> webpack.common.js
echo ^  target: 'node', >> webpack.common.js
echo ^  output: { >> webpack.common.js
echo ^    filename: '[name].bundle.js', >> webpack.common.js
echo ^    path: path.resolve(__dirname, 'dist'), >> webpack.common.js
echo ^  }, >> webpack.common.js
echo ^  module: { >> webpack.common.js
echo ^    rules: [ >> webpack.common.js
echo ^      { >> webpack.common.js
echo ^        test: /\.ts$/, >> webpack.common.js
echo ^        use: 'ts-loader', >> webpack.common.js
echo ^        exclude: /node_modules/ >> webpack.common.js
echo ^      } >> webpack.common.js
echo ^    ] >> webpack.common.js
echo ^  }, >> webpack.common.js
echo ^  resolve: { >> webpack.common.js
echo ^    extensions: ['.ts', '.js'] >> webpack.common.js
echo ^  }, >> webpack.common.js
echo ^  node: { >> webpack.common.js
echo ^    __dirname: false, >> webpack.common.js
echo ^    __filename: false >> webpack.common.js
echo ^  } >> webpack.common.js
echo }; >> webpack.common.js

:: webpack.config.js
echo const path = require('path'); > webpack.config.js
echo module.exports = { >> webpack.config.js
echo ^  entry: { >> webpack.config.js
echo ^    api: './public/api/api_base.ts', >> webpack.config.js
echo ^    base: './public/src/base.ts' >> webpack.config.js
echo ^  }, >> webpack.config.js
echo ^  target: 'node', >> webpack.config.js
echo ^  output: { >> webpack.config.js
echo ^    filename: '[name].bundle.js', >> webpack.config.js
echo ^    path: path.resolve(__dirname, 'public'), >> webpack.config.js
echo ^  }, >> webpack.config.js
echo ^  module: { >> webpack.config.js
echo ^    rules: [ >> webpack.config.js
echo ^      { >> webpack.config.js
echo ^        test: /\.ts$/, >> webpack.config.js
echo ^        use: 'ts-loader', >> webpack.config.js
echo ^        exclude: /node_modules/ >> webpack.config.js
echo ^      }, >> webpack.config.js
echo ^      { >> webpack.config.js
echo ^        test: /\.scss$/, >> webpack.config.js
echo ^        use: ['style-loader', 'css-loader', 'sass-loader'] >> webpack.config.js
echo ^      }, >> webpack.config.js
echo ^      { >> webpack.config.js
echo ^        test: /\.html$/, >> webpack.config.js
echo ^        use: 'html-loader' >> webpack.config.js
echo ^      } >> webpack.config.js
echo ^    ] >> webpack.config.js
echo ^  }, >> webpack.config.js
echo ^  resolve: { >> webpack.config.js
echo ^    extensions: ['.ts', '.js', '.scss', '.html'] >> webpack.config.js
echo ^  }, >> webpack.config.js
echo ^  node: { >> webpack.config.js
echo ^    __dirname: false, >> webpack.config.js
echo ^    __filename: false >> webpack.config.js
echo ^  } >> webpack.config.js
echo }; >> webpack.config.js

:: webpack.dev.js
echo const { merge } = require('webpack-merge'); > webpack.dev.js
echo const common = require('./webpack.common.js'); >> webpack.dev.js
echo const webpack = require('webpack'); >> webpack.dev.js
echo const path = require('path'); >> webpack.dev.js
echo module.exports = merge(common, { >> webpack.dev.js
echo ^  mode: 'development', >> webpack.dev.js
echo ^  devtool: 'inline-source-map', >> webpack.dev.js
echo ^  devServer: { >> webpack.dev.js
echo ^    contentBase: path.join(__dirname, 'public'), >> webpack.dev.js
echo ^    watchContentBase: true, >> webpack.dev.js
echo ^    compress: true, >> webpack.dev.js
echo ^    hot: true, >> webpack.dev.js
echo ^    port: 3000, >> webpack.dev.js
echo ^    open: 'Google Chrome' >> webpack.dev.js
echo ^  }, >> webpack.dev.js
echo ^  plugins: [ >> webpack.dev.js
echo ^    new webpack.HotModuleReplacementPlugin() >> webpack.dev.js
echo ^  ] >> webpack.dev.js
echo }); >> webpack.dev.js

:: webpack.prod.js
echo const { merge } = require('webpack-merge'); > webpack.prod.js
echo const common = require('./webpack.common.js'); >> webpack.prod.js
echo module.exports = merge(common, { >> webpack.prod.js
echo ^  mode: 'production' >> webpack.prod.js
echo }); >> webpack.prod.js

:: README.md
echo # %app_name% > README.md

:: todo.md
echo # TODO > todo.md

:: package.json
echo { > package.json
echo ^  "name": "testBash", >> package.json
echo ^  "version": "1.0.0", >> package.json
echo ^  "description": "", >> package.json
echo ^  "main": "index.js", >> package.json
echo ^  "type": "module", >> package.json
echo ^  "scripts": { >> package.json
echo ^    "start": "node --experimental-modules server.mjs", >> package.json
echo ^    "start2": "npm run build && node ./server.js", >> package.json
echo ^    "start:dev": "webpack serve --config webpack.dev.js --open", >> package.json
echo ^    "build": "webpack --config webpack.config.js", >> package.json
echo ^    "build2": "webpack", >> package.json
echo ^    "dev": "node --experimental-modules ./node_modules/webpack/bin/webpack.js --watch --mode=development", >> package.json
echo ^    "dev2": "npm run watch && node --experimental-modules server.mjs", >> package.json
echo ^    "watch": "webpack --watch" >> package.json
echo ^  }, >> package.json
echo ^  "keywords": [], >> package.json
echo ^  "author": "", >> package.json
echo ^  "license": "ISC", >> package.json
echo ^  "dependencies": { >> package.json
echo ^    "css-loader": "^7.1.1", >> package.json
echo ^    "esm": "^3.2.25", >> package.json
echo ^    "express": "^4.17.1", >> package.json
echo ^    "sass-loader": "^14.2.1", >> package.json
echo ^    "style-loader": "^4.0.0", >> package.json
echo ^    "webpack-merge": "^5.10.0" >> package.json
echo ^  }, >> package.json
echo ^  "devDependencies": { >> package.json
echo ^    "@babel/cli": "^7.24.5", >> package.json
echo ^    "@babel/core": "^7.24.5", >> package.json
echo ^    "@babel/preset-env": "^7.24.5", >> package.json
echo ^    "@types/express": "^4.17.13", >> package.json
echo ^    "@types/node": "^16.11.7", >> package.json
echo ^    "babel-loader": "^9.1.3", >> package.json
echo ^    "cors": "^2.8.5", >> package.json
echo ^    "nodemon": "^2.0.22", >> package.json
echo ^    "ts-loader": "^9.5.1", >> package.json
echo ^    "typescript": "^4.9.5", >> package.json
echo ^    "typescript-cli": "^0.1.0", >> package.json
echo ^    "webpack": "^5.91.0", >> package.json
echo ^    "webpack-cli": "^4.10.0", >> package.json
echo ^    "webpack-dev-middleware": "^7.2.1", >> package.json
echo ^    "webpack-dev-server": "^3.11.3", >> package.json
echo ^    "webpack-hot-middleware": "^2.26.1", >> package.json
echo ^    "webpack-node-externals": "^3.0.0" >> package.json
echo ^  } >> package.json
echo } >> package.json

:: public\api\api_base.ts
echo // api_base.ts > public\api\api_base.ts

:: public\scss\base.scss
echo // base.scss > public\scss\base.scss

:: public\src\base.ts
echo // base.ts > public\src\base.ts

:: public\index.html
echo ^<!DOCTYPE html^> > public\index.html
echo <html lang="en"> >> public\index.html
echo <head> >> public\index.html
echo ^  <meta charset="UTF-8"> >> public\index.html
echo ^  <meta name="viewport" content="width=device-width, initial-scale=1.0"> >> public\index.html
echo ^  <title>Document</title> >> public\index.html
echo </head> >> public\index.html
echo <body> >> public\index.html
echo ^  <h1>Project Has been Created From Bat File</h1> >> public\index.html
echo ^  <span>It is located</span> >> public\index.html
echo </body> >> public\index.html
echo </html> >> public\index.html

echo Files created successfully!

:: Change to the newly created directory
cd "%app_path%\%app_name%"

:: Run npm install
echo Running npm install...
npm install

echo Setup complete!
pause
