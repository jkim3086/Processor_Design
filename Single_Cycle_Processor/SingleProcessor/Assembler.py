import sys
import re

# Intial Declaration 
Opcode_Map = dict(dict.fromkeys(["ADD", "SUB", "AND", "OR", "XOR", "NAND", "NOT", "NOR", "XNOR"], 12))
Opcode_Map.update(dict.fromkeys(["ADDI", "SUBI", "ANDI", "ORI", "XORI", "NANDI", "NORI", "XNORI", "MVHI"], 4))
Opcode_Map.update(dict.fromkeys(["LW"], 7))
Opcode_Map.update(dict.fromkeys(["SW"], 3))
Opcode_Map.update(dict.fromkeys(["F", "EQ", "LT", "LTE", "T", "NE", "GTE", "GT"], 13))
Opcode_Map.update(dict.fromkeys(["FI", "EQI", "LTI", "LTEI", "TI", "NEI", "GTEI", "GTI"], 5))
Opcode_Map.update(dict.fromkeys(["BF", "BEQ", "BLT", "BLTE", "BEQZ", "BLTZ", "BLTEZ", "BT", "BNE", "BGTE", "BGT", "BNEZ", "BGTEZ", "BGTZ", "BR"], 2))
Opcode_Map.update(dict.fromkeys(["JAL", "CALL", "RET"], 6))

Function_Map = dict(dict.fromkeys(["AND", "ANDI", "T", "TI", "BT", "JAL", "LW", "SW", "CALL", "RET"], 0))
Function_Map.update(dict.fromkeys(["OR", "ORI", "BNEZ"], 1))
Function_Map.update(dict.fromkeys(["XOR", "XORI", "BEQZ"], 2))
Function_Map.update(dict.fromkeys(["F", "FI", "BF"], 3))
Function_Map.update(dict.fromkeys(["NE", "NEI", "BNE"], 5))
Function_Map.update(dict.fromkeys(["SUB", "SUBI", "EQ", "EQI", "BEQ", "BR"], 6))
Function_Map.update(dict.fromkeys(["ADD", "ADDI"], 7))
Function_Map.update(dict.fromkeys(["NAND", "NOT", "NANDI", "BLTEZ"], 8))
Function_Map.update(dict.fromkeys(["NOR", "NORI", "LT", "LTI", "BLT"], 9))
Function_Map.update(dict.fromkeys(["XNOR", "XNORI", "GTE", "GTEI", "BGTE"], 10))
Function_Map.update(dict.fromkeys(["BGT"], 11))
Function_Map.update(dict.fromkeys(["LTE", "LTEI", "BLTE"], 12))
Function_Map.update(dict.fromkeys(["BLTZ"], 13))
Function_Map.update(dict.fromkeys(["BGTEZ"], 14))
Function_Map.update(dict.fromkeys(["GT", "GTI", "BGTZ", "MVHI"], 15))

Registers = dict(dict.fromkeys(["R0", "A0"], 0))
Registers.update(dict.fromkeys(["R1", "A1"], 1))
Registers.update(dict.fromkeys(["R2", "A2"], 2))
Registers.update(dict.fromkeys(["R3", "A3", "RV"], 3))
Registers.update(dict.fromkeys(["R4", "T0"], 4))
Registers.update(dict.fromkeys(["R5", "T1"], 5))
Registers.update(dict.fromkeys(["R6", "S0"], 6))
Registers.update(dict.fromkeys(["R7", "S1"], 7))
Registers.update(dict.fromkeys(["R8", "S2"], 8))
Registers.update(dict.fromkeys(["R9"], 9))
Registers.update(dict.fromkeys(["R10"], 10))
Registers.update(dict.fromkeys(["R11"], 11))
Registers.update(dict.fromkeys(["R12", "GP"], 12))
Registers.update(dict.fromkeys(["R13", "FP"], 13))
Registers.update(dict.fromkeys(["R14", "SP"], 14))
Registers.update(dict.fromkeys(["R15", "RA"], 15))

Branch_Zero = ["BEQZ", "BLTZ", "BLTEZ", "BNEZ", "BGTEZ", "BGTZ"]

Pseudo_Instrs = ["NOT", "BLE","BGE"]

dec2hex = { 0: "0",
                      1: "1",
                      2: "2",
                      3: "3",
                      4: "4",
                      5: "5",
                      6: "6",
                      7: "7",
                      8: "8",
                      9: "9",
                      10: "a",
                      11: "b",
                      12: "c",
                      13: "d",
                      14: "e",
                      15: "f",
                      -1: ""   # This is used for pseudo instrs
                    }
