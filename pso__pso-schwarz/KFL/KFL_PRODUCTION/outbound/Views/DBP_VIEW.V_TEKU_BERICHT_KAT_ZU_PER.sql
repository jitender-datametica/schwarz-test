CREATE OR REPLACE VIEW kfl_production_dbp_view.v_teku_bericht_kat_zu_per AS SELECT teku_bericht_id,
 teku_kategorie_id,
 dat_von,
 dat_bis,
 teku_kategorie_note
FROM kfl_production_dbp_data.teku_bericht_kat_zu_per;