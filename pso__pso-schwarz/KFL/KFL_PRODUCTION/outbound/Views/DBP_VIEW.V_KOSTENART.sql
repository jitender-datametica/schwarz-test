CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kostenart AS SELECT krk_id,
 kostenart_id,
 mandant_id,
 system_id,
 kontenplan_id,
 kostenart_altnv_id,
 kostenart_grp_id
FROM kfl_production_dbp_data.kostenart;