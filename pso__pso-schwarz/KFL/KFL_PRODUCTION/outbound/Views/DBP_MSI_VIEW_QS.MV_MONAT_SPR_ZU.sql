CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_monat_spr_zu (mo_id, mo_bez) AS SELECT mo_id,
 mo_bez
FROM kfl_production_dbp_view.v_monat_spr_zu AS V01
WHERE spr_id = 22;