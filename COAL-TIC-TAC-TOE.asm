; TicTacToe
; by M. SHAGHIL, M. FAISAL, OMAR KHAN

INCLUDE Irvine32.inc
    
.DATA
board BYTE " 1      |2      |3      ",10,13,
           "        |       |       ",10,13,
           "        |       |       ",10,13,
           " -------+-------+-------",10,13, 
           " 4      |5      |6      ",10,13,
           "        |       |       ",10,13,
           "        |       |       ",10,13,
           " -------+-------+-------",10,13,
           " 7      |8      |9      ",10,13, 
           "        |       |       ",10,13,
           "        |       |       ",10,13,0
currPlayer       BYTE 'X'
choice           DWORD ?
winner           DWORD 0
Xwins            DWORD 0
Owins            DWORD 0
playAgainIn      BYTE 2 DUP (?)
msgIntro         BYTE "        TicTacToe        ",0
msgPlayAgain     BYTE "Do you want to Play again (y/n)? ",0
msgGoodBye       BYTE "Thanks for playing!",0
msgTurn          BYTE "'s turn. Pls choose a square: ",0
msgInvalidChoice BYTE "Invalid choice. Pls choose a square: ",0
msgTies          BYTE "Tie!!",0
msgWins          BYTE " wins!!",0

.CODE
printIntro     PROTO
chooseSquare   PROTO
checkWinner    PROTO
processWinner  PROTO
processTies    PROTO
clearBoard     PROTO
printBoard     PROTO
switchPlayer   PROTO
printGoodBye   PROTO

main PROC

     call printIntro

Play:  

     push OFFSET board
     call clearBoard
     
     ; print starting board
     push OFFSET board
     call printBoard


L1:   

     mov al,currPlayer             
     push eax                     
     push OFFSET board             
     call chooseSquare
     

     push OFFSET board
     call printBoard

   
     push OFFSET winner            
     mov al,currPlayer             
     push eax                      
     push OFFSET board             
     call checkWinner
     mov eax,winner
     cmp eax,1                     
     je Win
     cmp eax,2
     je Ties


     push OFFSET currPlayer        
     call switchPlayer
     jmp L1

Win:
     push OFFSET Owins
     push OFFSET Xwins
     mov al,currPlayer             
     push eax                     
     call processWinner
     jmp PlayAgain

Ties:
     push OFFSET Owins
     push OFFSET Xwins
     call processTies
     jmp PlayAgain
     
PlayAgain:

     mov edx,OFFSET msgPlayAgain
     call WriteString
     mov edx,OFFSET playAgainIn
     mov ecx,2
     call ReadString
     mov al,playAgainIn
     cmp al,'y'
     je Play
     cmp al,'n'
     je Finish
     
Finish: 

     call printGoodBye
     

     call WaitMsg
	
     exit
main ENDP




printIntro PROC
     mov  eax,black + (white * 16)
	 call SetTextColor
     mov edx,OFFSET msgIntro
     call WriteString
     call Crlf
     call Crlf
     ret
printIntro ENDP




clearBoard PROC

     push ebp
     mov  ebp,esp
     pushad


     mov esi,[ebp + 8]     
     mov bl,' '
     mov [esi + 30],bl
     mov [esi + 38],bl
     mov [esi + 46],bl
     mov [esi + 134],bl
     mov [esi + 142],bl
     mov [esi + 150],bl
     mov [esi + 238],bl
     mov [esi + 246],bl
     mov [esi + 254],bl


     popad
     pop  ebp
     ret  4
clearBoard ENDP




printBoard PROC

     push ebp
     mov  ebp,esp
     pushad

     ; print board
     mov edx,[ebp + 8]
     call WriteString


     popad
     pop  ebp
     ret  4
printBoard ENDP







chooseSquare PROC

     push ebp
     mov  ebp,esp
     pushad


     mov  eax,[ebp + 12]
     call WriteChar
     mov edx,OFFSET msgTurn
     call WriteString

