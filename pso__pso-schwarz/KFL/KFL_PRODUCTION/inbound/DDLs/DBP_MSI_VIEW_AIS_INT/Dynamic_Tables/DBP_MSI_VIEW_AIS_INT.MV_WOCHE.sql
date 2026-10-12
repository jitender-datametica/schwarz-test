CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_WOCHE (
      kjwo,
      gjwo,
      gjwo_vj,
      kjwo_vj,
      kjwo_vvj,
      kjwo_dat_von,
      kjwo_dat_bis,
      akt_kjwo_kl,
      akt_kjwo_kl_komplett,
      akt_kjwo_kalendarisch,
      akt_wo,
      kj,
      gj,
      akt_kj,
      akt_kj_komplett,
      akt_gj,
      akt_gj_komplett
   ) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
   AS
SELECT v01.kjwo,
   v01.gjwo,
   v01.gjwo_vj,
   v01.kjwo_vj,
   v01.kjwo_vvj,
   v01.wo_dat_von,
   v01.wo_dat_bis,
   v02.akt_kjwo_kl,
   v02.akt_kjwo_kl_komplett,
   v01.akt_wo_kalendarisch AS akt_kjwo_kalendarisch,
   v01.akt_wo,
   CAST (SUBSTR(TRIM(v01.kjwo), 0, 4) AS SMALLINT) AS kj,
   CAST (SUBSTR(TRIM(v01.gjwo), 0, 4) AS SMALLINT) AS gj,
   v02.akt_kj,
   v02.akt_kj_komplett,
   v03.akt_gj,
   v03.akt_gj_komplett
FROM dbp_view.v_woche v01
   JOIN dbp_view.v_woche_kj_kl v02 ON v01.kjwo = v02.kjwo_kl
   JOIN dbp_view.v_woche_gj_kl v03 ON v01.gjwo = v03.gjwo_kl
WHERE v01.kjwo > 200152;