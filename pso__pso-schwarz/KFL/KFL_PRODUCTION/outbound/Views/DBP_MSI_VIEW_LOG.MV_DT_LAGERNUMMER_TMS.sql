CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_log.mv_dt_lagernummer_tms (
MANDANT_ID BIGNUMERIC(38,0),
EWM_FG INTEGER,
TMS_GP_ID STRING(30),
TMS_GP_ID_ANZEIGE STRING(16777216),
TMS_GP_TYP_CD STRING(3),
TMS_GP_LFD_NR BIGNUMERIC(38,0),
TMS_GP_NAME STRING(50),
TMS_GP_ALTNV_NAME STRING(50),
TMS_GP_STRASSE STRING(50),
TMS_GP_ORT_NAME STRING(50),
TMS_GP_PLZ STRING(20),
TMS_LAND_CD STRING(5),
SPERR_FG BIGNUMERIC(38,0),
SAMMELBELEG_ID BIGNUMERIC(38,0),
TMS_STANDORTTYP_ID BIGNUMERIC(38,0),
DAT_WANKO_VON DATE,
LAGERNUMMER_BEZ STRING(160),
LAGERNUMMER_BEZ_DE STRING(160),
LAGERNUMMER_BEZ_CZ STRING(160),
LAGERNUMMER_BEZ_SK STRING(160),
LAGERNUMMER_BEZ_HR STRING(160),
LAGERNUMMER_BEZ_PL STRING(160),
LAGERNUMMER_BEZ_RO STRING(160),
LAGERNUMMER_BEZ_BG STRING(160)
) AS
(SELECT V01.mandant_id,
  1 AS ewm_fg,
  V01.tms_gp_id,
  V03.lagernummer_id AS tms_gp_id_anzeige,
  V01.tms_gp_typ_cd,
  V01.tms_gp_lfd_nr,
  V01.tms_gp_name,
  V01.tms_gp_altnv_name,
  V01.tms_gp_strasse,
  V01.tms_gp_ort_name,
  V01.tms_gp_plz,
  V01.tms_land_cd,
  V01.sperr_fg,
  V01.sammelbeleg_id,
  V01.tms_standorttyp_id,
  v000.dat_wanko_von,
  MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.lagernummer_bez
    ELSE NULL
    END) AS lagernummer_bez,
  MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.lagernummer_bez
    ELSE NULL
    END) AS lagernummer_bez_de,
  COALESCE(MAX(CASE
     WHEN V04.spr_id = 124
     THEN V04.lagernummer_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.lagernummer_bez
     ELSE NULL
     END)) AS lagernummer_bez_cz,
  COALESCE(MAX(CASE
     WHEN V04.spr_id = 108
     THEN V04.lagernummer_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.lagernummer_bez
     ELSE NULL
     END)) AS lagernummer_bez_sk,
  COALESCE(MAX(CASE
     WHEN V04.spr_id = 65
     THEN V04.lagernummer_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.lagernummer_bez
     ELSE NULL
     END)) AS lagernummer_bez_hr,
  COALESCE(MAX(CASE
     WHEN V04.spr_id = 90
     THEN V04.lagernummer_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.lagernummer_bez
     ELSE NULL
     END)) AS lagernummer_bez_pl,
  COALESCE(MAX(CASE
     WHEN V04.spr_id = 95
     THEN V04.lagernummer_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.lagernummer_bez
     ELSE NULL
     END)) AS lagernummer_bez_ro,
  COALESCE(MAX(CASE
     WHEN V04.spr_id = 18
     THEN V04.lagernummer_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.lagernummer_bez
     ELSE NULL
     END)) AS lagernummer_bez_bg
 FROM kfl_production_dbp_view.v_tms_gp AS V01
  INNER JOIN kfl_production_dbp_view.v_l_system AS SYS ON V01.system_id = SYS.system_id AND LEFT(SYS.system_bez, 4) =
     'KTMS' AND LEFT(SYS.kl_system_bez, 3) <> 'FLW'
  INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.mandant_id = V02.mandant_id AND ROUND(SAFE_CAST(V01.tms_gp_id
       AS BIGNUMERIC), 0) = V02.wup_id AND V02.nb_id = - 111
  INNER JOIN kfl_production_dbp_view.v_l_lagernummer AS V03 ON V02.mandant_id = V03.mandant_id AND V02.wup_id = V03.wup_id
      AND V03.ewm_fg = 1
  INNER JOIN kfl_production_dbp_view.v_lagernummer_spr_zu AS V04 ON V03.mandant_id = V04.mandant_id AND V03.lagernummer_id
     = V04.lagernummer_id
  INNER JOIN (SELECT mandant_id,
    wup_id,
    MIN(COALESCE(dat_tms_wanko, DATE '9999-12-31')) AS dat_wanko_von
   FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm AS V00
   GROUP BY mandant_id,
    wup_id) AS v000 ON V02.mandant_id = v000.mandant_id AND V02.wup_id = v000.wup_id
 WHERE V01.tms_gp_typ_cd = 'L'
 GROUP BY V01.mandant_id,
  V01.tms_gp_id,
  tms_gp_id_anzeige,
  V01.tms_gp_typ_cd,
  V01.tms_gp_lfd_nr,
  V01.tms_gp_name,
  V01.tms_gp_altnv_name,
  V01.tms_gp_strasse,
  V01.tms_gp_ort_name,
  V01.tms_gp_plz,
  V01.tms_land_cd,
  V01.sperr_fg,
  V01.sammelbeleg_id,
  V01.tms_standorttyp_id,
  v000.dat_wanko_von
 UNION DISTINCT
 SELECT DISTINCT V01.mandant_id,
  0 AS ewm_fg,
  V01.tms_gp_id,
  CAST(V02.wup_id AS STRING) AS tms_gp_id_anzeige,
  V01.tms_gp_typ_cd,
  V01.tms_gp_lfd_nr,
  V01.tms_gp_name,
  V01.tms_gp_altnv_name,
  V01.tms_gp_strasse,
  V01.tms_gp_ort_name,
  V01.tms_gp_plz,
  V01.tms_land_cd,
  V01.sperr_fg,
  V01.sammelbeleg_id,
  V01.tms_standorttyp_id,
  v03.dat_wanko_von,
  V02.wup_standort AS lagernummer_bez,
  V02.wup_standort AS lagernummer_bez_de,
  V02.wup_standort AS lagernummer_bez_cz,
  V02.wup_standort AS lagernummer_bez_sk,
  V02.wup_standort AS lagernummer_bez_hr,
  V02.wup_standort AS lagernummer_bez_pl,
  V02.wup_standort AS lagernummer_bez_ro,
  V02.wup_standort AS lagernummer_bez_bg
 FROM kfl_production_dbp_view.v_tms_gp AS V01
  INNER JOIN kfl_production_dbp_view.v_l_system AS SYS ON V01.system_id = SYS.system_id AND LEFT(SYS.system_bez, 4) =
     'KTMS' AND LEFT(SYS.kl_system_bez, 3) <> 'FLW'
  INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.mandant_id = V02.mandant_id AND ROUND(SAFE_CAST(V01.tms_gp_id
       AS BIGNUMERIC), 0) = V02.wup_id AND V02.nb_id = - 111
  INNER JOIN (SELECT mandant_id,
    wup_id,
    MIN(COALESCE(dat_tms_wanko, DATE '9999-12-31')) AS dat_wanko_von
   FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm
   GROUP BY mandant_id,
    wup_id) AS v03 ON V02.mandant_id = v03.mandant_id AND V02.wup_id = v03.wup_id
  INNER JOIN (SELECT mandant_id,
    wup_id,
    MIN(COALESCE(dat, DATE '9999-12-31')) AS dat_ewm_von
   FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat
   GROUP BY mandant_id,
    wup_id) AS v04 ON V02.mandant_id = v04.mandant_id AND V02.wup_id = v04.wup_id
 WHERE V01.tms_gp_typ_cd = 'L'
  AND v03.dat_wanko_von <= v04.dat_ewm_von)
