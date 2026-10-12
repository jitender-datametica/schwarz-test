create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FW_WK_SYSTEM_SPR_ZU_1(
	FW_WK_SYSTEM_ID,
	MANDANT_ID,
	FW_WK_SYSTEM_BEZ
) as
   SELECT
  fw_wk_system_id, mandant_id, fw_wk_system_bez

   FROM dbp_view.v_fw_wk_system_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id IN (1,2);