INSERT INTO dbp_etl.vis_tag_best_wg_wechsel_join_2
  (mandant_id, art_id, arthiertyp_id, dat, alt_neu_kz, wg_id, gj, kjmo, kjwo)
    (
      SELECT
        W1.mandant_id,
        W1.art_id,
        W1.arthiertyp_id,
        tmp.dat,
        W1.alt_neu_kz,
        W1.wg_id,
        tmp.gj,
        tmp.kjmo,
        tmp.kjwo
      FROM dbp_etl.vis_tag_best_wg_wechsel_tmp_2 AS W1
      INNER JOIN dbp_etl.vis_tag_best_wg_wechsel_tmp_2 AS W2
        ON
          W1.mandant_id = W2.mandant_id
          AND W1.art_id = W2.art_id
          AND W1.arthiertyp_id = W2.arthiertyp_id
          AND (
            W1.alt_neu_kz = 1 AND W2.alt_neu_kz = -1
            OR W1.alt_neu_kz
              = -1 AND W2.alt_neu_kz = 1)
      INNER JOIN
        (
          SELECT
            dat,
            gj,
            kjmo,
            kjwo
          FROM dbp_data.tag_2
          WHERE
            (
              akt_mo BETWEEN $VIS_BESTAND_AKT_MO_VON AND 0
              OR dat IN (
                SELECT MAX(dat) AS a1169003766
                FROM dbp_data.tag_2
                WHERE akt_mo = $VIS_BESTAND_AKT_MO_VON - 1
              ))
            AND dat <= (SELECT MAX(dat) FROM dbp_msi_data.vis_tag_bestand_wg_2)
        ) AS tmp
        ON TRUE
      WHERE W1.wg_id <> W2.wg_id
    );

-- [OK] statement is translated correctly (syntax and type checks are fine)

-- ,t4.abt_id
-- ,abt_id
-- ,t4.abt_id

-- Abteilung wird nur beim spaeteren INSERT INTO benoetigt und dort direkt herangejoint.
INSERT INTO dbp_etl.vis_tag_best_wg_wechsel_sum_t1_2
  (
    mandant_id,
    wup_id,
    wg_id,
    dat,
    gj,
    kjmo,
    kjwo,
    arthiertyp_id,
    nb_id,
    relevant_fg,
    bezugsweg_id,
    wrg_id,
    anz_artikel_bestand,
    anz_artikel_fehlmengen,
    anz_artikel_nullbestand,
    anz_artikel_minusbestand,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme,
    betrag_vk_brutto_frei_bme,
    betrag_vk_brutto_qual_bme)
    (
      SELECT
        T2.mandant_id,
        T2.wup_id,
        T1.wg_id,
        T1.dat,
        T1.gj,
        T1.kjmo,
        T1.kjwo,
        T1.arthiertyp_id,
        T2.nb_id,
        T2.relevant_fg,
        T2.bezugsweg_id,
        T3.wrg_id,
        SUM(T1.alt_neu_kz) AS anz_artikel_bestand,
        SUM(
          CASE
            WHEN T2.menge_lgbest_erp_frei_bme <= 0
              THEN T1.alt_neu_kz
            ELSE 0
            END) AS anz_artikel_fehlmenge,
        SUM(
          CASE
            WHEN T2.menge_lgbest_erp_frei_bme = 0
              THEN T1.alt_neu_kz
            ELSE 0
            END) AS anz_artikel_nullbestand,
        SUM(
          CASE
            WHEN T2.menge_lgbest_erp_frei_bme < 0
              THEN T1.alt_neu_kz
            ELSE 0
            END) AS anz_artikel_minusbestand,
        SUM(CAST(T2.menge_lgbest_erp_frei_bme * T1.alt_neu_kz AS NUMERIC))
          AS menge_lgbest_erp_frei_bme,
        SUM(CAST(T2.menge_lgbest_erp_qual_bme * T1.alt_neu_kz AS NUMERIC))
          AS menge_lgbest_erp_qual_bme,
        SUM(
          ROUND(
            CAST(
              T3.vk_netto
              * T2.menge_lgbest_erp_frei_bme
              * T1.alt_neu_kz
              AS NUMERIC),
            4)) AS betrag_vk_netto_frei_bme,
        SUM(
          ROUND(
            CAST(
              T3.vk_netto
              * T2.menge_lgbest_erp_qual_bme
              * T1.alt_neu_kz
              AS NUMERIC),
            4)) AS betrag_vk_netto_qual_bme,
        SUM(
          ROUND(
            CAST(
              COALESCE(T4.vk_brutto, 0)
              * T3.vk_netto
              * T2.menge_lgbest_erp_frei_bme
              * T1.alt_neu_kz AS NUMERIC),
            4)) AS betrag_vk_brutto_frei_bme,
        SUM(
          ROUND(
            CAST(
              COALESCE(T4.vk_brutto, 0)
              * T3.vk_netto
              * T2.menge_lgbest_erp_qual_bme
              * T1.alt_neu_kz AS NUMERIC),
            4)) AS betrag_vk_brutto_qual_bme
      FROM dbp_etl.vis_tag_best_wg_wechsel_join_2 AS T1_2
      INNER JOIN dbp_data.marktbestand_erp_2 AS T2
        ON
          T1.dat = T2.dat
          AND T1.art_id = T2.art_id
          AND T1.mandant_id
            = T2.mandant_id
      INNER JOIN dbp_data.marktbestand_erp_zu_2 AS T3
        ON T2.bestand_id = T3.bestand_id AND T2.mandant_id = T3.mandant_id
      LEFT JOIN dbp_data.art_wup_zu_per_2 AS T4
        ON
          T2.mandant_id = T4.mandant_id
          AND T2.art_id = T4.art_id
          AND T2.wup_id = T4.wup_id
          AND T2.nb_id = T4.nb_id
          AND T2.dat BETWEEN T4.dat_von AND T4.dat_bis
      GROUP BY
        T2.mandant_id,
        T2.wup_id,
        T1.wg_id,
        T1.dat,
        T1.gj,
        T1.kjmo,
        T1.kjwo,
        T1.arthiertyp_id,
        T2.nb_id,
        T2.relevant_fg,
        T2.bezugsweg_id,
        T3.wrg_id
    );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

