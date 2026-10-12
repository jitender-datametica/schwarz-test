CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_EINH_SPR_ZU
   AS 
   SELECT 
   v01.einh_id,
   v01.mandant_id,
   v01.spr_id,
   v01.einh_bez_kaufm,
   v01.einh_bez

   FROM dbp_view.v_einh_spr_zu v01
   WHERE mandant_id <>1;