create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_GF_1(
	MANDANT_ID,
	GF_ID,
	EK_FG,
	GF_NAME
) as
   SELECT
   mandant_id, gf_id, ek_fg, gf_name

   

   FROM
   dbp_view.v_gf_1
   WHERE ek_fg = 1;