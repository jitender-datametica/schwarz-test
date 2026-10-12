CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_bew_grund_spr_zu AS SELECT mandant_id,
 flw_bew_grund_id,
 lager_bewart_id,
 spr_id,
 flw_bew_grund_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_bew_grund_spr_zu;