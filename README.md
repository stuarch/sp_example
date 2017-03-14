# Voice Command Example

## 睡眠模式：
小智你好->從睡眠狀態喚醒

## 喚醒模式：
一號燈開<br>
一號燈關<br>
二號燈開<br>
二號燈關<br>
全開<br>
全關<br>
小智再見->回到睡眠狀態

## 修改指令動作
文字編輯器打開檔案`app_with_two.lua`
```
vc=require("speechtotxt")

--三號燈開和關
cmd_1_on = "gatttool --device=00:02:5B:00:15:1D --char-write-req --handle=0x000b --value=FA0301FE"
cmd_1_off = "gatttool --device=00:02:5B:00:15:1D --char-write-req --handle=0x000b --value=FA0300FE"
--另一個燈開關指令
cmd_2_on = "echo \"LED 2 On\""
cmd_2_off = "echo \"LED 2 Off\""
```
可以修改上面的字串改變控制藍芽燈的指令
