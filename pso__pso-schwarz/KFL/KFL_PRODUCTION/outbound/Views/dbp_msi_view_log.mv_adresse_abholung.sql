CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_adresse_abholung (mandant_id, belos_adresse_abholung_id,
land_id, adress_name, adress_name_zusatz, strasse, be_entlade_stelle, plz, ansprechpartner, ort) AS SELECT mandant_id,
 belos_adresse_id AS belos_adresse_abholung_id,
 land_id,
 adress_name,
 adress_name_zusatz,
 strasse,
 be_entlade_stelle,
 CAST(plz AS STRING) AS plz,
 ansprechpartner,
 ort
FROM kfl_production_dbp_view.v_belos_adresse
WHERE spedition_fg = 0;