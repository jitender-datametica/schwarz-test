CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_ARTKZ_EIGENMARKE
   AS 
   SELECT
   v01.mandant_id,
   v01.eigenmarke_id,
   v01.eigenmarke_bez,
   v01.spr_id
  --, ' ' AS eigenmarke_bez

  FROM
   dbp_view.v_artkz_eigenmarke v01
   WHERE mandant_id <> 1;