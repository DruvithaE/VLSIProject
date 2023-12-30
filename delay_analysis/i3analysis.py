import os
import subprocess
# import time

# This clears the output file
fp3 = open("i3delay.txt",'w')
fp3.close()

#this is the command this helps to choose which file to run
command = "ngspice -b des.cir"

#start of script
for j in range(0,8): #j represents the iteration of input. since we have 8 inputs we have kept it as 0,8
    if j<4:
        s1 = "a"+str(j)   #for input sequence 0000 1111 output = 1111 s1 indicates string1
    else:
        s1 = "b"+str(j-4) #for input sequence 1111 0000 output = 1111

    for i in range(0,3):  #i is for output sequence
        
        s2 = "y"+str(i) #s2 indicates string 2.

        #fp1 is src file since you cant modify it you open it in read mode
        if( i==0 or i==2):
            if (j < 4):
                fp1 = open("compdel1.cir",'r') #for input sequence 1
            elif (j >= 4):
                fp1 = open("compdel4.cir",'r') #for input sequence 1
        elif (i==1 and j<4):
            fp1 = open("compdel2.cir",'r') #for input sequecne 2
        elif (i==1 and j>=4):
            fp1 = open("compdel3.cir",'r') #for input sequecne 2        
        #if you have any other input sequences you can add

        fp2 =open("des.cir",'w') #destination file for running
        fp3 = open("i3delay.txt",'a') #final output file
        mode1 = "RISE"
        mode2 = "RISE"
        mode3 = "FALL"
        mode4 = "FALL"
        if(j<4 and i == 0):
            mode1 = "RISE"
            mode2 = "RISE"
            mode3 = "FALL"
            mode4 = "FALL"
        elif(j<4 and i == 1):
            mode1 = "RISE"
            mode2 = "RISE"
            mode3 = "FALL"
            mode4 = "FALL"
        elif(j<4 and i == 2):            
            mode1 = "FALL"
            mode2 = "RISE"
            mode3 = "RISE"
            mode4 = "FALL"
        elif(j>=4 and i == 0):            
            mode3 = "FALL"
            mode4 = "RISE"
            mode1 = "RISE"
            mode2 = "FALL"
        elif(j>=4 and i == 1):            
            mode1 = "RISE"
            mode2 = "RISE"
            mode3 = "FALL"
            mode4 = "FALL"  
        elif(j>=4 and i == 2):                     
            mode1 = "RISE"
            mode2 = "RISE"
            mode3 = "FALL"
            mode4 = "FALL" 
                                    
        data = fp1.read() #reading data from file to a string

        search_text = "*target text"
        replace_text = f'''
.measure tran trise 
+ TRIG v({s1}) VAL = 'SUPPLY/2' {mode1} =1
+ TARG v({s2}) VAL = 'SUPPLY/2' {mode2} =1 

.measure tran tfall 
+ TRIG v({s1}) VAL = 'SUPPLY/2' {mode3} =1 
+ TARG v({s2}) VAL = 'SUPPLY/2' {mode4}=1

.measure tran tpd param = '(trise + tfall)/2' goal = 0
        '''
        #now we replace search text with replace text in the file
        data = data.replace(search_text,replace_text)
        fp2.write(data) #this writes the modified text into a new file called temp2.ckt
        fp1.close()
        fp2.close()

        #just use this block as it is so that your command is run in the terminal and output is stored into the string named as output
        completed_process = subprocess.run(command, shell=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if completed_process.returncode == 0:
            # Capture the standard output into a string
            output = completed_process.stdout
        else:
            output = ("Command execution failed. at",str(i),str(j))

        output = output.split('\n') #helps to seperate the string based on the new line characters
        output = output[-18] + '\n'
        additional_text = f"input = {s1} output = {s2}\n"

        fp3.write(additional_text+output+'\n')
        # time.sleep(0.4)
                
