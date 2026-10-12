CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagerbestand_ewm_tag AS WITH LETYPS AS (SELECT mandant_id,
    lagernummer_id,
    dat,
    lagertyp_id,
    SAFE_CAST(ROUND(CAST(RIGHT(lagereinheitentyp_id_top, 2) AS FLOAT64)) AS INTEGER) AS size_,
    0 AS lp_av_fg
   FROM kfl_production_dbp_view.v_lagerbestand_ewm_tag AS T
   WHERE lagereinheitentyp_id_top IS NOT NULL
    AND (STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1')
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
    SAFE_CAST(ROUND(CAST(RIGHT(lagerplatz_typ_id, 2) AS FLOAT64)) AS INTEGER) AS size_,
    1 AS lp_av_fg
   FROM kfl_production_dbp_view.v_lagerbestand_ewm_tag AS T
   WHERE lagereinheitentyp_id_top IS NOT NULL
    AND (STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1')
    AND RIGHT(lagerplatz_typ_id, 1) <> 'X'
   GROUP BY mandant_id,
    lagernummer_id,
    dat,
    lagertyp_id,
    size_) (SELECT L_EWM_T.mandant_id,
   L_EWM_T.lagernummer_id,
   L_EWM_T.dat,
   L_EWM_T.lagertyp_id,
   L_EWM_T.lagerbereich_id,
   L_EWM_T.lagerplatz_id,
   L_EWM_T.handling_unit_id_top,
   L_EWM_T.handling_unit_id,
   L_EWM_T.charge_id,
   L_EWM_T.lagerbestand_typ_id,
   L_EWM_T.lagerplatz_typ_id,
   L_EWM_T.gang_id,
   L_EWM_T.saeule_id,
   L_EWM_T.ebene_id,
   L_EWM_T.lagereinheitentyp_id_top,
   LETYPs.size_ AS ideal_size,
   SAFE_CAST(ROUND(CAST(LEFT(L_EWM_T.lagerplatz_typ_id, 2) AS FLOAT64)) AS INTEGER) AS actual_size,
   COALESCE(MAX(LETYPs.lp_av_fg), -1) AS size_is_av_fg,
   MIN(LETYPs_min.size_) AS next_size,
    CASE
    WHEN LETYPs.size_ = SAFE_CAST(ROUND(CAST(LEFT(L_EWM_T.lagerplatz_typ_id, 2) AS FLOAT64)) AS INTEGER)
    THEN 0
    WHEN MIN(LETYPs_min.size_) = SAFE_CAST(ROUND(CAST(LEFT(L_EWM_T.lagerplatz_typ_id, 2) AS FLOAT64)) AS INTEGER)
    THEN 1
    ELSE 2
    END AS letyp_lptyp_diff_id
  FROM kfl_production_dbp_view.v_lagerbestand_ewm_tag AS L_EWM_T
   LEFT JOIN LETYPS AS LETYPs ON L_EWM_T.dat = LETYPs.dat AND L_EWM_T.lagernummer_id = LETYPs.lagernummer_id AND L_EWM_T
       .lagertyp_id = LETYPs.lagertyp_id AND L_EWM_T.mandant_id = LETYPs.mandant_id AND SAFE_CAST(ROUND(CAST(RIGHT(L_EWM_T.lagereinheitentyp_id, 2) AS FLOAT64)
       ) AS INTEGER) = LETYPs.size_
   LEFT JOIN LETYPS AS LETYPs_min ON LETYPs_min.lp_av_fg = 1 AND LETYPs.size_ < LETYPs_min.size_ AND LETYPs.mandant_id =
        LETYPs_min.mandant_id AND LETYPs.lagernummer_id = LETYPs_min.lagernummer_id AND LETYPs.dat = LETYPs_min.dat AND
     LETYPs.lagertyp_id = LETYPs_min.lagertyp_id
  WHERE RIGHT(L_EWM_T.lagereinheitentyp_id, 1) <> 'X'
  GROUP BY L_EWM_T.mandant_id,
   L_EWM_T.lagernummer_id,
   L_EWM_T.dat,
   L_EWM_T.lagertyp_id,
   ideal_size,
   L_EWM_T.lagerbereich_id,
   L_EWM_T.lagerplatz_id,
   L_EWM_T.handling_unit_id_top,
   L_EWM_T.handling_unit_id,
   L_EWM_T.charge_id,
   L_EWM_T.lagerbestand_typ_id,
   L_EWM_T.lagerplatz_typ_id,
   L_EWM_T.gang_id,
   L_EWM_T.saeule_id,
   L_EWM_T.ebene_id,
   L_EWM_T.lagereinheitentyp_id_top);