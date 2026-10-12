CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_ART_SPR_ZU 
AS 
SELECT
   v01.mandant_id,
   v01.art_id,
   v02.kl_art_id,
   v01.art_bez,
v01.spr_id
  FROM dbp_view.v_art_spr_zu v01

   JOIN dbp_view.v_art v02
   ON (v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id)
   WHERE v01.mandant_id <> 1;