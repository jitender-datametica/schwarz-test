CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sort_mapping_owg_zu_gfk_wg_1 (mandant_id, gfk_wg_id,
mandant_id_gfk_wg, gfk_wg_bez, owg_id, mandant_id_owg, owg_bez, owg_bez_de, owg_bez_cz, owg_bez_sk, owg_bez_hr,
owg_bez_pl, owg_bez_ro, owg_bez_bg) AS SELECT DISTINCT V02.mandant_id,
 V03.gfk_wg_id,
 V03.mandant_id AS mandant_id_gfk_wg,
 V03.gfk_wg_bez,
 V04.owg_id,
 V04.mandant_id AS mandant_id_owg,
 V04.owg_bez,
 V04.owg_bez_de,
 V04.owg_bez_cz,
 V04.owg_bez_sk,
 V04.owg_bez_hr,
 V04.owg_bez_pl,
 V04.owg_bez_ro,
 V04.owg_bez_bg
FROM kfl_production_dbp_data.kl_wg_nielsen_gfk_hhp_wg_zu_1 AS V01
 FULL JOIN kfl_production_dbp_data.gfk_hhp_wg_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.gfk_wg_id = V03.gfk_wg_id
   
 FULL JOIN kfl_production_dbp_msi_view_ais_int.mv_owg_spr_zu_1 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.kl_wg_id
   = V04.owg_id
 INNER JOIN kfl_production_dbp_data.mandant_1 AS V02 ON V02.mandant_id = COALESCE(V01.mandant_id, V03.mandant_id, V04.mandant_id
   , V02.mandant_id);