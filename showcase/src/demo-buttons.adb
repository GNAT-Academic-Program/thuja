with Thuja.Widgets.Blocks;
with Thuja.Widgets.Labels;
with Thuja.Layout; use Thuja.Layout;

package body Demo.Buttons is

   package Blocks renames Thuja.Widgets.Blocks;
   package Labels renames Thuja.Widgets.Labels;

   overriding procedure Draw
     (D       : in out State;
      Frame   : in out Buffer;
      Area    : Rect;
      Focused : Boolean)
   is
      Sections : constant Rect_Array :=
        Split
          (Area  => Blocks.Inner (Area),
           Along => Column,
           Items => [Fixed (3), Fixed (3)],
           Gap   => 1);
   begin
      Blocks.Draw (Frame, Area, Title, Border (Focused));

      Button.Draw
        (Frame => Frame,
         Area  => Sections (1),
         Text  => "Click Me",
	 S     => D.Click_Button);

      Labels.Draw
        (Frame => Frame,
         Area  => Sections (2),
         Text  => "Clicks:" & Natural'Image (D.Click_Count),
         Align => Labels.Center);
   end Draw;

   overriding procedure Update
     (D    : in out State;
      E    : Event;
      Used : out Boolean)
   is
   begin
      Used := False;

      -- Toggle button using D
      if E.Kind = Text_Input and then E.Length > 0 then
         if E.Text (1) = 'd' or else E.Text (1) = 'D' then
            D.Click_Button.Enabled := not D.Click_Button.Enabled;

	 if not D.Click_Button.Enabled then
  		 D.Click_Button.Activated := False;
   		 D.Click_Button.Pressed := False;
	 end if;

            Used := True;
            return;
         end if;
      end if;

      -- Handle button activation
      Button.Handle (D.Click_Button, E, Used);

      if Button.Was_Clicked (D.Click_Button) then
         D.Click_Count := D.Click_Count + 1;
	 D.Click_Button.Activated := False;
      end if;
   end Update;
end Demo.Buttons;