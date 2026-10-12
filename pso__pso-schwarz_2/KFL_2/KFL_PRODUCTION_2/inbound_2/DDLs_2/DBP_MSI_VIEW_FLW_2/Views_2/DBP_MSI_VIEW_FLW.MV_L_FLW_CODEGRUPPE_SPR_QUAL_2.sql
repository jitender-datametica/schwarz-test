CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_CODEGRUPPE_SPR_QUAL_2
   as 
   SELECT
   --  v01.system_id
   v01.mandant_id, v01.katalogart_id, v01.codegruppe_id, v01.spr_id, v01.codegruppe_bez

   FROM DBP_MSI_VIEW_FLW.tbl_MV_L_FLW_CODEGRUPPE_SPR_QUAL_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;