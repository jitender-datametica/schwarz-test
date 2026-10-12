create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_WTAG_SPR_ZU(
	WTAG_ID,
	WTAG_BEZ
) as
   SELECT
   v01.wtag_id, v01.wtag_bez

   FROM dbp_view.v_wtag_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;