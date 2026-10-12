CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagerbestand_ewm_tag AS WITH LETYPS AS (SELECT mandant_id,
    lagernummer_id,
    dat,
    lagertyp_id,
    ROUND(SAFE_CAST(RIGHT(lagereinheitentyp_id_top, 2) AS BIGNUMERIC), 0) AS size_,
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
    ROUND(SAFE_CAST(RIGHT(lagerplatz_typ_id, 2) AS BIGNUMERIC), 0) AS size_,
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
   LETYPS.size_ AS ideal_size,
   ROUND(SAFE_CAST(LEFT(L_EWM_T.lagerplatz_typ_id, 2) AS BIGNUMERIC), 0) AS actual_size,
   COALESCE(MAX(LETYPS.lp_av_fg), - 1) AS size_is_av_fg,
   MIN(LETYPS_MIN.size_) AS next_size,
    CASE
    WHEN LETYPS.size_ = ROUND(SAFE_CAST(LEFT(L_EWM_T.lagerplatz_typ_id, 2) AS BIGNUMERIC), 0)
    THEN 0
    WHEN MIN(LETYPS_MIN.size_) = ROUND(SAFE_CAST(LEFT(L_EWM_T.lagerplatz_typ_id, 2) AS BIGNUMERIC), 0)
    THEN 1
    ELSE 2
    END AS letyp_lptyp_diff_id
  FROM kfl_production_dbp_view.v_lagerbestand_ewm_tag AS L_EWM_T
   LEFT JOIN LETYPS AS LETYPS ON L_EWM_T.dat = LETYPS.dat AND L_EWM_T.lagernummer_id = LETYPS.lagernummer_id AND L_EWM_T
       .lagertyp_id = LETYPS.lagertyp_id AND L_EWM_T.mandant_id = LETYPS.mandant_id AND ROUND(SAFE_CAST(RIGHT(L_EWM_T.lagereinheitentyp_id
        , 2) AS BIGNUMERIC), 0) = LETYPS.size_
   LEFT JOIN LETYPS AS LETYPS_MIN ON LETYPS_MIN.lp_av_fg = 1 AND LETYPS.size_ < LETYPS_MIN.size_ AND LETYPS.mandant_id =
        LETYPS_MIN.mandant_id AND LETYPS.lagernummer_id = LETYPS_MIN.lagernummer_id AND LETYPS.dat = LETYPS_MIN.dat AND
     LETYPS.lagertyp_id = LETYPS_MIN.lagertyp_id
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