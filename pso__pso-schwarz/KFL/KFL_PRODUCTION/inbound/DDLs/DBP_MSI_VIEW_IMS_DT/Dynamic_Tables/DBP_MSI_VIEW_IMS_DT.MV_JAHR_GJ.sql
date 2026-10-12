CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_JAHR_GJ
(
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	GJ_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
--15.04.2013 AL  initial
--24.06.2013 twie: Dummyjahr 1900 und bez hinzu
   SELECT
   gj,
   akt_gj,
   akt_gj_komplett,
   CAST(gj AS VARCHAR(4)) gj_bez

   FROM dbp_view.v_jahr_gj

   UNION

   SELECT
   1900 AS gj,
   -9999 AS akt_gj,
   -9999 AS akt_gj_komplett,
   '' AS  gj_bez
   FROM dbp_view.v_jahr_gj
   WHERE akt_gj = 0
;