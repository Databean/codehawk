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

(* xprlib *)
open XprTypes

(* bchlib *)
open BCHLibTypes

(* bchlibx86 *)
open BCHLibx86Types

exception InconsistentInstruction of string

val is_conditional_jump_instruction: opcode_t -> bool
val is_direct_jump_instruction     : opcode_t -> bool
val is_jump_instruction            : opcode_t -> bool

val get_jump_operand               : opcode_t -> operand_int

(* deconstructing operands from the assembly instructions *)

val select_word_or_dword_reg: bool -> int -> cpureg_t

val decompose_avx_lpp: int -> (int * int * int)
val decompose_avx_rxb: int -> (int * int)
val decompose_modrm  : int -> (int * int * int)

val get_rm_byte_operand: ?addrsize_override:bool -> int -> int -> pushback_stream_int -> 
  operand_mode_t -> operand_int

val get_rm_word_operand: int -> int -> pushback_stream_int -> operand_mode_t -> operand_int

val get_rm_operand: int -> int -> 
  ?seg_override:segment_t option -> ?size:int -> ?floating_point:bool -> 
    pushback_stream_int -> operand_mode_t -> operand_int

val get_rm_def_operand: bool -> ?seg_override:segment_t option -> int -> int -> 
  pushback_stream_int -> operand_mode_t -> operand_int

val get_modrm_operands     : ?seg_override:segment_t option -> ?addrsize_override:bool -> 
  pushback_stream_int -> operand_mode_t -> operand_mode_t -> (operand_int * operand_int)

val get_modrm_byte_operands: pushback_stream_int -> operand_mode_t -> operand_mode_t -> 
  (operand_int * operand_int)

val get_modrm_word_operands: pushback_stream_int -> operand_mode_t -> operand_mode_t ->
  (operand_int * operand_int)

val get_modrm_seg_operands : ?opsize_override:bool -> pushback_stream_int -> 
  operand_mode_t -> operand_mode_t -> (operand_int * operand_int)

val get_modrm_quadword_operands: pushback_stream_int -> operand_mode_t -> 
  operand_mode_t -> (operand_int * operand_int)

val get_modrm_double_quadword_operands: pushback_stream_int -> operand_mode_t -> 
  operand_mode_t -> (operand_int * operand_int)

val get_modrm_mm_operands: pushback_stream_int -> int -> operand_mode_t -> 
  operand_mode_t -> (operand_int * operand_int)

val get_modrm_xmm_operands : pushback_stream_int -> int -> operand_mode_t -> 
  operand_mode_t -> (operand_int * operand_int)

val get_modrm_xmm_mm_operands: pushback_stream_int -> int -> operand_mode_t -> 
  operand_mode_t -> (operand_int * operand_int)

val get_modrm_xmm_reg_operands: pushback_stream_int -> int -> operand_mode_t -> 
  operand_mode_t -> (operand_int * operand_int)

val get_modrm_sized_operands: pushback_stream_int -> int -> operand_mode_t -> int -> 
  operand_mode_t -> (operand_int * operand_int)

val get_modrm_def_operands : bool -> ?seg_override:segment_t option -> 
  ?addrsize_override:bool -> pushback_stream_int -> operand_mode_t -> operand_mode_t -> 
  (operand_int * operand_int)

val get_modrm_cr_operands: pushback_stream_int -> operand_mode_t -> operand_mode_t ->
  (operand_int * operand_int)

val get_modrm_dr_operands: pushback_stream_int -> operand_mode_t -> operand_mode_t ->
  (operand_int * operand_int)

val get_string_reference: floc_int -> xpr_t -> string option
