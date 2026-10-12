CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_wirtschaftseinheit_messung AS SELECT mandant_id,
 we_intreno,
 dat_von,
 dat_bis,
 bemessung_art_id,
 groesse,
 groesse_einheit
FROM kfl_production_dbp_data.immo_wirtschaftseinheit_messung;