CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_AKTIV_KZ_2
-- 17.07.2019 ssch1303 Umstellung der Quelltabelle von sternchenlogik auf art_list_wup_zu_per_2
(
mandant_id
, aktiv_kz
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS

   SELECT
   mandant_id,
   aktiv_kz
  FROM

  (SELECT
  v01.mandant_id,
   v01.art_id,
   Coalesce (CASE WHEN Count (v02.wup_id) > 0 THEN 'X' END, '') AS aktiv_kz

  FROM dbp_view.v_art_2 v01
   LEFT OUTER JOIN dbp_view.v_art_list_wup_zu_per_2 v02
   ON   v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND v02.dat_von <= CURRENT_DATE
   AND v02.dat_bis >= CURRENT_DATE

   WHERE v01.mandant_id <> 1

   GROUP BY 1, 2) a

   GROUP BY 1,2;