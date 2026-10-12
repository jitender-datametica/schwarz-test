CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ART_AKTIV_KZ_ZU_1
-- 10.07.2019 sgro2903 Umstellung der Quelltabelle von sternchenlogik auf art_list_wup_zu_per_1
(
  mandant_id
, art_id
, aktiv_kz
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS

   SELECT
   v01.mandant_id, v01.art_id, Coalesce(CASE WHEN Count(v02.wup_id) > 0 THEN 'X' END, '') AS aktiv_kz

   FROM dbp_view.v_art_1 v01
   LEFT OUTER JOIN dbp_view.v_art_list_wup_zu_per_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND v02.dat_von <= CURRENT_DATE
   AND v02.dat_bis >= CURRENT_DATE

   GROUP BY 1, 2;