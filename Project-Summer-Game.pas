uses GraphABC;
var mouse_button : integer;
var type_trash : picture;
var type_trash_random, level : integer;
type array2d = array [0..9, 1..2] of integer;
var answers : array2d;
var cor, notcor, y_box, g_box, b_box: picture;

procedure coll_trash(answer : integer);
begin

  Sleep(300);
  UnlockDrawing();
  SetBrushColor(clWhite);
  if answer = 1 then begin SetBrushColor(clTransparent); SetFontColor(clLightGreen); SetFontSize(30); SetFontStyle(fsBold); TextOut(230, 150, 'Correct!') end 
  else begin SetBrushColor(clTransparent); SetFontColor(clRed); SetFontSize(30); SetFontStyle(fsBold); TextOut(210, 150, 'Not correct!') end;
  LockDrawing();
  Sleep(100);

end;

procedure MouseDown(x, y, mb : integer);
begin
    
    if (mb = 1) and (y >= 280) and ((x <= 150) and (x >= 0)) then 
    begin  
      mouse_button := 1;
      if type_trash_random = 1 then begin answers[level][2] += 1; coll_trash(1) end
      else begin coll_trash(0); answers[level][1] += 1; end;
    end
    else if (mb = 1) and (y >= 280) and ((x >= 233) and (x <= 383)) then 
    begin 
      mouse_button := 1; 
      if type_trash_random = 2 then begin answers[level][2] += 1; coll_trash(1) end
      else begin coll_trash(0); answers[level][1] += 1; end;
    end
    else if (mb = 1) and (y >= 280) and ((x <= 606) and (x >= 456)) then 
    begin 
      mouse_button := 1; 
      if type_trash_random = 3 then begin answers[level][2] += 1; coll_trash(1) end
      else begin coll_trash(0); answers[level][1] += 1; end;
    end;

end;

procedure draw_trash(fall : integer);
begin

  var x, y : integer;

  fall := 1;
  type_trash_random := Random(1, 3);
  x := Random(10, 500);

  LockDrawing();

  repeat
  begin
        
      case type_trash_random of
      
        1 : type_trash := picture.Create('milk.png');
        2 : type_trash := picture.Create('banana.png');
        3 : type_trash := picture.Create('bottle.png');
      
      end;
      
      Window.Clear;
            
      SetPenColor(clBlack);
      
      type_trash.Draw(x, y + 10 * fall, 90, 80);
      fall += 1;
      
      SetBrushColor(clTransparent); 
      SetFontColor(clBlack); 
      SetFontSize(15); 
      TextOut(0, 0, IntToStr(level) + ' Level');
      
      notcor := picture.Create('notcorrect.jpg');
      notcor.Draw(430, 0, 50, 50);
      SetBrushColor(clTransparent); 
      SetFontColor(RGB(191, 30, 46)); 
      SetFontSize(39); 
      TextOut(477, -5, answers[level][1]);
           
      cor := picture.Create('correct.png');
      cor.Draw(535, 5, 50, 41);
      SetBrushColor(clTransparent); 
      SetFontColor(RGB(79, 198, 47)); 
      SetFontSize(39); 
      TextOut(581, -5, answers[level][2]);
      
      y_box := picture.Create('yellow.png');
      y_box.Draw(0, 280, 150, 200);
      
      g_box := picture.Create('green.png');
      g_box.Draw(233, 280, 150, 200);
            
      b_box := picture.Create('blue.png');
      b_box.Draw(456, 280, 150, 200);
      
      ReDraw();
     
      Sleep(150);
    
  end;
  until mouse_button = 1;
  mouse_button := 0;
  SetBrushColor(clWhite);
  SetPenColor(clWhite);
  Circle(x, y + 10 * (fall - 1), 15);
  
end;

begin
  
  OnMouseDown := MouseDown;
  for var i := 1 to 100 do begin draw_trash(1); if i mod 11 = 0 then begin level += 1; Sleep(1000); end; Sleep(400); end;
 
end.