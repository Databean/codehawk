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
open CHPretty

(* chutil *)
open CHLogger
open CHXmlDocument
open CHXmlReader

(* bchlib *)
open BCHBasicTypes
open BCHConstantDefinitions
open BCHLibTypes
open BCHTypeDefinitions
open BCHVariableType
open BCHXmlUtil


let raise_error (node:xml_element_int) (msg:pretty_t) =
  let error_msg =
    LBLOCK [ STR "(" ; INT node#getLineNumber ; STR "," ; 
	     INT node#getColumnNumber ; STR ") " ; msg ] in
  begin
    ch_error_log#add "xml parse error" error_msg ;
    raise (XmlReaderError (node#getLineNumber, node#getColumnNumber, msg))
  end


let rec is_pointer_type (t:btype_t) =
  match t with
  | TPtr _ -> true
  | TNamed (name,_) when type_definitions#has_type name ->
    begin
      match type_definitions#get_type name with
      | TNamed (dname,_) when name = dname -> false
      | tt -> is_pointer_type tt
    end
  | _ -> false

let rec get_pointer_target_type (t:btype_t) =
  match t with
  | TPtr (tt,_) -> tt
  | TNamed (name,_) when type_definitions#has_type name ->
    begin
      match type_definitions#get_type name with
      | TNamed (dname,_) when name = dname ->
	 raise (BCH_failure
                  (LBLOCK [ STR "Unable to retrieve pointer target type from " ;
			    STR " named type: " ; STR name ]))
      | tt -> get_pointer_target_type tt
    end
  | _ ->
    raise (BCH_failure (LBLOCK [ STR "Type is not a pointer type: " ; 
				 STR (btype_to_string t) ] ))

