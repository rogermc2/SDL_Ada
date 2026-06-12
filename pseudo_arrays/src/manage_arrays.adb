
with SDL.Events.Events;
with SDL.TTFs.Makers;
with SDL.Video.Rectangles;
with SDL.Video.Renderers;
with SDL.Video.Renderers.Makers;
with SDL.Video.Surfaces;
with SDL.Video.Textures;
with SDL.Video.Textures.Makers;
with SDL.Video.Windows.Makers;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
--  with Ada.Text_IO; use Ada.Text_IO;

with Common; use Common;
with Types; use Types;
with Printing; use Printing;
procedure Manage_Arrays is
   use type SDL.Events.Event_Types;
   Width   : constant := 800;
   Height  : constant := 800;
   Window   : SDL.Video.Windows.Window;
   Renderer : SDL.Video.Renderers.Renderer;
   Event    : SDL.Events.Events.Events;
   Running  : Boolean := True;
   My_List  : Person_List;
   My_Array : Common.Pseudo_Array_Package.Map;
   Font     : SDL.TTFs.Fonts;
   procedure Render is
      use SDL.Video.Renderers;
      use type SDL.C.int;
      use Person_List_Package;
      Node_Width      : constant := 128;
      Box_X           : constant := 20;
      Box_Y           : constant := 200;
      Box_Width       : constant := 64;
      Box_Height      : constant := 48;
      Arrow_X         : constant := Box_X + Box_Width;
      Arrow_Y         : constant := Box_Y + Box_Height / 2;
      Arrow_Length    : constant := Node_Width - Box_Width;
      Arrow_Head_Size : constant := 20;
      X_Start         : constant := 128;
      Draw_X          : SDL.C.int := 0;
      Text_Surface    : SDL.Video.Surfaces.Surface;
      Text_Texture    : SDL.Video.Textures.Texture;
      Node            : Unbounded_String;
      Curs            : Cursor := My_List.First;
      Pos             : Float := 0.0;
   begin
      Renderer.Set_Draw_Colour ((0, 0, 0, 255));
      Renderer.Fill
      (Rectangle => SDL.Video.Rectangles.Rectangle'(0, 0, Width, Height));

      Renderer.Set_Draw_Colour ((0, 128, 0, 255));
      while Has_Element (Curs) loop
         Node := Element (Curs);
         Draw_X := X_Start + Draw_X;
         Pos := Pos + 1.0;
         Renderer.Draw (Rectangle => SDL.Video.Rectangles.Rectangle'
                        (Box_X + Draw_X, Box_Y, Box_Width, Box_Height));

         Renderer.Draw (Line => SDL.Video.Rectangles.Line_Segment'
                        (SDL.Coordinates'(Arrow_X + Draw_X, Arrow_Y),
                        (SDL.Coordinates'(Arrow_X + Arrow_Length + Draw_X,
                         Arrow_Y))));
         Renderer.Draw (Line => SDL.Video.Rectangles.Line_Segment'
                        (SDL.Coordinates'
                        (Arrow_X + Arrow_Length - Arrow_Head_Size + Draw_X,
                         Arrow_Y + Arrow_Head_Size),
                        (SDL.Coordinates'(Arrow_X + Arrow_Length + Draw_X,
                         Arrow_Y))));
         Renderer.Draw (Line => SDL.Video.Rectangles.Line_Segment'
                        (SDL.Coordinates'
                        (Arrow_X + Arrow_Length - Arrow_Head_Size + Draw_X,
                        Arrow_Y - Arrow_Head_Size),
                        (SDL.Coordinates'(Arrow_X + Arrow_Length + Draw_X,
                         Arrow_Y))));
         Text_Surface :=
            SDL.TTFs.Render_Solid (Font, P_Image (Node), (255, 0, 0, 255));

         SDL.Video.Textures.Makers.Create
            (Text_Texture, Renderer, Text_Surface);
         SDL.Video.Renderers.Copy (Renderer, Text_Texture,
            To => (X => 20.0 + Float (X_Start) * Pos, Y => 204.0,
                   Width => 64.0, Height => 48.0));
         Next (Curs);
      end loop;

   end Render;

begin
   Print (My_List);
   My_List.Insert (12, To_Unbounded_String ("A"));
   Print (My_List);
   My_List.Insert (3, To_Unbounded_String ("B"));
   Print (My_List);
   My_List.Insert (45, To_Unbounded_String ("C"));
   Print (My_List);
   My_List.Insert (2, To_Unbounded_String ("D"));
   Print (My_List);

   My_List.Delete_First;
   Print (My_List);

   My_List.Insert (20, To_Unbounded_String ("E"));
   Print (My_List);

   Print (My_Array);
   My_Array.Insert (12, To_Unbounded_String ("A"));
   Print (My_Array);
   My_Array.Insert (3, To_Unbounded_String ("B"));
   Print (My_Array);
   My_Array.Insert (45, To_Unbounded_String ("C"));
   Print (My_Array);
   My_Array.Insert (2, To_Unbounded_String ("D"));
   Print (My_Array);
   My_Array.Insert (20, To_Unbounded_String ("E"));
   Print (My_Array);

   if not SDL.Initialise (Flags => SDL.Enable_Screen) then
      return;
   end if;

   if not SDL.TTFs.Initialise then
      return;
   end if;

   SDL.Video.Windows.Makers.Create
     (Win      => Window,
      Title    => "Linked List",
      Position => SDL.Natural_Coordinates'(X => 10, Y => 10),
      Size     => SDL.Positive_Sizes'(Width, Height),
      Flags    => 0);
   SDL.Video.Renderers.Makers.Create (Renderer, Window.Get_Surface);
   SDL.TTFs.Makers.Create (Font, "font.ttf", 16);
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

end Manage_Arrays;
