CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_BRANCHE_2(
	BRANCHE_ID,
	BRANCHE_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v0.branche_id AS branche_id, v0.branche_bez AS branche_bez
   FROM dbp_view.v_immo_l_branche_2 v0
   WHERE mandant_id = 1

   UNION

   SELECT
   0 AS branche_id, '' AS branche_bez
   FROM dbp_view.v_mandant_2;