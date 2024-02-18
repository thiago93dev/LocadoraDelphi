unit LocacaoFilmes;

interface

uses
  System.SysUtils,
  Clientes,
  Filmes,
  TypeRecord,
  Procedimentos;

procedure LocarFilme;

implementation

procedure LocarFilme;
var
  sair_lista: boolean;
  i, j, id_cliente, quantidade: integer;
  locacao_filme, vetor_dias: array of integer;
  opcao_locacao: char;
  total_locacao: double;
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

    writeln('AREA DE LOCAÇÃO');
    writeln('---------------');
    write('Informe o ID do cliente: ');
    readln(id_cliente);
    writeln;

    id_cliente := id_cliente - 1;

    if (id_cliente < 0) or (id_cliente > length(cliente) - 1) then
    begin
      writeln('***Código inválido***');
      writeln('---------------------');
      writeln;
      permanecer_menu_principal:= True;
      exit;
    end;

    if (cliente[id_cliente].status = False) then
    begin
      writeln('***Cliente inativo, não é possivel locação***');
      writeln('---------------------');
      writeln;
      permanecer_menu_principal:= True;
      exit;
    end;

    if (cliente[id_cliente].statusPagamento = False) then
    begin
      writeln('***Cliente ja possui locações, não é possivel locação***');
      writeln('---------------------');
      writeln;
      permanecer_menu_principal:= True;
      exit;
    end;

    writeln('Cadastro cliente "',cliente[id_cliente].nome,'" acessado com sucesso');
    writeln('-----------------------------');
    writeln;

    write('Digite a quantidade de filmes que serão locados: ');
    readln(quantidade);
    writeln;

    if (quantidade > length(filme)) then
    begin
     writeln('***Quantidade maior do que os filmes cadastrados***');
     writeln('---------------------');
     writeln;
     permanecer_menu_principal:= True;
     exit;
    end;

    setlength(locacao_filme, quantidade);
    setlength(vetor_dias, quantidade);

    for i := 0 to quantidade - 1 do
    begin
      write('Digite a ID do filme: ');
      readln(locacao_filme[i]);

      if (locacao_filme[i]-1 < 0) or (locacao_filme[i]-1 > length(filme)-1) then
      begin
        writeln;
        writeln('***Código inválido***');
        writeln('---------------------');
        permanecer_menu_principal:= True;
        writeln;
        exit;
      end;

      if (filme[locacao_filme[i]-1].status = False) then
      begin
        writeln;
        writeln('***Filme inativo, não é possivel locação***');
        writeln('---------------------');
        permanecer_menu_principal:= True;
        writeln;
        exit;
      end;
    end;

    for i:= 0 to quantidade -1 do
      if length (locacao_filme) = 0 then
      begin
      permanecer_menu_principal:= True;
      exit;
      end
      else
        for j := i + 1 to quantidade-1 do
          if locacao_filme[i] = locacao_filme [j] then
            begin
              writeln;
              writeln('***Operação inválida voce digitou ID de filme repetida***');
              writeln('---------------------');
              writeln;
              setlength (locacao_filme,0);
              permanecer_menu_principal:= True;
              exit;
            end;

    writeln;

    for i := 0 to quantidade - 1 do
      if (filme[locacao_filme[i]-1].locacao = False) then
      begin
        writeln('Filme "', filme[locacao_filme[i]-1].nome, '" disponivel');
        writeln;
      end
      else
      begin
        writeln('Filme "', filme[locacao_filme[i]-1].nome, '" locado');
        writeln;
        permanecer_menu_principal:= True;
        sair_lista:= True;
      end;

    if (sair_lista = True) then
    exit;

    total_locacao:= 0;

    for i := 0 to quantidade - 1 do
    begin
      write('Quantos dias voce pretende locar o filme "', filme[locacao_filme[i]-1].nome, '": ');
      readln(vetor_dias[i]);
      total_locacao:= total_locacao + (filme[locacao_filme[i]-1].valor * vetor_dias[i]);
      writeln;
    end;

    writeln('"VALORES"');
    writeln('---------');

    for i := 0 to quantidade - 1 do
    begin
      writeln('O valor individual do filme "', filme[locacao_filme[i]-1].nome,'" é: ', Format('R$%.2f', [filme[locacao_filme[i]-1].valor]));
      writeln('O valor com os dias locados é: ',Format('R$%.2f', [(filme[locacao_filme[i]-1].valor * vetor_dias[i])]));
      writeln;
    end;

    writeln('O valor total da locação é: ', Format('R$%.2f', [total_locacao]));
    writeln;

    writeln('Deseja confirmar a operação? "S" para continuar ou tecle para sair: ');
    readln(opcao_locacao);
    opcao_locacao := UpCase(opcao_locacao);
    writeln;


    if (opcao_locacao = 'S') then
    begin
      setlength (cliente[id_cliente].id_filmes_locados, quantidade);

      for i := 0 to quantidade - 1 do
      begin
      filme[locacao_filme[i]-1].locacao := True;
      cliente[id_cliente].id_filmes_locados[i]:= locacao_filme[i]-1;
      end;
    end
    else
    begin
      writeln('Operação não confirmada');
      writeln('---------------------');
      writeln;
      permanecer_menu_principal:= True;
      exit;
    end;

    cliente[id_cliente].quantidadeFilmes:= quantidade;
    cliente[id_cliente].valorPendente := total_locacao;
    cliente[id_cliente].statusPagamento := False;

    setlength (locacao_filme,0);

    writeln('Filme(s) locados com sucesso');
    writeln('----------------------------');
    writeln;
  until ContinuarAcao = False;
end;

end.
