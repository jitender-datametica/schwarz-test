create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_ABSCHLUSSGRUND_1(
	ABSCHLUSSGRUND_ID
) as
   SELECT
   abschlussgrund_id
   FROM dbp_view.v_l_geku_abschlussgrund_1;