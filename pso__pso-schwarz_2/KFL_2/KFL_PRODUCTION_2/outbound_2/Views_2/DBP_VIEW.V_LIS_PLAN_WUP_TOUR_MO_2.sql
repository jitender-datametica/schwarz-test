CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lis_plan_wup_tour_mo_2 AS SELECT mandant_id,
 lis_planzahl_id,
 lis_plan_typ_id,
 wup_id,
 nb_id,
 belos_tourart_id,
 kjmo,
 lis_plan_wert
FROM kfl_production_dbp_data.lis_plan_wup_tour_mo_2;