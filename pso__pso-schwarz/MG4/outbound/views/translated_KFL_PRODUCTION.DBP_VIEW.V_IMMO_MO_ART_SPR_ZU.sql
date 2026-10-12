CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_mo_art_spr_zu (mandant_id, mo_art_kz, spr_id, mo_art_bez,
td_update, td_insert) AS SELECT mandant_id,
 mo_art_kz,
 spr_id,
 mo_art_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_mo_art_spr_zu;