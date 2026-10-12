CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_GELISTETE_MO
(
  art_id
, mandant_id
, listung_id
, kjmo
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   v01.art_id,
   v01.mandant_id,
   v01.listung_id,
   v02.kjmo

  FROM
  (
  SELECT
  art_id,
   wup_id,
   dat_von,
   dat_bis,
   mandant_id,
   listung_id
  FROM dbp_view.v_art_wup_zu_per
  WHERE mandant_id <>1
  AND listung_id=1
  AND nb_id = 0
  AND dat_bis = '9999-12-31'
  ) v01
   INNER JOIN dbp_view.v_monat v02
   ON TO_DATE(TO_CHAR(kjmo),'YYYYMM')  BETWEEN v01.dat_von AND v01.dat_bis 

   WHERE v02.akt_mo <= 0
   ;