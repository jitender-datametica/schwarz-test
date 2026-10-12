CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_MAPPING_OWG_ZU_GFK_WG
AS
   SELECT DISTINCT v02.mandant_id, v03.gfk_wg_id, v03.mandant_id AS mandant_id_gfk_wg, v03.gfk_wg_bez, v04.owg_id, v04.mandant_id AS mandant_id_owg, v04.owg_bez, v04.owg_bez_de, v04.owg_bez_cz, v04.owg_bez_sk, v04.owg_bez_hr, v04.owg_bez_pl, v04.owg_bez_ro, v04.owg_bez_bg
   FROM (dbp_view.v_kl_wg_nielsen_gfk_hhp_wg_zu v01
   FULL OUTER JOIN dbp_view.v_gfk_hhp_wg v03
   ON  (v01.mandant_id = v03.mandant_id
   AND v01.gfk_wg_id = v03.gfk_wg_id )
   FULL OUTER JOIN dbp_msi_view_ek_sort.mv_owg_spr_zu v04
   ON  (v01.mandant_id = v04.mandant_id
   AND v01.kl_wg_id = v04.owg_id))
   JOIN dbp_view.v_mandant v02
   ON (v02.mandant_id = COALESCE(v01.mandant_id, v03.mandant_id,
   v04.mandant_id,v02.mandant_id));