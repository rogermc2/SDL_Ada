
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Common; use Common;

package Types is
   function P_Image
    (aList : Person_List; Curs : Person_List_Package.Cursor) return String;
   function P_Image (Node : Unbounded_String) return String;

end Types;