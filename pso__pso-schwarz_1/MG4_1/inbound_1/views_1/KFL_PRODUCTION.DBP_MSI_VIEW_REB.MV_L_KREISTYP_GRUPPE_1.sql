create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_L_KREISTYP_GRUPPE_1(
	MANDANT_ID,
	KREISTYP_GRUPPE_ID
) as
   SELECT
   mandant_id, kreistyp_gruppe_id
   FROM dbp_view.v_l_kreistyp_gruppe_1;