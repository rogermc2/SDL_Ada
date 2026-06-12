
generic
   type T is private;
package Arrays is
   type Elements_Type is array (Positive range <>) of T;
   type Elements_Access is access Elements_Type;

   type Array_Record is record
      Elements : Elements_Access := new Elements_Type (1 .. 2);
      Capacity : Natural := 1;
   end record;

   type Array_Record_Access is access Array_Record;

   procedure Insert (Target : Array_Record_Access; Index : Positive;
      Element : T);
   function Get (Target : Array_Record_Access; Index : Positive) return T;

end Arrays;