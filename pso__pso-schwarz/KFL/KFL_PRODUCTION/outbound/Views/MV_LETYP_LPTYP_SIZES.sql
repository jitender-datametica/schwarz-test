-- 2023-12-20, DKNOP, AP0201997, SPEC0229692, INITIAL

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_letyp_lptyp_sizes AS WITH LETYPS AS (SELECT mandant_id,
    lagernummer_id,
    dat,
    lagertyp_id,
    ROUND(SAFE_CAST(RIGHT(lagereinheitentyp_id, 2) AS BIGNUMERIC), 0) AS size_,
    0 AS lp_av_fg
   FROM kfl_production_dbp_view.v_lagerbestand_ewm_tag AS T
   WHERE lagereinheitentyp_id IS NOT NULL
    AND (STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1')
    AND RIGHT(lagereinheitentyp_id, 1) <> 'X'
   GROUP BY mandant_id,
    lagernummer_id,
    dat,
    lagertyp_id,
    size_
   UNION DISTINCT
   SELECT mandant_id,
    lagernummer_id,
    dat,
    lagertyp_id,
    ROUND(SAFE_CAST(RIGHT(lagereinheitentyp_id, 2) AS BIGNUMERIC), 0) AS size_,
    1 AS lp_av_fg
   FROM kfl_production_dbp_view.v_lagerbestand_ewm_tag AS T
   WHERE lagereinheitentyp_id IS NOT NULL
    AND (STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1')
    AND RIGHT(lagerplatz_typ_id, 1) <> 'X'
   GROUP BY mandant_id,
    lagernummer_id,
    dat,
    lagertyp_id,
    size_) (-- ACTUALLY USED LETYPS
 -- AVAILABLE/DEFINED LPTYPS
 SELECT LETYPS.mandant_id,
   LETYPS.lagernummer_id,
   LETYPS.dat,
   LETYPS.lagertyp_id,
   LETYPS.size_,
   MIN(LETYPS_MIN.size_) AS next_size
  FROM LETYPS AS LETYPS
   LEFT JOIN LETYPS AS LETYPS_MIN ON LETYPS_MIN.lp_av_fg = 1 AND LETYPS.size_ < LETYPS_MIN.size_ AND LETYPS.mandant_id =
        LETYPS_MIN.mandant_id AND LETYPS.lagernummer_id = LETYPS_MIN.lagernummer_id AND LETYPS.dat = LETYPS_MIN.dat AND
     LETYPS.lagertyp_id = LETYPS_MIN.lagertyp_id
  GROUP BY LETYPS.mandant_id,
   LETYPS.lagernummer_id,
   LETYPS.dat,
   LETYPS.lagertyp_id,
   LETYPS.size_);