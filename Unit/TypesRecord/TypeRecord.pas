unit TypeRecord;

interface

type
  TRloginAdm = record
    usuario: string;
    senha: string;
  end;

  TRfilmes = record
    nome: string;
    genero: string;
    censura: string;
    valor: double;
    status: boolean;
    locacao: boolean;
    id: integer;
  end;

  TRclientes = record
    nome: string;
    cpf: string;
    endereco: string;
    idade: integer;
    id: integer;
    id_filmes_locados: array of integer;
    quantidadeFilmes: integer;
    valorPendente: double;
    status: boolean;
    statusPagamento: boolean;
  end;


implementation


end.
