CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_l_mo_bemessung_art_1 (mandant_id, bemessung_art_id, td_update,
td_insert) AS SELECT mandant_id,
 bemessung_art_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_l_mo_bemessung_art_1;