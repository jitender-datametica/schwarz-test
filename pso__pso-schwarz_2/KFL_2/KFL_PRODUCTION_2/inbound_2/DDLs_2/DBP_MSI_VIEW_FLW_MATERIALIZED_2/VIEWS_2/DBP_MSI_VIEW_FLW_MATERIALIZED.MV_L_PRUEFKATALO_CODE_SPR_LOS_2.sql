create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_PRUEFKATALO_CODE_SPR_LOS_2(
	MANDANT_ID,
	KATALOGART_ID,
	CODEGRUPPE_ID,
	PRUEFCODE_ID,
	VERSION_ID,
	SPR_ID,
	PRUEFKATALOG_CODE_BEZ
) as
   SELECT
   --  v01.system_id
   v01.mandant_id, v01.katalogart_id, v01.codegruppe_id, v01.pruefcode_id, v01.version_id, v01.spr_id, v01.pruefkatalog_code_bez

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_L_PRUEFKATALO_CODE_SPR_LOS_2  v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;