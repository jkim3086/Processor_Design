force -freeze /Project3/clk 1 0, 0 10 -repeat 20
force -freeze /Project3/reset 1 0, 0 10
force -deposit /Project3/KEY 4'b1111
force -deposit /Project3/SW 9'b0 0
mem load -i /test/programs/Test2.mif.mem /Project3/instMem/data
mem load -i /test/programs/Test2.mif.mem /Project3/datamem/data