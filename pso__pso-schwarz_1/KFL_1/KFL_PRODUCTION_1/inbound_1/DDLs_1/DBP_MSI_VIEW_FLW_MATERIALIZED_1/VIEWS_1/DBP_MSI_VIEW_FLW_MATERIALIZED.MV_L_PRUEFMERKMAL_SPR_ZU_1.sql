create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_PRUEFMERKMAL_SPR_ZU_1(
	MANDANT_ID,
	WERK_ID,
	STP_MERKMAL_ID,
	SPR_ID,
	MERKMAL_BEZ
) as
   SELECT
   v01.mandant_id, v01.werk_id, v01.stp_merkmal_id, v01.spr_id, v01.merkmal_bez

   FROM dbp_view.v_flw_pruefmerkmal_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;