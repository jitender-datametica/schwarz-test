CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_mapping_owg_zu_gfk_wg_2 AS SELECT DISTINCT V02.mandant_id,
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
FROM kfl_production_dbp_view.v_kl_wg_nielsen_gfk_hhp_wg_zu_2 AS V01
 FULL JOIN kfl_production_dbp_view.v_gfk_hhp_wg_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.gfk_wg_id = V03.gfk_wg_id
   
 FULL JOIN kfl_production_dbp_msi_view_ek_sort.mv_owg_spr_zu_2 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.kl_wg_id
   = V04.owg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V02 ON V02.mandant_id = COALESCE(V01.mandant_id, V03.mandant_id, V04.mandant_id
   , V02.mandant_id);