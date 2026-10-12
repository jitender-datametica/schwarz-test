CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_ofentyp_zu AS SELECT art_id,
 mandant_id,
 ofen_typ_id,
 blech_belegung
FROM kfl_production_dbp_data.art_ofentyp_zu;