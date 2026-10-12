CREATE OR REPLACE VIEW kfl_production_dbp_view.v_leistung_psp_wg_zu AS SELECT mandant_id,
 in_wg_id,
 bvv_leist_id
FROM kfl_production_dbp_data.leistung_psp_wg_zu;