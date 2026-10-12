CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_wbnk_gruppe AS SELECT system_id,
 mandant_id,
 wbnk_gruppe_id
FROM kfl_production_dbp_data.l_wbnk_gruppe;