CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_mietobjekt_messung_2 AS SELECT mandant_id,
 mo_intreno,
 bemessung_art_id,
 dat_bis,
 dat_von,
 groesse,
 groesse_einheit,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_mietobjekt_messung_2;