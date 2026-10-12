create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_CODEGRUPPE_SPR_LOS_1(
	MANDANT_ID,
	KATALOGART_ID,
	CODEGRUPPE_ID,
	SPR_ID,
	CODEGRUPPE_BEZ
) as 
   SELECT
   --  v01.system_id
   v01.mandant_id, v01.katalogart_id, v01.codegruppe_id, v01.spr_id, v01.codegruppe_bez

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.tbl_MV_L_FLW_CODEGRUPPE_SPR_LOS_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;