#//////////////// label-convert Start///////////////
def label_convert(cur_address, label_address):
	if cur_address < label_address:
		#return "%4.4x" % (label_address & 0xffff)
		return (label_address/4)
	else:
		#result = int(((label_address-cur_address) & 0xffff))
		return ((label_address-cur_address - 1)/4)
	'''
	if cur_address < label_address:
		return label_address
	else:
		return label_address - cur_address
	'''
#//////////////// label-convert End///////////////

#//////////////// label-convert Start///////////////
def branch_address_calculation(cur_address, label_address):
		return ((label_address-cur_address - 1)/4)
#//////////////// label-convert End///////////////


#//////////////// Pre-running Start///////////////
def pre_run(in_file):

	global label_dict
	global cur_addr

	with open(in_file) as a32:
		for line in a32:
		    line = line.strip()
		    comment_index = line.find(';')
		    if comment_index != -1:
		        line = line[:comment_index]
		    if line:
		        words = line.split()
		        if line[0] == '.':
		            if words[0] == ".NAME":
		                rest = "".join(words[1:])
		                rest = rest.split('=')
		                #label_dict[rest[0]] = int(rest[1], 0)
		                Name_label_dict[rest[0]] = int(rest[1], 0)
		            elif words[0] == ".ORIG":
		                start_addr = int(words[1], 0)
		                cur_addr = start_addr
		            elif words[0] == ".WORD":
		            	#print "word: %s" % cur_addr
		                cur_addr += 4
		        elif words[0][-1] == ':':
					if words[0][0:-1] == "GoodChkAsc":
						print ""
						#print"pre-run cur: %s " % cur_addr		
					label_dict[words[0][0:-1]] = (cur_addr)
		        else:
					cur_addr += 4
					#print "End Line: %s" % cur_addr



#//////////////// Pre-running End///////////////



#///////////////////////////////////

