CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artkz_eigenmarke AS SELECT eigenmarke_id,
 mandant_id,
 spr_id,
 eigenmarke_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.artkz_eigenmarke;