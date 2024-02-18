unit Menus;

interface

uses
  System.SysUtils,
  Clientes,
  Filmes,
  LocacaoFilmes,
  Procedimentos;

var
  opcao_menu_locadora: char;

procedure MenuPrincipal;
procedure MenuConsultaListaOuIndividual;
procedure MenuClientes;
procedure MenuFilmes;

implementation

procedure MenuPrincipal;
begin
  writeln('Escolha as opções abaixo:');
  writeln('(A) FILMES');
  writeln('(B) CLIENTES');
  writeln('(C) LOCAÇÃO');
  writeln('Ou outra tecla para SAIR');
  writeln;
  write('Digite a opção: ');
  readln(opcao_menu_locadora);
  opcao_menu_locadora := UpCase(opcao_menu_locadora);
  writeln;

  if (opcao_menu_locadora <> 'A') and (opcao_menu_locadora <> 'B')
    and (opcao_menu_locadora <> 'C') then
  permanecer_menu_principal:= False;

end;

procedure MenuConsultaListaOuIndividual;
var
  tipo_consulta: integer;
begin
  repeat
    case opcao_menu_locadora of
      'A':
        writeln('CONSULTA FILMES');

      'B':
        writeln('CONSULTA CLIENTES');
    end;

    writeln('Digite "1" para lista ou "2" para individual: ');
    readln(tipo_consulta);
    writeln;
  until (tipo_consulta = 1) or (tipo_consulta = 2);
end;

procedure MenuFilmes;
var
  opcao_filmes: char;
begin
  writeln('Filmes');
  writeln('------');
  writeln('Digite uma das opções de FILME abaixo: ');
  writeln('(A) CADASTRAR FILME');
  writeln('(B) CONSULTAR FILME');
  writeln('(C) EXCLUIR FILME');
  writeln('(D) DEVOLUÇÃO');
  writeln('Ou outra tecla para SAIR');
  writeln;
  write('Digite a opção: ');
  readln(opcao_filmes);
  opcao_filmes := UpCase(opcao_filmes);
  writeln;

  case opcao_filmes of
   'A':
      AdicionarFilme;

   'B':
      ConsultaFilmes;

   'C':
      InativarFilme;

   'D':
      DevolverFilmes;

  else
    permanecer_menu_principal:= True;
  end;

end;

procedure MenuClientes;
var
  opcao_clientes: char;
begin
  writeln('Clientes');
  writeln('------');
  writeln('Digite uma das opções de CLIENTE abaixo: ');
  writeln('(A) CADASTRAR CLIENTE');
  writeln('(B) CONSULTAR CLIENTE');
  writeln('(C) EXCLUIR CLIENTE');
  writeln('Ou outra tecla para SAIR');
  writeln;
  write('Digite a opção: ');
  readln(opcao_clientes);
  opcao_clientes := UpCase(opcao_clientes);
  writeln;

  case opcao_clientes of
    'A':
      CadastrarCliente;

    'B':
      ConsultarClientes;

    'C':
      InativarCliente;
  else
    permanecer_menu_principal:= True;
  end;

end;

end.
