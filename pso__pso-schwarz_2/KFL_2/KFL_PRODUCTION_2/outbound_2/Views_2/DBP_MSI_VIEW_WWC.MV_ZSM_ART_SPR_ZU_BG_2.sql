CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_zsm_art_spr_zu_bg_2 (spr_id, int_art_id, mandant_id, int_art_bez
) AS SELECT V01.spr_id,
 V02.int_art_id,
 V01.mandant_id,
 V01.art_bez AS int_art_bez
FROM kfl_production_dbp_view.v_art_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
WHERE V01.spr_id = 18;