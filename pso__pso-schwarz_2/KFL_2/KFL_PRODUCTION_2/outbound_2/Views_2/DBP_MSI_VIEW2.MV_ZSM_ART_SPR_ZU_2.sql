CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_zsm_art_spr_zu_2 (int_art_id, mandant_id, art_bez) AS SELECT V02.int_art_id
 ,
 V01.mandant_id,
 V01.art_bez
FROM kfl_production_dbp_view.v_art_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02.art_id
WHERE V01.spr_id = 22
 AND V01.mandant_id = 1;