CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_in_art_spr_zu_sk_1 AS SELECT mandant_id,
 in_art_id,
  CASE
  WHEN in_art_id = - 1
  THEN ''
  ELSE art_bez
  END AS art_bez
FROM kfl_production_dbp_view.v_in_art_spr_zu_1 AS V01
WHERE spr_id = 108;