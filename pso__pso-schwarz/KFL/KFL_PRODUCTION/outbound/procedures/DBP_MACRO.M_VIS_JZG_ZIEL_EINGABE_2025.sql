/* OWNER does not work */



/*



	SQL MERGE JZG : Jahreszielgespräch. TS Zielwerte + Kommentare



	2025-01-23 ssch0611 : Review 2025. Kommentar Zielereichung [AP0244672]



*/



CREATE OR REPLACE PROCEDURE dbp_macro.m_vis_jzg_ziel_eingabe_2025(IN P_MANDANT_ID INT64, IN P_NB_ID INT64, IN P_WUP_ID INT64, IN P_WRG_ID STRING, IN P_GJ INT64, IN P_METRIK_ID INT64, IN P_TYP_ID INT64, IN P_LEVEL_ID INT64, IN P_WERT_EINGABE FLOAT64, IN P_KOMMENTAR_EINGABE STRING, IN P_ZIELERREICH_EINGABE STRING, OUT out_param STRING)
BEGIN
DECLARE v_ergebnis STRING(16777216) DEFAULT 'JZG 2025 merged';
BEGIN 
BEGIN TRANSACTION;
MERGE INTO dbp_msi_view_vis.ts_vis_jzg_ziel_eingabe_2025 AS TRGT
USING (SELECT P_MANDANT_ID AS mandant_id, P_NB_ID AS nb_id, P_WUP_ID AS wup_id, P_WRG_ID AS wrg_id, P_GJ AS gj, P_METRIK_ID AS metrik_id, P_TYP_ID AS typ_id, P_LEVEL_ID AS level_id, P_WERT_EINGABE AS wert_eingabe, P_KOMMENTAR_EINGABE AS kommentar_eingabe, P_ZIELERREICH_EINGABE AS zielerreich_eingabe) AS srce
ON TRGT.mandant_id = srce.mandant_id AND TRGT.wup_id = srce.wup_id AND TRGT.wrg_id = srce.wrg_id AND TRGT.gj = srce.gj AND TRGT.metrik_id = srce.metrik_id AND TRGT.typ_id = srce.typ_id AND TRGT.level_id = srce.level_id
WHEN MATCHED THEN UPDATE SET
    wert_eingabe = ROUND(ROUND(CAST(srce.wert_eingabe AS BIGNUMERIC), 0), 0),
    kommentar_eingabe = srce.kommentar_eingabe,
    zielerreich_eingabe = srce.zielerreich_eingabe,
    zeitstempel = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(srce.mandant_id , srce.nb_id , srce.wup_id , srce.wrg_id, srce.gj , srce.metrik_id , srce.typ_id , srce.level_id , ROUND(ROUND(CAST(COALESCE(srce.wert_eingabe, NULL) AS BIGNUMERIC), 0), 0), COALESCE(srce.kommentar_eingabe, ''), COALESCE(srce.zielerreich_eingabe, ''), CAST(CURRENT_TIMESTAMP() AS DATETIME));
COMMIT TRANSACTION;
SET out_param  =  v_ergebnis;
SELECT out_param;
RETURN;
END;
END;


