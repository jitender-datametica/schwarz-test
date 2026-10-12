CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_mzk_grund_spr_zu_1 (geku_mzk_grund_uid, spr_id, geku_mzk_grund_bez,
quelle_spr_id, td_update, td_insert) AS SELECT geku_mzk_grund_uid,
 spr_id,
 geku_mzk_grund_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_mzk_grund_spr_zu_1;