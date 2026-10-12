CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_KENNZEICHEN_2(
	KZ_ID,
	KZ_BEZ,
	KZ_KBEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT DISTINCT
   0 AS kz_id, 'NEIN' AS kz_bez, 'N' AS kz_kbez
   FROM dbp_view.v_mandant_2

   UNION ALL

   SELECT DISTINCT
   1 AS kz_id, 'JA' AS kz_bez, 'J' AS kz_kbez
   FROM dbp_view.v_mandant_2
;