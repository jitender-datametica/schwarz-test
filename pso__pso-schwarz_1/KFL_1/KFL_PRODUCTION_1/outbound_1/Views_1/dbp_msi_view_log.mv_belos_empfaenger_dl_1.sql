CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_belos_empfaenger_dl_1 (mandant_id, wup_id,
belos_adresse_empfaenger_id, belos_adresse_empf_num_id, belos_adresse_absender_num_id, land_id, adress_name,
adress_name_zusatz, strasse, be_entlade_stelle, plz, ansprechpartner, ort) AS SELECT mandant_id,
 belos_adresse_num_id AS wup_id,
 belos_adresse_id AS belos_adresse_empfaenger_id,
 belos_adresse_num_id AS belos_adresse_empf_num_id,
 belos_adresse_num_id AS belos_adresse_absender_num_id,
 land_id,
 adress_name,
 adress_name_zusatz,
 strasse,
 be_entlade_stelle,
 plz,
 ansprechpartner,
 ort
FROM kfl_production_dbp_view.v_belos_adresse_1 AS V01
WHERE spedition_fg <> 1;