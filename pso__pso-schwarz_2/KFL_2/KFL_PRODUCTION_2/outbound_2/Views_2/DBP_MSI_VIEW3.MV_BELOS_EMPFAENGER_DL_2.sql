CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_belos_empfaenger_dl_2 (mandant_id, wup_id,
belos_adresse_empfaenger_id, belos_adresse_empf_num_id, belos_adresse_absender_num_id, land_id, adress_name,
adress_name_zusatz, strasse, be_entlade_stelle, plz, ansprechpartner, ort, nb_id) AS SELECT A.mandant_id,
 A.belos_adresse_num_id AS wup_id,
 A.belos_adresse_id AS belos_adresse_empfaenger_id,
 A.belos_adresse_num_id AS belos_adresse_empf_num_id,
 A.belos_adresse_num_id AS belos_adresse_absender_num_id,
 A.land_id,
 A.adress_name,
 A.adress_name_zusatz,
 A.strasse,
 A.be_entlade_stelle,
 A.plz,
 A.ansprechpartner,
 A.ort,
 COALESCE(B.nb_id, - 1) AS nb_id
FROM kfl_production_dbp_view.v_belos_adresse_2 AS A
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS B ON A.mandant_id = B.mandant_id AND A.belos_adresse_id = CAST(B.wup_id AS STRING)
   
WHERE A.spedition_fg = 0;