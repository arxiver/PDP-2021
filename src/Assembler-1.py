import re

Assembly_opcode_map={}
one_operand_opcode_map={} # Why it's here***
Opcode_assembly_out=[]

One_operand_opcodes=[]
Two_operand_opcodes=[]
Zero_operand_opcodes=[]
Branch_operand_opcodes=[]
Jump_operand_opcodes=[]


#these 4 functions will fill the Assembly_opcode_map with {"assembly , opcode "}
#could be more than 4 i don't know .

#Filling the map
#################

def oneoperand_opcode_map_append():
    Assembly_opcode_map['INC']='0000' #0
    Assembly_opcode_map['DEC']='0001' #1
    Assembly_opcode_map['CLR']='0010' #2
    Assembly_opcode_map['INV']='0011' #3
    Assembly_opcode_map['LSR']='0100' #4
    Assembly_opcode_map['ROR']='0101' #5
    Assembly_opcode_map['RRC']='0110' #6
    Assembly_opcode_map['ASR']='0111' #7
    Assembly_opcode_map['LSL']='1000' #8
    Assembly_opcode_map['ROL']='1001' #9
    Assembly_opcode_map['RLC']='1010' #0
    

def twooperands_opcode_map_append():
    Assembly_opcode_map["MOV"]  = "0100" # 4 in octal
    Assembly_opcode_map["CMP"]  = "0101" # 5 in octal
    Assembly_opcode_map["ADD"]  = "0110" # 6 in octal 
    Assembly_opcode_map["SUB"]  = "0111" # 7 in octal
    Assembly_opcode_map["ADC"]  = "1000" # 8 in octal
    Assembly_opcode_map["SBC"]  = "1001" # 9 in octal
    Assembly_opcode_map["AND"]  = "1010" # 10 in octal
    Assembly_opcode_map["OR"]   = "1011" # 11 in octal
    Assembly_opcode_map["XNOR"] = "1100" # 12 in octal


def branching_opcode_map_append():
    Assembly_opcode_map["BR"]   = "000"
    Assembly_opcode_map["BEQ"]  = "001"
    Assembly_opcode_map["BNE"]  = "010"
    Assembly_opcode_map["BLO"]  = "011"
    Assembly_opcode_map["BLS"]  = "100"
    Assembly_opcode_map["BHI"]  = "101"
    Assembly_opcode_map["BHS"]  = "110"


def zero_opcode_map_append():
    Assembly_opcode_map["HLT"] = "0000000000000000"
    Assembly_opcode_map["NOP"] = "0000000000000001"

def jump_opcode_map_append():
    pass



