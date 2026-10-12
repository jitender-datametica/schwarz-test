CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_PRUEFKATALO_CODE_SPR_QUAL
-- 26.10.2011 system_id entfernt
AS 
SELECT
   --  v01.system_id
   v01.mandant_id, v01.katalogart_id, v01.codegruppe_id, v01.pruefcode_id, v01.version_id, v01.spr_id, v01.pruefkatalog_code_bez

   FROM DBP_MSI_VIEW_FLW.TBL_MV_L_PRUEFKATALO_CODE_SPR_QUAL  v01
   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
   ;