CREATE OR REPLACE TRIGGER cpf_certo
BEFORE INSERT OR UPDATE ON tecnico
FOR EACH ROW
BEGIN 
    IF (LENGTH(:NEW.cpf) <> 11) THEN 
        RAISE_APPLICATION_ERROR(-20901,'Numero de CPF invalido'); 
    END IF; 
END;

/

CREATE OR REPLACE TRIGGER cnpj_certo
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW
BEGIN 
    IF (LENGTH(:NEW.cnpj) <> 14) THEN 
        RAISE_APPLICATION_ERROR(-20902,'Numero de CNPJ invalido'); 
    END IF; 
END;

/

CREATE OR REPLACE TRIGGER nao_deleta_os
BEFORE DELETE ON os
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20910,'Proibido deletar OS');
END;

/

CREATE OR REPLACE TRIGGER verifica_os
BEFORE INSERT OR UPDATE ON OS
FOR EACH ROW
DECLARE
    q_preventivas INTEGER;
    q_corretivas INTEGER;
BEGIN
    SELECT contrato_desconto.qpv INTO q_preventivas FROM contrato_desconto
    WHERE :NEW.id_cli_os_fk = contrato_desconto.id_cli_con_fk;
    SELECT contrato_desconto.qcv INTO q_corretivas FROM contrato_desconto
    WHERE :NEW.id_cli_os_fk = contrato_desconto.id_cli_con_fk;
    IF q_preventivas = 0 AND :NEW.tipo = 'MP' THEN
        RAISE_APPLICATION_ERROR(-20920,'Numero de Preventivas Excedido');
    END IF;
    IF q_preventivas <> 0 AND :NEW.tipo = 'MP' THEN
        UPDATE contrato_desconto SET qpv = (q_preventivas - 1) WHERE :NEW.id_cli_os_fk = contrato_desconto.id_cli_con_fk;
    END IF;
    IF q_corretivas = 0 AND :NEW.tipo = 'MC' THEN
        RAISE_APPLICATION_ERROR(-20921,'Numero de Corretivas Excedido');
    END IF;
    IF q_corretivas <> 0 AND :NEW.tipo = 'MC' THEN
        UPDATE contrato_desconto SET qcv = (q_corretivas - 1) WHERE :NEW.id_cli_os_fk = contrato_desconto.id_cli_con_fk;
    END IF;    
END;

/