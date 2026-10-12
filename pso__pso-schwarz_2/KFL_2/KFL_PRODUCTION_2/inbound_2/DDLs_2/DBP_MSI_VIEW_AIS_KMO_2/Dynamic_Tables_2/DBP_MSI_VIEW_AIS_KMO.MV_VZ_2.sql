CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_VZ_2
(
mandant_id
, vz_id
, nb_id
, vz_bez
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS

   SELECT v01.mandant_id,
   v01.wup_id AS vz_id,
   v01.nb_id,
   v01.wup_standort AS vz_bez

  FROM dbp_view.v_wup_2 AS v01

   WHERE ((v01.mandant_id = 2 AND v01.verkaufsorganisation_id = '1000')
   OR (v01.mandant_id = 3 AND v01.verkaufsorganisation_id = '1060')
   OR (v01.mandant_id = 5 AND v01.verkaufsorganisation_id = '1020')
   OR (v01.mandant_id = 6 AND v01.verkaufsorganisation_id = '1030')
   OR (v01.mandant_id = 4 AND v01.verkaufsorganisation_id = '1040')
   OR (v01.mandant_id = 7 AND v01.verkaufsorganisation_id = '1070')
   OR (v01.mandant_id = 8 AND v01.verkaufsorganisation_id = '1090'))
   AND v01.nb_id = -111;