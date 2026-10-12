create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_GF(
	MANDANT_ID,
	GF_ID,
	EK_FG,
	GF_NAME
) as
   SELECT
   mandant_id, gf_id, ek_fg, gf_name

   

   FROM
   dbp_view.v_gf
   WHERE ek_fg = 1;