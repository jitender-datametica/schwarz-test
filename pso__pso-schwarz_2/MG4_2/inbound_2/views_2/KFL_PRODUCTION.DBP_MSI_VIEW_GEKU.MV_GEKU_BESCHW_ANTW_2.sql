create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_BESCHW_ANTW_2(
	BESCHWERDE_ANTWORT_ID,
	GEKU_MASSNAHME_UID,
	BERECHTIGT_FG,
	AVG_FG
) as
   SELECT
   beschwerde_antwort_id
   , geku_massnahme_uid
   , berechtigt_fg
   , avg_fg
   FROM dbp_view.v_geku_beschw_antw_2;