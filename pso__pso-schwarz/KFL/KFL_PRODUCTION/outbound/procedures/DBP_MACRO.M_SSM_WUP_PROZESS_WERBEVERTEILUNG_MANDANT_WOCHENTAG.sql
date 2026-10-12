CREATE OR REPLACE PROCEDURE dbp_macro.m_ssm_wup_prozess_werbeverteilung_mandant_wochentag(IN P_MANDANT_ID BIGNUMERIC, IN P_SSM_PROZESS_ID BIGNUMERIC, IN P_WTAG BIGNUMERIC, IN P_WERT BIGNUMERIC, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
MERGE INTO dbp_data.ssm_wup_prozess_werbeverteilung AS TARGET
USING (SELECT werbtsr.mandant_id, W.wup_id, W.nb_id, werbtsr.ssm_prozess_id, T.dat, werbtsr.wert
    FROM (SELECT P_MANDANT_ID AS mandant_id, P_SSM_PROZESS_ID AS ssm_prozess_id, P_WERT AS wert) AS werbtsr
        INNER JOIN dbp_data.wup AS W ON werbtsr.mandant_id = W.mandant_id
        INNER JOIN dbp_data.tag AS T ON P_WTAG = T.wtag_id
    WHERE W.nb_id = 0 AND W.dat_eroeffnung < DATE '2090-12-31' AND T.akt_wo BETWEEN 5 AND 52) AS source
ON TARGET.mandant_id = source.mandant_id AND TARGET.wup_id = source.wup_id AND TARGET.nb_id = source.nb_id AND TARGET.ssm_prozess_id = source.ssm_prozess_id AND TARGET.dat = source.dat
WHEN MATCHED THEN UPDATE SET
    wert = CAST(source.wert AS INTEGER)
WHEN NOT MATCHED THEN INSERT (mandant_id, wup_id, nb_id, ssm_prozess_id, dat, wert) VALUES(CAST(source.mandant_id AS INTEGER), source.wup_id, source.nb_id, CAST(source.ssm_prozess_id AS INTEGER), source.dat, CAST(source.wert AS INTEGER));
COMMIT TRANSACTION;
SET out_param  =  'UPDATE/INSERT SUCCESSFUL';
SELECT out_param;
RETURN;
END;
