CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_MV_ANLASS_ZWVERMIETUNG(
	ANLASS_ZWVERMIETUNG_ID,
	ANLASS_ZWVERMIETUNG_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v0.anlass_zwvermietung_id, v0.anlass_zwvermietung_bez
   FROM dbp_view.v_immo_l_mv_anlass_zwvermietung v0
   WHERE mandant_id = 1;