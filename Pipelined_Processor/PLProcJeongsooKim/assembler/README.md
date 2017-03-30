CS3220 Assembler
================

Introduction
------------

This is an assembler built in ruby which will convert .a32 (asm file)
to .MIF file.

The assembler library specifies its own Domain-Specific Language,
which is then used to describe the ISA and associated assembly file
syntax.

Run Instruction
---------------

Ruby 2.1 or greater is recommended. At a minimum, Ruby 1.9 is
required, but this has not been tested.

```sh
ruby assembler.rb /path/to/assembly_file.a32 /path/to/write/mif_file.mif
```

The first path argument specifies the path to the assembly file. The
second argument specifies the path to write the MIF file. If the MIF
file already exists at the path, it will be overwritten.

Structure and Customizing
-------------------------

The assembler top-level directory structure is as follows:

* `assembler.rb`: The top-level assembler and file-handling logic
* `lib/`: the assembler library, which specifies the assembler
  Domain-Specific Language
* `fields/`: ISA field definitions, which specify how to convert
  symbolic definitions (such as register names and integer values)
  into a binary representation.
* `instructions/`: ISA instruction definitions, which specify classes
  of instructions and declare the positions and types of fields that
  comprise them
* `syntax/`: Assembler syntax declarations, which declare the
  different syntax forms the assembler can recognize and how to handle
  them.
  
### Customizing the assembler

To adapt the assembler for a new ISA, we recommend the following
approach:

1. Break the supported instructions down into various fixed-width
   "fields", and implement these using subclasses of `Field`. Two
   subclasses are available out of the box: `EnumField` for specifying
   fields with a fixed set of values, i.e. register numbers,
   opcodes. `SignedField` provides for fixed-width signed integer
   fields, such as offsets and immediate values.
2. Implement each concrete instruction with `Instruction`
   subclasses. Specify the fields in the order that they should be
   passed as arguments to a constructor.  Fields that should only ever
   have one value can be specified with a default value.
3. Create `Syntax` subclasses to support each unique syntactic form
   supported in the assembly dialect.
   
Instructions support the following declarations:

* `pad start..end`: pad a range of bits with zeros, merely reserving
  empty space
* `field start..end, :type, :name => default_value`: declare a field
  over the range start..end, of type `:type`. Give the field the name
  `:name`, which can be used when passing a Hash to the
  constructor. An optional `default_value` can be specified, which
  will be supplied if the field is omitted from the constructor. If no
  default is specified, the field is required.
  
Syntaxes comprise of the following declarations:

* `parse`: specifies a regexp to match against lines of the assembly
  code. An optional block argument receives the `MatchData` from any
  match and can further process the matched text. If the block returns
  nil, the match is ignored.
* `preprocess`: Called during the first stage of processing a matching
  form. Preprocess blocks may want to make use of the following APIs:
  
  * `reserve_region :name, bytes, options`: reserves a region of
    `bytes` bytes in memory for the instruction to later generate. The
    name is used to match against any `generate` blocks given in the
    syntax declaration.
  * `push_symbol :symbol`: pushes a symbol on to the symbol stack,
    which will be popped and used to label the next region allocated
    with `reserve_region`.
  * `seek_to address`: sets the byte address of where the next region
    allocated with `reserve_region` will be inserted.
    
* `generate`: provides a block to generate the bytes for a named
  reserved region. The block is called with two arguments--a
  `BitRange` object to write the region's bytes, and an address
  parameter containing the starting address of the region.

