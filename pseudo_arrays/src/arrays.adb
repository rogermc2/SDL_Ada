
with Ada.Unchecked_Deallocation;

package body Arrays is

   procedure Resize (Target : Array_Record_Access);

   procedure Free is new  Ada.Unchecked_Deallocation
      (Object => Elements_Type, Name => Elements_Access);
   procedure Insert (Target : Array_Record_Access; Index : Positive;
      Element : T) is
   begin
      while Index >= Target.Capacity loop
         Resize (Target);
      end loop;

      Target.Elements (Index) := Element;
   end Insert;
   function Get (Target : Array_Record_Access; Index : Positive) return T is
   begin
      return Target.Elements (Index);
   end Get;

   procedure Resize (Target : Array_Record_Access) is
      Old_Elements :  Elements_Access := Target.Elements;
      New_Elements : constant Elements_Access :=
         new Elements_Type (1 .. 2 * Target.Capacity);
   begin
      New_Elements (1 .. Target.Capacity) :=
         Old_Elements (1 .. Target.Capacity);
      Free (Old_Elements);
      Target.Elements := New_Elements;
      Target.Capacity := 2 * Target.Capacity;
   end Resize;

end Arrays;