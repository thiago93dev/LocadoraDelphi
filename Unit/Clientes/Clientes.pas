unit Clientes;

interface
uses
  System.SysUtils,
  Procedimentos,
  TypeRecord;

var
  cliente: array of TRclientes;

Procedure CadastrarCliente;
procedure ConsultarClientes;
procedure InativarCliente;

implementation
var
  tipo_consulta: integer;
  id_clientes: integer = 0;

Procedure CadastrarCliente;
begin
  repeat
    setlength(cliente, length(cliente) + 1);

    writeln('CADASTRAR CLIENTE');
    write('Nome Cliente: ');
    readln(cliente[id_clientes].nome);
    cliente[id_clientes].nome := AnsiUpperCase(cliente[id_clientes].nome);
    write('CPF: ');
    readln(cliente[id_clientes].cpf);
    write('Endereço: ');
    readln(cliente[id_clientes].endereco);
    write('Idade: ');
    readln(cliente[id_clientes].idade);

    cliente[id_clientes].id := id_clientes + 1;
    cliente[id_clientes].status := True;
    cliente[id_clientes].statusPagamento := True;
    cliente[id_clientes].valorPendente := 0;
    cliente[id_clientes].quantidadeFilmes:= 0;
    writeln;

    writeln('"Cadastro Realizado"');
    writeln('ID Cliente: ', cliente[id_clientes].id);
    writeln;

    id_clientes := id_clientes + 1;
  until ContinuarAcao = False ;
end;

procedure PesquisarClienteLista;
var
  i: integer;
  consultar: char;
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
  readln(consultar);
  writeln;
  consultar := UpCase(consultar);


  if consultar = 'A' then
  begin
    for i := 0 to length(cliente) - 1 do
      if cliente[i].status = True then
      begin
        writeln('"CLIENTES ATIVOS"');
        writeln('Nome: ', cliente[i].nome);
        writeln('CPF: ', cliente[i].cpf);
        writeln('Endereço: ', cliente[i].endereco);
        writeln('Idade: ', cliente[i].idade);
        writeln('Valor pendente: ',Format('R$%.2f',[cliente[i].valorPendente]));
        writeln('ID Cliente: ', cliente[i].id);
        writeln;
      end;
  end
  else if consultar = 'B' then
  begin
    writeln('Lista de Excluidos');
    writeln;

    for i := 0 to length(cliente) - 1 do
      if cliente[i].status = False then
      begin
        writeln('"CLIENTES EXCLUIDOS"');
        writeln('Nome: ', cliente[i].nome);
        writeln('CPF: ', cliente[i].cpf);
        writeln('Endereço: ', cliente[i].endereco);
        writeln('Idade: ', cliente[i].idade);
        writeln('Valor pendente: ', Format('R$%.2f',[cliente[i].valorPendente]));
        writeln('ID Cliente: ', cliente[i].id);
        writeln;
      end;
  end
  else
  begin
    for i := 0 to length(cliente) - 1 do
    begin
      writeln('"TODOS CLIENTES"');
      writeln('Nome: ', cliente[i].nome);
      writeln('CPF: ', cliente[i].cpf);
      writeln('Endereço: ', cliente[i].endereco);
      writeln('Idade: ', cliente[i].idade);
      writeln('Valor pendente: ', Format('R$%.2f',[cliente[i].valorPendente]));
      writeln('ID Cliente: ', cliente[i].id);

      if cliente[i].status = True then
        writeln('Status: ativo')
      else
        writeln('Status: inativo');

      writeln;
    end;
  end;
end;

procedure PesquisarClienteIndividual;
var
  consulta_id: integer;
begin
  if not (tipo_consulta = 2) then
  begin
    permanecer_menu_principal:= True;
    exit;
  end;

  writeln('CONSULTA INDIVIDUAL');
  write('Digite a ID Cliente: ');
  readln(consulta_id);
  writeln;

  consulta_id := consulta_id - 1;

  if (consulta_id < 0) or (consulta_id > length(cliente) - 1) then
  begin
    writeln('***Código inválido***');
    writeln('---------------------');
    permanecer_menu_principal:= True;
    writeln;
    exit;
  end;

  if cliente[consulta_id].status = False then
  begin
    writeln('***Cliente já esta excluido***');
    writeln('---------------------');
    permanecer_menu_principal:= True;
    writeln;
    exit;
  end;

  writeln('Nome: ', cliente[consulta_id].nome);
  writeln('CPF: ', cliente[consulta_id].cpf);
  writeln('Endereço: ', cliente[consulta_id].endereco);
  writeln('Idade: ', cliente[consulta_id].idade);
  writeln('Valor pendente: ', Format('R$%.2f',[cliente[consulta_id].valorPendente]));
  writeln('ID Cliente: ', cliente[consulta_id].id);
  writeln;

  if (cliente[consulta_id].status = True) then
    writeln('Status: ativo')
  else
    writeln('Status: inativo');
end;

procedure ConsultarClientes;
begin
 repeat
   if length(cliente) < 1 then
   begin
    writeln('***Nenhum cliente cadastrado***');
    writeln('---------------------');
    permanecer_menu_principal:= True;
    writeln;
    exit;
   end;

   writeln('CONSULTA CLIENTES');
   writeln('Digite "1" para lista ou "2" para individual: ');
   readln(tipo_consulta);
   writeln;
   PesquisarClienteLista;
   PesquisarClienteIndividual;

 until ContinuarAcao = False ;
end;

procedure InativarCliente;
var
 id_cliente: integer;
begin
  repeat
    if length(cliente) < 1 then
    begin
      writeln('***Nenhum cliente cadastrado***');
      writeln('---------------------');
      permanecer_menu_principal:= True;
      writeln;
      exit;
    end;

    writeln('EXCLUIR CLIENTE');
    write('Digite o ID do cliente: ');
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

     if (cliente[id_cliente].statusPagamento = False) then
    begin
      writeln('***Cliente possui locações, não é possivel exclusão***');
      writeln('---------------------');
      writeln;
      permanecer_menu_principal:= True;
      exit;
    end;

    if cliente[id_cliente].status = False then
    begin
      writeln('Cliente "',cliente[id_cliente].id,'" já esta excluido');
      writeln('---------------------');
      writeln;
      permanecer_menu_principal:= True;
      exit;
    end;

    cliente[id_cliente].status := False;
    writeln('Cliente"',cliente[id_cliente].nome, '" removido');;
    writeln('ID: ', cliente[id_cliente].id);
    writeln;
  until ContinuarAcao = False ;
end;

end.
