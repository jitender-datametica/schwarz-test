/* OWNER does not work */
/*
	SQL MERGE Leergut :  TS Eingabe Löschung
	2025-03-20 muellerpatri : initiale Erstellung [AP0228745]
*/



CREATE OR REPLACE PROCEDURE dbp_macro.m_vis_warenverlust_loesch_eingabe(IN P_MANDANT_ID BIGNUMERIC, IN P_INVENTUR_ID BIGNUMERIC, IN P_LOESCH_FG BIGNUMERIC, OUT out_param STRING)
BEGIN
DECLARE v_ergebnis STRING(16777216) DEFAULT 'Leergut merged';
BEGIN
BEGIN TRANSACTION;
MERGE INTO dbp_data.inventur_warenverlust AS TRGT
USING (SELECT P_MANDANT_ID AS mandant_id, P_INVENTUR_ID AS inventur_id, P_LOESCH_FG AS loesch_fg) AS srce
ON TRGT.inventur_id = srce.inventur_id AND TRGT.mandant_id = srce.mandant_id
WHEN MATCHED THEN UPDATE SET
    loesch_fg = CAST(srce.loesch_fg AS INTEGER),
    td_update = CURRENT_TIMESTAMP();
COMMIT TRANSACTION;
SET out_param  =  v_ergebnis;
SELECT out_param;
RETURN;
END;
END;
