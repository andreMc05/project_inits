#!/bin/bash

echo "Enter the file path where the application will go:"
read file_path

echo "Enter the name of the application:"
read app_name

mkdir -p $file_path/$app_name/{public/{api,scss,src},dist}

cd $file_path/$app_name

# Create server.js
cat <<EOL > server.js
const express = require('express');
const cors = require('cors');
const path = require('path');
const app = express();
const port = 3000;

const corsOptions = {
  origin: 'http://example.com',
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  optionsSuccessStatus: 204
};

app.use(cors());
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/index.html'));
});

const server = app.listen(port, () => {
  console.log(\`Server is running on http://localhost:\${port}\`);
});

if (module.hot) {
  module.hot.accept();
  module.hot.dispose(() => server.close());
}
EOL

# Create tsconfig.json
cat <<EOL > tsconfig.json
{
  "compilerOptions": {
    "target": "ES6",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["./public/api/**/*.ts", "./public/src/**/*.ts"]
}
EOL

# Create webpack.common.js
cat <<EOL > webpack.common.js
const path = require('path');

module.exports = {
  entry: {
    api: './public/api/api_base.ts',
    base: './public/src/base.ts'
  },
  target: 'node',
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: ['.ts', '.js'],
  },
  node: {
    __dirname: false,
    __filename: false,
  },
};
EOL

# Create webpack.config.js
cat <<EOL > webpack.config.js
const path = require('path');

module.exports = {
  entry: {
    api: './public/api/api_base.ts',
    base: './public/src/base.ts'
  },
  target: 'node',
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'public'),
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.scss$/,
        use: ['style-loader', 'css-loader', 'sass-loader'],
      },
      {
        test: /\.html$/,
        use: 'html-loader',
      },
    ],
  },
  resolve: {
    extensions: ['.ts', '.js', '.scss', '.html'],
  },
  node: {
    __dirname: false,
    __filename: false,
  },
};
EOL

# Create webpack.dev.js
cat <<EOL > webpack.dev.js
const { merge } = require('webpack-merge');
const common = require('./webpack.common.js');
const webpack = require('webpack');
const path = require('path');

module.exports = merge(common, {
  mode: 'development',
  devtool: 'inline-source-map',
  devServer: {
    contentBase: path.join(__dirname, 'public'),
    watchContentBase: true,
    compress: true,
    hot: true,
    port: 3000,
    open: true,
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
  ],
});
EOL

# Create webpack.prod.js
cat <<EOL > webpack.prod.js
const { merge } = require('webpack-merge');
const common = require('./webpack.common.js');

module.exports = merge(common, {
  mode: 'production',
});
EOL

# Create .babelrc
cat <<EOL > .babelrc
{
    "presets": [
      ["@babel/preset-env", {
        "targets": {
          "node": "current"
        }
      }]
    ],
    "plugins": ["@babel/plugin-transform-modules-commonjs"]
}
EOL

# Create README.md
cat <<EOL > README.md
# $app_name

## Description

## Installation

## Usage
EOL

# Create todo.md
cat <<EOL > todo.md
# To Do
EOL

# Create package.json
cat <<EOL > package.json
{
  "name": "$app_name",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "type": "module",
  "scripts": {
    "start": "node --experimental-modules server.js",
    "start2": "npm run build && node ./server.js",
    "start:dev": "webpack serve --config webpack.dev.js --open",
    "build": "webpack --config webpack.config.js",
    "build2": "webpack",
    "dev": "node --experimental-modules ./node_modules/webpack/bin/webpack.js --watch --mode=development",
    "dev2": "npm run watch && node --experimental-modules server.js",
    "watch": "webpack --watch"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "css-loader": "^7.1.1",
    "esm": "^3.2.25",
    "express": "^4.17.1",
    "sass-loader": "^14.2.1",
    "style-loader": "^4.0.0",
    "webpack-merge": "^5.10.0"
  },
  "devDependencies": {
    "@babel/cli": "^7.24.5",
    "@babel/core": "^7.24.5",
    "@babel/preset-env": "^7.24.5",
    "@types/express": "^4.17.13",
    "@types/node": "^16.11.7",
    "babel-loader": "^9.1.3",
    "cors": "^2.8.5",
    "nodemon": "^2.0.22",
    "ts-loader": "^9.5.1",
    "typescript": "^4.9.5",
    "typescript-cli": "^0.1.0",
    "webpack": "^5.91.0",
    "webpack-cli": "^4.10.0",
    "webpack-dev-middleware": "^7.2.1",
    "webpack-dev-server": "^3.11.3",
    "webpack-hot-middleware": "^2.26.1",
    "webpack-node-externals": "^3.0.0"
  }
}
EOL

# Create public/api/api_base.ts
cat <<EOL > public/api/api_base.ts
// api_base.ts
EOL

# Create public/scss/base.scss
cat <<EOL > public/scss/base.scss
// base.scss
EOL

# Create public/src/base.ts
cat <<EOL > public/src/base.ts
// base.ts
EOL

# Create public/index.html
cat <<EOL > public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <h1>$app_name Project Has been Created From Script</h1>
  <span>It is located at $file_path</span>
</body>
</html>
EOL

echo "Files created successfully!"
