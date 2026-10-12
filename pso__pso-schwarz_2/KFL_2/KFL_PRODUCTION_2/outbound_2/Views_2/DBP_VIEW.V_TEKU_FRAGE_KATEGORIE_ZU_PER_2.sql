CREATE OR REPLACE VIEW kfl_production_dbp_view.v_teku_frage_kategorie_zu_per_2 AS SELECT teku_frage_kat_zu_id,
 dat_von,
 teku_kategorie_id,
 teku_frage_id,
 teku_frage_pos_id,
 teku_frage_gewicht,
 dat_bis
FROM kfl_production_dbp_data.teku_frage_kategorie_zu_per_2;