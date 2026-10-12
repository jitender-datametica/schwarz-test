CREATE OR REPLACE VIEW kfl_production_dbp_view.v_umbewertung_periode_2 AS SELECT mandant_id,
 pae_beleg_id,
 kj,
 pae_beleg_pos_id,
 gjmo,
 periodenart_id,
 dat_buch,
 menge_bestand_bme_alt,
 td_update,
 td_insert
FROM kfl_production_dbp_data.umbewertung_periode_2;