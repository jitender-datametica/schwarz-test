CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_WG_SPR_ZU_1 
   AS 
   SELECT
   v01.mandant_id,
   v01.wg_id,
   v01.arthiertyp_id,
   v01.wg_bez,
   v01.spr_id
  FROM dbp_view.v_wg_spr_zu_1 v01
   WHERE v01.mandant_id <> 1
   AND v01.arthiertyp_id = 2;