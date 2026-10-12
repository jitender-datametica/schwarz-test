CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_belos_absender_bl_1 (mandant_id, belos_adresse_absender_id,
belos_adresse_absender_num_id, land_id, adress_name, adress_name_zusatz, strasse, be_entlade_stelle, plz,
ansprechpartner, ort) AS SELECT mandant_id,
 belos_adresse_id AS belos_adresse_absender_id,
 belos_adresse_num_id AS belos_adresse_absender_num_id,
 land_id,
 adress_name,
 adress_name_zusatz,
 strasse,
 be_entlade_stelle,
 plz,
 ansprechpartner,
 ort
FROM kfl_production_dbp_view.v_belos_adresse_1
WHERE spedition_fg = 0;