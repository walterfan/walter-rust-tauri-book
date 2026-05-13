# 新一代客户端架构：用 Tauri + Rust 构建桌面应用

*一本写给 C++ / Java 后端工程师的桌面客户端架构实践书：从 Rust 语言基础，到 Tauri 架构、工程化、安全、发布与长期演进。*

| | |
|--|--|
| **作者** | Walter Fan |
| **许可证** | CC-BY-SA-4.0（正文）· MIT（代码样例） |
| **状态** | 0.1.0-draft |

## 阅读路线

如果你是后端工程师，建议按顺序阅读：先理解客户端架构为什么走到 Tauri，再用 Rust 速成部分建立语言直觉，最后进入 Tauri 的核心能力和工程化章节。

如果你已经熟悉 Rust，可以跳过第三至九章，直接从第十章开始，把 Hive 项目当成一个小型桌面客户端的架构样板。

## 本版增强

这一版把草稿从“知识点集合”推进到“可学习、可实践、可复盘”的结构：

- 每章开头都有一张 Mermaid 思维导图，先给读者一张“本章地图”。
- 技术讲解尽量回到 Hive 项目的真实设计抉择，而不只是罗列 API。
- 对后端工程师不熟悉的前端框架，尤其 React 与 Vue，补充了必要背景和心智模型。
- 每个主题都尽量回答三个问题：它解决什么问题、代价是什么、在桌面客户端里怎样落地。

```{toctree}
:maxdepth: 2
:caption: Part 0 · 开场

chapters/ch01
chapters/ch02
```

```{toctree}
:maxdepth: 2
:caption: Part 1 · Rust 速成

chapters/ch03
chapters/ch04
chapters/ch05
chapters/ch06
chapters/ch07
chapters/ch08
chapters/ch09
```

```{toctree}
:maxdepth: 2
:caption: Part 2 · Tauri 深度

chapters/ch10
chapters/ch11
chapters/ch12
chapters/ch13
chapters/ch14
chapters/ch15
chapters/ch16
chapters/ch17
```

```{toctree}
:maxdepth: 2
:caption: Part 3 · 高级实践

chapters/ch18
chapters/ch19
chapters/ch20
chapters/ch21
chapters/ch22
```

```{toctree}
:maxdepth: 2
:caption: Part 4 · 结语与参考

chapters/ch23
chapters/appendix-a
chapters/appendix-b
chapters/appendix-c
```
