
with Ada.Containers.Ordered_Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Types is

   package Person_List_Package is new
     Ada.Containers.Ordered_Maps (Positive, Unbounded_String);
   subtype Person_List is Person_List_Package.Map;

   --  type Person is
   --     record
   --        ID   : Integer;
   --        Name : Unbounded_String;
   --     end record;

   --  function Key (P : Person) return Integer;
   --  --  function P_Image (P : Person) return String;
   function P_Image
    (aList : Person_List; Curs : Person_List_Package.Cursor) return String; 

end Types;