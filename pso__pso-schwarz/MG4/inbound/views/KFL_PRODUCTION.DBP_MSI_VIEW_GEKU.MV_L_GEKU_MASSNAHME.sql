create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_MASSNAHME(
	GEKU_MASSNAHME_UID,
	GEKU_MASSNAHME_ID
) as
   SELECT
   geku_massnahme_uid
   , geku_massnahme_id
   FROM dbp_view.v_l_geku_massnahme;