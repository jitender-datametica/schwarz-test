create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_PROFIT_CENTER_SPR_ZU(
	MANDANT_ID,
	PC_ID,
	SPR_ID,
	KRK_ID,
	PC_BEZ
) as
   SELECT
   v01.mandant_id, v01.pc_id, v01.spr_id, v01.krk_id, v01.pc_bez

   FROM dbp_view.v_profit_center_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;