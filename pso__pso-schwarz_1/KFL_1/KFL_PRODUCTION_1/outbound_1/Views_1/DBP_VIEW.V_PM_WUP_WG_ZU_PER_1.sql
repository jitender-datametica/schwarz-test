CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pm_wup_wg_zu_per_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 arthiertyp_id,
 wg_id,
 dat_von,
 pm_id,
 dat_bis,
 spr_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.pm_wup_wg_zu_per_1;