CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_konzessionaer_hist_1 (mandant_id, konzessionaer_id, dat_von,
dat_bis, konzessionaer_branche_id, konzessionaer_rechtsform, konzessionaer_name, konzessionaer_strasse,
konzessionaer_plz, konzessionaer_ort, dat_insolvenz_eintritt, intern_fg, land_id, konzessionaer_topmieter_fg,
konzessionaer_holding_id) AS SELECT mandant_id,
 konzessionaer_id,
 dat_von,
 dat_bis,
 konzessionaer_branche_id,
 konzessionaer_rechtsform,
 kfl_production_dbp_process.transcriptc(konzessionaer_name) AS konzessionaer_name,
 kfl_production_dbp_process.transcriptc(konzessionaer_strasse) AS konzessionaer_strasse,
 konzessionaer_plz,
 kfl_production_dbp_process.transcriptc(konzessionaer_ort) AS konzessionaer_ort,
 dat_insolvenz_eintritt,
 intern_fg,
 land_id,
 konzessionaer_topmieter_fg,
 CAST(konzessionaer_holding_id AS STRING) AS konzessionaer_holding_id
FROM kfl_production_dbp_view.v_ivs_konzessionaer_per_1
WHERE (mandant_id, konzessionaer_id, dat_von) IN (SELECT (mandant_id, konzessionaer_id, MAX(dat_von))
   FROM kfl_production_dbp_view.v_ivs_konzessionaer_per_1
   GROUP BY mandant_id,
    konzessionaer_id);