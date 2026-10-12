-- 20230718 staeblern  - CAST bei Art_id_Bez entfernen. wird nicht benoetigt und fuehrt zu fehler, wenn wir mehr Zeichen haben

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.tbl_mv_art_spr_zu_1 (spr_id, art_id, mandant_id, art_bez
, art_id_bez) AS SELECT spr_id,
 art_id,
 mandant_id,
 art_bez,
   CAST(art_id AS STRING) || ' ' || art_bez AS art_id_bez
FROM kfl_production_dbp_view.v_art_spr_zu_1 AS V01;