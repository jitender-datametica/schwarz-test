CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kl_owg_nielsen AS SELECT mandant_id,
 kl_owg_id,
 kl_wg_id,
 kl_owg_bez
FROM kfl_production_dbp_data.kl_owg_nielsen;