CREATE OR REPLACE VIEW kfl_production_dbp_view.v_it_projekt_plan_1 AS SELECT it_projekt_id,
 plan_revision_id,
 planart_id,
 sonstiger_aufwand,
 aktivierungsquote_intern_ist,
 aktivierungsquote_intern_plan,
 aktivierungsquote_extern_ist,
 aktivierungsquote_extern_plan,
 dat_von,
 dat_bis,
 kapital_kostensatz
FROM kfl_production_dbp_data.it_projekt_plan_1;