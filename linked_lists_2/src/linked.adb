with SDL.Video.Windows.Makers;
with SDL.Video.Rectangles;
with SDL.Video.Renderers;
with SDL.Video.Renderers.Makers;
with SDL.Events.Events;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;

with Types; use Types;
procedure Linked is
   use type SDL.Events.Event_Types;
   Width   : constant := 800;
   Height  : constant := 800;
   Window   : SDL.Video.Windows.Window;
   Renderer : SDL.Video.Renderers.Renderer;
   Event    : SDL.Events.Events.Events;
   Running  : Boolean := True;
   My_List  : Person_List;
   --  My_List  : Person_List.Link := null;
   procedure Render is
      use SDL.Video.Renderers;
      use type SDL.C.int;
      use Person_List_Package;
      Node_Width   : constant := 128;
      Box_X        : constant := 28;
      Box_Y        : constant := 200;
      Box_Width    : constant := 164;
      Box_Height   : constant := 48;
      Arrow_X      : constant := Box_X + Box_Width;
      Arrow_Length : constant := Node_Width + Box_Width;
      Draw_X       : SDL.C.int := 0;
      Node         : Person_List;
      Curs         : Cursor := My_List.First;
   begin
      Renderer.Set_Draw_Colour ((0, 0, 0, 255));
      Renderer.Fill
      (Rectangle => SDL.Video.Rectangles.Rectangle'(0, 0, Width, Height));

      Renderer.Set_Draw_Colour ((0, 128, 0, 255));
      while Has_Element (Curs) loop
         Draw_X := Draw_X + 128;
         Renderer.Draw
          (Rectangle => SDL.Video.Rectangles.Rectangle'
          (Box_X + Draw_X, Box_Y, Box_Width, Box_Height));
         Next (Curs);
      end loop;

   end Render;

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

begin
   --  Initialize data
   --  My_List := null;
   Print (My_List);
   My_List.Insert (12, To_Unbounded_String ("A"));
   --  Person_List.Insert (My_List, Person'(12, To_Unbounded_String ("A")));
   Print (My_List);
   --  Person_List.Insert (My_List, Person'(3, To_Unbounded_String ("B")));
   My_List.Insert (3, To_Unbounded_String ("B"));
   Print (My_List);
   --  Person_List.Insert (My_List, Person'(45, To_Unbounded_String ("C")));
   My_List.Insert (45, To_Unbounded_String ("C"));
   Print (My_List);
   --  Person_List.Insert (My_List, Person'(2, To_Unbounded_String ("D")));
   My_List.Insert (2, To_Unbounded_String ("D"));
   Print (My_List);

   My_List.Delete_First;
   --  Person_List.Remove (My_List);
   Print (My_List);

   --  Person_List.Insert (My_List, Person'(20, To_Unbounded_String ("E")));
   My_List.Insert (20, To_Unbounded_String ("E"));
   Print (My_List);

   if not SDL.Initialise (Flags => SDL.Enable_Screen) then
      return;
   end if;

   SDL.Video.Windows.Makers.Create
     (Win      => Window,
      Title    => "Linked List",
      Position => SDL.Natural_Coordinates'(X => 10, Y => 10),
      Size     => SDL.Positive_Sizes'(Width, Height),
      Flags    => 0);
   SDL.Video.Renderers.Makers.Create (Renderer, Window.Get_Surface);

   while Running loop

      while SDL.Events.Events.Poll (Event) loop
         if Event.Common.Event_Type = SDL.Events.Quit then
            Running := False;
         end if;
      end loop;

      Render;
      Window.Update_Surface;

   end loop;

   Window.Finalize;
   SDL.Finalise;
end Linked;