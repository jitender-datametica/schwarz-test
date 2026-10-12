CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_lager_bewart_spr_zu_1 AS SELECT mandant_id,
 lager_bewart_id,
 spr_id,
 lager_bewart_bez,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_lager_bewart_spr_zu_1;