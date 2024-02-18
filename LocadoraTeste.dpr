program LocadoraTeste;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Clientes in 'Unit(s)\Clientes\Clientes.pas',
  Filmes in 'Unit(s)\Filmes\Filmes.pas',
  Login in 'Unit(s)\Login\Login.pas',
  LocacaoFilmes in 'Unit(s)\Locação\LocacaoFilmes.pas',
  Menus in 'Unit(s)\Menus\Menus.pas',
  Procedimentos in 'Unit(s)\Procedimentos\Procedimentos.pas',
  TypeRecord in 'Unit(s)\TypesRecord\TypeRecord.pas';

begin
  BoasVindas;
  LoginAcessoADM;

  repeat
    MenuPrincipal;

     case opcao_menu_locadora of
      'A':
          MenuFilmes;

      'B':
          MenuClientes;

      'C':
          LocarFilme;
     end;

  until permanecer_menu_principal = False ;

end.
