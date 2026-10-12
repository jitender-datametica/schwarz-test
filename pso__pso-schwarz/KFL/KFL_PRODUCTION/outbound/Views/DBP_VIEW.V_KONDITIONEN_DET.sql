CREATE OR REPLACE VIEW kfl_production_dbp_view.v_konditionen_det AS SELECT mandant_id,
 konditionsart_id,
 gp_id,
 art_id,
 einkaufsorganisation_id,
 dat_bis,
 dat_von,
 kondition_betrag,
 kondition_einh_id,
 kondition_preis_einh_id,
 kondition_menge_einh_id,
 loesch_kz,
 konditionssatz_id
FROM kfl_production_dbp_data.konditionen_det;