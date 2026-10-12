CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_cockpit_wup (mandant_id, nb_id, wup_id, wrg_id,
cockpit_variante, expber_fg, ums_dat_von, ums_dat_bis, ums_zeit_akt, ums_zeit_vor, ums_netto_wup_akt, ums_netto_wup_vor
, ums_netto_wup_abw, ums_netto_rang, ums_netto_nat, ums_netto_min, ums_netto_max, abs_dat_von, abs_dat_bis, abs_zeit_akt
, abs_zeit_vor, abs_brutto_wup_akt, abs_umsatz_wup_akt, abs_brutto_wup_vor, abs_umsatz_wup_vor, abs_quote_wup,
abs_quote_rang, abs_quote_nat, abs_quote_nat_akt, abs_quote_nat_vor, kuga_dat_von, kuga_dat_bis, kuga_zeit_akt,
kuga_zeit_vor, kuga_wup_akt, kuga_wup_vor, kuga_wup_abw, kuga_rang, kuga_nat, kuga_min, kuga_max, pk_dat_von, pk_dat_bis
, pk_zeit_akt, pk_zeit_vor, pk_kosten_wup_akt, pk_umsatz_wup_akt, pk_kosten_wup_vor, pk_umsatz_wup_vor, pk_quote_wup,
pk_quote_rang, pk_quote_nat, pk_quote_nat_akt, pk_quote_nat_vor, kunde_wup_akt, kunde_wup_vor, kunde_wup_abw, kunde_rang
, kunde_nat, kunde_min, kunde_max) AS SELECT V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 V01.wrg_id,
 V01.cockpit_variante,
 V01.exp_ber_fg AS expber_fg,
 V01.ums_dat_von,
 V01.ums_dat_bis,
     '(' || CAST(V01.ums_dat_von AS STRING) || ' - ' || CAST(V01.ums_dat_bis AS STRING) || ')' AS ums_zeit_akt,
     '(' || CAST(DATE_SUB(V01.ums_dat_von, INTERVAL 364 DAY) AS STRING) || ' - ' || CAST(DATE_SUB(V01.ums_dat_bis, INTERVAL 364 DAY) AS STRING)
    || ')' AS ums_zeit_vor,
 V01.ums_netto_wup_akt,
 V01.ums_netto_wup_vor,
 V01.ums_netto_wup_abw,
 V01.ums_netto_rang,
 V01.ums_netto_nat,
 V01.ums_netto_min,
 V01.ums_netto_max,
 V01.abs_dat_von,
 V01.abs_dat_bis,
     '(' || CAST(V01.abs_dat_von AS STRING) || ' - ' || CAST(V01.abs_dat_bis AS STRING) || ')' AS abs_zeit_akt,
     '(' || CAST(DATE_SUB(V01.abs_dat_von, INTERVAL 364 DAY) AS STRING) || ' - ' || CAST(DATE_SUB(V01.abs_dat_bis, INTERVAL 364 DAY) AS STRING)
    || ')' AS abs_zeit_vor,
 V01.abs_brutto_wup_akt,
 V01.abs_umsatz_wup_akt,
 V01.abs_brutto_wup_vor,
 V01.abs_umsatz_wup_vor,
 V01.abs_quote_wup,
 V01.abs_quote_rang,
 V01.abs_quote_nat,
 V01.abs_quote_nat_akt,
 V01.abs_quote_nat_vor,
 V01.kuga_dat_von,
 V01.kuga_dat_bis,
     '(' || CAST(NULLIF(V01.kuga_dat_von, DATE '1900-01-01') AS STRING) || ' - ' || CAST(V01.kuga_dat_bis AS STRING) ||
  ')' AS kuga_zeit_akt,
     '(' || CAST(DATE_SUB(NULLIF(V01.kuga_dat_von, DATE '2091-01-01'), INTERVAL 364 DAY) AS STRING) || ' - ' || CAST(DATE_SUB(V01.kuga_dat_bis, INTERVAL 364 DAY) AS STRING)
    || ')' AS kuga_zeit_vor,
 V01.kuga_wup_akt,
 V01.kuga_wup_vor,
 V01.kuga_wup_abw,
 V01.kuga_rang,
 V01.kuga_nat,
 V01.kuga_min,
 V01.kuga_max,
 V01.pk_dat_von,
 V01.pk_dat_bis,
     '(' || CAST(V01.pk_dat_von AS STRING) || ' - ' || CAST(V01.pk_dat_bis AS STRING) || ')' AS pk_zeit_akt,
     '(' || CAST(IF(V01.pk_dat_von = LAST_DAY(V01.pk_dat_von), LAST_DAY(DATE_ADD(V01.pk_dat_von, INTERVAL - 12 MONTH)), DATE_ADD(V01.pk_dat_von, INTERVAL - 12 MONTH)) AS STRING)
      || ' - ' || CAST(IF(V01.pk_dat_bis = LAST_DAY(V01.pk_dat_bis), LAST_DAY(DATE_ADD(V01.pk_dat_bis, INTERVAL - 12 MONTH)), DATE_ADD(V01.pk_dat_bis, INTERVAL - 12 MONTH)) AS STRING)
    || ')' AS pk_zeit_vor,
 V01.pk_kosten_wup_akt,
 V01.pk_umsatz_wup_akt,
 V01.pk_kosten_wup_vor,
 V01.pk_umsatz_wup_vor,
 V01.pk_quote_wup,
 V01.pk_quote_rang,
 V01.pk_quote_nat,
 V01.pk_quote_nat_akt,
 V01.pk_quote_nat_vor,
 sub01.kunde_wup_akt,
 sub01.kunde_wup_vor,
 sub01.kunde_wup_abw,
 sub01.kunde_rang,
 sub01.kunde_nat,
 sub01.kunde_min,
 sub01.kunde_max
