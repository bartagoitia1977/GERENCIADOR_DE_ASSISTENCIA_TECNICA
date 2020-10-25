/* Criação das tabelas do banco de dados Assistência Técnica */

create table cliente (
    id number(5) primary key not null,
    id_matriz_FK number(5),
    cnpj varchar(14) unique not null,
    nome_fantasia varchar(50) not null,
    razao_social varchar(50) not null,
    telefone_fixo varchar(10),
    telefone_movel varchar(11),
    end_estado varchar(2),
    end_cidade varchar(30),
    end_bairro varchar(30),
    end_cep varchar(8) not null,
    end_logradouro varchar(100),
    end_complemento varchar(20)
    );

create table OS (
    numero_os number(6) primary key not null,
    id_tec_os_FK number(3) not null,
    id_cli_os_FK number(5) not null,
    ns_FK varchar(20) not null,
    data_ini date not null,
    data_ter date not null,
    tipo varchar(2) not null,
    desc_serv varchar(100) not null,
    data_ger date not null
    );

create table equipamento (
    ns varchar(20) primary key not null,
    numero_con_FK number(4) not null,
    modelo varchar(10) not null,
    fabricante varchar(20) not null,
    data_fabricacao date not null
    );

create table reparo (
    id_reparo number(6) not null,
    ns_FK varchar(20) not null,
    data_rep date not null,
    numero_reparos integer not null,
    primary key (id_reparo,ns_FK)
    );

create table contrato_desconto (
    numero_con number(4) primary key not null,    
    id_cli_con_FK number(5) not null,
    data_ini date not null,
    data_ter date not null,
    valor float not null,
    qpv integer not null,
    qc integer not null,
    qcv integer not null,
    qp integer not null,
    porc_desc float not null
    );

create table tecnico (
    id number(3) primary key not null,
    nome varchar(50) not null,
    cpf varchar(11) unique not null,
    telefone_fixo varchar(10),
    telefone_movel varchar(11),
    end_estado varchar(2),
    end_cidade varchar(30),
    end_bairro varchar(30),
    end_cep varchar(8) not null,
    end_logradouro varchar(100),
    end_complemento varchar(20)
    );

create table requisita (
    id_FK number(3) not null,
    cod_peca_FK number(8) not null,
    primary key (id_FK,cod_peca_FK)
    );

create table peca (
    cod_peca number(8) primary key not null,
    descricao varchar(30) not null
    );

/* Configuração das chaves estrangeiras */

alter table cliente add constraint filial_matriz foreign key (id_matriz_FK) references cliente(id);
alter table os add constraint tec_os_fk foreign key (id_tec_os_FK) references tecnico(id);
alter table os add constraint cli_os_fk foreign key (id_cli_os_FK) references cliente(id);
alter table os add constraint eq_os_fk foreign key (ns_FK) references equipamento(ns);
alter table equipamento add constraint eq_con_fk foreign key (numero_con_FK) references contrato_desconto(numero_con);
alter table contrato_desconto add constraint con_eq_fk foreign key (id_cli_con_FK) references cliente(id);
alter table reparo add constraint rep_eq_fk foreign key (ns_FK) references equipamento(ns);
alter table requisita add constraint req_tec_fk foreign key (id_FK) references tecnico(id);
alter table requisita add constraint req_pec_fk foreign key (cod_peca_FK) references peca(cod_peca);