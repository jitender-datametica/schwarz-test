create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_KL_ART_2(
	KL_ART_ID,
	MANDANT_ID,
	ART_ID
) as
   SELECT
     CASE WHEN kl_art_id = 0 THEN art_id ELSE kl_art_id END AS kl_art_id
   , mandant_id
   , art_id
   FROM dbp_view.v_art_2
   WHERE dat_bis = '9999-12-31'
;