
		ORG		00H
        JMP     START
        ORG     32H

START:
        MOV     R0,#27          ; R0 : 迴圈計數
		MOV     R1,#5           ; R1 : 迴圈計數
        MOV     DPTR,#LED_TABLE ; DPTR 指向 LED 顯示資料表
       
d1:
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P0,A            ; 將LED 碼 送到PORT-0
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P1,A            ; 將LED 碼 送到PORT-1
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P2,A            ; 將LED 碼 送到PORT-2
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P3,A            ; 將LED 碼 送到PORT-3
        INC     DPTR            ; 指向下一筆 LED 顯示資
		CALL    DELAY_05S       ; 延遲時間 0.5 SECOND
		DJNZ    R0,d1
			
d2:
		CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P0,A            ; 將LED 碼 送到PORT-0
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P1,A            ; 將LED 碼 送到PORT-1
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P2,A            ; 將LED 碼 送到PORT-2
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P3,A            ; 將LED 碼 送到PORT-3
        INC     DPTR            ; 指向下一筆 LED 顯示資
		CALL    DELAY_01S       ; 延遲時間 0.1 SECOND
		DJNZ    R1,d2
		JMP		START
		




;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; 副程式名稱 ︰ READ_LEDCODE
; 功  能    ︰ 讀LED 碼儲存在累積器 ACC 中
;使用暫存器  ︰ A,DPTR
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



READ_LEDCODE:
        MOV     A,#0            ;
        MOVC    A,@A+DPTR       ; 將查表所得之資料送至 P0
        RET



;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; 副程式名稱 ︰ DELAY_0.5S
;  功  能    ︰ 延遲時間 0.5 SECOND
;使用暫存器  ︰ R7,R6,R5
;延遲時間    T=1+R7*[1+R6*(1+R5*2+2)+2]+2
;             =1+5*[1+200*(1+1+248*2+2)+2]+2
;             =500018 us = 0.5 SEC
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

;DELAY_0.5S: 不能有小數點且不充許$符號

DELAY_05S:
        MOV     R7,#5
a3:        
        MOV     R6,#200  ; 需要１個機械週期
a2:
        MOV     R5,#248;
        NOP              ; 需要１個機械週期
a1: 
        DJNZ    R5,a1    ; 需要２個機械週期
        DJNZ    R6,a2
        DJNZ    R7,a3
        RET



;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; 副程式名稱 ︰ DELAY_0.1S
;  功  能    ︰ 延遲時間 0.1 SECOND
;使用暫存器  ︰ R7,R6,R5
;延遲時間    T=1+R7*[1+R6*(1+R5*2+2)+2]+2
;             =1+1*[1+200*(1+1+248*2+2)+2]+2
;             =99801 us = 0.1 SEC
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

;DELAY_0.1S: 不能有小數點且不充許$符號

DELAY_01S:
        MOV     R7,#1
b3:        
        MOV     R6,#200  ; 需要１個機械週期
b2:
        MOV     R5,#248
        NOP              ; 需要１個機械週期
b1: 
        DJNZ    R5,b1    ; 需要２個機械週期
        DJNZ    R6,b2
        DJNZ    R7,b3
        RET
		
		
		
		
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; LED_TABLE  的資料 1 表示LED 會亮
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


LED_TABLE:               ; LED 顯示資料表(資料開頭需為數字)

        DB      0FFH,0FFH,0FFH,0FFH   
		DB      0FFH,0FFH,0FFH,0FFH   		
        DB      7FH,0FEH,7FH,0FEH 
		DB      7FH,0FEH,7FH,0FEH 
        DB      3FH,0FCH,3FH,0FCH
		DB      3FH,0FCH,3FH,0FCH
        DB      1FH,0FBH,1FH,0FBH
		DB      1FH,0FBH,1FH,0FBH
        DB      0FH,0F0H,0FH,0F0H
		DB      0FH,0F0H,0FH,0F0H
        DB      07H,0E0H,07H,0E0H
		DB      07H,0E0H,07H,0E0H
        DB      03H,0C0H,03H,0C0H
		DB      03H,0C0H,03H,0C0H
        DB      01H,80H,01H,80H
		DB      01H,80H,01H,80H
        DB      00H,80H,01H,00H
		DB      00H,80H,01H,00H
		
        DB      01H,80H,01H,80H        
        DB      02H,40H,02H,40H        
        DB      04H,20H,04H,20H        
        DB      08H,10H,08H,10H       
        DB      10H,08H,10H,08H        
        DB      20H,04H,20H,04H       
        DB      40H,02H,40H,02H        
        DB      80H,01H,80H,01H        
        DB      00H,01H,00H,00H  
		
        DB      00H,00H,00H,00H        
        DB      0FFH,0FFH,0FFH,0FFH        
        DB      00H,00H,00H,00H        
        DB      0FFH,0FFH,0FFH,0FFH 
		DB      00H,00H,00H,00H		

END
