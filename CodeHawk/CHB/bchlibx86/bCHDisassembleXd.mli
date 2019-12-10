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

(* bchlib *)
open BCHLibTypes

(* bchlibx86 *)
open BCHLibx86Types

val pxd0: pushback_stream_int -> opcode_t
val pxd1: bool -> pushback_stream_int -> opcode_t
val pxd2: pushback_stream_int -> opcode_t
val pxd3: bool -> pushback_stream_int -> opcode_t
val pxd8: bool -> pushback_stream_int -> opcode_t
val pxd9: bool -> pushback_stream_int -> opcode_t
val pxda: bool -> pushback_stream_int -> opcode_t
val pxdb: bool -> pushback_stream_int -> opcode_t
val pxdc: bool -> pushback_stream_int -> opcode_t
val pxdd: bool -> pushback_stream_int -> opcode_t
val pxde: bool -> pushback_stream_int -> opcode_t
val pxdf: bool -> pushback_stream_int -> opcode_t

