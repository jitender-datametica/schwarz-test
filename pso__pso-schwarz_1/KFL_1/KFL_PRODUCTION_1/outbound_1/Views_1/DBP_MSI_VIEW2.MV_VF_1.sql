CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_vf_1 (vf_id, vf_name, mandant_id) AS SELECT vf_id,
 vf_name,
 mandant_id
FROM kfl_production_dbp_view.v_vf_1
WHERE mandant_id = 1;