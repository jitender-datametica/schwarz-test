CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_vermieter_per AS SELECT mandant_id,
 vermieter_id,
 dat_von,
 dat_bis,
 vermieter_branche_id,
 vermieter_rechtsform,
 vermieter_name,
 vermieter_strasse,
 vermieter_plz,
 vermieter_ort,
 dat_insolvenz_eintritt,
 intern_fg,
 land_id
FROM kfl_production_dbp_data.ivs_vermieter_per;