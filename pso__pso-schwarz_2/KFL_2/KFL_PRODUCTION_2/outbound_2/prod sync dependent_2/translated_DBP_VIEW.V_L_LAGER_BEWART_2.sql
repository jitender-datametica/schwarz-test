CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lager_bewart_2 (mandant_id, lager_bewart_id, system_id,
abschriftgruppe_id) AS SELECT mandant_id,
 lager_bewart_id,
 system_id,
 abschriftgruppe_id
FROM kfl_production_dbp_data.l_lager_bewart_2;