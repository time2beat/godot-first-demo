# Fox Fight Bats

初次学习 Godot 的练习项目，2D 像素风格 ARPG 游戏 Demo（单场景）。

## 参考资料

- 《[Game Programming Patterns](http://gameprogrammingpatterns.com/)》（[中文版 - 游戏编程模式](https://gpp.tkchu.me/)）
- 《[Godot Docs](https://docs.godotengine.org/)》（[中文版 - Godot 官方文档](http://godot.pro/doc/index.html)）

## 项目引用

- [本杰明\(HeartBeast\)的视频教程 - Youtube](https://youtu.be/mAbG8Oi-SvQ)
- [素材来源 - GitHub](https://github.com/uheartbeast/youtube-tutorials)

## 实现

### Features

- [x] 支持<ruby><rb>闲置</rb><rp>（</rp><rt>Idle</rt><rp>）</rp></ruby>、<ruby><rb>移动</rb><rp>（</rp><rt>Move</rt><rp>）</rp></ruby>、<ruby><rb>攻击</rb><rp>（</rp><rt>Attack</rt><rp>）</rp></ruby>、<ruby><rb>翻滚</rb><rp>（</rp><rt>Roll</rt><rp>）</rp></ruby>四种状态的<ruby><rb>「有限状态机」</rb><rp>（</rp><rt>Finite State Machine</rt><rp>）</rp></ruby>
- [x] 以及与四方向动作对应的动画（用 `AnimationTree` 节点的 `BlendSpace2D` 实现）
- [x] 支持八向动作（移动、翻滚、攻击），具有加速度、减速（模拟摩擦）等简单物理效果
- [x] 基于 `YSort` 节点实现自动排序重叠时的优先显示区域（站在树前显示玩家，站在树后显示树）
- [x] 基于 `Autotile` 自动完成场景地形连接切换显示细节，不可通过的地形使用碰撞箱 `Collision` 实现
- [x] 基于碰撞箱实现 `hitbox` 和 `hurtbox` 来检测伤害判定
- [x] 基于碰撞箱实现的可交互（被破坏）地形（杂草）
- [x] 漂浮在空中具有待机动画的小怪，能够检测并追踪玩家，被攻击时具有击退效果，死亡时有动画
- [x] 玩家和小怪都具有动态计算的血量和受击反馈动画
- [x] 玩家血量显示到 HUD
- [x] 小怪之间的软碰撞（`Soft Collision`，本质是当碰撞箱重叠时，提供一个向量将另一个物体推出去，用来防止复数同类物体重叠在一切）
- [x] 跟随玩家位置的平滑镜头
- [x] 小怪游荡状态（巡逻路径），玩家脱离仇恨（离开检测范围）后自动返回游荡地点
- [x] 攻击（Swipe）、翻滚（Evade）、击中（Hit）、击杀（EnemyDie）、受伤（Hurt）的音效
- [x] 基于着色器（`Shader`）实现的（敌我双方）受击闪烁特效（用来提示无敌帧）
- [x] 翻滚时添加隐藏（不闪烁）的无敌帧
- [x] 基于「`Node` 节点无位置信息的特性」和「用脚本指定 `Camera2D` 节点的 `Limit`」实现的可快速编辑的镜头限制
- [x] 带音效可随时开关的暂停功能，可选择返回标题界面
- [x] 简单的标题界面，平滑（渐入渐出）的场景切换
- [x] 死亡时弹出 Game Over 画面，点击按钮或 <kbd>Esc</kbd> 可以回到标题画面
- [x] 用「Aseprite」照着项目的 heart 素材临摹了一个 icon 图标

### Bugs

- [ ] 移动结束后人物会轻微抖动，初步推测是速度向量停止后没有对齐像素
- [ ] 标题界面支持按键切换选项，并提供音效
- [ ] 清关提示
