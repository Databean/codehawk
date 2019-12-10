(* =============================================================================
   CodeHawk Binary Analyzer 
   Author: Henny Sipma
   ------------------------------------------------------------------------------
   The MIT License (MIT)
 
   Copyright (c) 2005-2019 Kestrel Technology LLC

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:
 
   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.
  
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.
   ============================================================================= *)

(* chlib *)
open CHLanguage
open CHPretty

(* chutil *)
open CHPrettyUtil
open CHSumTypeSerializer

(* bchlib *)
open BCHBasicTypes
open BCHLibTypes

(* bchlibx86 *)
open BCHLibx86Types

class opkind_mcts_t: [ asm_operand_kind_t ] mfts_int =
object

  inherit [ asm_operand_kind_t ] mcts_t "asm_operand_kind_t"
        
  method ts (k:asm_operand_kind_t) =
    match k with
    | Flag _ -> "v"
    | Reg _ -> "r"
    | FpuReg _ -> "f"
    | ControlReg _ -> "c"
    | DebugReg _ -> "d"
    | MmReg _ -> "m"
    | XmmReg _ -> "x"
    | SegReg _ -> "s"
    | IndReg _ -> "ri"
    | SegIndReg _ -> "si"
    | ScaledIndReg _ -> "rs"
    | DoubleReg _ -> "rd"
    | Imm _ -> "i"
    | Absolute _ -> "a"
    | SegAbsolute _ -> "sa"
    | DummyOp -> "u"
               
  method tags = [ "a"; "c"; "d"; "f"; "i"; "m"; "r"; "rd";
                  "ri"; "rs"; "s"; "sa"; "si"; "u"; "x" ]
              
end

let opkind_mcts:asm_operand_kind_t mfts_int = new opkind_mcts_t
