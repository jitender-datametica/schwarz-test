/* OWNER does not work */
/*
	SQL MERGE Leergut :  TS Eingabe Zählung
	2025-03-20 muellerpatri : initiale Erstellung [AP0228745]
*/



CREATE OR REPLACE PROCEDURE dbp_macro.m_vis_leergut_wert_eingabe(IN P_MANDANT_ID BIGNUMERIC, IN P_WUP_ID BIGNUMERIC, IN P_NB_ID BIGNUMERIC, IN P_DAT STRING, IN P_WRG_ID STRING, IN P_BETRAG_LEERGUT_ZAEHLUNG FLOAT64, OUT out_param STRING)
BEGIN
DECLARE v_ergebnis STRING(16777216) DEFAULT 'Leergut merged';
BEGIN
BEGIN TRANSACTION;
MERGE INTO dbp_msi_data.ts_wup_dat_leergut_1 AS TRGT
USING (SELECT P_MANDANT_ID AS mandant_id, P_WUP_ID AS wup_id, P_NB_ID AS nb_id, P_DAT AS dat, 
    P_WRG_ID AS wrg_id, P_BETRAG_LEERGUT_ZAEHLUNG AS betrag_leergut_zaehlung) AS srce
ON TRGT.mandant_id = srce.mandant_id AND TRGT.wup_id = srce.wup_id 
AND TRGT.dat = CAST(srce.dat AS DATE) AND TRGT.wrg_id = srce.wrg_id
WHEN MATCHED THEN UPDATE SET
    betrag_leergut_zaehlung = CAST(ROUND(CAST(srce.betrag_leergut_zaehlung AS BIGNUMERIC), 0) AS NUMERIC),
    td_update = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(CAST(srce.mandant_id AS INTEGER), CAST(srce.wup_id AS INTEGER), CAST(srce.nb_id AS INTEGER), CAST(srce.dat AS DATE), srce.wrg_id, CAST(ROUND(CAST(COALESCE(srce.betrag_leergut_zaehlung, NULL) AS BIGNUMERIC), 0) AS NUMERIC), CAST(NULL AS NUMERIC), CAST(NULL AS TIMESTAMP), CURRENT_TIMESTAMP());
COMMIT TRANSACTION;
SET out_param  =  v_ergebnis;
SELECT out_param;
RETURN;
END;
END;