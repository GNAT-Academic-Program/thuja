
with Thuja.Widgets.Labels;

package body Thuja.Widgets.Buttons is

   procedure Set_Enabled
     (S : in out State;
      Value : Boolean)
   is
   begin
      S.Enabled := Value;

      if not Value then
         S.Activated := False;
         S.Pressed := False;
      end if;
   end Set_Enabled;

   function Is_Enabled
     (S : State) return Boolean
   is
   begin
      return S.Enabled;
   end Is_Enabled;

   procedure Handle
     (S    : in out State;
      E    : Event;
      Used : out Boolean)
   is
   begin
      Used := False;

      if not S.Enabled then
         return;
      end if;

      if E.Kind = Key_Down and then E.Key = Key_Return then
         S.Activated := True;
         S.Pressed := True;
         Used := True;
      elsif E.Kind = Key_Up and then E.Key = Key_Return then
         S.Pressed := False;
         Used := True;
      elsif E.Kind = Key_Down or else E.Kind = Text_Input then
         S.Pressed := False;
      end if;
   end Handle;

   function Was_Clicked
     (S : in out State) return Boolean
   is
      Result : constant Boolean := S.Activated;
   begin
      S.Activated := False;
      return Result;
   end Was_Clicked;

   procedure Draw
     (Frame : in out Buffer;
      Area  : Rect;
      Text  : String;
      S     : in out State)
   is
      Display_Text : constant String :=
        (if not S.Enabled then "( " & Text & " )"
         elsif S.Pressed then "< " & Text & " >"
         else "[ " & Text & " ]");
   begin
      if Is_Empty (Area) then
         return;
      end if;

      Thuja.Widgets.Labels.Draw
        (Frame => Frame,
         Area  => Area,
         Text  => Display_Text,
         Align => Thuja.Widgets.Labels.Center);
      S.Pressed := False;
   end Draw;

end Thuja.Widgets.Buttons;
