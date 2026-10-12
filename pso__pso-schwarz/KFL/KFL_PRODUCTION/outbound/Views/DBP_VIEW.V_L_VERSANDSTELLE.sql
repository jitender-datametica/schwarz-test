CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_versandstelle AS SELECT mandant_id,
 versandstelle_id,
 artikelsortiment_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_versandstelle;