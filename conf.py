"""Sphinx configuration for 《新一代客户端架构：用 Tauri + Rust 构建桌面应用》."""

from __future__ import annotations

project = "新一代客户端架构：用 Tauri + Rust 构建桌面应用"
author = "Walter Fan"
copyright = "2026, Walter Fan"
release = "0.1.0-draft"
language = "zh_CN"

extensions = [
    "myst_parser",
    "sphinx_copybutton",
    "sphinx_design",
    "sphinxcontrib.mermaid",
]

myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "fieldlist",
    "substitution",
    "tasklist",
]
myst_heading_anchors = 3
myst_fence_as_directive = ["mermaid"]

html_theme = "sphinx_rtd_theme"
html_title = "Tauri + Rust 客户端架构"
html_show_sourcelink = False
html_theme_options = {
    "navigation_depth": 2,
    "collapse_navigation": True,
    "sticky_navigation": True,
    "prev_next_buttons_location": "bottom",
}

exclude_patterns = [
    ".DS_Store",
    ".venv/**",
    "build/**",
    "PLAN.md",
    "README.md",
    "poetry.lock",
    "poetry.toml",
    "pyproject.toml",
    "requirements-docs.txt",
]

mermaid_version = "10.9.1"
nitpicky = False

