CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_mo_bemessung_art_spr_zu AS SELECT mandant_id,
 bemessung_art_id,
 spr_id,
 bemessung_art_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_mo_bemessung_art_spr_zu;