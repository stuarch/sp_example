vc=require("speechtotxt")

--三號燈開和關
cmd_1_on = "gatttool --device=00:02:5B:00:15:1D --char-write-req --handle=0x000b --value=FA0301FE"
cmd_1_off = "gatttool --device=00:02:5B:00:15:1D --char-write-req --handle=0x000b --value=FA0300FE"
--另一個燈開關指令
cmd_2_on = "echo \"LED 2 On\""
cmd_2_off = "echo \"LED 2 Off\""

function wakeup()
    sp = vc.init(nil,"./sp/7179.lm","./sp/7179.dict")
    while true do
        txt = sp:inmic()
        wake = io.open("./sp/wake.txt","r")
        flag = 0
        while true do
            order = wake:read()
            if order == nil then break end
            if txt == order:upper() then
                flag=1
                print("\n=====Wake Up=====\n")
                break
            end
        end
        if flag == 1 then
            break
        end
     end
     sp:close()
end

function movements()
    sp = vc.init(nil,"./sp/4351.lm", "./sp/4351.dict")
    while true do
        txt = sp:inmic()
--        mv = io.open("./movement.txt")
	one_on = io.open("./sp/one_on.txt","r")
	one_off = io.open("./sp/one_off.txt","r")
	two_on = io.open("./sp/two_on.txt","r")
	two_off = io.open("./sp/two_off.txt","r")
	all_on = io.open("./sp/all_on.txt","r")
	all_off = io.open("./sp/all_off.txt","r")	
        sd = io.open("./sp/suspend.txt","r")
        flag = 0
        cnt = 0

	while true do
		order = one_on:read()
		if order == nil then break end
		if txt == order:upper() then
                	flag = 1
			cnt = 0
                	break
            end
	end

	while true do
		order = one_off:read()
		if order == nil then break end
		if txt == order:upper() then
                	flag = 1
			cnt = 1
                	break
            end
	end
	while true do
		order = two_on:read()
		if order == nil then break end
		if txt == order:upper() then
                	flag = 1
			cnt = 2
			print("two on")
                	break
            end
	end
	while true do
		order = two_off:read()
		if order == nil then break end
		if txt == order:upper() then
                	flag = 1
			cnt = 3
			print("two off")
                	break
            end
	end
	while true do
		order = all_on:read()
		if order == nil then break end
		if txt == order:upper() then
                	flag = 1
			cnt = 4
                	break
            end
	end
	while true do
		order = all_off:read()
		if order == nil then break end
		if txt == order:upper() then
                	flag = 1
			cnt = 5
                	break
            end
	end

         while true do
            order = sd:read()
            if order ==nil then break end
            if txt == order:upper() then
                flag = 2
                break
            end
         end
         if flag == 1 then
             --print("cnt " ..  cnt .. "\n")
             if cnt == 0 then
                 os.execute(cmd_1_on)
             elseif cnt==1 then
                 os.execute(cmd_1_off)
             elseif cnt==2 then
              	os.execute(cmd_2_on)
             elseif cnt==3 then
              	os.execute(cmd_2_off)
             elseif cnt==4 then
              	os.execute(cmd_1_on)
				os.execute(cmd_2_on)		
             elseif cnt==5 then
                os.execute(cmd_1_off)
				os.execute(cmd_2_off)
             end
         elseif flag == 2 then
             print("\n=====Suspend=====\n")
             break
         end
     end
     sp:close()
end
    
while true do
    wakeup()
    movements()
end
