CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_letyp_lptyp_sizes_2 AS WITH LETYPS AS (SELECT mandant_id,
    lagernummer_id,
    dat,
    lagertyp_id,
    SAFE_CAST(ROUND(CAST(RIGHT(lagereinheitentyp_id, 2) AS FLOAT64)) AS INTEGER) AS size_,
    0 AS lp_av_fg
   FROM kfl_production_dbp_view.v_lagerbestand_ewm_tag_2 AS T
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
    SAFE_CAST(ROUND(CAST(RIGHT(lagereinheitentyp_id, 2) AS FLOAT64)) AS INTEGER) AS size_,
    1 AS lp_av_fg
   FROM kfl_production_dbp_view.v_lagerbestand_ewm_tag_2 AS T
   WHERE lagereinheitentyp_id IS NOT NULL
    AND (STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1')
    AND RIGHT(lagerplatz_typ_id, 1) <> 'X'
   GROUP BY mandant_id,
    lagernummer_id,
    dat,
    lagertyp_id,
    size_) (SELECT LETYPs.mandant_id,
   LETYPs.lagernummer_id,
   LETYPs.dat,
   LETYPs.lagertyp_id,
   LETYPs.size_,
   MIN(LETYPs_min.size_) AS next_size
  FROM LETYPS AS LETYPs
   LEFT JOIN LETYPS AS LETYPs_min ON LETYPs_min.lp_av_fg = 1 AND LETYPs.size_ < LETYPs_min.size_ AND LETYPs.mandant_id =
        LETYPs_min.mandant_id AND LETYPs.lagernummer_id = LETYPs_min.lagernummer_id AND LETYPs.dat = LETYPs_min.dat AND
     LETYPs.lagertyp_id = LETYPs_min.lagertyp_id
  GROUP BY LETYPs.mandant_id,
   LETYPs.lagernummer_id,
   LETYPs.dat,
   LETYPs.lagertyp_id,
   LETYPs.size_);