
with Ada.Text_IO; use Ada.Text_IO;

with Types;

package body Printing is

   procedure Print (aList : Person_List) is
      use Person_List_Package;
      Curs : Cursor := aList.First;
   begin
      if Integer (Length (aList)) > 0 then
         Put_Line ("List length:" & Integer'Image (Integer (Length (aList))));
      else
         Put_Line ("List length: 0");
      end if;

      while Has_Element (Curs) loop
         Put (Types.P_Image (aList, Curs) & ", ");
         Next (Curs);
      end loop;
      New_Line;

   end Print;

   procedure Print (anArray : Pseudo_Array) is
      use Pseudo_Array_Package;
      Curs : Cursor := anArray.First;
   begin
      if Integer (Length (anArray)) > 0 then
         Put_Line ("Array length:" &
         Integer'Image (Integer (Length (anArray))));
      else
         Put_Line ("Array length: 0");
      end if;

      while Has_Element (Curs) loop
         Put (Types.P_Image (anArray, Curs) & ", ");
         Next (Curs);
      end loop;
      New_Line;

   end Print;

end Printing;