def registers_adressing_modes_map_append():    
    Assembly_opcode_map["R0"] = "000000" 
    Assembly_opcode_map["(R0)+"] = "010000"
    Assembly_opcode_map["-(R0)"] = "100000" 
    Assembly_opcode_map["X(R0)"] = "110000"
    Assembly_opcode_map["@R0"] = "001000"
    Assembly_opcode_map["@(R0)+"] = "011000"
    Assembly_opcode_map["@-(R0)"] = "101000"
    Assembly_opcode_map["@X(R0)"] = "111000"
    ###########################################################
    Assembly_opcode_map["R1"] = "000001" 
    Assembly_opcode_map["(R1)+"] = "010001"
    Assembly_opcode_map["-(R1)"] = "100001" 
    Assembly_opcode_map["X(R1)"] = "110001"
    Assembly_opcode_map["@R1"] = "001001"
    Assembly_opcode_map["@(R1)+"] = "011001"
    Assembly_opcode_map["@-(R1)"] = "101001"
    Assembly_opcode_map["@X(R1)"] = "111001"
    ###########################################################
    Assembly_opcode_map["R2"] = "000010" 
    Assembly_opcode_map["(R2)+"] = "010010"
    Assembly_opcode_map["-(R2)"] = "100010" 
    Assembly_opcode_map["X(R2)"] = "110010"
    Assembly_opcode_map["@R2"] = "001010"
    Assembly_opcode_map["@(R2)+"] = "011010"
    Assembly_opcode_map["@-(R2)"] = "101010"
    Assembly_opcode_map["@X(R2)"] = "111010"
    ################################################################
    Assembly_opcode_map["R3"] = "000011" 
    Assembly_opcode_map["(R3)+"] = "010011"
    Assembly_opcode_map["-(R3)"] = "100011" 
    Assembly_opcode_map["X(R3)"] = "110011"
    Assembly_opcode_map["@R3"] = "001011"
    Assembly_opcode_map["@(R3)+"] = "011011"
    Assembly_opcode_map["@-(R3)"] = "101011"
    Assembly_opcode_map["@X(R3)"] = "111011"
    ########################################################
    Assembly_opcode_map["R4"] = "000100" 
    Assembly_opcode_map["(R4)+"] = "010100"
    Assembly_opcode_map["-(R4)"] = "100100" 
    Assembly_opcode_map["X(R4)"] = "110100"
    Assembly_opcode_map["@R4"] = "001100"
    Assembly_opcode_map["@(R4)+"] = "011100"
    Assembly_opcode_map["@-(R4)"] = "101100"
    Assembly_opcode_map["@X(R4)"] = "111100"
    ########################################################
    Assembly_opcode_map["R5"] = "000101" 
    Assembly_opcode_map["(R5)+"] = "010101"
    Assembly_opcode_map["-(R5)"] = "100101" 
    Assembly_opcode_map["X(R5)"] = "110101"
    Assembly_opcode_map["@R5"] = "001101"
    Assembly_opcode_map["@(R5)+"] = "011101"
    Assembly_opcode_map["@-(R5)"] = "101101"
    Assembly_opcode_map["@X(R5)"] = "111101"
    ##############################################################
    Assembly_opcode_map["R6"] = "000110" 
    Assembly_opcode_map["(R6)+"] = "010110"
    Assembly_opcode_map["-(R6)"] = "100110" 
    Assembly_opcode_map["X(R6)"] = "110110"
    Assembly_opcode_map["@R6"] = "001110"
    Assembly_opcode_map["@(R6)+"] = "011110"
    Assembly_opcode_map["@-(R6)"] = "101110"
    Assembly_opcode_map["@X(R6)"] = "111110"
    ###############################################################
    Assembly_opcode_map["R7"] = "000111" 
    Assembly_opcode_map["(R7)+"] = "010111"
    Assembly_opcode_map["-(R7)"] = "100111" 
    Assembly_opcode_map["X(R7)"] = "110111"
    Assembly_opcode_map["@R7"] = "001111"
    Assembly_opcode_map["@(R7)+"] = "011111"
    Assembly_opcode_map["@-(R7)"] = "101111"
    Assembly_opcode_map["@X(R7)"] = "111111"
    

# Filling the list of each category of operation
################################################
def one_operand_opcode_append():
    One_operand_opcodes.extend(['INC','DEC','CLR','INV','LSR','ROR','RRC','ASR','LSR','ROL','RLC'])

def two_operand_opcode_append():
    Two_operand_opcodes.extend(["MOV", "ADD" , "ADC" , "CMP" , "SUB" , "SBC" , "AND" , "XNOR" , "OR"])

def zero_operand_opcode_append():
    Zero_operand_opcodes.extend(["HLT" , "NOP"])

def branch_operand_opcode_append():
    Branch_operand_opcodes.extend(["BR" , "BEQ" , "BNE" , "BLO" , "BLS" , "BHI" , "BHS"])

def jump_operand_opcode_append():
    Jump_operand_opcodes.extend(["JSR" , "RTS" , "IRET" , "INTERRUPT"])

# Converting the instructions
###########################
#this 3 functions will take an assembly line as an input
#and return the corresponding opcode

def zeroperand_opcode_convert(OpCode):
    opcode=[]
    opcode.append(Assembly_opcode_map.get(OpCode))
    return opcode


def segment_one_operand(line):
    Segment = line.split(" ")
    OpCode = Segment[0]
    Src = Segment[1]
    OpCode = OpCode.strip()
    Src = Src.strip()
    return [OpCode , Src] 

def oneoperand_opcode_convert(OpCode,Dis):
    temp = []
    opcode=[]
    temp[0:4] = "0001"
    temp[4:8] = list(Assembly_opcode_map.get(OpCode))
    temp[8:10] = "00"
    temp[10:16] = list(Assembly_opcode_map.get(Dis))
    String = ''.join(temp)
    opcode.append(String)
    return opcode


def segment_two_operand(line):
    Segment = line.split(" ")
    OpCode = Segment[0]
    Src = Segment[1]
    Dis = Segment[2]
    Src = Src[0:-1]
    OpCode = OpCode.strip()
    Src = Src.strip()
    Dis = Dis.strip()
    return [OpCode , Src , Dis]


def twooperands_opcode_convert(OpCode, Src, Dis):
    temp = []
    opcode=[]
    temp[0:4] = list(Assembly_opcode_map.get(OpCode))
    temp[4:10] = list(Assembly_opcode_map.get(Src))
    temp[10:16] = list(Assembly_opcode_map.get(Dis))
    String = ''.join(temp)
    opcode.append(String)
    return opcode

