CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_termin_1 AS SELECT mandant_id,
 dat_plan_zaehlung,
 inventurart_id,
 inventurart_kurz_bez,
 inventurart_bez,
 dat_von,
 dat_bis,
 inventurart_int_id
FROM kfl_production_dbp_data.inventur_termin_1;