-- Comment from validation checker
-- MESSAGE: SQL compilation error:
-- Object 'T1_2' does not exist or not authorized.

UPDATE dbp_etl.vis_tag_best_wg_wechsel_sum_t1_2 AS T1_2
SET
  betrag_mo_anf_vk_ntto_frei_bme = tmp.betrag_vk_netto_frei_bme,
  betrag_mo_anf_vk_ntto_qual_bme = tmp.betrag_vk_netto_qual_bme,
  betrag_mo_anf_vk_btto_frei_bme = tmp.betrag_vk_brutto_frei_bme,
  betrag_mo_anf_vk_btto_qual_bme = tmp.betrag_vk_brutto_qual_bme
FROM
  (
    SELECT
      VTBW.mandant_id,
      VTBW.wup_id,
      VTBW.wg_id,
      VTBW.gj,
      M.kjmo,
      VTBW.arthiertyp_id,
      VTBW.nb_id,
      VTBW.relevant_fg,
      VTBW.bezugsweg_id,
      VTBW.wrg_id,
      VTBW.betrag_vk_netto_frei_bme,
      VTBW.betrag_vk_netto_qual_bme,
      VTBW.betrag_vk_brutto_frei_bme,
      VTBW.betrag_vk_brutto_qual_bme
    FROM dbp_etl.vis_tag_best_wg_wechsel_sum_t1_2 AS VTBW
    INNER JOIN dbp_data.monat_2 AS M
      ON DATE_SUB(M.min_dat, INTERVAL 1 DAY) = VTBW.dat
  ) AS tmp
WHERE
  T1.mandant_id = tmp.mandant_id
  AND T1.wup_id = tmp.wup_id
  AND T1.wg_id = tmp.wg_id
  AND T1.gj = tmp.gj
  AND T1.kjmo
    = tmp.kjmo
  AND T1.arthiertyp_id = tmp.arthiertyp_id
  AND T1.nb_id = tmp.nb_id
  AND T1.relevant_fg = tmp.relevant_fg
  AND T1.bezugsweg_id = tmp.bezugsweg_id
  AND T1.wrg_id = tmp.wrg_id;

-- [OK] statement is translated correctly (syntax and type checks are fine)
-- WARNING : Possible parameter resolution issue

