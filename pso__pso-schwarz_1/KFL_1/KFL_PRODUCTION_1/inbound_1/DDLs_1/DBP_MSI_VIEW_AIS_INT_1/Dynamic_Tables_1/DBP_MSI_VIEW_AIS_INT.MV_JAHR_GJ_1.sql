CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_JAHR_GJ_1
(
gj
,akt_gj
,akt_gj_komplett
,akt_gj_help
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.gj, 
   v01.akt_gj, 
   v01.akt_gj_komplett, 
   CASE WHEN EXTRACT (MONTH FROM(CURRENT_DATE))=3 THEN v01.akt_gj+1 ELSE v01.akt_gj END AS akt_gj_help
   FROM dbp_view.v_jahr_gj_1 v01

   WHERE v01.gj > 2001;