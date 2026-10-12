create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_FLAG_SPR_ZU_2(
	FLAG,
	FLAG_BEZ
) as
   SELECT
   v01.flag, v01.flag_bez

   FROM dbp_view.v_flag_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.flag_typ_id = 1  -- Ja/Nein;