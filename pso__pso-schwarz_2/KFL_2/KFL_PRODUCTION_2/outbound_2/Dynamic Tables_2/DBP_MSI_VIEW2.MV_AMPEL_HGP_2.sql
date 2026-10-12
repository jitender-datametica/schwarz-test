CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_ampel_hgp_2 (
  mandant_id BIGNUMERIC(38, 0),
  hgp_id BIGNUMERIC(38, 0),
  kj BIGNUMERIC(38, 0),
  ums_sort BIGNUMERIC(38, 0),
  kl_id INT64,
  ampel_umsatz INT64,
  sw_umsatz_oben BIGNUMERIC(38, 0),
  ampel_we_umsatz INT64,
  sw_we_umsatz_oben BIGNUMERIC(38, 0),
  ampel_rohertrag INT64,
  sw_rohertrag_oben BIGNUMERIC(38, 0),
  ampel_spanne INT64,
  sw_spanne_oben NUMERIC(20, 0),
  sw_fg STRING(1),
  umsatz_netto BIGNUMERIC(38, 0),
  umsatz_netto_vj BIGNUMERIC(38, 0),
  sw_umsatz_unten BIGNUMERIC(38, 0),
  ek_mep BIGNUMERIC(38, 0),
  ek_mep_vj BIGNUMERIC(38, 0),
  rohertrag BIGNUMERIC(38, 0),
  rohertrag_vj BIGNUMERIC(38, 0),
  sw_rohertrag_unten BIGNUMERIC(38, 0),
  spanne NUMERIC(19, 0),
  spanne_vj NUMERIC(19, 0),
  sw_spanne_unten NUMERIC(19, 0),
  we_umsatz BIGNUMERIC(38, 0),
  we_umsatz_vj BIGNUMERIC(38, 0),
  sw_we_umsatz_unten BIGNUMERIC(38, 0)
) AS
SELECT
  dt1.mandant_id AS mandant_id,
  t5.hgp_id AS hgp_id,
  dt1.kj AS kj,
  SUM(dt3.umsatz_netto) AS ums_sort,
  1 AS kl_id,
  CASE
    WHEN SUM(dt3.umsatz_netto_vj + ABS(dt3.umsatz_netto_vj) * dt1.sw_umsatz_oben) <= SUM(dt3.umsatz_netto)
    THEN 1
    WHEN SUM(dt3.umsatz_netto_vj + ABS(dt3.umsatz_netto_vj) * dt1.sw_umsatz_unten) < SUM(dt3.umsatz_netto)
    THEN 2
    WHEN SUM(dt3.umsatz_netto_vj + ABS(dt3.umsatz_netto_vj) * dt1.sw_umsatz_unten) >= SUM(dt3.umsatz_netto)
    THEN 3
    ELSE 4
  END AS ampel_umsatz,
  SUM(dt3.umsatz_netto_vj + ABS(dt3.umsatz_netto_vj) * dt1.sw_umsatz_oben) AS sw_umsatz_oben,
  CASE
    WHEN SUM(dt2.we_umsatz_vj + ABS(dt2.we_umsatz_vj) * dt1.sw_we_umsatz_oben) <= SUM(dt2.we_umsatz)
    THEN 1
    WHEN SUM(dt2.we_umsatz_vj + ABS(dt2.we_umsatz_vj) * dt1.sw_we_umsatz_unten) < SUM(dt2.we_umsatz)
    THEN 2
    WHEN SUM(dt2.we_umsatz_vj + ABS(dt2.we_umsatz_vj) * dt1.sw_we_umsatz_unten) >= SUM(dt2.we_umsatz)
    THEN 3
    ELSE 4
  END AS ampel_we_umsatz,
  SUM(dt2.we_umsatz_vj + ABS(dt2.we_umsatz_vj) * dt1.sw_we_umsatz_oben) AS sw_we_umsatz_oben,
  CASE
    WHEN SUM(
      dt3.umsatz_netto_vj - dt3.ek_mep_vj + ABS(dt3.umsatz_netto_vj - dt3.ek_mep_vj) * dt1.sw_rohertrag_oben
    ) <= SUM(dt3.umsatz_netto - dt3.ek_mep)
    THEN 1
    WHEN SUM(
      dt3.umsatz_netto_vj - dt3.ek_mep_vj + ABS(dt3.umsatz_netto_vj - dt3.ek_mep_vj) * dt1.sw_rohertrag_unten
    ) < SUM(dt3.umsatz_netto - dt3.ek_mep)
    THEN 2
    WHEN SUM(
      dt3.umsatz_netto_vj - dt3.ek_mep_vj + ABS(dt3.umsatz_netto_vj - dt3.ek_mep_vj) * dt1.sw_rohertrag_unten
    ) >= SUM(dt3.umsatz_netto - dt3.ek_mep)
    THEN 3
    ELSE 4
  END AS ampel_rohertrag,
  SUM(
    dt3.umsatz_netto_vj - dt3.ek_mep_vj + ABS(dt3.umsatz_netto_vj - dt3.ek_mep_vj) * dt1.sw_rohertrag_oben
  ) AS sw_rohertrag_oben,
  CASE
    WHEN SUM(dt3.umsatz_netto * dt1.sw_spanne_oben) / SUM(dt3.umsatz_netto) + SUM(dt3.umsatz_netto_vj - dt3.ek_mep_vj) / SUM(dt3.umsatz_netto_vj) <= SUM(dt3.umsatz_netto - dt3.ek_mep) / SUM(dt3.umsatz_netto)
    THEN 1
    WHEN SUM(dt3.umsatz_netto * dt1.sw_spanne_unten) / SUM(dt3.umsatz_netto) + SUM(dt3.umsatz_netto_vj - dt3.ek_mep_vj) / SUM(dt3.umsatz_netto_vj) < SUM(dt3.umsatz_netto - dt3.ek_mep) / SUM(dt3.umsatz_netto)
    THEN 2
    WHEN SUM(dt3.umsatz_netto * dt1.sw_spanne_unten) / SUM(dt3.umsatz_netto) + SUM(dt3.umsatz_netto_vj - dt3.ek_mep_vj) / SUM(dt3.umsatz_netto_vj) >= SUM(dt3.umsatz_netto - dt3.ek_mep) / SUM(dt3.umsatz_netto)
    THEN 3
    ELSE 4
  END AS ampel_spanne,
  SUM(dt3.umsatz_netto * dt1.sw_spanne_oben) / SUM(dt3.umsatz_netto) + SUM(dt3.umsatz_netto_vj - dt3.ek_mep_vj) / SUM(dt3.umsatz_netto_vj) AS sw_spanne_oben,
  CASE WHEN MAX(dt1.sw_fg) = 1 THEN 'X' ELSE ' ' END AS sw_fg,
  SUM(dt3.umsatz_netto) AS umsatz_netto,
  SUM(dt3.umsatz_netto_vj) AS umsatz_netto_vj,
  SUM(dt3.umsatz_netto_vj + ABS(dt3.umsatz_netto_vj) * dt1.sw_umsatz_unten) AS sw_umsatz_unten,
  SUM(dt3.ek_mep) AS ek_mep,
  SUM(dt3.ek_mep_vj) AS ek_mep_vj,
  SUM(dt3.umsatz_netto - dt3.ek_mep) AS rohertrag,
  SUM(dt3.umsatz_netto_vj - dt3.ek_mep_vj) AS rohertrag_vj,
  SUM(
    dt3.umsatz_netto_vj - dt3.ek_mep_vj + ABS(dt3.umsatz_netto_vj - dt3.ek_mep_vj) * dt1.sw_rohertrag_unten
  ) AS sw_rohertrag_unten,
  SUM(dt3.umsatz_netto - dt3.ek_mep) / SUM(dt3.umsatz_netto) AS spanne,
  SUM(dt3.umsatz_netto_vj - dt3.ek_mep_vj) / SUM(dt3.umsatz_netto_vj) AS spanne_vj,
  SUM(dt3.umsatz_netto * dt1.sw_spanne_unten) / SUM(dt3.umsatz_netto) AS sw_spanne_unten,
  SUM(dt2.we_umsatz) AS we_umsatz,
  SUM(dt2.we_umsatz_vj) AS we_umsatz_vj,
  SUM(dt2.we_umsatz_vj + ABS(dt2.we_umsatz_vj) * dt1.sw_we_umsatz_unten) AS sw_we_umsatz_unten
