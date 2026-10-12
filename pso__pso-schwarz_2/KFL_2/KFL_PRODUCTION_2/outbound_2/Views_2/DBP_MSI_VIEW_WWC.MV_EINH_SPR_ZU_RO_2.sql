CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_einh_spr_zu_ro_2 (einh_id, mandant_id, spr_id, einh_bez_kaufm,
einh_bez) AS SELECT einh_id,
 mandant_id,
 spr_id,
 einh_bez_kaufm,
 einh_bez
FROM kfl_production_dbp_view.v_einh_spr_zu_2
WHERE spr_id = 95;