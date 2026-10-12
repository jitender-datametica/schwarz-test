CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_hl_sk_1 AS SELECT mandant_id,
 ma_id AS hausleiter_id,
 ma_anrede,
 ma_name,
 ma_vorname
FROM kfl_production_dbp_view.v_ma_spr_zu_1
WHERE spr_id = 108
 AND (mandant_id, ma_id) IN (SELECT (mandant_id, hausleiter_id)
   FROM kfl_production_dbp_msi_v_view.v_wup_denorm_1);