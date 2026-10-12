/* OWNER does not work */



CREATE OR REPLACE PROCEDURE dbp_macro.m_vis_jzg_ziel_merge(IN P_MANDANT_ID BIGNUMERIC, IN P_NB_ID BIGNUMERIC, IN P_WUP_ID BIGNUMERIC, IN P_WRG_ID STRING, IN P_GJ BIGNUMERIC, IN P_METRIK_ID BIGNUMERIC, IN P_TYP_ID BIGNUMERIC, IN P_LEVEL_ID BIGNUMERIC, IN P_WERT_EINGABE FLOAT64, IN P_KOMMENTAR_EINGABE STRING, OUT out_param STRING)
BEGIN
DECLARE v_ergebnis STRING(16777216) DEFAULT 'Merge';
BEGIN
BEGIN TRANSACTION;
MERGE INTO dbp_msi_view_vis.ts_vis_jzg_ziel_eingabe_1 AS TRGT
USING (SELECT P_MANDANT_ID AS mandant_id, P_NB_ID AS nb_id, P_WUP_ID AS wup_id, P_WRG_ID AS wrg_id, P_GJ AS gj, P_METRIK_ID AS metrik_id, P_TYP_ID AS typ_id, P_LEVEL_ID AS level_id, P_WERT_EINGABE AS wert_eingabe, P_KOMMENTAR_EINGABE AS kommentar_eingabe) AS srce
ON TRGT.mandant_id = srce.mandant_id AND TRGT.wup_id = srce.wup_id AND TRGT.wrg_id = srce.wrg_id AND TRGT.gj = srce.gj AND TRGT.metrik_id = srce.metrik_id AND TRGT.typ_id = srce.typ_id AND TRGT.level_id = srce.level_id
WHEN MATCHED THEN UPDATE SET
    wert_eingabe = ROUND(CAST(srce.wert_eingabe AS BIGNUMERIC), 0),
    kommentar_eingabe = srce.kommentar_eingabe,
    zeitstempel = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(CAST(srce.mandant_id AS INTEGER), CAST(srce.nb_id AS INTEGER), CAST(srce.wup_id AS INTEGER), srce.wrg_id, CAST(srce.gj AS INTEGER), CAST(srce.metrik_id AS INTEGER), CAST(srce.typ_id AS INTEGER), CAST(srce.level_id AS INTEGER), ROUND(CAST(COALESCE(srce.wert_eingabe, NULL) AS BIGNUMERIC), 0), COALESCE(srce.kommentar_eingabe, ''), CAST(CURRENT_TIMESTAMP() AS DATETIME));
COMMIT TRANSACTION;
SET v_ergebnis  =  'JZG ' || v_ergebnis || ' done';
SET out_param  =  v_ergebnis;
SELECT out_param;
RETURN;
END;
END;