Validate:
     call ReadDec
     mov  choice,eax
     cmp  choice,9
     ja   Invalid             
     cmp  choice,1
     jb   Invalid             
     cmp choice,1                         
     je Square1                
     cmp choice,2                         
     je Square2                
     cmp choice,3                         
     je Square3                
     cmp choice,4                         
     je Square4                
     cmp choice,5                         
     je Square5                
     cmp choice,6                         
     je Square6                
     cmp choice,7                         
     je Square7                
     cmp choice,8                         
     je Square8                
     cmp choice,9                         
     je Square9                
     jmp  Finish

Square1:
     mov esi,[ebp + 8]       
     add esi,30               
     mov bl,' '
     cmp [esi],bl            
     jne Invalid             
     mov bl,[ebp + 12]        
     mov [esi],bl             
     jmp Finish

Square2:
     mov esi,[ebp + 8]        
     add esi,38               
     mov bl,' '
     cmp [esi],bl           
     jne Invalid              
     mov bl,[ebp + 12]        
     mov [esi],bl            
     jmp Finish

Square3:
     mov esi,[ebp + 8]        
     add esi,46               
     mov bl,' '
     cmp [esi],bl         
     jne Invalid              
     mov bl,[ebp + 12]       
     mov [esi],bl             
     jmp Finish

Square4:
     mov esi,[ebp + 8]        
     add esi,134              
     mov bl,' '
     cmp [esi],bl            
     jne Invalid              
     mov bl,[ebp + 12]        
     mov [esi],bl             
     jmp Finish

Square5:
     mov esi,[ebp + 8]       
     add esi,142             
     mov bl,' '
     cmp [esi],bl             
     jne Invalid              
     mov bl,[ebp + 12]        
     mov [esi],bl             
     jmp Finish

Square6:
     mov esi,[ebp + 8]        
     add esi,150              
     mov bl,' '
     cmp [esi],bl             
     jne Invalid              
     mov bl,[ebp + 12]        
     mov [esi],bl          
     jmp Finish

Square7:
     mov esi,[ebp + 8]        
     add esi,238            
     mov bl,' '
     cmp [esi],bl           
     jne Invalid             
     mov bl,[ebp + 12]        
     mov [esi],bl             
     jmp Finish

Square8:
     mov esi,[ebp + 8]       
     add esi,246              
     mov bl,' '
     cmp [esi],bl             
     jne Invalid              
     mov bl,[ebp + 12]       
     mov [esi],bl             
     jmp Finish

Square9:
     mov esi,[ebp + 8]        
     add esi,254              
     mov bl,' '
     cmp [esi],bl             
     jne Invalid              
     mov bl,[ebp + 12]        
     mov [esi],bl             
     jmp Finish

Invalid:
     mov  edx,OFFSET msgInvalidChoice
     call WriteString
     jmp  Validate

Finish:
     ; clean up stack frame
     popad
     pop  ebp
     ret 8
chooseSquare ENDP









checkWinner PROC

     push ebp
     mov  ebp,esp
     pushad

     mov bl,[ebp + 12]       
     mov edi,[ebp + 16]       

CheckR1:
     mov esi,[ebp + 8]       
     add esi,30            
     cmp [esi],bl           
     jne CheckR2           
     add esi,8                
     cmp [esi],bl            
     jne CheckR2            
     add esi,8                
     cmp [esi],bl            
     jne CheckR2           
     jmp WinnerFound          

CheckR2:
     mov esi,[ebp + 8]        
     add esi,134              
     cmp [esi],bl             
     jne CheckR3            
     add esi,8                
     cmp [esi],bl             
     jne CheckR3            
     add esi,8                
     cmp [esi],bl             
     jne CheckR3            
     jmp WinnerFound          

CheckR3:
     mov esi,[ebp + 8]       
     add esi,238             
     cmp [esi],bl             
     jne CheckC1         
     add esi,8              
     cmp [esi],bl             
     jne CheckC1         
     add esi,8              
     cmp [esi],bl             
     jne CheckC1        
     jmp WinnerFound     

