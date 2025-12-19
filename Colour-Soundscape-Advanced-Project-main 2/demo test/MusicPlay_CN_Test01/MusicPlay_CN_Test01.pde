/*
 * 多音乐播放控制器（独立音量版）
 * - 按 1/2/3/4/5 播放对应音乐（每首音量独立渐强）
 * - 按空格键停止所有音乐
 * - 完全避免音乐间的音量串扰
 */

import processing.sound.*;

PFont chineseFont;          // 中文字体对象
SoundFile[] tracks;         // 存储所有音乐文件
boolean[] isPlaying;        // 记录每首音乐是否在播放
float[] targetVolumes;      // 每首音乐的目标音量
float[] currentVolumes;     // 每首音乐的当前音量

void setup() {
  size(640, 480);                                             // 设置窗口显示大小
  chineseFont = createFont("Dialog", 24);
  textFont(chineseFont);
  textAlign(CENTER, CENTER);
  
  // 初始化音乐和音量状态
  tracks = new SoundFile[5];
  isPlaying = new boolean[5];
  targetVolumes = new float[5];
  currentVolumes = new float[5];
  
  // 加载音乐文件（确保 data 文件夹中有 1.mp3, 2.mp3, ..., 5.mp3）
  for (int i = 0; i < tracks.length; i++) {
    tracks[i] = new SoundFile(this, (i + 1) + ".wav");
    isPlaying[i] = false;
    targetVolumes[i] = 0.0;
    currentVolumes[i] = 0.0;
  }
}

void draw() {
  background(0);
  fill(255);
  
  // 显示播放状态
  String playingStatus = "按 1-5 播放音乐，空格键停止";
  playingStatus = "正在播放: 音乐 ";
  for (int i = 0; i < tracks.length; i++) {
    if (isPlaying[i]) {
      playingStatus += (i + 1);
      playingStatus += "  "; 
    }
  }
  text(playingStatus, width / 2, height / 2);
  
  // 更新所有音乐的音量（独立控制）
  for (int i = 0; i < tracks.length; i++) {
    if (isPlaying[i]) {
      // 音量渐强效果（线性插值）
      if (currentVolumes[i] < targetVolumes[i]) {
        currentVolumes[i] = lerp(currentVolumes[i], targetVolumes[i], 0.005);
        tracks[i].amp(currentVolumes[i]);
      }
    }
  }
}

void keyPressed() {
  // 数字键 1-5：播放/停止对应音乐
  if (key >= '1' && key <= '5') {
    int trackIndex = key - '1';
    
    if (isPlaying[trackIndex]) {
      // 如果正在播放，停止并重置音量
      tracks[trackIndex].stop();
      isPlaying[trackIndex] = false;
      targetVolumes[trackIndex] = 0.0;
      currentVolumes[trackIndex] = 0.0;
    } else {
      // 如果未播放，开始播放并初始化音量
      tracks[trackIndex].loop();
      isPlaying[trackIndex] = true;
      targetVolumes[trackIndex] = 1;  // 目标音量设为 100%
      currentVolumes[trackIndex] = 0.0; // 从静音开始渐强
    }
  }
  
  // 空格键：停止所有音乐
  if (key == ' ') {
    for (int i = 0; i < tracks.length; i++) {
      if (isPlaying[i]) {
        tracks[i].stop();
        isPlaying[i] = false;
        targetVolumes[i] = 0.0;
        currentVolumes[i] = 0.0;
      }
    }
  }
}
