CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_QUARTAL_KJ_2
(
kjqu
, akt_kjqu
, akt_kjqu_komplett
, kj
, akt_kj
, akt_kj_komplett
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   kjqu, akt_kjqu, akt_kjqu_komplett, kj, akt_kj, akt_kj_komplett
   FROM dbp_view.v_quartal_kj_2
   WHERE kjqu > 201004;