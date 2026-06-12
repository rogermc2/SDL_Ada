
with Ada.Containers.Ordered_Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Common is

   package Person_List_Package is new
     Ada.Containers.Ordered_Maps (Positive, Unbounded_String);
   subtype Person_List is Person_List_Package.Map;

   package Pseudo_Array_Package is new 
     Ada.Containers.Ordered_Maps (Positive, Unbounded_String);
   subtype Pseudo_Array is Pseudo_Array_Package.Map;

end Common;