#insts is a list of inst. inst[0] is the instruction (eg MVHI) and inst[1] is the rest
def inst2bin(insts):
    global cur_addr

    for inst in insts:
				if inst[0].upper() == "RET":
					mif.write(("-- @ 0x%8.8x : %s\n" % (cur_addr, "RET")))
				elif inst[0].upper() == "BR":
					imm_display = re.split(',|\(|\)', inst[1])
					mif.write(("-- @ 0x%8.8x : %s %s\n" % (cur_addr, "BR", imm_display[2])))
				elif inst[0].upper() == "JMP":
					imm_display = re.split(',', inst[1])
					mif.write(("-- @ 0x%8.8x : %s %s\n" % (cur_addr, "JMP", imm_display[1])))
				else:
					mif.write(("-- @ 0x%8.8x : %s %s\n" % (cur_addr, inst[0].upper(), inst[1].upper())))

				# TODO: binary code translation
				op_map = dec2hex[Opcode_Map[inst[0].upper()]]
				func_map = dec2hex[Function_Map[inst[0].upper()]]
				code = ""
				# PSEUDO INSTRS
				# The reason why I am using upper method here is that 
				# it seems some instructions are converted into upper-case, but some others are not.
				if inst[0].upper() in Pseudo_Instrs:
					unused = "000"
					regs = inst[1].split(",")
					rd = Registers[regs[0].upper()]
					rs1 = Registers[regs[1].upper()]
					if inst[0].upper() == "NOT":
						rs2 = rs1                  
						code = op_map+""+func_map+""+dec2hex[rd]+dec2hex[rs1]+dec2hex[rs2]+unused	              
				# ALU-R and CMP-R
				elif op_map == "d" or op_map == "c":
					unused = "000"
					print "CMP-R: %s" % inst
					regs = inst[1].split(",")
					rd = Registers[regs[0].upper()]
					rs1 = Registers[regs[1].upper()]
					rs2 = Registers[regs[2].upper()]
					code = op_map+""+func_map+""+dec2hex[rd]+dec2hex[rs1]+dec2hex[rs2]+unused
                # ALU-I and CMP-I
				elif (op_map == "4" or op_map == "5"):
					reg_imm = inst[1].split(",")
					# if MVHI
					if func_map == "f":
						rd = Registers[reg_imm[0].upper()]
						imm = ""
						if label_dict.has_key(reg_imm[1]):
							#imm = label_dict[reg_imm[1]] 
							imm = label_convert(cur_addr, label_dict[reg_imm[1]])
							imm = "%4.4x" % ((imm & 0xffff0000) >> 16)
						elif Name_label_dict.has_key(reg_imm[1]):
							imm = Name_label_dict[reg_imm[1]]
							imm = "%4.4x" % ((imm & 0xffff0000) >> 16)
						else:
							imm = "%4.4x" % ((int(reg_imm[1], 0) & 0xffff0000) >> 16)
						code = op_map+func_map+dec2hex[rd]+"0"+imm
					else:
						rd = Registers[reg_imm[0].upper()]
						rs1 = Registers[reg_imm[1].upper()]
						imm = ""
						if label_dict.has_key(reg_imm[2]):
							imm = label_convert(cur_addr, label_dict[reg_imm[2]])
                            #imm = label_convert(cur_addr, label_dict[reg_imm[2]]) // Not applicable to .NAME vars
							imm = "%4.4x" % (imm & 0xffff)
						elif Name_label_dict.has_key(reg_imm[2]):
							imm = Name_label_dict[reg_imm[2]]
							imm = "%4.4x" % (imm & 0xffff)
						else:
							imm = "%4.4x" % (int(reg_imm[2], 0) & 0xffff)
						code = op_map+func_map+dec2hex[rd]+dec2hex[rs1]+imm
				# Branch
				elif op_map == "2":
					regs = re.split(',|\(|\)', inst[1])
					reg_imm = inst[1].split(",")
					rd = Registers[regs[0].upper()]
					imm = ""                           
					if inst[0] in Branch_Zero:
						rs1 = 0
						if label_dict.has_key(regs[1]):
							imm = label_convert(cur_addr, label_dict[regs[1]])
							imm = "%4.4x" % (imm & 0xffff)
						elif Name_label_dict.has_key(regs[1]):
							offset = Name_label_dict[regs[1]]
							offset = "%4.4x" % (offset & 0xffff)
					else:
						rs1 = Registers[regs[1].upper()]
						if label_dict.has_key(regs[2]):
							#print "Branch2 inst: %s" % (inst)
							#print "Branch2 cur: %s | label: %s" % (cur_addr, label_dict[regs[2]])
							# imm = label_dict[regs[2]]		origin
							#imm = label_convert(cur_addr, label_dict[regs[2]])
							imm = branch_address_calculation(cur_addr, label_dict[regs[2]])
							imm = "%4.4x" % (imm & 0xffff)
						elif inst[0] == "bt":
							imm = "%4.4x" % (cur_addr+8)           
					code = op_map+func_map+dec2hex[rd]+dec2hex[rs1]+imm
				# JAL, CALL
				elif op_map == "6":
					regs = re.split(',|\(|\)', inst[1])
					# Try to handle CALL instruction without messing up the orginal print statement
					index = 0; # this fixes the index of regs for CALL inst
					if inst[0].upper() == "CALL":
						rd = Registers["RA"]
						index = 1;
					else:
						rd = Registers[regs[0].upper()]
					offset = "";
					if label_dict.has_key(regs[1-index]):
						#offset = (label_dict[regs[1-index]] - cur_addr) / 4
						#print "CUR_ADDRESS: %s" % cur_addr
						offset = label_convert(cur_addr, label_dict[regs[1-index]])
						offset = "%4.4x" % (offset & 0xffff)
					elif Name_label_dict.has_key(regs[1]):
							offset = Name_label_dict[regs[1]]
							offset = "%4.4x" % (offset & 0xffff)
					else:						
						offset = "%4.4x" % (int(regs[1-index], 0) & 0xffff)
					rs1 = Registers[regs[2-index].upper()]	
					code = op_map+func_map+dec2hex[rd]+dec2hex[rs1]+offset
                # LW
				elif op_map == "7":
					regs = re.split(',|\(|\)', inst[1])
					rd = Registers[regs[0].upper()]
					offset = "";
					if label_dict.has_key(regs[1]):
						#offset = (label_dict[regs[1]]) / 4 Chenkai
						offset = (label_dict[regs[1]])
						offset = "%4.4x" % (offset & 0xffff)
					elif Name_label_dict.has_key(regs[1]):
							offset = Name_label_dict[regs[1]]
							offset = "%4.4x" % (offset & 0xffff)
					else:
						offset = "%4.4x" % (int(regs[1], 0) & 0xffff)
					rs1 = Registers[regs[2].upper()]
					code = op_map+func_map+dec2hex[rd]+dec2hex[rs1]+offset
				# SW
				elif op_map == "3":
					regs = re.split(',|\(|\)', inst[1])
					rs2 = Registers[regs[0].upper()]
					if label_dict.has_key(regs[1]):
						#offset = (label_dict[regs[1]]) / 4 Chenkai
						offset = (label_dict[regs[1]])
						offset = "%4.4x" % (offset & 0xffff)
					elif Name_label_dict.has_key(regs[1]):
							offset = Name_label_dict[regs[1]]
							offset = "%4.4x" % (offset & 0xffff)
					else:
						offset = "%4.4x" % (int(regs[1], 0) & 0xffff)
					rs1 = Registers[regs[2].upper()]
					code = op_map+func_map+dec2hex[rs2]+dec2hex[rs1]+offset

				mif.write("%8.8x : %s;\n" % (cur_addr / 4, code))
				cur_addr += 4

