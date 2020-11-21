/*Funcão retorna as filiais de cliente caso eles a tenham.*/

create or replace function consulta_filial(
id_cliente number)
    return varchar2 is
    v_id_matriz_FK cliente.id_matriz_FK%type;
begin
    select id_matriz_FK into v_id_matriz_FK
    from cliente
    where id = id_cliente;

    if v_id_matriz_FK is null then
        return null;
    end if;

    if v_id_matriz_FK is not null then
        return v_id_matriz_FK;
    end if;

end consulta_filial;

/
