create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_MITARBEITER_STATUS_SPR_ZU_2(
	MANDANT_ID,
	MA_STATUS_ID,
	MA_STATUS_BEZ
) as
   SELECT
   v01.mandant_id, v01.ma_status_id, v01.ma_status_bez

   FROM DBP_MSI_VIEW_SHR_MATERIALIZED.TBL_MV_MITARBEITER_STATUS_SPR_ZU_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;