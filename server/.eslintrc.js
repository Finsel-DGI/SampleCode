module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    "google",
    "plugin:@typescript-eslint/recommended",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: ["tsconfig.json", "tsconfig.dev.json"],
    sourceType: "module",
  },
  ignorePatterns: [
    "/build/**/*", // Ignore built files.
    "/local/**/*", // Ignore local files.
    "/public/**/*", // Ignore local files.
  ],
  plugins: [
    "@typescript-eslint",
    "import",
  ],
  rules: {
    "quotes": ["error", "double"],
    "import/no-unresolved": 0,
    "max-len": ["error", {
      "code": 140, "ignoreComments": true, "ignoreTrailingComments": true,
      "ignoreUrls": true, "ignoreTemplateLiterals": true,
      "ignoreRegExpLiterals": true,
    }],
  },
};