DELETE FROM dbp_etl.vis_tag_best_wg_wechsel_sum_t1_2
WHERE
  kjmo IN (
    SELECT kjmo
    FROM dbp_data.monat_2
    WHERE akt_mo = $VIS_BESTAND_AKT_MO_VON - 1
  );

-- [OK] statement is translated correctly (syntax and type checks are fine)

-- , abt_id
INSERT INTO dbp_etl.vis_tag_best_wg_wechsel_sum_t1_2
  (
    mandant_id,
    wup_id,
    wg_id,
    dat,
    gj,
    kjmo,
    kjwo,
    arthiertyp_id,
    nb_id,
    relevant_fg,
    bezugsweg_id,
    wrg_id,
    anz_artikel_bestand,
    anz_artikel_fehlmengen,
    anz_artikel_nullbestand,
    anz_artikel_minusbestand,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme,
    betrag_vk_brutto_frei_bme,
    betrag_vk_brutto_qual_bme,
    betrag_mo_anf_vk_ntto_frei_bme,
    betrag_mo_anf_vk_ntto_qual_bme,
    betrag_mo_anf_vk_btto_frei_bme,
    betrag_mo_anf_vk_btto_qual_bme)
    (
      SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.wg_id,
        T1.dat  -- ,t1.abt_id
          ,
        T1.gj,
        T1.kjmo,
        T1.kjwo,
        T1.arthiertyp_id,
        T1.nb_id,
        T1.relevant_fg,
        T1.bezugsweg_id,
        K.nach_wrg_id,
        0 AS anz_artikel_bestand,
        0 AS anz_artikel_fehlmengen,
        0 AS anz_artikel_nullbestand,
        0 AS anz_artikel_minusbestand,
        T1.menge_lgbest_erp_frei_bme,
        T1.menge_lgbest_erp_qual_bme,
        T1.betrag_vk_netto_frei_bme * K.umrechnungskurs
          AS betrag_vk_netto_frei_bme,
        T1.betrag_vk_netto_qual_bme * K.umrechnungskurs
          AS betrag_vk_netto_qual_bme,
        T1.betrag_vk_brutto_frei_bme * K.umrechnungskurs
          AS betrag_vk_brutto_frei_bme,
        T1.betrag_vk_brutto_qual_bme * K.umrechnungskurs
          AS betrag_vk_brutto_qual_bme,
        T1.betrag_mo_anf_vk_ntto_frei_bme * K.umrechnungskurs
          AS betrag_mo_anf_vk_ntto_frei_bme,
        T1.betrag_mo_anf_vk_ntto_qual_bme * K.umrechnungskurs
          AS betrag_mo_anf_vk_ntto_qual_bme,
        T1.betrag_mo_anf_vk_btto_frei_bme * K.umrechnungskurs
          AS betrag_mo_anf_vk_btto_frei_bme,
        T1.betrag_mo_anf_vk_btto_qual_bme * K.umrechnungskurs
          AS betrag_mo_anf_vk_btto_qual_bme
      FROM dbp_etl.vis_tag_best_wg_wechsel_sum_t1_2 AS T1_2
      INNER JOIN dbp_data.kurs_2 AS K
        ON
          T1.wrg_id = K.von_wrg_id
          AND K.dat_bis = PARSE_DATE('%F', '9999-12-31')
          AND K.nach_wrg_id = 'EUR'
          AND K.kurstyp_id = 3
      WHERE T1.wrg_id <> 'EUR'
    );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

-- Comment from validation checker
-- MESSAGE: SQL compilation error:
-- Object 'ZIEL' does not exist or not authorized.

