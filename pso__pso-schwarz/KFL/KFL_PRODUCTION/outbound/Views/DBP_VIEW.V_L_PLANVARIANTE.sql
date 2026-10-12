CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_planvariante AS SELECT planvariante_id,
 mandant_id,
 system_id,
 spr_id,
 planvariante_bez
FROM kfl_production_dbp_data.l_planvariante;