FROM kfl_production_dbp_msi_v_view.v_vis_cockpit_wup AS V01
 LEFT JOIN (SELECT V00.mandant_id,
    V00.nb_id,
    V00.wup_id,
    v02.expber_fg,
    v01.wrg_id,
    0 AS cockpit_variante,
    v01.kunde_dat_von,
    v01.kunde_dat_bis,
    v01.kunde_wup_akt,
    v01.kunde_wup_vor,
    IFNULL((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000 / CASE
       WHEN v01.kunde_wup_vor * v02.expber_fg = 0
       THEN NULL
       ELSE v01.kunde_wup_vor * v02.expber_fg
       END, 0) AS kunde_wup_abw,
     v02.expber_fg * (RANK() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING), v01.wrg_id
       ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v02.expber_fg IS NULL, v02.expber_fg
         , COALESCE(IFNULL((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000 / CASE
             WHEN v01.kunde_wup_vor * v02.expber_fg = 0
             THEN NULL
             ELSE v01.kunde_wup_vor * v02.expber_fg
             END, 0), - 9999) IS NULL, COALESCE(IFNULL((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000 / CASE
             WHEN v01.kunde_wup_vor * v02.expber_fg = 0
             THEN NULL
             ELSE v01.kunde_wup_vor * v02.expber_fg
             END, 0), - 9999))) AS kunde_rang,
    SUM(v01.kunde_wup_akt * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
       , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id IS NULL,
       v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS kunde_nat_ist,
    SUM(v01.kunde_wup_vor * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
       , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id IS NULL,
       v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS kunde_nat_wvj,
    MIN(IFNULL((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000 / CASE
        WHEN v01.kunde_wup_vor * v02.expber_fg = 0
        THEN NULL
        ELSE v01.kunde_wup_vor * v02.expber_fg
        END, 0)) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING), v01.wrg_id ORDER BY v01.mandant_id
       IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id IS NULL, v01.wup_id RANGE BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS kunde_min,
    MAX(IFNULL((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000 / CASE
        WHEN v01.kunde_wup_vor * v02.expber_fg = 0
        THEN NULL
        ELSE v01.kunde_wup_vor * v02.expber_fg
        END, 0)) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING), v01.wrg_id ORDER BY v01.mandant_id
       IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id IS NULL, v01.wup_id RANGE BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS kunde_max,
    IFNULL((CASE
          WHEN (SUM(v01.kunde_wup_akt * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
               , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id
               IS NULL, v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
          THEN NULL
          ELSE SUM(v01.kunde_wup_akt * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
             , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id
             IS NULL, v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          END - CASE
          WHEN (SUM(v01.kunde_wup_vor * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
               , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id
               IS NULL, v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
          THEN NULL
          ELSE SUM(v01.kunde_wup_vor * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
             , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id
             IS NULL, v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          END) * 100.0000 / CASE
       WHEN (SUM(v01.kunde_wup_vor * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
            , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id
            IS NULL, v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
       THEN NULL
       ELSE SUM(v01.kunde_wup_vor * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
          , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id IS NULL
          , v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
       END, 0) AS kunde_nat
   FROM kfl_production_dbp_view.v_wup AS V00
    INNER JOIN (SELECT mandant_id,
      nb_id,
      wup_id,
      MIN(altersstruktur_tag_id) AS alter_min,
       CASE
       WHEN MIN(altersstruktur_tag_id) < 3
       THEN 1
       ELSE 0
       END AS expber_fg
     FROM kfl_production_dbp_msi_v_view.v_altersstruktur_eis AS R1
     WHERE nb_id = 0
     GROUP BY mandant_id,
      wup_id,
      nb_id) AS v02 ON V00.mandant_id = v02.mandant_id AND V00.wup_id = v02.wup_id
    INNER JOIN (SELECT V1.mandant_id,
      V1.nb_id,
      V1.wup_id,
      V1.wrg_id,
      MIN(V2.dat) AS kunde_dat_von,
      MAX(V2.dat) AS kunde_dat_bis,
      SUM(V1.anz_kunde) AS kunde_wup_akt,
      SUM(V1.anz_kunde_wvj) AS kunde_wup_vor
     FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup AS V1
      INNER JOIN kfl_production_dbp_view.v_tag AS V2 ON V1.dat = V2.dat AND V2.akt_mo = 0 AND V2.akt_tag <= 0
     WHERE V1.nb_id = 0
     GROUP BY V1.mandant_id,
      V1.nb_id,
      V1.wup_id,
      V1.wrg_id) AS v01 ON V00.mandant_id = v01.mandant_id AND V00.wup_id = v01.wup_id
   WHERE V00.dat_eroeffnung > DATE '1900-01-01'
    AND V00.nb_id = 0
   UNION ALL
   SELECT V00.mandant_id,
    V00.nb_id,
    V00.wup_id,
    v02.expber_fg,
    v01.wrg_id,
    1 AS cockpit_variante,
    v01.kunde_dat_von,
    v01.kunde_dat_bis,
    v01.kunde_wup_akt,
    v01.kunde_wup_vor,
    IFNULL((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000 / CASE
       WHEN v01.kunde_wup_vor * v02.expber_fg = 0
       THEN NULL
       ELSE v01.kunde_wup_vor * v02.expber_fg
       END, 0) AS kunde_wup_abw,
     v02.expber_fg * (RANK() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING), v01.wrg_id
       ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v02.expber_fg IS NULL, v02.expber_fg
         , COALESCE(IFNULL((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000 / CASE
             WHEN v01.kunde_wup_vor * v02.expber_fg = 0
             THEN NULL
             ELSE v01.kunde_wup_vor * v02.expber_fg
             END, 0), - 9999) IS NULL, COALESCE(IFNULL((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000 / CASE
             WHEN v01.kunde_wup_vor * v02.expber_fg = 0
             THEN NULL
             ELSE v01.kunde_wup_vor * v02.expber_fg
             END, 0), - 9999))) AS kunde_rang,
    SUM(v01.kunde_wup_akt * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
       , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id IS NULL,
       v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS kunde_nat_ist,
    SUM(v01.kunde_wup_vor * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
       , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id IS NULL,
       v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS kunde_nat_wvj,
    MIN(IFNULL((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000 / CASE
        WHEN v01.kunde_wup_vor * v02.expber_fg = 0
        THEN NULL
        ELSE v01.kunde_wup_vor * v02.expber_fg
        END, 0)) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING), v01.wrg_id ORDER BY v01.mandant_id
       IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id IS NULL, v01.wup_id RANGE BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS kunde_min,
    MAX(IFNULL((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000 / CASE
        WHEN v01.kunde_wup_vor * v02.expber_fg = 0
        THEN NULL
        ELSE v01.kunde_wup_vor * v02.expber_fg
        END, 0)) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING), v01.wrg_id ORDER BY v01.mandant_id
       IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id IS NULL, v01.wup_id RANGE BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS kunde_max,
    IFNULL((CASE
          WHEN (SUM(v01.kunde_wup_akt * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
               , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id
               IS NULL, v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
          THEN NULL
          ELSE SUM(v01.kunde_wup_akt * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
             , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id
             IS NULL, v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          END - CASE
          WHEN (SUM(v01.kunde_wup_vor * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
               , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id
               IS NULL, v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
          THEN NULL
          ELSE SUM(v01.kunde_wup_vor * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
             , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id
             IS NULL, v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          END) * 100.0000 / CASE
       WHEN (SUM(v01.kunde_wup_vor * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
            , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id
            IS NULL, v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
       THEN NULL
       ELSE SUM(v01.kunde_wup_vor * v02.expber_fg) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.nb_id AS STRING)
          , v01.wrg_id ORDER BY v01.mandant_id IS NULL, v01.mandant_id, v01.nb_id IS NULL, v01.nb_id, v01.wup_id IS NULL
          , v01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
       END, 0) AS kunde_nat
   FROM kfl_production_dbp_view.v_wup AS V00
    INNER JOIN (SELECT mandant_id,
      nb_id,
      wup_id,
      MIN(altersstruktur_tag_id) AS alter_min,
       CASE
       WHEN MIN(altersstruktur_tag_id) < 3
       THEN 1
       ELSE 0
       END AS expber_fg
     FROM kfl_production_dbp_msi_v_view.v_altersstruktur_eis AS R1
     WHERE nb_id = 0
     GROUP BY mandant_id,
      wup_id,
      nb_id) AS v02 ON V00.mandant_id = v02.mandant_id AND V00.wup_id = v02.wup_id
    INNER JOIN (SELECT V1.mandant_id,
      V1.nb_id,
      V1.wup_id,
      V1.wrg_id,
      MIN(V2.dat) AS kunde_dat_von,
      MAX(V2.dat) AS kunde_dat_bis,
      SUM(V1.anz_kunde) AS kunde_wup_akt,
      SUM(V1.anz_kunde_wvj) AS kunde_wup_vor
     FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup AS V1
      INNER JOIN kfl_production_dbp_view.v_tag AS V2 ON V1.dat = V2.dat AND V2.akt_gj = 0 AND V2.akt_tag <= 0
     WHERE V1.nb_id = 0
     GROUP BY V1.mandant_id,
      V1.nb_id,
      V1.wup_id,
      V1.wrg_id) AS v01 ON V00.mandant_id = v01.mandant_id AND V00.wup_id = v01.wup_id
   WHERE V00.dat_eroeffnung > DATE '1900-01-01'
    AND V00.nb_id = 0) AS sub01 ON V01.mandant_id = sub01.mandant_id AND V01.wup_id = sub01.wup_id AND V01.wrg_id =
    sub01.wrg_id AND V01.cockpit_variante = sub01.cockpit_variante;