UPDATE dbp_msi_data.vis_tag_bestand_wg_2 AS ZIEL
SET
  anz_artikel_bestand = ZIEL.anz_artikel_bestand + TMP.anz_artikel_bestand,
  anz_artikel_fehlmengen = ZIEL.anz_artikel_fehlmengen
    + TMP.anz_artikel_fehlmengen,
  anz_artikel_nullbestand = ZIEL.anz_artikel_nullbestand
    + TMP.anz_artikel_nullbestand,
  anz_artikel_minusbestand = ZIEL.anz_artikel_minusbestand
    + TMP.anz_artikel_minusbestand,
  menge_lgbest_erp_frei_bme = ZIEL.menge_lgbest_erp_frei_bme
    + TMP.menge_lgbest_erp_frei_bme,
  menge_lgbest_erp_qual_bme = ZIEL.menge_lgbest_erp_qual_bme
    + TMP.menge_lgbest_erp_qual_bme,
  betrag_vk_netto_frei_bme = ZIEL.betrag_vk_netto_frei_bme
    + TMP.betrag_vk_netto_frei_bme,
  betrag_vk_netto_qual_bme = ZIEL.betrag_vk_netto_qual_bme
    + TMP.betrag_vk_netto_qual_bme,
  betrag_vk_brutto_frei_bme = ZIEL.betrag_vk_brutto_frei_bme
    + TMP.betrag_vk_brutto_frei_bme,
  betrag_vk_brutto_qual_bme = ZIEL.betrag_vk_brutto_qual_bme
    + TMP.betrag_vk_brutto_qual_bme,
  betrag_mo_anf_vk_ntto_frei_bme = ZIEL.betrag_mo_anf_vk_ntto_frei_bme
    + TMP.betrag_mo_anf_vk_ntto_frei_bme,
  betrag_mo_anf_vk_ntto_qual_bme = ZIEL.betrag_mo_anf_vk_ntto_qual_bme
    + TMP.betrag_mo_anf_vk_ntto_qual_bme,
  betrag_mo_anf_vk_btto_frei_bme = ZIEL.betrag_mo_anf_vk_btto_frei_bme
    + TMP.betrag_mo_anf_vk_btto_frei_bme,
  betrag_mo_anf_vk_btto_qual_bme = ZIEL.betrag_mo_anf_vk_btto_qual_bme
    + TMP.betrag_mo_anf_vk_btto_qual_bme
FROM
  dbp_etl.vis_tag_best_wg_wechsel_sum_t1_2 AS TMP
WHERE
  ZIEL.mandant_id = TMP.mandant_id
  AND ZIEL.wup_id = TMP.wup_id
  AND ZIEL.wg_id = TMP.wg_id
  AND ZIEL.dat = TMP.dat
  AND ZIEL.arthiertyp_id = TMP.arthiertyp_id
  AND ZIEL.nb_id = TMP.nb_id
  AND ZIEL.relevant_fg = TMP.relevant_fg
  AND ZIEL.bezugsweg_id = TMP.bezugsweg_id
  AND ZIEL.wrg_id = TMP.wrg_id;

-- [OK] statement is translated correctly (syntax and type checks are fine)

INSERT INTO dbp_msi_data.vis_tag_bestand_wg_2
  (
    mandant_id,
    wup_id,
    wg_id,
    dat,
    relevant_fg,
    bezugsweg_id,
    arthiertyp_id,
    wrg_id,
    abt_id,
    gj,
    kjmo,
    kjwo,
    nb_id,
    anz_artikel_bestand,
    anz_artikel_fehlmengen,
    anz_artikel_nullbestand,
    anz_artikel_minusbestand,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme,
    betrag_vk_brutto_frei_bme,
    betrag_vk_brutto_qual_bme,
    betrag_mo_anf_vk_ntto_frei_bme,
    betrag_mo_anf_vk_ntto_qual_bme,
    betrag_mo_anf_vk_btto_frei_bme,
    betrag_mo_anf_vk_btto_qual_bme)
    (
      SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.wg_id,
        T1.dat,
        T1.relevant_fg,
        T1.bezugsweg_id,
        T1.arthiertyp_id,
        T1.wrg_id,
        WP.abt_id,
        T1.gj,
        T1.kjmo,
        T1.kjwo,
        T1.nb_id,
        T1.anz_artikel_bestand,
        T1.anz_artikel_fehlmengen,
        T1.anz_artikel_nullbestand,
        T1.anz_artikel_minusbestand,
        T1.menge_lgbest_erp_frei_bme,
        T1.menge_lgbest_erp_qual_bme,
        T1.betrag_vk_netto_frei_bme,
        T1.betrag_vk_netto_qual_bme,
        T1.betrag_vk_brutto_frei_bme,
        T1.betrag_vk_brutto_qual_bme,
        T1.betrag_mo_anf_vk_ntto_frei_bme,
        T1.betrag_mo_anf_vk_ntto_qual_bme,
        T1.betrag_mo_anf_vk_btto_frei_bme,
        T1.betrag_mo_anf_vk_btto_qual_bme
      FROM dbp_etl.vis_tag_best_wg_wechsel_sum_t1_2 AS T1_2
      INNER JOIN dbp_data.wg_per_2 AS WP
        ON
          T1.mandant_id = WP.mandant_id
          AND T1.wg_id = WP.wg_id
          AND T1.arthiertyp_id
            = WP.arthiertyp_id
          AND WP.dat_bis = PARSE_DATE('%F', '9999-12-31')
      LEFT JOIN dbp_msi_data.vis_tag_bestand_wg_2 AS ZIEL
        ON
          T1.mandant_id = ZIEL.mandant_id
          AND T1.wup_id = ZIEL.wup_id
          AND T1.wg_id = ZIEL.wg_id
          AND T1.dat = ZIEL.dat
          AND T1.arthiertyp_id = ZIEL.arthiertyp_id
          AND T1.nb_id = ZIEL.nb_id
          AND T1.relevant_fg = ZIEL.relevant_fg
          AND T1.bezugsweg_id = ZIEL.bezugsweg_id
          AND T1.wrg_id = ZIEL.wrg_id
      WHERE ZIEL.mandant_id IS NULL
    );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
-- WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.

-- Comment from validation checker
-- MESSAGE: SQL compilation error:
-- Object 'T1_2' does not exist or not authorized.

UPDATE dbp_msi_data.vis_tag_bestand_wg_2 AS T1_2
SET
  betrag_d_vmo_vk_ntto_frei_bme = tmp.d_betrag_vk_netto_frei_bme,
  betrag_d_vmo_vk_ntto_qual_bme = tmp.d_betrag_vk_netto_qual_bme,
  betrag_d_vmo_vk_btto_frei_bme = tmp.d_betrag_vk_brutto_frei_bme,
  betrag_d_vmo_vk_btto_qual_bme = tmp.d_betrag_vk_brutto_qual_bme
FROM
  (
    SELECT
      mandant_id,
      wup_id,
      wg_id,
      abt_id,
      dat,
      kjmo,
      arthiertyp_id,
      nb_id,
      relevant_fg,
      bezugsweg_id,
      wrg_id,
      (
        SUM(betrag_vk_netto_frei_bme)
          OVER (
            PARTITION BY
              mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg,
              bezugsweg_id, kjmo, wrg_id
            ORDER BY dat IS NULL, dat
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
          ))
        / EXTRACT(DAY FROM dat) AS d_betrag_vk_netto_frei_bme,
      (
        SUM(betrag_vk_netto_qual_bme)
          OVER (
            PARTITION BY
              mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg,
              bezugsweg_id, kjmo, wrg_id
            ORDER BY dat IS NULL, dat
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
          ))
        / EXTRACT(DAY FROM dat) AS d_betrag_vk_netto_qual_bme,
      (
        SUM(betrag_vk_brutto_frei_bme)
          OVER (
            PARTITION BY
              mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg,
              bezugsweg_id, kjmo, wrg_id
            ORDER BY dat IS NULL, dat
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
          ))
        / EXTRACT(DAY FROM dat) AS d_betrag_vk_brutto_frei_bme,
      (
        SUM(betrag_vk_brutto_qual_bme)
          OVER (
            PARTITION BY
              mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg,
              bezugsweg_id, kjmo, wrg_id
            ORDER BY dat IS NULL, dat
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
          ))
        / EXTRACT(DAY FROM dat) AS d_betrag_vk_brutto_qual_bme
    FROM dbp_msi_data.vis_tag_bestand_wg_2
    WHERE
      (mandant_id, wg_id)
      IN (SELECT (mandant_id, wg_id) FROM dbp_etl.vis_tag_best_wg_wechsel_join_2)
  ) AS tmp
WHERE
  T1.mandant_id = tmp.mandant_id
  AND T1.wup_id = tmp.wup_id
  AND T1.wg_id = tmp.wg_id
  AND T1.abt_id = tmp.abt_id
  AND T1.dat = tmp.dat
  AND T1.arthiertyp_id = tmp.arthiertyp_id
  AND T1.nb_id = tmp.nb_id
  AND T1.relevant_fg = tmp.relevant_fg
  AND T1.bezugsweg_id = tmp.bezugsweg_id
  AND T1.wrg_id = tmp.wrg_id;

-- [OK] statement is translated correctly (syntax and type checks are fine)

TRUNCATE TABLE dbp_etl.vis_tag_bestand_wg_wechsel_log_2;
