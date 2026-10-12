CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_stichwort_spr_zu_1 (geku_stichwort_uid, spr_id, geku_stichwort_bez,
quelle_spr_id, td_update, td_insert) AS SELECT geku_stichwort_uid,
 spr_id,
 geku_stichwort_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_stichwort_spr_zu_1;