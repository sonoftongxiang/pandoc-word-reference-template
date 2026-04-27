# Pandoc Word Reference Template

这个项目用来维护解包后的 Word 模板，并重新打包成 Pandoc 可用的 `reference.docx`。

## 目录

```text
.
├── scripts/pack-reference-docx.sh
├── template/reference/
└── examples/
```

## 用法

以下命令都在项目根目录执行：

```bash
cd .
bash ./scripts/pack-reference-docx.sh ./template/reference reference ./examples/output
```

生成结果：

```text
./examples/output/reference.zip
./examples/output/reference.docx
```

## 参数

```bash
bash ./scripts/pack-reference-docx.sh <源目录> <输出名> <输出目录>
```

示例：

```bash
bash ./scripts/pack-reference-docx.sh ./template/reference my-template ./examples/output
```

## 在 Pandoc 中使用

```bash
pandoc ./examples/demo.md -o ./examples/output/demo.docx --reference-doc=./examples/output/reference.docx
```

## 常改文件

- `./template/reference/word/styles.xml`
- `./template/reference/word/document.xml`
- `./template/reference/word/numbering.xml`
- `./template/reference/word/theme/theme1.xml`

## 注意

- 必须打包 `reference/` 目录内部内容，不能多包一层父目录。
- `docx` 根目录需要直接包含 `[Content_Types].xml`、`word/`、`docProps/` 等文件。
- 修改模板后，先重新打包，再让 Pandoc 使用新的 `reference.docx`。