FROM (
  SELECT
    gp_id,
    kj,
    mandant_id,
    MAX(sw_fg) AS sw_fg,
    SUM(CASE WHEN sw_id = 1 THEN ROUND(CAST(sw_oben AS NUMERIC), 4) ELSE 0 END) AS sw_rohertrag_oben,
    SUM(CASE WHEN sw_id = 1 THEN ROUND(CAST(sw_unten AS NUMERIC), 4) ELSE 0 END) AS sw_rohertrag_unten,
    SUM(CASE WHEN sw_id = 2 THEN ROUND(CAST(sw_oben AS NUMERIC), 4) ELSE 0 END) AS sw_spanne_oben,
    SUM(CASE WHEN sw_id = 2 THEN ROUND(CAST(sw_unten AS NUMERIC), 4) ELSE 0 END) AS sw_spanne_unten,
    SUM(CASE WHEN sw_id = 3 THEN ROUND(CAST(sw_oben AS NUMERIC), 4) ELSE 0 END) AS sw_umsatz_oben,
    SUM(CASE WHEN sw_id = 3 THEN ROUND(CAST(sw_unten AS NUMERIC), 4) ELSE 0 END) AS sw_umsatz_unten,
    SUM(CASE WHEN sw_id = 4 THEN ROUND(CAST(sw_oben AS NUMERIC), 4) ELSE 0 END) AS sw_we_umsatz_oben,
    SUM(CASE WHEN sw_id = 4 THEN ROUND(CAST(sw_unten AS NUMERIC), 4) ELSE 0 END) AS sw_we_umsatz_unten
  FROM kfl_production_dbp_view.v_gp_schwellwert_zu_2 AS t01
  WHERE
    gp_id > 999999
  GROUP BY
    gp_id,
    kj,
    mandant_id
) AS dt1
LEFT JOIN (
  SELECT
    t2.kj,
    t1.gp_id,
    t1.mandant_id,
    CASE WHEN SUM(t1.ek_n * t2.akt_fg) = 0 THEN NULL ELSE SUM(t1.ek_n * t2.akt_fg) END AS we_umsatz,
    CASE WHEN SUM(t1.ek_n * t2.vj_fg) = 0 THEN NULL ELSE SUM(t1.ek_n * t2.vj_fg) END AS we_umsatz_vj
  FROM kfl_production_dbp_view.v_bsch_rech_det_gp_sum_2 AS t1_2
  INNER JOIN (
    SELECT
      kj,
      dat AS dat_join,
      1 AS akt_fg,
      0 AS vj_fg
    FROM kfl_production_dbp_view.v_tag_2
    WHERE
      dat < CURRENT_DATE AND akt_kj IN (0, -1)
    UNION DISTINCT
    SELECT
      kj,
      dat_vj AS dat_join,
      0 AS akt_fg,
      1 AS vj_fg
    FROM kfl_production_dbp_view.v_tag_2
    WHERE
      dat < CURRENT_DATE AND akt_kj IN (0, -1)
  ) AS t2
    ON t1.dat = t2.dat_join
  GROUP BY
    t2.kj,
    t1.gp_id,
    t1.mandant_id
) AS dt2
  ON dt1.gp_id = dt2.gp_id AND dt1.mandant_id = dt2.mandant_id AND dt1.kj = dt2.kj
