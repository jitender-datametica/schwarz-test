CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_fin_plan_2 AS SELECT fin_gruppe_hierarchie_id,
 dat_start,
 rpm_plantyp_id,
 dat_von,
 wrg_id,
 mandant_id,
 betrag,
 dat_bis
FROM kfl_production_dbp_data.rpm_fin_plan_2;