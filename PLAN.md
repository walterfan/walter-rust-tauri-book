# 新一代客户端架构：用 Tauri + Rust 构建桌面应用

*A hands-on book for experienced C++/Java backend engineers — learn Rust, Tauri, and modern client architecture from scratch.*

| | |
|--|--|
| **作者** | Walter Fan |
| **许可证** | CC-BY-SA-4.0（正文）· MIT（代码样例） |
| **状态** | 草稿 —— 骨架就位，章节正在撰写中 |

---

## 目标读者

- 有 3 年以上 C++/Java 后端开发经验
- 不了解 Rust 和 Tauri
- 希望转型或扩展到桌面客户端开发
- 对现代前端（HTML/CSS/JS）有基本了解即可

## 写作原则

1. **对比驱动** — 每个 Rust 概念都与 C++/Java 对照，降低认知门槛
2. **图文并茂** — 每章至少 2 张 Mermaid 架构图 / 流程图 / 序列图
3. **渐进式实战** — Hive 项目逐章迭代，每章交付可运行增量
4. **代码即文档** — 所有示例可独立编译，放在 `examples/` 目录

## 贯穿全书的实战项目：「Hive」

一个团队协作桌面客户端，从 v0.1 迭代到 v1.0：

```
v0.1 → Hello Tauri + Markdown 笔记编辑器        (Ch02, Ch10)
v0.2 → SQLite 本地持久化                         (Ch12)
v0.3 → REST API 云同步                           (Ch13)
v0.4 → 系统托盘 / 通知 / 全局快捷键              (Ch14)
v0.5 → 群聊功能（WebSocket 实时通信）             (Ch15)
v0.6 → 插件系统                                   (Ch17)
v1.0 → 自动更新 + 多平台 CI/CD                   (Ch20)
```

## 全书大纲

### Part 0 · 开场（为什么）

| 章 | 标题 | 核心内容 | 预计字数 |
|----|------|----------|----------|
| 01 | 客户端架构的前世今生 | 原生→Electron→Tauri 演进；为什么后端工程师也该懂客户端 | 5000 |
| 02 | 五分钟跑起第一个 Tauri 应用 | 环境搭建、create-tauri-app、项目结构、Hello World | 4000 |

### Part 1 · Rust 速成（给 C++/Java 工程师的 Rust）

| 章 | 标题 | 核心内容 | 预计字数 |
|----|------|----------|----------|
| 03 | Rust 初印象：从 Hello World 到 Cargo | 工具链、Cargo、基本语法、与 C++/Java 对比 | 6000 |
| 04 | 所有权与借用：Rust 的灵魂 | 所有权三规则、借用、生命周期；与 C++ RAII / Java GC 对比 | 8000 |
| 05 | 结构体、枚举与模式匹配 | struct/enum/match/Option/Result；与 C++ class / Java record 对比 | 6000 |
| 06 | Trait 与泛型：Rust 的多态 | trait/impl/dyn/泛型约束；与 C++ template / Java interface 对比 | 6000 |
| 07 | 错误处理的艺术 | Result/Option/?操作符/thiserror/anyhow；与异常机制对比 | 5000 |
| 08 | 异步编程：从线程到 async/await | std::thread/tokio/async-await/channel；与 C++ std::async / Java CompletableFuture 对比 | 7000 |
| 09 | Rust 实战小项目：CLI 聊天室 | 综合运用前 6 章知识，写一个终端聊天室 | 5000 |

### Part 2 · Tauri 深度（架构与核心能力）

| 章 | 标题 | 核心内容 | 预计字数 |
|----|------|----------|----------|
| 10 | Tauri 架构全景 | Core 进程 vs WebView 进程、IPC 桥、事件系统、安全模型 | 7000 |
| 11 | 前后端通信：Command 与 Event | #[tauri::command]、invoke()、事件发布/订阅、状态管理 | 7000 |
| 12 | 前端集成：选择你的武器 | Vanilla / React / Vue / Svelte 集成；Hive 选型 | 5000 |
| 13 | 数据持久化：从文件到 SQLite | tauri-plugin-fs、tauri-plugin-sql、SQLite + sqlx | 6000 |
| 14 | 网络与 API 调用 | reqwest/HTTP 客户端、REST 集成、离线队列 | 6000 |
| 15 | 实时通信：WebSocket 与群聊 | tokio-tungstenite、消息协议设计、群聊功能实现、在线状态 | 8000 |
| 16 | 原生能力：托盘、通知、快捷键、剪贴板 | 系统托盘、桌面通知、全局快捷键、剪贴板读写 | 6000 |
| 17 | 安全加固 | CSP 策略、IPC 权限控制、capabilities 配置、代码签名 | 5000 |

### Part 3 · 高级实践（工程化与架构）

| 章 | 标题 | 核心内容 | 预计字数 |
|----|------|----------|----------|
| 18 | 插件开发 | Tauri 插件体系、编写自定义插件、发布到 crates.io | 6000 |
| 19 | 测试策略 | Rust 单元测试、集成测试、WebDriver E2E、CI 集成 | 6000 |
| 20 | 性能优化 | 启动时间、内存占用、渲染性能、Rust profiling 工具 | 6000 |
| 21 | 多平台打包与发布 | tauri-action、GitHub Actions、自动更新、macOS/Windows/Linux 签名 | 6000 |
| 22 | 架构模式与最佳实践 | 分层架构、状态管理模式、错误边界、日志与可观测性 | 6000 |

### Part 4 · 结语与参考

| 章 | 标题 | 核心内容 | 预计字数 |
|----|------|----------|----------|
| 23 | 未来展望 | Tauri 2.0 移动端、WASM、AI 集成、Rust GUI 生态 | 3000 |
| A  | 附录 A：Rust 速查表 | 语法速查、常用 trait、常用 crate | 3000 |
| B  | 附录 B：Tauri CLI 参考 | 常用命令速查 | 2000 |
| C  | 附录 C：推荐资源 | 书籍、博客、社区、视频 | 1500 |

**全书预计总字数：约 14 万字**

## 写作计划

| 周次 | 目标 | 交付 |
|------|------|------|
| W01 | 项目骨架 + Ch01~02 | 可构建的 Sphinx 项目 + 开场两章 |
| W02 | Ch03~04 | Rust 基础 + 所有权 |
| W03 | Ch05~06 | 结构体/枚举 + Trait/泛型 |
| W04 | Ch07~09 | 错误处理 + 异步 + CLI 聊天室 |
| W05 | Ch10~11 | Tauri 架构 + IPC 通信 |
| W06 | Ch12~13 | 前端集成 + 数据持久化 |
| W07 | Ch14~15 | 网络 API + WebSocket 群聊 |
| W08 | Ch16~17 | 原生能力 + 安全加固 |
| W09 | Ch18~19 | 插件开发 + 测试策略 |
| W10 | Ch20~21 | 性能优化 + 多平台打包 |
| W11 | Ch22~23 | 架构模式 + 未来展望 |
| W12 | 附录 + 审校 | 附录 A/B/C + 全书审校 |
| W13 | 最终发布 | PDF/HTML/ePub 输出 |
