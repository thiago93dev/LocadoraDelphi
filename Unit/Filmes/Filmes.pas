unit Filmes;

interface

uses
  System.SysUtils,
  Clientes,
  Procedimentos,
  TypeRecord;

var
  filme: array of TRfilmes;

procedure AdicionarFilme;
procedure ConsultaFilmes;
Procedure InativarFilme;
procedure DevolverFilmes;

implementation

var
  id_filmes: integer = 0;
  tipo_consulta: integer;

procedure AdicionarFilme;
begin
  repeat
   SetLength(filme, length(filme) + 1);

   writeln('CADASTRAR FILME');
   write('Nome Filme: ');
   readln(filme[id_filmes].nome);
   filme[id_filmes].nome := AnsiUpperCase(filme[id_filmes].nome);
   write('Genero Filme: ');
   readln(filme[id_filmes].genero);
   filme[id_filmes].genero := AnsiUpperCase(filme[id_filmes].genero);
   write('Censura Filme: ');
   readln(filme[id_filmes].censura);
   write('Valor diário: ');
   readln(filme[id_filmes].valor);

   filme[id_filmes].status := True;
   filme[id_filmes].locacao := False;
   writeln;

   filme[id_filmes].id := id_filmes + 1;

   writeln('"Cadastro Realizado"');
   writeln('ID Filme: ', filme[id_filmes].id);
   id_filmes := id_filmes + 1;
   writeln;

  until ContinuarAcao = False ;

end;

procedure Pesquisalista;
var
  opcao: char;
  i: integer;
begin
  if not (tipo_consulta = 1) then
  begin
    permanecer_menu_principal:= True;
    exit;
  end;

  writeln('"LISTA"');
  writeln('Digite "A" para lista ATIVOS');
  writeln('Digite "B" para lista EXCLUIDOS');
  writeln('Digite outra tecla para TODOS');
  write('Opção: ');
  readln(opcao);
  writeln;
  opcao := UpCase(opcao);

  if opcao = 'A' then
  begin
    for i := 0 to length(filme) - 1 do
      if filme[i].status = True then
      begin
        writeln('"FILMES ATIVOS"');
        writeln('Nome: ', filme[i].nome);
        writeln('Genero: ', filme[i].genero);
        writeln('Censura: ', filme[i].censura);
        writeln('Valor: ',Format('R$%.2f', [filme[i].valor]));

        if (filme[i].locacao = False) then
        writeln('Situação: Filme disponivel')
        else
        writeln ('Situação: Filme locado');

        writeln('ID Filme: ', filme[i].id);
        writeln;
      end;
  end
  else if opcao = 'B' then
  begin
    writeln('Lista de Excluidos');
    writeln;

    for i := 0 to length(filme) - 1 do
      if filme[i].status = False then
      begin
        writeln('"FILMES INATIVOS"');
        writeln('Nome: ', filme[i].nome);
        writeln('Genero: ', filme[i].genero);
        writeln('Censura: ', filme[i].censura);
        writeln('Valor: ',Format('R$%.2f', [filme[i].valor]));
        writeln('Situação: Filme excluido');
        writeln('ID Filme: ', filme[i].id);
        writeln;
      end;
  end
  else
  begin
    for i := 0 to length(filme) - 1 do
    begin
      writeln('"TODOS OS FILMES"');
      writeln('Nome: ', filme[i].nome);
      writeln('Genero: ', filme[i].genero);
      writeln('Censura: ', filme[i].censura);
      writeln('Valor: ',Format('R$%.2f', [filme[i].valor]));

      if (filme[i].locacao = False) and (filme[i].status = True) then
      writeln('Situação: Filme disponivel')
      else if (filme[i].status = False) then
      writeln('Situação: Filme excluido')
      else
      writeln ('Situação: Filme locado');

      writeln('ID Filme: ', filme[i].id);

      if filme[i].status = True then
        writeln('Status: ativo')
      else
        writeln('Status: inativo');

      writeln;
    end;
  end;
end;

procedure PesquisaIndividual;
var
consultaId: integer;

begin
  if not (tipo_consulta = 2) then
  begin
    permanecer_menu_principal:= True;
    exit;
  end;

  writeln('CONSULTA INDIVIDUAL');
  write('Digite a ID Filme: ');
  readln(consultaId);
  writeln;

  consultaId := consultaId - 1;

  if (consultaId < 0) or (consultaId > length(filme) - 1) then
  begin
    writeln('***Código inválido***');
    writeln('---------------------');
    permanecer_menu_principal:= True;
    exit;
  end;


  writeln('FILME ID: ', filme[consultaId].id);
  writeln('Nome: ', filme[consultaId].nome);
  writeln('Genero: ', filme[consultaId].genero);
  writeln('Censura: ', filme[consultaId].censura);
  writeln('Valor: ', Format('R$%.2f', [filme[consultaId].valor]));

  if (filme[consultaId].locacao = False) and (filme[consultaId].status = True) then
    writeln('Situação: Filme disponivel')
  else if (filme[consultaId].status = False) then
    writeln('Situação: Filme excluido')
  else
    writeln('Situação: Filme locado');

  writeln('ID Filme: ', filme[consultaId].id);

  if (filme[consultaId].status = True) then
    writeln('Status: ativo')
  else
    writeln('Status: inativo');

  writeln;
