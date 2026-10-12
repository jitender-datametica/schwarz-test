CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_einh_spr_zu_2 AS SELECT einh_id,
 mandant_id,
 spr_id,
 einh_bez_kaufm,
 einh_bez
FROM kfl_production_dbp_view.v_einh_spr_zu_2 AS V01
WHERE mandant_id <> 1;