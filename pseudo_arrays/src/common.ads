
with Ada.Containers.Ordered_Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Arrays;

package Common is

   package Person_List_Package is new
     Ada.Containers.Ordered_Maps (Positive, Unbounded_String);
   subtype Person_List is Person_List_Package.Map;

   package Array_Package is new Arrays (T => Unbounded_String);

end Common;