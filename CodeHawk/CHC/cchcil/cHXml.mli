(* =============================================================================
   CodeHawk C Analyzer Parser using CIL
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

(* cchcil *)
open CHPrettyPrint

exception XmlDocumentError of int * int * pretty_t

class type xml_element_int =
object ('a)

  (* setters *)
  method appendChildren: 'a list -> unit
  method setText: string -> unit
  method setAttribute: string -> string -> unit
  method setIntAttribute: string -> int -> unit
  method setPrettyAttribute: string -> pretty_t -> unit
  method setBoolAttribute: string -> bool -> unit
  method setYesNoAttribute: string -> bool -> unit
  method setLineNumber: int -> unit
  method setColumnNumber: int -> unit

  (* accessors *)
  method getTag: string
  method getChild: 'a
  method getTaggedChild: string -> 'a 
  method getChildren: 'a list
  method getTaggedChildren: string -> 'a list
  method getAttribute: string -> string
  method getIntAttribute: string -> int
  method getYesNoAttribute: string -> bool
  method getDefaultAttribute: string -> string -> string
  method getDefaultIntAttribute: string -> int -> int
  method getOptAttribute: string -> string option
  method getOptIntAttribute: string -> int option
  method getText: string
  method getLineNumber: int
  method getColumnNumber: int

  (* predicates *)
  method hasChild: bool                       (* has exactly one child *)
  method hasChildren: bool                    (* has one or more children *)
  method hasOneTaggedChild: string -> bool       (* has exactly one child with the given tag *)
  method hasTaggedChildren: string -> bool    (* has one or more children with the given tag *)
  method hasAttributes: bool
  method hasNamedAttribute: string -> bool
  method hasText: bool
  method isEmpty: bool

  (* printing *)
  method toPretty: pretty_t
end

class type xml_document_int =
object
  method setNode: xml_element_int -> unit
  method getRoot: xml_element_int
  method toPretty: pretty_t
end

val replace: char -> string -> string -> string

val stri: int -> string
val time_to_string: float -> string
val current_time_to_string: unit -> string

val xmlDocument: unit -> xml_document_int
val xmlElement: string -> xml_element_int

val xml_string: string -> string -> xml_element_int
val xml_pretty: string -> pretty_t -> xml_element_int
val xml_attr_string: string -> string -> string -> xml_element_int
val xml_attr_int: string -> string -> int -> xml_element_int

val has_control_characters: string -> bool
val hex_string: string -> string

val write_xml_constant_string: xml_element_int -> string -> string -> unit
