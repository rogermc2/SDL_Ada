
package body Types is
   --  function Key (P : Person) return Integer is
   --  begin
   --     return P.ID;
   --  end Key;

   function P_Image
    (aList : Person_List; Curs : Person_List_Package.Cursor) return String is
      use Person_List_Package;
      aKey : constant Positive := Key (Curs);
      Name : constant Unbounded_String := aList.Element (aKey);
   begin
      return Positive'Image (aKey) & ": " & To_String (Name);
   end P_Image;

   function P_Image
    (Node : Unbounded_String) return String is
   begin
      return To_String (Node);
   end P_Image;

end Types;