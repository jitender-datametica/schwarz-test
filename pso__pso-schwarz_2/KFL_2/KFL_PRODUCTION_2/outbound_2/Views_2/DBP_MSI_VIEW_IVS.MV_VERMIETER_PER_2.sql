CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_vermieter_per_2 AS SELECT mandant_id,
 vermieter_id,
 dat_von,
 dat_bis,
 kfl_production_dbp_process.transcriptc(vermieter_name) AS vermieter_name,
 intern_fg,
 land_id,
 vermieter_plz,
 kfl_production_dbp_process.transcriptc(vermieter_ort) AS vermieter_ort,
 kfl_production_dbp_process.transcriptc(vermieter_strasse) AS vermieter_strasse,
 vermieter_rechtsform,
 dat_insolvenz_eintritt,
 vermieter_branche_id
FROM kfl_production_dbp_view.v_ivs_vermieter_per_2
WHERE dat_bis = DATE '9999-12-31';