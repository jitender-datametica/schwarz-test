CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_LIST_WUP_ZU_MIN_1
(
  mandant_id
, art_id
, wup_id
, nb_id
, dat_listung
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS

   SELECT v01.mandant_id,
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   MIN(v01.dat_von) dat_listung

  FROM dbp_view.v_art_list_wup_zu_per_1 v01

   WHERE v01.mandant_id <> 1
   AND v01.nb_id = 0
   AND v01.dat_bis = '9999-12-31'

   GROUP BY 1, 2, 3, 4;