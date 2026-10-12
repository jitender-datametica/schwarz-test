CREATE OR REPLACE VIEW kfl_production_dbp_view.v_it_projekt_bew_1 AS SELECT it_projekt_id,
 extern_fg,
 dat_leistung,
 it_projekt_bereich_id,
 it_plan_ebene_id,
 mandant_id,
 hr_objekt_ebene11_id,
 stunden_ist,
 stunden_bewertet,
 wrg_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.it_projekt_bew_1;