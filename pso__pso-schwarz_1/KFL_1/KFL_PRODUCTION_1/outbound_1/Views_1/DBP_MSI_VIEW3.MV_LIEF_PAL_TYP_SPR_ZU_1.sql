-- #613296 Splitt Palettentyp 6 in 61 und 64 - sschuecke 10.06.2015

-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf STRING

-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_lief_pal_typ_spr_zu_1(USERID STRING) AS -- ,trycast(lief_pal_typ_id AS INTEGER )  AS lief_pal_typ_id

-- WHERE trycast(lief_pal_typ_id AS INTEGER ) IS NOT NULL
 -- ,61 AS lief_pal_typ_id

/* JOIN KFL_PRODUCTION.dbp_msi.akt_msi_user_spr_zu_1 v04
ON v02.spr_id = v04.spr_id */ -- ,64 AS lief_pal_typ_id
 SELECT
 v01.lief_pal_typ_bez,
 v01.lief_pal_typ_id,
 v01.mandant_id,
 v01.spr_id
FROM ((SELECT lief_pal_typ_bez,
     CAST(lief_pal_typ_id AS STRING) AS lief_pal_typ_id,
     mandant_id,
     spr_id
    FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_1
    UNION DISTINCT
    SELECT 'Mix on GP_1 - GP_1 Anteil' AS lief_pal_typ_bez,
     '61' AS lief_pal_typ_id,
     mandant_id,
     spr_id
    FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_1)
   UNION DISTINCT
   SELECT 'Mix on GP_1 - MP Anteil' AS lief_pal_typ_bez,
    '64' AS lief_pal_typ_id,
    mandant_id,
    spr_id
   FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_1) AS v01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON v01.spr_id = V02.spr_id;