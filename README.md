# Snake Pet~~

一个基于QtQuick、QML、C++、CMake、GCC、ffmpeg的桌宠应用。
**由于是基于Gif播放动画，所以项目构建占用过大虚拟内存！！！**

---

## 执行样例

![菜单样例](../../Asset/Snipaste_2026-03-02_11-18-33.jpg)
![snake样例](../../Asset/Snipaste_2026-03-02_11-21-04.jpg)

---

## Quick Start

1. 单击Add键添加新对象，单击Style切换服饰。
2. 新建对象可以通过单击互动、右键选择状态/删除、双击触发特殊动作、Ctrl+滚轮调节大小。

---

## 实现功能

【基础要求】

- [x] 基础显示 无边框透明窗口 显示宠物角色（可以是简单图片/动画） 始终置顶显示
- [x] 基础动画 至少 3 种状态动画（待机、行走、睡觉等） 平滑的动画过渡
- [x] 拖拽交互 可以用鼠标拖拽宠物移动
- [x] 托盘菜单 系统托盘图标 右键菜单（退出、设置等）

【进阶要求】

- [ ] 自主行为 宠物在桌面上随机走动 在屏幕边缘停止/折返 长时间不互动会进入睡眠状态
- [x] 点击互动 点击宠物有反应动画 双击触发特殊动作
- [x] 多套皮肤 支持切换不同角色/皮肤 皮肤配置文件
- [ ] 设置界面 调整移动速度 调整大小 开机自启动选项

---

## 技术栈

QtQuick、QML、C++、CMake、GCC、ffmpeg  ~~Deepseek~~

---

## 开发环境

Windows11

---

## 参考文献

[QtDocumentation](https://doc.qt.io/)

对于排版使用qmlformat大刀阔斧地修改了一下。

图片来源：[prts.wiki](https://prts.wiki/)

后采用ffmpeg修改:

webm转gif:

```
ffmpeg -i input.webm -filter_complex "[0:v]chromakey=color=0xFF0000:similarity=0.3:blend=0.0[ckout];[ckout]fps=15[fast];[fast]split[base][alpha];[base]palettegen=stats_mode=diff[pal];[alpha][pal]paletteuse=new=1:alpha_threshold=128" output.gif
```

调整图片大小:

```
ffmpeg -i input.gif -vf "format=rgba,crop=x:y:z:a,split[temp][original];[temp]palettegen=stats_mode=diff[pal];[original][pal]paletteuse=new=1:alpha_threshold=128" output.gif`
```

---