#///////////////////////////////////
if len(sys.argv) < 2:
    print "Usage: python Assembler.py [a32 file name] [mif file name]"
    sys.exit(1)

in_file = sys.argv[1]
out_file = sys.argv[2]

inst_mem_size_words = 2048
data_mem_size_bytes = 8192

label_dict = {}
Name_label_dict = {}
cur_addr = 0

pre_run(in_file)
for k, v in label_dict.items():
	    print(k,v)
cur_addr = 0;

mif = open(out_file, 'w')
mif.write("WIDTH=32;\n")
mif.write("DEPTH=2048;\n")
mif.write("ADDRESS_RADIX=HEX;\n")
mif.write("DATA_RADIX=HEX;\n")
mif.write("CONTENT BEGIN\n")

with open(in_file) as a32:
    #lines = a32.readlines()
    #a32.read().splitlines()
	for line in a32:
		# Get rid of the starting and ending whitespace
		line = line.strip()
		# Get rid of the comments
		comment_index = line.find(';')
		if comment_index != -1:
		    line = line[:comment_index]
		# Processing a line if it is not empty
		if line:
			#line_count += 1
			words = line.split()
			if line[0] == '.':
				if words[0] == ".NAME":
					print ""
				elif words[0] == ".ORIG":
				    start_addr = int(words[1], 0)
				    if start_addr != cur_addr:
				    	if ((cur_addr/4) != (start_addr / 4 - 1)):
				        	mif.write("[%8.8x..%8.8x] : DEAD;\n" % (cur_addr, start_addr / 4 - 1))
			        	else:
			        		mif.write("%8.8x : DEAD;\n" % (cur_addr/4))
				    cur_addr = start_addr
				elif words[0] == ".WORD":
				    mif.write("-- @ 0x%8.8x : %s %s\n" % (cur_addr, words[0].upper(), words[1].upper()))
				    code = ""
				    if label_dict.has_key(words[1]):
				        code = "%8.8x" % (label_dict[words[1]])
				    else:
				        code = "%8.8x" % (int(words[1], 0))
				    mif.write("%8.8x : %s;\n" % (cur_addr / 4, code))
				    cur_addr += 4
			elif words[0][-1] == ':':
				#label_dict[words[0][0:-1]] = cur_addr
				print ""
			else:
				#inst[0] is the instruction (eg MVHI) and inst[1] is the rest
				inst = [words[0], "".join(words[1:])]
				insts = []
				# Pseudo instructions
				if inst[0].upper() == "BR":
					insts.append(["BEQ", "R6,R6,"+inst[1]])
				elif inst[0].upper() == "NOT":
					params = inst[1].split(',')
					#insts.append(["NAND", params[0]+","+params[1]+","+params[1]]) Chenkai
					insts.append(["NOT", params[0]+","+params[1]])
				elif inst[0].upper() == "BLE":
					params = inst[1].split(',')
					insts.append(["LTE", "R6,"+params[0]+","+params[1]])
					insts.append(["BNEZ", "R6,"+params[2]])
				elif inst[0].upper() == "BGE":
					params = inst[1].split(',')
					insts.append(["GTE", "R6,"+params[0]+","+params[1]])
					insts.append(["BNEZ", "R6,"+params[2]])
				elif inst[0].upper() == "CALL":
					params = re.split('\(|\)', inst[1])
					insts.append(["CALL", ""+params[0]+"("+params[1]+")"])
					#insts.append(["JAL", "RA,"+params[0]+"("+params[1]+")"])
				elif inst[0].upper() == "RET":
					insts.append(["RET", "R9,0(RA)"])
					#insts.append(["JAL", "R9,0(RA)"]) Chenkai
				elif inst[0].upper() == "JMP":
					params = re.split('(|)', inst[1])
					insts.append(["JAL", "R9,"+params[0]+"("+params[1]+")"])
				else:
					insts.append(inst)
				inst2bin(insts)


mif.write("[%8.8x..%8.8x] : DEAD;\n" % (cur_addr / 4, inst_mem_size_words - 1))
mif.write("END;\n")

#a32.close() #with statement automatically closes the file
mif.close()


