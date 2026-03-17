# Snake Pet~~

一个基于QtQuick、QML、C++、CMake、GCC、ffmpeg的桌宠应用。

---

## 执行样例

![菜单样例](..\Assets\Example\Snipaste_2026-03-02_11-18-33.jpg)
![snake样例](..\Assets\Example\Snipaste_2026-03-02_11-21-04.jpg)

---

## Quick Start

1. 单击Add键添加新对象，单击Style切换服饰。
2. 新建对象可以通过单击互动、右键选择状态/删除、双击触发特殊动作、Ctrl+滚轮调节大小。

---

## 技术栈

QtQuick、QML、C++、CMake、GCC、ffmpeg  ~~Deepseek~~

---

## 开发环境

Windows11

---

## 参考文献

[QtDocumentation](https://doc.qt.io/)

图片来源：[prts.wiki](https://prts.wiki/)

后采用[ffmpeg](https://ffmpeg.org/)修改:

webm转gif,同时去除背景颜色0xFF0000:

```PowerShell
ffmpeg -i input.webm -filter_complex "[0:v]chromakey=color=0xFF0000:similarity=0.3:blend=0.0[ckout];[ckout]fps=30[fast];[fast]split[base][alpha];[base]palettegen=stats_mode=diff[pal];[alpha][pal]paletteuse=new=1:alpha_threshold=128" out.gif
```

调整图片大小:

```PowerShell
ffmpeg -i input.gif -vf "format=rgba,crop=x:y:z:a,split[temp][original];[temp]palettegen=stats_mode=diff[pal];[original][pal]paletteuse=new=1:alpha_threshold=128" output.gif
```

左右颠倒:

```PowerShell
ffmpeg -i input.gif -vf hflip output.gif
```

---