end;

procedure ConsultaFilmes;
begin
 repeat
   if length(filme) < 1 then
   begin
     writeln('***Nenhum filme cadastrado***');
     writeln('-------');
     permanecer_menu_principal:= True;
     exit;
   end;

   writeln('CONSULTA FILMES');
   writeln('Digite "1" para lista ou "2" para individual: ');
   readln(tipo_consulta);
   writeln;

   PesquisaLista;
   PesquisaIndividual;
 until ContinuarAcao = False ;

end;

Procedure InativarFilme;
var
  id_exclusao: integer;

begin
  repeat
    if length(filme) < 1 then
    begin
      writeln('***Nenhum filme cadastrado***');
      writeln('---------------------');
      permanecer_menu_principal:= True;
      exit;
    end;

    writeln('EXCLUIR FILMES');
    write('Digite o ID do filme: ');
    readln(id_exclusao);
    writeln;

    id_exclusao := id_exclusao - 1;
    writeln ('ID filme :', filme[id_exclusao].id);

    if (id_exclusao < 0) or (id_exclusao > length(filme) - 1) then
    begin
      writeln('***Código inválido***');
      writeln('---------------------');
      permanecer_menu_principal:= True;
      writeln;
      exit;
    end;

    if (filme[id_exclusao].locacao = True) then
    begin
      writeln;
      writeln('***O filme esta locado, não é possivel excluir***');
      writeln('---------------------');
      permanecer_menu_principal:= True;
      writeln;
      exit;
    end;

    if filme[id_exclusao].status = False then
    begin
      writeln('***Filme já esta excluido***');
      writeln('---------------------');
      permanecer_menu_principal:= True;
      writeln;
      exit;
    end;


    filme[id_exclusao].status := False;
    writeln('Filme "',filme[id_exclusao].nome,'" removido');
    writeln('ID: ', filme[id_exclusao].id);
    writeln;
  until ContinuarAcao = False ;
end;

procedure DevolverFilmes;
var
  i, consulta_id: integer;
  opcao_filmes: char;

begin
  repeat
    if (length (cliente) < 1) then
    begin
      writeln('***Nenhum cliente cadastrado***');
      writeln('---------------------');
      writeln;
      permanecer_menu_principal:= True;
      exit;
    end;

    if (length (filme)  < 1) then
    begin
      writeln('***Nenhum filme cadastrado***');
      writeln('---------------------');
      writeln;
      permanecer_menu_principal:= True;
      exit;
    end;

    writeln('DEVOLUÇÃO');
    writeln('---------------');
    write('Informe o ID do cliente: ');
    readln(consulta_id);
    writeln;

    consulta_id := consulta_id - 1;

    if (consulta_id < 0) or (consulta_id > length(cliente) - 1) then
    begin
      writeln('***Código inválido***');
      writeln('---------------------');
      permanecer_menu_principal:= True;
      exit;
    end;

    if (cliente[consulta_id].status = False) then
    begin
      writeln('***Cliente inativo, não é possivel devolução***');
      writeln('---------------------');
      permanecer_menu_principal:= True;
      writeln;
      exit;
    end;

    if not (cliente[consulta_id].statusPagamento = False) then
    begin
      writeln('***Cliente não locou filmes, não é possivel devolução***');
      writeln('---------------------');
      permanecer_menu_principal:= True;
      writeln;
      exit;
    end;


    writeln('O cliente "',cliente[consulta_id].nome,
    '" precisa devolver "', cliente[consulta_id].quantidadeFilmes,
    '" filmes:');

    for i:= 0 to cliente[consulta_id].quantidadeFilmes -1 do
    writeln(filme[cliente[consulta_id].id_filmes_locados[i]].nome);

    writeln;

    writeln('o valor total das pendencias é ', Format ('R$%.2f',[cliente[consulta_id].valorPendente]));
    writeln;

    writeln ('Confirma o pagamento e a devolução? Digite "S" sim ou tecle para sair:');
    readln (opcao_filmes);
    opcao_filmes:= UpCase (opcao_filmes);

    if (opcao_filmes <> 'S') then
    begin
     permanecer_menu_principal:= True;
     exit;
    end;

    writeln;
    writeln('Pagamento efetuado com sucesso cliente ',cliente[consulta_id].nome );
    writeln('---------------------------------------');
    writeln;

    for i := 0 to cliente[consulta_id].quantidadeFilmes - 1 do
      filme[cliente[consulta_id].id_filmes_locados[i]].locacao := False;

    SetLength (cliente[consulta_id].id_filmes_locados, 0);
    cliente[consulta_id].quantidadeFilmes:= 0;
    cliente[consulta_id].valorPendente:= 0;
    cliente[consulta_id].statusPagamento:= True;

  until ContinuarAcao = False ;
end;

end.
