CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_JAHR_KJ_2
(
kj
,akt_kj
,akt_kj_komplett
)  TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.kj, v01.akt_kj, v01.akt_kj_komplett
   FROM dbp_view.v_jahr_kj_2 v01

   WHERE v01.kj > 2001;