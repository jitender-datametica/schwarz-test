CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lis_plan_spr_zu_2 AS SELECT mandant_id,
 lis_planzahl_id,
 lis_plan_typ_id,
 spr_id,
 lis_planzahl_bez
FROM kfl_production_dbp_data.lis_plan_spr_zu_2;