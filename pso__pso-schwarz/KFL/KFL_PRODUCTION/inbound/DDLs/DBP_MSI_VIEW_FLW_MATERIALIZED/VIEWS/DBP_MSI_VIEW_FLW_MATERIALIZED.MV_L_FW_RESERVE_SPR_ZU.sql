create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FW_RESERVE_SPR_ZU(
	FW_RESERVE_ID,
	MANDANT_ID,
	FW_RESERVE_BEZ
) as
   SELECT
  fw_reserve_id, mandant_id, fw_reserve_bez

   FROM dbp_view.v_fw_reserve_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id IN (1,2);