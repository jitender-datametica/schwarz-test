CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_WG_ZU_PER_1
(
  mandant_id
, art_id
, wg_id
, wug_id
, arthiertyp_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS

   SELECT mandant_id,
   v01.art_id,
   v01.wg_id,
   v01.wug_id,
   v01.arthiertyp_id

  FROM dbp_view.v_art_wg_zu_per_1 v01

   WHERE v01.mandant_id <> 1
   AND v01.arthiertyp_id = 2
   AND v01.dat_bis= '9999-12-31';