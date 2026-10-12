CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_KALK_VARIANTE_SPR_ZU_2
   AS 
   SELECT
    v01.mandant_id, v01.kalk_variante_id, v01.spr_id, v01.kalk_variante_bez, v01.mandant_kbez

   FROM DBP_MSI_VIEW_FLW.TBL_MV_FLW_KALK_VARIANTE_SPR_ZU_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id
;