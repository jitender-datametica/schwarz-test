CREATE OR REPLACE VIEW kfl_production_dbp_view.v_umbewertung_det AS SELECT mandant_id,
 pae_beleg_id,
 kj,
 pae_beleg_pos_id,
 art_id,
 bewertungskreis_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.umbewertung_det;