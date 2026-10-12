CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_GF(
	GF_ID,
	MANDANT_ID,
	EK_FG,
	GF_NAME
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT

   gf_id, mandant_id, ek_fg, gf_name

   FROM dbp_view.v_gf
;