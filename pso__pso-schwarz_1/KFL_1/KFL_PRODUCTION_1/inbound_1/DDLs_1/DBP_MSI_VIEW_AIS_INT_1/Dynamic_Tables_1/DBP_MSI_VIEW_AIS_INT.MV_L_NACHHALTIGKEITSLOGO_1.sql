CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_L_NACHHALTIGKEITSLOGO_1
(
nachhaltigkeitslogo_id
,nachhaltigkeitslogo_bez
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
  nachhaltigkeitslogo_id, nachhaltigkeitslogo_bez
   FROM dbp_view.v_l_nachhaltigkeitslogo_1 v01
   UNION
   SELECT
   nachhaltigkeitslogo_id, nachhaltigkeitslogo_bez
   FROM (SELECT -999 AS nachhaltigkeitslogo_id, 'kein Logo_1' AS nachhaltigkeitslogo_bez) v02;