def segment_branching(line):
    Segment = line.split(" ")
    OpCode = Segment[0]
    Offset = Segment[1]
    OpCode = OpCode.strip()
    Offset = Offset.strip()
    return [OpCode , Offset]

def branching_opcode_convert(OpCode , Offset):
    temp = []
    opcode=[]
    temp[0:4] = "0010"
    temp[4:7] = list(Assembly_opcode_map.get(OpCode))
    temp[7:8] = "0"
    temp[8:16] = list(decimal2binary(int(Offset),8))
    String = ''.join(temp)
    opcode.append(String)
    return opcode


def number_convert(line):
    opcode=[]
    opcode.append(decimal2binary(int(line),16))
    return opcode




#this function to read assembly from file reomve the comments
#retrun array of strings (assembly lines)
def readInputFile():
    #read from input file
    myfile=open("input.txt", "r")
    #contents will be array of lines from assembly
    contents=myfile.readlines()
    # a directory to store key:value pairs
    assemblylines=[]
    for line in contents:        
        if(line=='\n' or line == ''):         
            continue   
        if(line.endswith("\n")):
            line = line[:-1]
        removecomments=line.split(';')[0]
        if(removecomments==''):
            continue
        removetabs=removecomments.split('\t')[0]
        if removetabs=='':
            continue
        assemblylines.append(removetabs.upper())
    return assemblylines


#this function will return what type of assembly line it is to deal with it
def type_of_instruction(line):
    # zero operand => 0
    # one operand  => 1
    # two operand  => 2
    # branch => 3
    # jump => 4
    #....................
    Opcode = line.split(" ",1)[0]

    if Opcode in Zero_operand_opcodes:
        return 0

    if Opcode in One_operand_opcodes:
        return 1

    if Opcode in Two_operand_opcodes:
        return 2

    if Opcode in Branch_operand_opcodes:
        return 3

    if Opcode in Jump_operand_opcodes:
        return 4


#this function will convert every line of assembly instruction
#into the coresponding binary code
def convert_assembly_binary(assembilylines):    
    opcode=[]
    #array of opcode lines (could be 1 or 2 or 3  i think)
    for line in assembilylines:
        ins_type=type_of_instruction(line)
        if ins_type == 0:
            # There is no segmentation in zero operand
            opcode=zeroperand_opcode_convert(line)

        elif ins_type == 1:
            Segments = segment_one_operand(line)
            opcode=oneoperand_opcode_convert(Segments[0],Segments[1]) 

        elif ins_type == 2:
            Segments = segment_two_operand(line)
            opcode=twooperands_opcode_convert(Segments[0],Segments[1],Segments[2])

        elif ins_type == 3:
            Segments = segment_branching(line)
            opcode=branching_opcode_convert(Segments[0] , Segments[1])

        else:
            opcode=number_convert(line)

        for opline in opcode:
            Opcode_assembly_out.append(opline)
    

#this file will output the binarycode generated into a file
def writeOutputFile():   
    f=open("IR.txt", "w+")     
    for opline in Opcode_assembly_out:        
        f.write(opline+"\n")


def decimal2binary(x,n = 0):
    binary = []
    def decimaltobinary(y,n):
        if y > 1 or n >= 1:
            decimaltobinary(y/2 , n-1)
            binary.append(int(y%2))

    Negative = False
    if(x < 0):
        Negative = True

    decimaltobinary(abs(x),n)

    if(Negative == True):
        binary[0] = '1'

    for i in range(len(binary)):
        binary[i] = str(binary[i])

    string = ''.join(binary)
    return string
        
def getVariablesNames(assembly):
    variables_list=[]
    for i in range(len(assembly)-1,-1,-1):
        if len(re.findall("DEFINE", assembly[i]))!=0:
            variables_list.append(assembly[i].split()[1])
        else :
            break
    return variables_list
        
    
