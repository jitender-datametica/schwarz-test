CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_WG_WUP_PM_ZU_PER_1
(
wup_id
, nb_id
, arthiertyp_id
, wg_id
, pm_id
, dat_von
, dat_bis
, mandant_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
  wup_id,
   nb_id,
   arthiertyp_id,
   wg_id,
   pm_id,
   dat_von,
   dat_bis,
   mandant_id
  FROM dbp_view.v_pm_wup_wg_zu_per_1
  WHERE mandant_id <> 1
  AND arthiertyp_id = 2
  AND dat_bis = '9999-12-31';