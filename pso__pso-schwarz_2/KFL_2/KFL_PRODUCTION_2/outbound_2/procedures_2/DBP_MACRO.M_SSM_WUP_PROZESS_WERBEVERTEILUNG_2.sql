CREATE OR REPLACE PROCEDURE dbp_macro.m_ssm_wup_prozess_werbeverteilung(IN P_MANDANT_ID BIGNUMERIC, IN P_WUP_ID BIGNUMERIC, IN P_NB_ID BIGNUMERIC, IN P_SSM_PROZESS_ID BIGNUMERIC, IN P_DAT STRING, IN P_WERT BIGNUMERIC, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
MERGE INTO dbp_data.ssm_wup_prozess_werbeverteilung_2 AS TARGET
USING (SELECT P_MANDANT_ID AS mandant_id, P_WUP_ID AS wup_id, P_NB_ID AS nb_id, P_SSM_PROZESS_ID AS ssm_prozess_id, P_DAT AS dat, P_WERT AS wert) AS source
ON TARGET.mandant_id = source.mandant_id AND TARGET.wup_id = source.wup_id AND TARGET.nb_id = source.nb_id AND TARGET.ssm_prozess_id = source.ssm_prozess_id AND TARGET.dat = CAST(source.dat AS DATE)
WHEN MATCHED THEN UPDATE SET
    wert = CAST(source.wert AS INTEGER)
WHEN NOT MATCHED THEN INSERT (mandant_id, wup_id, nb_id, ssm_prozess_id, dat, wert) VALUES(CAST(source.mandant_id AS INTEGER), CAST(source.wup_id AS INTEGER), CAST(source.nb_id AS INTEGER), CAST(source.ssm_prozess_id AS INTEGER), CAST(source.dat AS DATE), CAST(source.wert AS INTEGER));
COMMIT TRANSACTION;
SET out_param  =  'UPDATE/INSERT SUCCESSFUL';
SELECT out_param;
RETURN;
END;
