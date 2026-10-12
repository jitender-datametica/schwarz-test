create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_IN_ART_SPR_ZU(
	MANDANT_ID,
	IN_ART_ID,
	SPR_ID,
	ART_BEZ
) as
   SELECT v01.mandant_id
   , v01.in_art_id
   , v01.spr_id
   , v01.art_bez
   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.tbl_MV_L_IN_ART_SPR_ZU v01
   JOIN dbp_msi.akt_msi_user_spr_zu v03
   ON v01.spr_id = v03.spr_id;