CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lager_bewart_spr_zu (mandant_id, lager_bewart_id, spr_id, system_id,
lager_bewart_bez, td_insert, td_update) AS SELECT mandant_id,
 lager_bewart_id,
 spr_id,
 system_id,
 lager_bewart_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.lager_bewart_spr_zu;