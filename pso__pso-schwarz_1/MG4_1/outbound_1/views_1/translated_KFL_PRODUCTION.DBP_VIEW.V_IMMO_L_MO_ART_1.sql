CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_l_mo_art_1 (mandant_id, mo_art_kz, td_update, td_insert) AS SELECT
 mandant_id,
 mo_art_kz,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_l_mo_art_1;