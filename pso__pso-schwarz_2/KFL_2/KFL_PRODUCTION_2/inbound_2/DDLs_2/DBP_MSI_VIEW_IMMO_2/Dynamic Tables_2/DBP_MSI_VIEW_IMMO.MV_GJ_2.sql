CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_GJ_2(
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	DAT_GJ_BEGINN,
	DAT_GJ_ENDE
) TARGET_LAG = '1 hour' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT  gj
         , akt_gj
         , akt_gj_komplett
         , CAST(CAST(gj AS CHAR(4)) || '03' AS VARCHAR)  dat_gj_beginn
         , ADD_MONTHS(TO_DATE(dat_gj_beginn,'YYYYMM'), 12) -1  dat_gj_ende

         
   FROM dbp_view.v_jahr_gj_2
   WHERE akt_gj BETWEEN -5 AND 1;