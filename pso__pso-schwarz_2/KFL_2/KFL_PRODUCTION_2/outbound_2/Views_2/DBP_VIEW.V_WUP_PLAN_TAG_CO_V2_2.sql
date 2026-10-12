CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_plan_tag_co_v2_2 AS SELECT wup_id,
 nb_id,
 mandant_id,
 dat,
 regression_faktor_var,
 regression_faktor_fix
FROM kfl_production_dbp_data.wup_plan_tag_co_v2_2;