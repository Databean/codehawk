(* =============================================================================
   CodeHawk C Analyzer 
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
open CHXmlDocument

(* cchlib *)
open CCHBasicTypes
open CCHUtilities

module H = Hashtbl

class virtual ['a,'b] indexed_table_t =
object (self: _)

  val mutable next = 1

  method reset = next <- 1 

  method virtual lookup: 'a -> 'b option

  method virtual insert: 'a -> 'b -> unit

  method virtual add_xref: 'a -> 'b -> unit

  method add (k: 'a) (mk: int -> 'b) =
    match self#lookup k with
      | Some e -> begin self#add_xref k e ; e end
      | None ->
	  let e = mk next in
	  let _ = next <- next + 1 in
	  let _ = self#insert k e in
	    e
	      
end

let table_to_pretty t =
  let p = ref [] in
  let _ = Hashtbl.iter (fun k v -> p := (LBLOCK [ INT k ; STR " -> " ; INT v ; NL ]) :: !p) t in
  LBLOCK [ STR "table: " ; NL ; INDENT (3,LBLOCK !p) ; NL ]
  
  
class virtual ['a,'b] indexed_table_with_retrieval_t =
object (self: _)
  
  val mutable next = 1
  val store = Hashtbl.create 5
    
  method reset = begin Hashtbl.clear store ; next <- 1 end
    
  method virtual lookup: 'a -> 'b option
    
  method virtual insert: 'a -> 'b -> unit
    
  method virtual values: 'b list

  method add (k: 'a) (mk: int -> 'b) =
    match self#lookup k with
    | Some e -> e
    | None ->
      let e = mk next in
      let _ = self#insert k e in
      let _ = Hashtbl.add store next e in
      let _ = next <- next + 1 in
      e
	
  method retrieve (index:int) =
    try
      Hashtbl.find store index
    with
      Not_found ->
	raise (CCHFailure (LBLOCK [ STR "Index not found in indexed table: " ; INT index ]))

  method private get_values =
    let rec aux n l =
      if n = 1 then l else aux (n-1) ((self#retrieve (n-1))::l) in 
    aux next []

  method write_xml (node:xml_element_int) (childtag:string) 
    ?(filter=(fun (e:'b) -> true)) (f:xml_element_int -> 'b -> unit) =
    let seti = node#setIntAttribute in
    begin
      node#appendChildren (List.map (fun b ->
	let cNode = xmlElement childtag in 
	begin f cNode b ; cNode end) (List.filter filter self#get_values)) ;
      seti "size" (next - 1)
    end
      
  method read_xml (node:xml_element_int) 
    (get_value:xml_element_int -> 'b) (get_key:'b -> 'a) (get_index:'b -> int) =
    List.iter (fun x ->
      let e = get_value x in
      let k = get_key e in
      let i = get_index e in
      begin
	self#insert k e ;
	Hashtbl.add store i e ;
	next <- Pervasives.max (i+1) next
      end ) node#getChildren

end
  
  
