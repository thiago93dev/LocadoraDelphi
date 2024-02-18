unit Login;

interface

uses
 System.SysUtils,
 TypeRecord;

procedure BoasVindas;
procedure LoginAcessoADM;

implementation

var
  login_admin: TRloginAdm;

procedure BoasVindas;
begin
  writeln;
  writeln ('***Bem vindo ao sistema de locadora***');
  writeln ('--------------------------------------');
end;

procedure LoginAcessoADM;
begin
  repeat
    writeln;
    write('Digite o usuario: ');
    readln(login_admin.usuario);
    login_admin.usuario := AnsiUpperCase(login_admin.usuario);
    write('Digite a senha: ');
    readln(login_admin.senha);

    if not((login_admin.usuario = 'ADMIN') and (login_admin.senha = '1234')) then
    begin
      writeln;
      writeln('***Login incorreto, tente novamente***');
      writeln('-------');
    end
    else
    begin
      writeln;
      writeln('***Login usuario "ADMIN" realizado***');
      writeln('-------');
    end;

  until (login_admin.usuario = 'ADMIN') and (login_admin.senha = '1234');
end;

end.
