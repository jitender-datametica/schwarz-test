CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_art_bewertungskreis_per_2 AS SELECT mandant_id,
 flw_art_id,
 dat_von,
 bewertungskreis_id,
 system_id,
 dat_bis,
 preis_steuer_kz,
 gld,
 standard_preis,
 preis_faktor,
 wrg_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_art_bewertungskreis_per_2;