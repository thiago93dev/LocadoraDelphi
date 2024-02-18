unit Procedimentos;

interface

uses
 System.SysUtils;

// variavel compartilhada para a permanencia nos menus
var
  permanecer_menu_principal: boolean;

function ContinuarAcao: boolean;

implementation

function ContinuarAcao: boolean;
var
  escolha: string;
begin
  writeln ('CONTINUAR? digite "1" para SIM ou tecle para sair');
  readln(escolha);
  writeln;

  if escolha <> '1' then
  permanecer_menu_principal:= True;

  result:= (escolha = '1');
end;

end.