UNION DISTINCT
SELECT V01.mandant_id,
 2 AS ewm_fg,
 V01.tms_gp_id,
 V01.tms_gp_id AS tms_gp_id_anzeige,
 V01.tms_gp_typ_cd,
 V01.tms_gp_lfd_nr,
 V01.tms_gp_name,
 V01.tms_gp_altnv_name,
 V01.tms_gp_strasse,
 V01.tms_gp_ort_name,
 V01.tms_gp_plz,
 V01.tms_land_cd,
 V01.sperr_fg,
 V01.sammelbeleg_id,
 V01.tms_standorttyp_id,
  CASE
  WHEN V01.tms_gp_id = '6922'
  THEN DATE '2025-02-17'
  WHEN V01.tms_gp_id = '6921'
  THEN DATE '2025-03-10'
  ELSE DATE '1900-01-01'
  END AS dat_wanko_von,
 V01.tms_gp_name AS lagernummer_bez,
 V01.tms_gp_name AS lagernummer_bez_de,
 V01.tms_gp_name AS lagernummer_bez_cz,
 V01.tms_gp_name AS lagernummer_bez_sk,
 V01.tms_gp_name AS lagernummer_bez_hr,
 V01.tms_gp_name AS lagernummer_bez_pl,
 V01.tms_gp_name AS lagernummer_bez_ro,
 V01.tms_gp_name AS lagernummer_bez_bg
FROM kfl_production_dbp_view.v_tms_gp AS V01
 INNER JOIN kfl_production_dbp_view.v_l_system AS SYS ON V01.system_id = SYS.system_id AND LEFT(SYS.system_bez, 4) =
    'KTMS' AND LEFT(SYS.kl_system_bez, 3) = 'FLW'
WHERE V01.tms_gp_id IN ('6921', '6922')
 AND V01.tms_gp_typ_cd = 'L';