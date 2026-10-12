CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_WUP_BETRIEB_1
(
   MANDANT_ID,
   WUP_ID,
   NB_ID,
   WUP_STANDORT,
   DAT_VON,
   DAT_BIS,
   DAT_QBM_UMSTELLUNG,
   DAT_EROEFFNUNG,
   WUP_PLZ,
   REGION_ID,
   KREISTYP_GRUPPE_ID,
   VKL_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS

   SELECT v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.wup_standort,
   v01.dat_von,
   v01.dat_bis,
   v01.dat_qbm_umstellung,
   v01.dat_eroeffnung,
   v01.wup_plz,
   v02.region_id,
   v01.kreistyp_gruppe_id,
   v01.vkl_id

  FROM dbp_view.v_wup_1 AS v01
   LEFT JOIN dbp_view.v_vaus_wup_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id

   WHERE (((v01.mandant_id = 2 AND v01.verkaufsorganisation_id = '1000')
   OR (v01.mandant_id = 3 AND v01.verkaufsorganisation_id = '1060')
   OR (v01.mandant_id = 5 AND v01.verkaufsorganisation_id = '1020')
   OR (v01.mandant_id = 6 AND v01.verkaufsorganisation_id = '1030')
   OR (v01.mandant_id = 7 AND v01.verkaufsorganisation_id = '1070')
   OR (v01.mandant_id = 8 AND v01.verkaufsorganisation_id = '1090'))
   AND v01.nb_id = -111)
   OR
   (v01.mandant_id <> 1
   AND (v01.nb_id = 0 OR v01.wup_id=0))

;