def preAssembler(assembly):
    variables_names=getVariablesNames(assembly)
    labels_name=[]
    labels_name_address={}
    variabels_name_address={}
    pdp_assembly=[]    
    for line in assembly:
        matches = [x for x in variables_names if x+',' in line or ' '+x in line]
        if(len(re.findall(",", line))==1):#two operand instructions
            if(len(re.findall('#',line))==1 and len(matches)==1):#immediate value and variable
                opcode=line.split()[0]
                immediate_value=line.split()[1].replace(",","").replace("#", "")
                distenation=line.split()[2]
                pdp_assembly.append(opcode+" (R7)+, "+"X(R7)")
                pdp_assembly.append(immediate_value)
                pdp_assembly.append(distenation)
            elif(len(re.findall('#',line))==1): #immediate value 
                opcode=line.split()[0]
                immediate_value=line.split()[1].replace(",","").replace("#", "")
                distenation=line.split()[2]           
                pdp_assembly.append(opcode+" (R7)+, "+distenation)
                pdp_assembly.append(immediate_value)
            elif(len(matches)==2):#means two variables so will be opcode X(R7)+,X(R7)+ then virst variable then the next variable
                opcode=line.split()[0]
                variable1=matches[0]
                variable2=matches[1]
                pdp_assembly.append(opcode+" X(R7), "+"X(R7)")
                pdp_assembly.append(variable1)#variable of the src 
                pdp_assembly.append(variable2)#variable of dst
            elif(len(matches)==1):#only one variable i have to detect where it is and act accordingly
                opcode=line.split()[0]
                op1=line.split()[1].replace(',','')
                op2=line.split()[2]
                if op1 in matches:
                    pdp_assembly.append(opcode+" X(R7), "+op2)
                    pdp_assembly.append(op1)
                else:
                    pdp_assembly.append(opcode+" "+op1+ ", X(R7)")
                    pdp_assembly.append(op2)   
            else:#this means normal mode line opcode R1,R2 or whatever
                pdp_assembly.append(line)
        elif line.split()[0] in One_operand_opcodes:#this means one operand instruction
            opcode=line.split()[0]
            dst=line.split()[1]
            if(dst in matches):#this means variable
                pdp_assembly.append(opcode+' X(R7)')
                pdp_assembly.append(dst)
            else:
                pdp_assembly.append(line)
        elif(len(re.findall(':',line))==1):#this means a label i will save the address and the name
            labels_name_address[line.replace(':','').replace(' ','')]=len(pdp_assembly)
            labels_name.append(line.replace(':','').replace(' ',''))
                            
        elif(len(re.findall('DEFINE',line))==1):#this means variable address
            variabels_name_address[line.split()[1]]=len(pdp_assembly)
            pdp_assembly.append(line.split()[2])
        else:
            pdp_assembly.append(line)
    
    for i in range(len(pdp_assembly)):
        if(pdp_assembly[i] in variables_names):            
            pdp_assembly[i]=str(variabels_name_address[pdp_assembly[i]]-i+1)
            continue        
        findlabel = [x for x in labels_name if x in pdp_assembly[i]]
        if(len(findlabel)>0):
            pdp_assembly[i]=pdp_assembly[i].split()[0]+" "+str(labels_name_address[findlabel[0]]-i+1)
    return pdp_assembly        
            
            
            
            
                    
                    
                
            
                
            
        
    
    


if __name__ == "__main__":
    assemblylines=readInputFile()


    #clear mapping and output
    Assembly_opcode_map.clear()
    Opcode_assembly_out.clear()



    # fill the mapping
    oneoperand_opcode_map_append()
    twooperands_opcode_map_append()
    branching_opcode_map_append()
    zero_opcode_map_append()
    jump_opcode_map_append()
    registers_adressing_modes_map_append()


    # fill each type of instruction
    one_operand_opcode_append()
    two_operand_opcode_append()
    zero_operand_opcode_append()
    branch_operand_opcode_append()
    jump_operand_opcode_append()


    assemblylines = (preAssembler(assemblylines))
    convert_assembly_binary(assemblylines)


    #write the opcode out to a file
    writeOutputFile()

    # for i in assemblylines:
    #     print(i)
    #print(Opcode_assembly_out)




#main function
# '''if __name__ == "__main__":

#     #clear mapping and output
#     Assembly_opcode_map.clear()
#     Opcode_assembly_out.clear()

#     #fill the mapping
#     oneoperand_opcode_map_append()
#     twooperands_opcode_map_append()
#     addressing_modes_regisers_map_append()
#     registers_adressing_modes_map_append()
#     # registers_map_append()

#     #fill the opcodes 
#     one_operand_opcode_append()
#     two_operand_opcode_append()
#     zero_operand_opcode_append()
#     branch_operand_opcode_append()
#     jump_operand_opcode_append()

#     #read assembly file
#     assemblylines=readInputFile()
    

#     #convert into binary
#     convert_assembly_binary(assemblylines)
#     # print(Opcode_assembly_out)


#     #write the opcode out to a file
#     writeOutputFile()
#     '''