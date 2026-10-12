CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_sparte_spr_zu_sk_2 AS SELECT DE.sparte_id,
 COALESCE(ls.sparte_bez, DE.sparte_bez) AS sparte_bez
FROM kfl_production_dbp_view.v_sparte_spr_zu_2 AS DE
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_sparte_spr_zu_2
  WHERE spr_id = 108) AS ls ON DE.sparte_id = ls.sparte_id
WHERE DE.spr_id = 22
 AND DE.sparte_id <> 8;