LEFT JOIN (
  SELECT
    t4.kj,
    t3.gp_id,
    t3.mandant_id,
    CASE
      WHEN SUM((
        t3.umsatz_netto + t3.diff_umsatz_netto_konz
      ) * t4.akt_fg) = 0
      THEN NULL
      ELSE SUM((
        t3.umsatz_netto + t3.diff_umsatz_netto_konz
      ) * t4.akt_fg)
    END AS umsatz_netto,
    CASE
      WHEN SUM((
        t3.umsatz_netto + t3.diff_umsatz_netto_konz
      ) * t4.vj_fg) = 0
      THEN NULL
      ELSE SUM((
        t3.umsatz_netto + t3.diff_umsatz_netto_konz
      ) * t4.vj_fg)
    END AS umsatz_netto_vj,
    CASE
      WHEN SUM((
        t3.ek_mep + t3.diff_ek_mep_konz
      ) * t4.akt_fg) = 0
      THEN NULL
      ELSE SUM((
        t3.ek_mep + t3.diff_ek_mep_konz
      ) * t4.akt_fg)
    END AS ek_mep,
    CASE
      WHEN SUM((
        t3.ek_mep + t3.diff_ek_mep_konz
      ) * t4.vj_fg) = 0
      THEN NULL
      ELSE SUM((
        t3.ek_mep + t3.diff_ek_mep_konz
      ) * t4.vj_fg)
    END AS ek_mep_vj
  FROM kfl_production_dbp_view.v_artbew_gp_sum_2 AS t3
  INNER JOIN (
    SELECT
      kj,
      dat AS dat_join,
      1 AS akt_fg,
      0 AS vj_fg
    FROM kfl_production_dbp_view.v_tag_2
    WHERE
      dat < CURRENT_DATE AND akt_kj IN (0, -1)
    UNION DISTINCT
    SELECT
      kj,
      dat_vj AS dat_join,
      0 AS akt_fg,
      1 AS vj_fg
    FROM kfl_production_dbp_view.v_tag_2
    WHERE
      dat < CURRENT_DATE AND akt_kj IN (0, -1)
  ) AS t4
    ON t3.dat = t4.dat_join
  GROUP BY
    t4.kj,
    t3.gp_id,
    t3.mandant_id
) AS dt3
  ON dt1.gp_id = dt3.gp_id AND dt1.mandant_id = dt3.mandant_id AND dt1.kj = dt3.kj
INNER JOIN kfl_production_dbp_view.v_gp_2 AS t5
  ON dt1.mandant_id = t5.mandant_id AND dt1.gp_id = t5.gp_id
GROUP BY
  dt1.mandant_id,
  t5.hgp_id,
  dt1.kj,
  kl_id;
