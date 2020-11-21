/*Procedure para solicitar peças ou cancelar uma solicitação de peças/

create or replace procedure sp_os (
    v_numero_os number,
    v_desc_serv varchar,
    v_id_cli_os_FK number,
    v_id_tec_os_FK number,
    v_parametro varchar
) is
begin
    if v_parametro = 'alterar descricao' then
        update os set desc_serv = v_desc_serv where numero_os = v_numero_os;
    else
    if v_parametro = 'cliente cancela os' then
        delete from os where id_cli_os_FK = v_id_cli_os_FK;
    else
    if v_parametro = 'tecnico cancela os' then
        delete from os where id_tec_os_FK = v_id_tec_os_FK;
    end if;
    end if;
    end if;

end sp_os;