CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_termin_wup_zu_per_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat_plan_zaehlung,
 inventur_abnahme_fg
FROM kfl_production_dbp_data.inventur_termin_wup_zu_per_2;