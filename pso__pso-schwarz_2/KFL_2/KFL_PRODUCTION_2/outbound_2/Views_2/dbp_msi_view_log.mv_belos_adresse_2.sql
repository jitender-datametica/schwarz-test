CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_belos_adresse_2 AS SELECT mandant_id,
 belos_adresse_id,
 land_id,
 adress_name,
 adress_name_zusatz,
 strasse,
 be_entlade_stelle,
 plz,
 ansprechpartner,
 ort,
 spedition_fg,
 belos_standort_typ_id,
 belos_adresse_num_id
FROM kfl_production_dbp_view.v_belos_adresse_2 AS V01;