CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_QUARTAL_GJ_1
(
gjqu
, akt_gjqu
, akt_gjqu_komplett
, gj, akt_gj
, akt_gj_komplett
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj, akt_gj_komplett
   FROM dbp_view.v_quartal_gj_1
   WHERE gjqu > 201004;