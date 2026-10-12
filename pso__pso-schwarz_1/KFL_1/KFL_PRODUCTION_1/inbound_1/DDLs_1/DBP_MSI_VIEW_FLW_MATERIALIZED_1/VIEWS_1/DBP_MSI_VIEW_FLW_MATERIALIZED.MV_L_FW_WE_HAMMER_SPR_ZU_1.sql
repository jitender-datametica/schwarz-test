create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FW_WE_HAMMER_SPR_ZU_1(
	FW_WE_HAMMER_ID,
	MANDANT_ID,
	FW_WE_HAMMER_BEZ
) as
   SELECT
  fw_we_hammer_id, mandant_id, fw_we_hammer_bez

   FROM dbp_view.v_fw_we_hammer_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id IN (1,2);