CheckC1:
     mov esi,[ebp + 8]       
     add esi,30           
     cmp [esi],bl             
     jne CheckC2         
     add esi,104              
     cmp [esi],bl            
     jne CheckC2         
     add esi,104            
     cmp [esi],bl        
     jne CheckC2         
     jmp WinnerFound       

CheckC2:
     mov esi,[ebp + 8]       
     add esi,38              
     cmp [esi],bl             
     jne CheckC3         
     add esi,104              
     cmp [esi],bl           
     jne CheckC3         
     add esi,104            
     cmp [esi],bl            
     jne CheckC3         
     jmp WinnerFound          

CheckC3:
     mov esi,[ebp + 8]        
     add esi,46              
     cmp [esi],bl         
     jne CheckDiagonal1       
     add esi,104              
     cmp [esi],bl             
     jne CheckDiagonal1       
     add esi,104              
     cmp [esi],bl             
     jne CheckDiagonal1      
     jmp WinnerFound         

CheckDiagonal1:
     mov esi,[ebp + 8]        
     add esi,30               
     cmp [esi],bl             
     jne CheckDiagonal2       
     add esi,112              
     cmp [esi],bl             
     jne CheckDiagonal2      
     add esi,112             
     cmp [esi],bl          
     jne CheckDiagonal2       
     jmp WinnerFound          

CheckDiagonal2:
     mov esi,[ebp + 8]      
     add esi,46             
     cmp [esi],bl          
     jne CheckTies         
     add esi,96             
     cmp [esi],bl            
     jne CheckTies         
     add esi,96            
     cmp [esi],bl     
     jne CheckTies            
     jmp WinnerFound         

CheckTies:
     mov esi,[ebp + 8]       
     mov bl,' '
     cmp [esi + 30],bl       
     je NoWinnerFound         
     cmp [esi + 38],bl
     je NoWinnerFound
     cmp [esi + 46],bl
     je NoWinnerFound
     cmp [esi + 134],bl
     je NoWinnerFound
     cmp [esi + 142],bl
     je NoWinnerFound
     cmp [esi + 150],bl
     je NoWinnerFound
     cmp [esi + 238],bl
     je NoWinnerFound
     cmp [esi + 246],bl
     je NoWinnerFound
     cmp [esi + 254],bl
     je NoWinnerFound
     jmp TiesFound

NoWinnerFound:
     mov edx,0
     mov [edi],edx
     jmp Finish

WinnerFound:
     mov edx,1
     mov [edi],edx
     jmp Finish

TiesFound:
     mov edx,2
     mov [edi],edx
     jmp Finish

Finish:

     popad
     pop  ebp
     ret 12
checkWinner ENDP







processWinner PROC

     push ebp
     mov  ebp,esp
     pushad


     mov eax,[ebp + 8]
     mov esi,[ebp + 12]           
     mov edi,[ebp + 16]          


     call WriteChar
     mov edx,OFFSET msgWins
     call WriteString
     call Crlf

     popad
     pop  ebp
     ret 16
processWinner ENDP






processTies PROC

     push ebp
     mov  ebp,esp
     pushad


     mov edx,OFFSET msgTies 
     call WriteString
     call Crlf





     popad
     pop  ebp
     ret 12
processTies ENDP




switchPlayer PROC

     push ebp
     mov  ebp,esp
     pushad


     mov esi,[ebp + 8]   
     mov ebx,[esi]            


     mov ecx,'X'
     mov edx,'O'


     cmp bl,cl               
     je XtoO
     cmp bl,dl            
     je OtoX


XtoO:
     mov bl,dl
     jmp Finish
OtoX:
     mov bl,cl
     jmp Finish
     
Finish:

     mov [esi],bl

    
     popad
     pop  ebp
     ret 4
switchPlayer ENDP




printGoodBye PROC

     push ebp
     mov  ebp,esp
     pushad


     mov edx,OFFSET msgGoodBye
     call WriteString
     call Crlf


     popad
     pop  ebp
     ret
printGoodBye ENDP

END main