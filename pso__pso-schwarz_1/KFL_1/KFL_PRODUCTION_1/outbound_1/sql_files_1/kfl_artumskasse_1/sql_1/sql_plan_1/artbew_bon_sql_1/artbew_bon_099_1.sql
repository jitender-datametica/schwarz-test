CREATE OR REPLACE TABLE dbp_etl.artbew_mis_1(
  mandant_id INTEGER,
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id INTEGER,
  wg_id INTEGER,
  arthiertyp_id INTEGER,
  bewart_id INTEGER,
  dat DATE,
  menge NUMERIC(29, 4),
  wrg_1 STRING(3) COLLATE 'und:ci',
  umsatz_netto NUMERIC(29, 4),
  diff_umsatz_netto_konz NUMERIC(29, 4),
  umsatz_mwst_betrag NUMERIC(29, 4),
  diff_umsatz_mwst_betrag_konz NUMERIC(29, 4));

CREATE OR REPLACE TABLE dbp_etl.`_artbew_tmp`(
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  bewart_id INTEGER NOT NULL,
  gp_id INTEGER,
  einkaufsorganisation_id INTEGER,
  nb_id INTEGER NOT NULL,
  dat DATE NOT NULL,
  aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
  ean_kasse INTEGER NOT NULL,
  herst_id INTEGER,
  wg_id INTEGER,
  mwst_id INTEGER,
  menge NUMERIC(29, 4),
  wrg_1 STRING(3) COLLATE 'und:ci',
  umsatz_netto NUMERIC(29, 4),
  umsatz_mwst_betrag NUMERIC(29, 4),
  ek_brutto NUMERIC(29, 4),
  ek_netto NUMERIC(29, 4),
  ek_nettonetto NUMERIC(29, 4),
  ek_kal_basis NUMERIC(29, 4),
  ek_mep NUMERIC(29, 4),
  einstandspreis NUMERIC(29, 4),
  logkostenzuschlag NUMERIC(29, 4),
  bezugsweg_id INTEGER,
  ek_netto_bnk NUMERIC(29, 4),
  ek_netto_bnk_sachk NUMERIC(29, 4),
  posten_id STRING(2),
  bewart_det_id INTEGER NOT NULL,
  standard_aktion_id STRING(10) COLLATE 'und:ci',
  aktionsart_id_liste_txt STRING(300),
  aktionsart_bez_liste_txt STRING(300),
  aktion_typ_id_liste_txt STRING(300),
  aktion_typ_bez_liste_txt STRING(300),
  loyalty_berechtigt_fg INTEGER DEFAULT 0);

CREATE OR REPLACE TABLE dbp_etl.`_artbew_tmp2`(
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  bewart_id INTEGER NOT NULL,
  gp_id INTEGER,
  einkaufsorganisation_id INTEGER,
  nb_id INTEGER NOT NULL,
  dat DATE NOT NULL,
  aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
  ean_kasse INTEGER NOT NULL,
  herst_id INTEGER,
  wg_id INTEGER,
  mwst_id INTEGER,
  menge NUMERIC(29, 4),
  wrg_1 STRING(3) COLLATE 'und:ci',
  umsatz_netto NUMERIC(29, 4),
  umsatz_mwst_betrag NUMERIC(29, 4),
  ek_brutto NUMERIC(29, 4),
  ek_netto NUMERIC(29, 4),
  ek_nettonetto NUMERIC(29, 4),
  ek_kal_basis NUMERIC(29, 4),
  ek_mep NUMERIC(29, 4),
  einstandspreis NUMERIC(29, 4),
  logkostenzuschlag NUMERIC(29, 4),
  bezugsweg_id INTEGER,
  ek_netto_bnk NUMERIC(29, 4),
  ek_netto_bnk_sachk NUMERIC(29, 4),
  posten_id STRING(2),
  bewart_det_id INTEGER NOT NULL,
  kundenkarte_id STRING(255) COLLATE 'und:ci',
  loyalty_berechtigt_fg INTEGER DEFAULT 0);

CREATE OR REPLACE TABLE dbp_etl.`_artbew_tmp_anr`(
  art_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  gp_id INTEGER,
  faktor_fg INTEGER,
  wg_id INTEGER,
  einkaufsorganisation_id INTEGER,
  dat DATE NOT NULL,
  herst_id INTEGER,
  zekp_dat_von DATE,
  ek_brutto NUMERIC(29, 4),
  ek_netto NUMERIC(29, 4),
  ek_nettonetto NUMERIC(29, 4),
  ek_kal_basis NUMERIC(29, 4),
  ek_mep NUMERIC(29, 4),
  einstandspreis NUMERIC(29, 4),
  logkostenzuschlag NUMERIC(29, 4),
  bezugsweg_id INTEGER,
  ek_netto_bnk NUMERIC(29, 4),
  ek_netto_bnk_sachk NUMERIC(29, 4));

-- -dbay-, 20.11.2023
--
-- neue logik

/* Initialisierung, im Anschluss erfolgt Ermittlung ueber MARC_1 */ /* fuehrend */  -- Ermittlung nb_id

/* fuehrend MWST aus Bondaten */ INSERT INTO dbp_etl.`_artbew_tmp`
  (
    art_id,
    wup_id,
    mandant_id,
    bewart_id,
    nb_id,
    dat,
    aktion_id,
    ean_kasse,
    mwst_id,
    menge,
    wrg_1,
    umsatz_netto,
    umsatz_mwst_betrag,
    bezugsweg_id,
    posten_id,
    bewart_det_id,
    standard_aktion_id,
    aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt,
    loyalty_berechtigt_fg)
    (
      SELECT
        COALESCE(t2.art_id, ERF.art_id, 0),
        CAST(p.wup_id AS INTEGER) AS wup_id,
        CAST(p.mandant_id AS INTEGER) AS mandant_id,
        p.bewart_id,
        W.nb_id,
        p.dat,
        p.aktion_id,
        CAST(COALESCE(p.ean_kasse, 0) AS INTEGER) AS ean_kasse,
        COALESCE(MW.mwst_id, MWS.mwst_id),
        SUM(p.menge) AS menge_,
        'EUR' AS wrg_1,
        ROUND(
          CAST(
            SUM(p.umsatz)
            - SUM(
              p.umsatz
              / (1 + COALESCE(MW.mwst, MWS.mwst) / 100)
              * (COALESCE(MW.mwst, MWS.mwst) / 100))
            AS NUMERIC),
          4) AS umsatz_netto,
        CAST(
          SUM(
            p.umsatz
            / (1 + COALESCE(MW.mwst, MWS.mwst) / 100)
            * (COALESCE(MW.mwst, MWS.mwst) / 100))
          AS NUMERIC) AS umsatz_mwst_betrag,
        COALESCE(AW.bezugsweg_id, p.bezugsweg_id),
        COALESCE(t2.posten_id, '') AS posten_id,
        CAST(p.bewart_det_id AS INTEGER) AS bewart_det_id,
        '' AS standard_aktion_id,
        MAX(p.aktionsart_id),
        MAX(p.aktionsart_bez),
        MAX(p.aktion_typ_id_2),
        MAX(p.aktion_typ_bez),
        CAST(p.loyalty_berechtigt_fg AS INTEGER) AS loyalty_berechtigt_fg
      FROM
        (
          SELECT
            mandant_id,
            wup_id,
            dat,
            kl_art_id,
            ean_kasse,
            wg_id,
            CAST(umsatz_brutto AS FLOAT64) AS umsatz,
            mwst_id,
            menge,
            CASE
              WHEN LTRIM(aktion_id) IN ('0', '0000000000', '')
                THEN 1001  /* aktoinsfrei */
              ELSE 1002  /* Sonderaktion */
              END AS bewart_id,
            CASE
              WHEN LTRIM(aktion_id) IN ('0', '0000000000', '')
                THEN ''
              ELSE aktion_id
              END AS aktion_id,
            4 AS bezugsweg_id,
            COALESCE(
              bewart_det_id_zmp,
              CASE
                WHEN
                  LTRIM(aktion_id) IN ('0', '0000000000', '')
                  AND (
                    kundenkarte_id IS NULL AND kundenkarte_typ_id IN (0)
                    OR kundenkarte_typ_id IN (3, 4))
                  THEN 100110
                ELSE
                  CASE
                    WHEN
                      LTRIM(aktion_id) IN ('0', '0000000000', '')
                      AND kundenkarte_typ_id IN (2)
                      AND kundenkarte_id IS NOT NULL
                      THEN 100111
                    ELSE
                      CASE
                        WHEN
                          LTRIM(bby_aktion) IN ('0', '0000000000', '')
                          AND bby_bewart = 1
                          AND customer_promotion_fg = 0
                          AND TRIM(promotion_art) = 'COMMON'
                          AND (
                            kundenkarte_typ_id IN (0)
                            OR kundenkarte_typ_id IN (3, 4)
                            OR kundenkarte_id IS NOT NULL
                            OR kundenkarte_typ_id IN (1, 2)
                              AND kundenkarte_id IS NOT NULL)
                          AND bonuskauf_id IS NOT NULL
                          THEN 100130
                        WHEN
                          LTRIM(bby_aktion) IN ('0', '0000000000', '')
                          AND bby_bewart = 1
                          AND kundenkarte_typ_id IN (2)
                          AND (
                            customer_promotion_fg
                                = 1
                              AND TRIM(promotion_art) = 'CUSTOMER'
                            OR customer_promotion_fg
                              = 1 AND TRIM(promotion_art) = 'PERSONAL'
                            OR customer_promotion_fg
                              = 0 AND TRIM(promotion_art) = 'COMMON')
                          AND kundenkarte_id
                            IS NOT NULL
                          THEN 100131
                        WHEN
                          (
                            kundenkarte_id IS NULL AND kundenkarte_typ_id IN (0)
                            OR kundenkarte_typ_id IN (3, 4))
                          AND (
                            bonuskauf_id
                              IS NULL
                            OR CAST(bonuskauf_id AS FLOAT64) = 0)
                          AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
                          AND aktion_id_obv IS NOT NULL
                          THEN 100210
                        ELSE
                          CASE
                            WHEN
                              kundenkarte_typ_id IN (2)
                              AND (
                                (important IS NULL OR important = 'N')
                                  AND bonuskauf_id IS NOT NULL
                                OR (important IS NULL OR important = 'Y')
                                  AND (
                                    bonuskauf_id IS NULL
                                    OR CAST(bonuskauf_id AS FLOAT64) = 0))
                              AND LTRIM(aktion_id)
                                NOT IN ('0', '0000000000', '')
                              AND kundenkarte_id IS NOT NULL
                              AND aktion_id_obv IS NOT NULL
                              THEN 100211
                            ELSE
                              CASE
                                WHEN
                                  (
                                    kundenkarte_id IS NULL
                                      AND kundenkarte_typ_id IN (0)
                                    OR kundenkarte_typ_id IN (3, 4))
                                  AND customer_promotion_fg = 0
                                  AND promotion_art = 'COMMON'
                                  AND LTRIM(aktion_id)
                                    NOT IN ('0', '0000000000', '')
                                  AND bonuskauf_id IS NOT NULL
                                  THEN 100220
                                ELSE
                                  CASE
                                    WHEN
                                      kundenkarte_typ_id IN (2)
                                      AND customer_promotion_fg = 0
                                      AND promotion_art = 'COMMON'
                                      AND LTRIM(aktion_id)
                                        NOT IN ('0', '0000000000', '')
                                      AND bonuskauf_id IS NOT NULL
                                      AND kundenkarte_id IS NOT NULL
                                      THEN 100221
                                    ELSE
                                      CASE
                                        WHEN
                                          customer_promotion_fg = 1
                                          AND promotion_art = 'CUSTOMER'
                                          AND LTRIM(aktion_id)
                                            NOT IN ('0', '0000000000', '')
                                          AND bonuskauf_id IS NOT NULL
                                          THEN 100231
                                        ELSE
                                          CASE
                                            WHEN
                                              customer_promotion_fg = 1
                                              AND promotion_art IN (
                                                'PERSONAL', 'XTRA')
                                              AND LTRIM(aktion_id)
                                                NOT IN ('0', '0000000000', '')
                                              AND bonuskauf_id IS NOT NULL
                                              THEN 100241
                                            ELSE 9999
                                            END
                                        END
                                    END
                                END
                            END
                        END
                    END
                END) AS bewart_det_id,
            aktionsart_id,
            aktionsart_bez,
            aktion_typ_id_2,
            aktion_typ_bez,
            loyalty_berechtigt_fg
          FROM dbp_etl.bon_artbew_tmp_talon_1
          WHERE
            dat >= DATE '2022-04-01'
            AND wg_id NOT IN (822)
        ) AS p
      INNER JOIN dbp_data.wup_1 AS W
        ON
          p.mandant_id = W.mandant_id
          AND p.wup_id  -- Ermittlung art_id
            = W.wup_id
      LEFT JOIN
        (
          SELECT
            mandant_id,
            art_id,
            kl_art_id,
            posten_id,
            mwst_id
          FROM dbp_data.art_1
          QUALIFY
            (
              ROW_NUMBER()
                OVER (
                  PARTITION BY mandant_id, kl_art_id
                  ORDER BY art_id IS NULL DESC, art_id DESC
                ))
            = 1
        ) AS t2
        ON p.kl_art_id = t2.kl_art_id AND p.mandant_id = t2.mandant_id
      -- Ermittlung art_id für unbekannte Artikel_1 und alle Artikel_1,
      -- deren Kassen-wg nicht mit der wg_id arthiertyp_1 2 der Stammdaten übereinstimmt
      LEFT JOIN dbp_etl_process.dwh_wg_erfass_artikel_1 AS ERF
        ON
          p.mandant_id = ERF.mandant_id
          AND p.wg_id = ERF.wg_id
          AND ERF.arthiertyp_id
            = 2  -- Ermittlung MWST ID fuer Artikel_1 der WG Erfassung
      LEFT JOIN dbp_data.art_1 AS AERF
        ON ERF.mandant_id = AERF.mandant_id AND ERF.art_id = AERF.art_id
      -- Ermittlung der MWST-ID aus den Bondaten (fuehrend)
      LEFT JOIN dbp_data.mwst_per_1 AS MW
        ON
          p.mandant_id = MW.mandant_id
          AND p.dat BETWEEN MW.dat_von AND MW.dat_bis
          AND p.mwst_id = MW.mwst_id
          AND COALESCE(MW.mwst, 0) <> 0
      -- Ermittlung der MWST-ID aus den Stammdaten (falls in Bondaten nicht korrekt gepflegt
      LEFT JOIN dbp_data.mwst_per_1 AS MWS
        ON
          p.mandant_id = MWS.mandant_id
          AND p.dat BETWEEN MWS.dat_von AND MWS.dat_bis
          AND COALESCE(t2.mwst_id, AERF.mwst_id) = MWS.mwst_id
      -- Ermittlung des Bezugsweges (Default ist 4) aus Stammdaten
      LEFT JOIN dbp_data.art_wup_zu_per_1 AS AW
        ON
          p.mandant_id = AW.mandant_id
          AND p.wup_id = AW.wup_id
          -- Artikelnummer aus Stammdaten!!! s.o.
          AND COALESCE(t2.art_id, ERF.art_id, 0) = AW.art_id
          AND p.dat
            BETWEEN AW.dat_von
            AND AW.dat_bis
      GROUP BY
        p.mandant_id,
        wrg_1,
        p.wup_id,
        W.nb_id,
        p.dat,
        posten_id,
        COALESCE(AW.bezugsweg_id, p.bezugsweg_id),
        COALESCE(t2.art_id, ERF.art_id, 0),
        ean_kasse,
        p.bewart_id,
        COALESCE(MW.mwst_id, MWS.mwst_id),
        p.aktion_id,
        p.bewart_det_id,
        standard_aktion_id,
        p.loyalty_berechtigt_fg
      HAVING menge_ <> 0 OR SUM(p.umsatz) - umsatz_mwst_betrag <> 0
    );

CREATE OR REPLACE TEMPORARY TABLE _artbew_822
AS
SELECT
  mandant_id,
  wup_id,
  dat,
  kl_art_id,
  ean_kasse,
  mwst_id,
  wg_id,
  aktion_id,
  umsatz_brutto,
  menge,
  talon_id,
  talon_id_aus_bon,
  bon_id,
  kundenkarte_id,
  kundenkarte_typ_id,
  bonuskauf_id,
  customer_promotion_fg,
  promotion_art,
  aktion_id_obv,
  bon_zeile,
  stichlogik,
  bby_bewart,
  bby_unique,
  personal_unique,
  personal,
  bby_aktion,
  important,
  loyalty_berechtigt_fg,
  aktionsart_id,
  aktionsart_bez,
  aktion_typ_id_2,
  aktion_typ_bez,
  bewart_det_id_zmp,
  COALESCE(bewart_det_id_zmp, 888888) AS bewart_det_id
FROM dbp_etl.bon_artbew_tmp_talon_1 AS A
WHERE
  dat >= DATE '2022-04-01'
  AND wg_id IN (822);

UPDATE `_artbew_822`
SET
  bewart_det_id = 100111
WHERE important = 'B';

CREATE OR REPLACE TEMPORARY TABLE _track_personal
AS
SELECT
  A.mandant_id,
  A.bon_id,
  A.bon_zeile,
  A.bon_dat,
  A.wup_id,
  A.promotion_art,
  MAX(b.anz) AS anz,
  COUNT(*) AS anz_zeilen,
  MAX(b.bonrabatt) AS bonrabatt
FROM dbp_etl.de_bd_for_promotion_1 AS A
INNER JOIN
  (
    SELECT
      mandant_id,
      bon_id,
      bon_zeile,
      bon_dat,
      wup_id,
      COUNT(DISTINCT promotion_art) AS anz,
      MAX(
        CASE
          WHEN konditionsart_id IN ('ZBON', 'ZBOV')
            THEN 1
          ELSE 0
          END) AS bonrabatt
    FROM dbp_etl.de_bd_for_promotion_1
    GROUP BY
      mandant_id,
      bon_id,
      bon_zeile,
      bon_dat,
      wup_id
  ) AS b
  ON
    A.mandant_id = b.mandant_id
    AND A.bon_id = b.bon_id
    AND A.bon_zeile = b.bon_zeile
    AND A.bon_dat = b.bon_dat
    AND A.wup_id = b.wup_id
WHERE
  (A.mandant_id, A.bon_id, A.bon_zeile, A.bon_dat, A.wup_id)
    IN (
      SELECT (mandant_id, bon_id, bon_zeile, bon_dat, wup_id)
      FROM dbp_etl.de_bd_for_promotion_1
      WHERE promotion_art = 'PERSONAL'
      GROUP BY
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id
    )
  AND A.konditionsart_id NOT IN ('ZRT3', 'ZTAG', 'ZGEB')
GROUP BY
  A.mandant_id,
  A.bon_id,
  A.wup_id,
  A.bon_zeile,
  A.bon_dat,
  A.promotion_art;

-- 1. Update fuer 100231

UPDATE `_artbew_822`
SET
  bewart_det_id = 100231
FROM
  (
    SELECT
      mandant_id,
      bon_id,
      bon_zeile,
      wup_id,
      bon_dat
    FROM `_track_personal`
    WHERE promotion_art = 'CUSTOMER'
    GROUP BY
      mandant_id,
      bon_id,
      bon_zeile,
      bon_dat,
      wup_id
  ) AS t1_1
WHERE
  `_artbew_822`.wup_id = t1.wup_id
  AND `_artbew_822`.mandant_id = t1.mandant_id
  AND `_artbew_822`.dat = t1.bon_dat
  AND `_artbew_822`.bon_id = t1.bon_id
  AND `_artbew_822`.bon_zeile = t1.bon_zeile
  AND `_artbew_822`.bewart_det_id = 888888
  AND `_artbew_822`.wg_id = 822;

UPDATE `_artbew_822`
SET
  bewart_det_id = 100211
FROM
  (
    SELECT
      mandant_id,
      bon_id,
      bon_zeile,
      wup_id,
      bon_dat
    FROM `_track_personal`
    WHERE
      promotion_art = 'PERSONAL' AND anz = 1
      OR promotion_art = 'PERSONAL' AND bonrabatt = 1
    GROUP BY
      mandant_id,
      bon_id,
      bon_zeile,
      bon_dat,
      wup_id
  ) AS t1_1
WHERE
  `_artbew_822`.wup_id = t1.wup_id
  AND `_artbew_822`.mandant_id = t1.mandant_id
  AND `_artbew_822`.dat = t1.bon_dat
  AND `_artbew_822`.bon_id = t1.bon_id
  AND `_artbew_822`.bon_zeile = t1.bon_zeile
  AND `_artbew_822`.bewart_det_id = 888888
  AND `_artbew_822`.bby_aktion <> ''
  AND `_artbew_822`.wg_id = 822
  AND `_artbew_822`.kundenkarte_id
    IS NOT NULL;

-- 2. Update fuer 100221

UPDATE `_artbew_822`
SET
  bewart_det_id = 100221
FROM
  (
    SELECT
      mandant_id,
      bon_id,
      bon_zeile,
      wup_id,
      bon_dat
    FROM `_track_personal`
    WHERE promotion_art = 'COMMON'
    GROUP BY
      mandant_id,
      bon_id,
      bon_zeile,
      bon_dat,
      wup_id
  ) AS t1_1
WHERE
  `_artbew_822`.wup_id = t1.wup_id
  AND `_artbew_822`.mandant_id = t1.mandant_id
  AND `_artbew_822`.dat = t1.bon_dat
  AND `_artbew_822`.bon_id = t1.bon_id
  AND `_artbew_822`.bon_zeile = t1.bon_zeile
  AND `_artbew_822`.bewart_det_id = 888888
  AND `_artbew_822`.wg_id = 822;

-- 3. Update fuer 100211

UPDATE `_artbew_822`
SET
  bewart_det_id = 100211
FROM
  (
    SELECT
      mandant_id,
      bon_id,
      bon_zeile,
      wup_id,
      bon_dat
    FROM `_track_personal`
    WHERE promotion_art = 'PERSONAL_SMP'
    GROUP BY
      mandant_id,
      bon_id,
      bon_zeile,
      bon_dat,
      wup_id
  ) AS t1_1
WHERE
  `_artbew_822`.wup_id = t1.wup_id
  AND `_artbew_822`.mandant_id = t1.mandant_id
  AND `_artbew_822`.dat = t1.bon_dat
  AND `_artbew_822`.bon_id = t1.bon_id
  AND `_artbew_822`.bon_zeile = t1.bon_zeile
  AND `_artbew_822`.bewart_det_id = 888888
  AND `_artbew_822`.bby_aktion <> ''
  AND `_artbew_822`.wg_id = 822;

UPDATE `_artbew_822`
SET
  bewart_det_id = 100241
FROM
  (
    SELECT
      mandant_id,
      bon_id,
      bon_zeile,
      wup_id,
      bon_dat
    FROM `_track_personal`
    WHERE
      promotion_art IN ('PERSONAL', 'XTRA')
      AND anz_zeilen > 1
      AND anz = 1
      AND bonrabatt = 0
    GROUP BY
      mandant_id,
      bon_id,
      bon_zeile,
      bon_dat,
      wup_id
  ) AS t1_1
WHERE
  `_artbew_822`.wup_id = t1.wup_id
  AND `_artbew_822`.mandant_id = t1.mandant_id
  AND `_artbew_822`.dat = t1.bon_dat
  AND `_artbew_822`.bon_id = t1.bon_id
  AND `_artbew_822`.bon_zeile = t1.bon_zeile
  AND `_artbew_822`.bewart_det_id = 888888
  AND `_artbew_822`.bby_aktion <> ''
  AND `_artbew_822`.wg_id = 822;

-- 4. Update fuer 100131

UPDATE `_artbew_822`
SET
  bewart_det_id = 100131
FROM
  (
    SELECT
      mandant_id,
      bon_id,
      bon_zeile,
      wup_id,
      bon_dat
    FROM `_track_personal`
    WHERE
      promotion_art IN ('PERSONAL', 'PERSONAL_SMP', 'CUSTOMER', 'COMMON')
      AND bonrabatt = 1
    GROUP BY
      mandant_id,
      bon_id,
      bon_zeile,
      bon_dat,
      wup_id
  ) AS t1_1
WHERE
  `_artbew_822`.wup_id = t1.wup_id
  AND `_artbew_822`.mandant_id = t1.mandant_id
  AND `_artbew_822`.dat = t1.bon_dat
  AND `_artbew_822`.bon_id = t1.bon_id
  AND `_artbew_822`.bon_zeile = t1.bon_zeile
  AND `_artbew_822`.bewart_det_id = 888888
  AND `_artbew_822`.bby_aktion = ''
  AND `_artbew_822`.wg_id = 822;

-- 5. Update fuer 100121

UPDATE `_artbew_822`
SET
  bewart_det_id = 100121
FROM
  (
    SELECT
      mandant_id,
      bon_id,
      bon_zeile,
      wup_id,
      bon_dat
    FROM `_track_personal`
    WHERE promotion_art IN ('PERSONAL_SMP')
    GROUP BY
      mandant_id,
      bon_id,
      bon_zeile,
      bon_dat,
      wup_id
  ) AS t1_1
WHERE
  `_artbew_822`.wup_id = t1.wup_id
  AND `_artbew_822`.mandant_id = t1.mandant_id
  AND `_artbew_822`.dat = t1.bon_dat
  AND `_artbew_822`.bon_id = t1.bon_id
  AND `_artbew_822`.bon_zeile = t1.bon_zeile
  AND `_artbew_822`.bewart_det_id = 888888
  AND `_artbew_822`.bby_aktion = ''
  AND `_artbew_822`.wg_id = 822;

-- 6. Update fuer 100211

UPDATE `_artbew_822`
SET
  bewart_det_id = 100211
FROM
  (
    SELECT
      mandant_id,
      bon_id,
      bon_zeile,
      wup_id,
      bon_dat
    FROM `_track_personal`
    GROUP BY
      mandant_id,
      bon_id,
      bon_zeile,
      bon_dat,
      wup_id
  ) AS t0
WHERE
  `_artbew_822`.wup_id = t0.wup_id
  AND `_artbew_822`.mandant_id = t0.mandant_id
  AND `_artbew_822`.dat = t0.bon_dat
  AND `_artbew_822`.bon_id = t0.bon_id
  AND `_artbew_822`.bon_zeile = t0.bon_zeile
  AND `_artbew_822`.bewart_det_id = 888888
  AND `_artbew_822`.bby_aktion <> ''
  AND `_artbew_822`.wg_id = 822;

CREATE OR REPLACE TEMPORARY TABLE _snap_822
AS
SELECT
  t5.mandant_id,
  t5.wrg_1,
  t5.wup_id,
  t5.nb_id,
  t5.dat,
  t5.posten_id,
  t5.bezugsweg_id,
  t5.art_id,
  t5.ean_kasse,
  t5.bewart_id,
  t5.mwst_id,
  t5.aktion_id,
  t5.menge_,
  t5.umsatz_mwst_betrag,
  t5.a1 - t5.umsatz_mwst_betrag AS umsatz_netto,
  t5.bewart_det_id,
  t5.standard_aktion_id,
  t5.aktionsart_id,
  t5.aktionsart_bez,
  t5.aktion_typ_id_2,
  t5.aktion_typ_bez,
  t5.loyalty_berechtigt_fg
FROM
  (
    SELECT
      p.mandant_id,
      'EUR' AS wrg_1,
      p.wup_id,
      W.nb_id,
      p.dat,
      COALESCE(t2.posten_id, '') AS posten_id,
      COALESCE(AW.bezugsweg_id, p.bezugsweg_id) AS bezugsweg_id,
      COALESCE(t2.art_id, ERF.art_id, 0) AS art_id,
      COALESCE(p.ean_kasse, 0) AS ean_kasse,
      p.bewart_id,
      COALESCE(MW.mwst_id, MWS.mwst_id) AS mwst_id,
      p.aktion_id,
      p.bewart_det_id,
      '' AS standard_aktion_id,
      p.loyalty_berechtigt_fg,
      SUM(p.menge) AS menge_,
      SUM(
        p.umsatz
        / (1 + COALESCE(MW.mwst, MWS.mwst) / 100)
        * (COALESCE(MW.mwst, MWS.mwst) / 100)) AS umsatz_mwst_betrag,
      SUM(p.umsatz) AS a1,
      MAX(p.aktionsart_id) AS aktionsart_id,
      MAX(p.aktionsart_bez) AS aktionsart_bez,
      MAX(p.aktion_typ_id_2) AS aktion_typ_id_2,
      MAX(p.aktion_typ_bez) AS aktion_typ_bez
    FROM
      (
        SELECT
          mandant_id,
          wup_id,
          dat,
          kl_art_id,
          ean_kasse,
          wg_id,
          CAST(umsatz_brutto AS FLOAT64) AS umsatz,
          mwst_id,
          menge,
          CASE
            WHEN LTRIM(aktion_id) IN ('0', '0000000000', '')
              THEN 1001
            ELSE 1002
            END AS bewart_id,
          CASE
            WHEN LTRIM(aktion_id) IN ('0', '0000000000', '')
              THEN ''
            ELSE aktion_id
            END AS aktion_id,
          4 AS bezugsweg_id,
          CASE
            WHEN bewart_det_id <> 888888
              THEN bewart_det_id
            WHEN
              LTRIM(aktion_id) IN ('0', '0000000000', '')
              AND (
                kundenkarte_id IS NULL AND kundenkarte_typ_id IN (0)
                OR kundenkarte_typ_id IN (3, 4))
              THEN 100110
            WHEN
              LTRIM(aktion_id) IN ('0', '0000000000', '')
              AND kundenkarte_typ_id IN (2)
              AND kundenkarte_id IS NOT NULL
              THEN 100111
            WHEN
              LTRIM(bby_aktion) IN ('0', '0000000000', '')
              AND bby_bewart = 1
              AND customer_promotion_fg = 0
              AND TRIM(promotion_art) = 'COMMON'
              AND (
                kundenkarte_typ_id IN (0, 3, 4)
                OR kundenkarte_id IS NOT NULL
                OR kundenkarte_typ_id IN (1, 2) AND kundenkarte_id IS NOT NULL)
              AND bonuskauf_id IS NOT NULL
              THEN 100130
            WHEN
              LTRIM(bby_aktion) IN ('0', '0000000000', '')
              AND bby_bewart = 1
              AND kundenkarte_typ_id IN (2)
              AND (
                customer_promotion_fg
                    = 1
                  AND TRIM(promotion_art) = 'CUSTOMER'
                OR customer_promotion_fg
                  = 1 AND TRIM(promotion_art) = 'PERSONAL'
                OR customer_promotion_fg = 0 AND TRIM(promotion_art) = 'COMMON')
              AND kundenkarte_id IS NOT NULL
              THEN 100131
            WHEN
              (
                kundenkarte_id IS NULL AND kundenkarte_typ_id IN (0)
                OR kundenkarte_typ_id IN (3, 4))
              AND (bonuskauf_id IS NULL OR CAST(bonuskauf_id AS FLOAT64) = 0)
              AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
              AND aktion_id_obv IS NOT NULL
              THEN 100210
            WHEN
              kundenkarte_typ_id IN (2)
              AND (
                (important IS NULL OR important = 'N')
                  AND bonuskauf_id IS NOT NULL
                OR (important IS NULL OR important = 'Y')
                  AND (
                    bonuskauf_id IS NULL OR CAST(bonuskauf_id AS FLOAT64) = 0))
              AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
              AND kundenkarte_id IS NOT NULL
              AND aktion_id_obv IS NOT NULL
              THEN 100211
            WHEN
              (
                kundenkarte_id IS NULL AND kundenkarte_typ_id IN (0)
                OR kundenkarte_typ_id IN (3, 4))
              AND customer_promotion_fg = 0
              AND promotion_art = 'COMMON'
              AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
              AND bonuskauf_id IS NOT NULL
              THEN 100220
            WHEN
              kundenkarte_typ_id IN (2)
              AND customer_promotion_fg = 0
              AND promotion_art = 'COMMON'
              AND LTRIM(aktion_id)
                NOT IN ('0', '0000000000', '')
              AND bonuskauf_id IS NOT NULL
              AND kundenkarte_id IS NOT NULL
              THEN 100221
            WHEN
              customer_promotion_fg = 1
              AND promotion_art = 'CUSTOMER'
              AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
              AND bonuskauf_id IS NOT NULL
              THEN 100231
            WHEN
              customer_promotion_fg = 1
              AND promotion_art IN ('PERSONAL', 'XTRA')
              AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
              AND bonuskauf_id IS NOT NULL
              THEN 100241
            ELSE 9999
            END AS bewart_det_id,
          aktionsart_id,
          aktionsart_bez,
          aktion_typ_id_2,
          aktion_typ_bez,
          loyalty_berechtigt_fg
        FROM `_artbew_822` AS X
        WHERE
          dat >= DATE '2022-04-01'
          AND wg_id IN (822)
      ) AS p
    INNER JOIN dbp_data.wup_1 AS W
      ON p.mandant_id = W.mandant_id AND p.wup_id = W.wup_id
    LEFT JOIN
      (
        SELECT
          mandant_id,
          art_id,
          kl_art_id,
          posten_id,
          mwst_id
        FROM dbp_data.art_1
        QUALIFY
          (
            ROW_NUMBER()
              OVER (
                PARTITION BY mandant_id, kl_art_id
                ORDER BY art_id IS NULL DESC, art_id DESC
              ))
          = 1
      ) AS t2
      ON p.kl_art_id = t2.kl_art_id AND p.mandant_id = t2.mandant_id
    LEFT JOIN dbp_etl_process.dwh_wg_erfass_artikel_1 AS ERF
      ON
        p.mandant_id = ERF.mandant_id
        AND p.wg_id = ERF.wg_id
        AND ERF.arthiertyp_id = 2
    LEFT JOIN dbp_data.art_1 AS AERF
      ON ERF.mandant_id = AERF.mandant_id AND ERF.art_id = AERF.art_id
    LEFT JOIN dbp_data.mwst_per_1 AS MW
      ON
        p.mandant_id = MW.mandant_id
        AND p.dat BETWEEN MW.dat_von AND MW.dat_bis
        AND p.mwst_id = MW.mwst_id
        AND COALESCE(MW.mwst, 0) <> 0
    LEFT JOIN dbp_data.mwst_per_1 AS MWS
      ON
        p.mandant_id = MWS.mandant_id
        AND p.dat BETWEEN MWS.dat_von AND MWS.dat_bis
        AND COALESCE(t2.mwst_id, AERF.mwst_id) = MWS.mwst_id
    LEFT JOIN dbp_data.art_wup_zu_per_1 AS AW
      ON
        p.mandant_id = AW.mandant_id
        AND p.wup_id = AW.wup_id
        AND COALESCE(t2.art_id, ERF.art_id, 0) = AW.art_id
        AND p.dat BETWEEN AW.dat_von AND AW.dat_bis
    GROUP BY
      p.mandant_id,
      wrg_1,
      p.wup_id,
      W.nb_id,
      p.dat,
      posten_id,
      bezugsweg_id,
      art_id,
      ean_kasse,
      p.bewart_id,
      mwst_id,
      p.aktion_id,
      p.bewart_det_id,
      standard_aktion_id,
      p.loyalty_berechtigt_fg
    HAVING menge_ <> 0 OR a1 - umsatz_mwst_betrag <> 0
  ) AS t5;

INSERT INTO dbp_etl.`_artbew_tmp`
  (
    art_id,
    wup_id,
    mandant_id,
    bewart_id,
    nb_id,
    dat,
    aktion_id,
    ean_kasse,
    mwst_id,
    menge,
    wrg_1,
    umsatz_netto,
    umsatz_mwst_betrag,
    bezugsweg_id,
    posten_id,
    bewart_det_id,
    standard_aktion_id,
    aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt,
    loyalty_berechtigt_fg)
    (
      SELECT
        art_id,
        CAST(wup_id AS INTEGER) AS wup_id,
        CAST(mandant_id AS INTEGER) AS mandant_id,
        bewart_id,
        nb_id,
        dat,
        aktion_id,
        CAST(ean_kasse AS INTEGER) AS ean_kasse,
        mwst_id,
        menge_,
        wrg_1,
        ROUND(CAST(umsatz_netto AS NUMERIC), 4) AS umsatz_netto,
        CAST(umsatz_mwst_betrag AS NUMERIC),
        bezugsweg_id,
        posten_id,
        CAST(bewart_det_id AS INTEGER) AS bewart_det_id,
        standard_aktion_id,
        aktionsart_id,
        aktionsart_bez,
        aktion_typ_id_2,
        aktion_typ_bez,
        CAST(loyalty_berechtigt_fg AS INTEGER) AS loyalty_berechtigt_fg
      FROM `_snap_822`
    );

UPDATE dbp_etl.`_artbew_tmp`
SET
  bewart_id = 1001
WHERE bewart_det_id IN (100110, 100111, 100121, 100130, 100131);

UPDATE dbp_etl.`_artbew_tmp`
SET
  bewart_id = 1001,
  bewart_det_id = 100121
FROM
  (
    SELECT
      t7.mandant_id,
      t7.bon_dat,
      t7.wup_id,
      t7.art_id
    FROM
      (
        SELECT
          A.mandant_id,
          A.bon_id,
          A.wup_id,
          A.bon_zeile,
          A.bon_dat,
          t0.art_id,
          COUNT(DISTINCT A.promotion_art)
        FROM dbp_etl.de_bd_for_promotion_1 AS A
        INNER JOIN
          (
            SELECT
              mandant_id,
              art_id,
              kl_art_id
            FROM dbp_data.art_1
            QUALIFY
              (
                ROW_NUMBER()
                  OVER (
                    PARTITION BY mandant_id, kl_art_id
                    ORDER BY art_id IS NULL DESC, art_id DESC
                  ))
              = 1
          ) AS t0
          ON A.mandant_id = t0.mandant_id AND A.kl_art_id = t0.kl_art_id
        WHERE
          (A.mandant_id, A.bon_id, A.bon_zeile, A.bon_dat, A.wup_id)
          IN (
            SELECT (mandant_id, bon_id, bon_zeile, bon_dat, wup_id)
            FROM dbp_etl.de_bd_for_promotion_1
            WHERE promotion_art IN ('PERSONAL_SMP')
            GROUP BY
              mandant_id,
              bon_id,
              bon_zeile,
              bon_dat,
              wup_id
          )
        GROUP BY
          A.mandant_id,
          A.bon_id,
          A.wup_id,
          A.bon_zeile,
          A.bon_dat,
          t0.art_id
        HAVING COUNT(DISTINCT A.promotion_art) = 1
      ) AS t7
    GROUP BY
      t7.mandant_id,
      t7.wup_id,
      t7.bon_dat,
      t7.art_id
  ) AS b
WHERE
  `_artbew_tmp`.mandant_id = b.mandant_id
  AND `_artbew_tmp`.art_id = b.art_id
  AND `_artbew_tmp`.dat = b.bon_dat
  AND `_artbew_tmp`.wup_id = b.wup_id
  AND `_artbew_tmp`.bewart_det_id = 9999
  AND `_artbew_tmp`.bewart_id = 1002;

INSERT INTO dbp_etl.`_artbew_tmp_anr`
  (art_id, mandant_id, wg_id, dat, bezugsweg_id)
    (
      SELECT
        A.art_id,
        A.mandant_id,
        W.wg_id,
        A.dat,
        A.bezugsweg_id
      FROM dbp_etl.`_artbew_tmp` AS A
      INNER JOIN dbp_data.art_wg_zu_per_1 AS W
        ON
          A.mandant_id = W.mandant_id
          AND A.art_id = W.art_id
          AND W.dat_bis = PARSE_DATE('%F', '9999-12-31')
          AND W.arthiertyp_id = 2
      GROUP BY
        A.art_id,
        A.mandant_id,
        A.dat,
        A.bezugsweg_id,
        W.wg_id
    );

CREATE OR REPLACE TEMPORARY TABLE _xxx
AS (
  SELECT
    T2.mandant_id,
    T2.gp_id,
    T2.wup_id,
    T2.nb_id,
    T2.dat_von,
    T2.bezugsweg_id,
    T2.art_id,
    T2.einkaufsorganisation_id,
    T2.dat_bis,
    T2.ek_brutto,
    T2.ek_netto,
    T2.ek_nettonetto,
    T2.ek_kal_basis,
    T2.ek_mep,
    T2.einstandspreis,
    T2.logistikkostenzuschlag,
    T2.wrg_id,
    T2.komponentenmenge,
    T2.ek_brutto_nrfb_rab,
    T2.bonusbasis,
    T2.bezugsnebenkosten,
    T2.zollwert,
    T2.ek_netto_bnk,
    T2.ek_netto_bnk_sachk,
    T2.cycle_id,
    T2.td_insert,
    T2.td_update,
    T2.ek_mep_vor_fwu,
    T2.ek_brutto_normal
  FROM dbp_etl.`_artbew_tmp_anr` AS T1_1
  INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS T2
    ON
      T1.mandant_id = T2.mandant_id
      AND T1.art_id = T2.art_id
      AND T1.dat BETWEEN T2.dat_von AND T2.dat_bis
  WHERE T2.wup_id = -1
  UNION DISTINCT
  SELECT
    T2.mandant_id,
    T2.gp_id,
    T2.wup_id,
    T2.nb_id,
    T2.dat_von,
    T2.bezugsweg_id,
    T2.art_id,
    T2.einkaufsorganisation_id,
    T2.dat_bis,
    T2.ek_brutto,
    T2.ek_netto,
    T2.ek_nettonetto,
    T2.ek_kal_basis,
    T2.ek_mep,
    T2.einstandspreis,
    T2.logistikkostenzuschlag,
    T2.wrg_id,
    T2.komponentenmenge,
    T2.ek_brutto_nrfb_rab,
    T2.bonusbasis,
    T2.bezugsnebenkosten,
    T2.zollwert,
    T2.ek_netto_bnk,
    T2.ek_netto_bnk_sachk,
    T2.cycle_id,
    T2.td_insert,
    T2.td_update,
    T2.ek_mep_vor_fwu,
    T2.ek_brutto_normal
  FROM dbp_etl.`_artbew_tmp_anr` AS T1_1
  INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS T2
    ON
      T1.mandant_id = T2.mandant_id
      AND T1.art_id = T2.art_id
      AND T1.dat BETWEEN T2.dat_von AND T2.dat_bis
  WHERE
    T2.wup_id = 6906
    AND (T1.mandant_id, T1.wg_id)
      NOT IN (
        SELECT (mandant_id, wg_id)
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 20
        GROUP BY
          mandant_id,
          wg_id
      )
)
UNION DISTINCT
SELECT
  T2.mandant_id,
  T2.gp_id,
  T2.wup_id,
  T2.nb_id,
  T2.dat_von,
  T2.bezugsweg_id,
  T2.art_id,
  T2.einkaufsorganisation_id,
  T2.dat_bis,
  T2.ek_brutto,
  T2.ek_netto,
  T2.ek_nettonetto,
  T2.ek_kal_basis,
  T2.ek_mep,
  T2.einstandspreis,
  T2.logistikkostenzuschlag,
  T2.wrg_id,
  T2.komponentenmenge,
  T2.ek_brutto_nrfb_rab,
  T2.bonusbasis,
  T2.bezugsnebenkosten,
  T2.zollwert,
  T2.ek_netto_bnk,
  T2.ek_netto_bnk_sachk,
  T2.cycle_id,
  T2.td_insert,
  T2.td_update,
  T2.ek_mep_vor_fwu,
  T2.ek_brutto_normal
FROM dbp_etl.`_artbew_tmp_anr` AS T1_1
INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS T2
  ON
    T1.mandant_id = T2.mandant_id
    AND T1.art_id = T2.art_id
    AND T1.dat BETWEEN T2.dat_von AND T2.dat_bis
WHERE
  T2.wup_id = 6907
  AND (T1.mandant_id, T1.wg_id)
    IN (
      SELECT (mandant_id, wg_id)
      FROM dbp_data.wg_filter_zu_1
      WHERE wg_filter_id = 20
      GROUP BY
        mandant_id,
        wg_id
    );

UPDATE dbp_etl.`_artbew_tmp_anr`
SET
  herst_id = dt1.`_herst_id`,
  gp_id = dt1.`_gp_id`,
  einkaufsorganisation_id = COALESCE(dt1.`_einkaufsorganisation_id`, 1000),
  ek_brutto = CAST(
    CASE
      WHEN dt1.`_ek_brutto` IS NOT NULL
        THEN CAST(dt1.`_ek_brutto` AS NUMERIC)
      ELSE NULL
      END AS NUMERIC),
  ek_netto = CAST(
    CASE
      WHEN dt1.`_ek_netto` IS NOT NULL
        THEN CAST(dt1.`_ek_netto` AS NUMERIC)
      ELSE NULL
      END AS NUMERIC),
  ek_nettonetto = CAST(
    CASE
      WHEN dt1.`_ek_nettonetto` IS NOT NULL
        THEN CAST(dt1.`_ek_nettonetto` AS NUMERIC)
      ELSE NULL
      END AS NUMERIC),
  ek_kal_basis = CAST(
    CASE
      WHEN dt1.`_ek_kal_basis` IS NOT NULL
        THEN CAST(dt1.`_ek_kal_basis` AS NUMERIC)
      ELSE NULL
      END AS NUMERIC),
  ek_mep = CAST(
    CASE
      WHEN dt1.`_ek_mep` IS NOT NULL
        THEN CAST(dt1.`_ek_mep` AS NUMERIC)
      ELSE NULL
      END AS NUMERIC),
  einstandspreis = CAST(
    CASE
      WHEN dt1.`_einstandspreis` IS NOT NULL
        THEN CAST(dt1.`_einstandspreis` AS NUMERIC)
      ELSE NULL
      END AS NUMERIC),
  logkostenzuschlag = CAST(
    CASE
      WHEN dt1.`_logkostenzuschlag` IS NOT NULL
        THEN dt1.`_logkostenzuschlag`
      ELSE NULL
      END AS NUMERIC),
  ek_netto_bnk = CAST(
    CASE
      WHEN dt1.`_ek_netto_bnk` IS NOT NULL
        THEN CAST(dt1.`_ek_netto_bnk` AS NUMERIC)
      ELSE NULL
      END AS NUMERIC),
  ek_netto_bnk_sachk = CAST(
    CASE
      WHEN dt1.`_ek_netto_bnk_sachk` IS NOT NULL
        THEN CAST(dt1.`_ek_netto_bnk_sachk` AS NUMERIC)
      ELSE NULL
      END AS NUMERIC)
FROM
  (
    SELECT
      T1.mandant_id AS `_mandant_id`,
      T1.art_id AS `_art_id`,
      T1.bezugsweg_id AS `_bezugsweg_id`,
      T1.dat AS `_dat`,
      COALESCE(T4.herst_id, T2.gp_id, -1) AS `_herst_id`,
      COALESCE(T2.gp_id, -1) AS `_gp_id`,
      T2.einkaufsorganisation_id AS `_einkaufsorganisation_id`,
      T2.ek_brutto AS `_ek_brutto`,
      T2.ek_netto AS `_ek_netto`,
      T2.ek_nettonetto AS `_ek_nettonetto`,
      T2.ek_kal_basis AS `_ek_kal_basis`,
      T2.ek_mep AS `_ek_mep`,
      T2.einstandspreis AS `_einstandspreis`,
      T2.logistikkostenzuschlag AS `_logkostenzuschlag`,
      T2.ek_netto_bnk AS `_ek_netto_bnk`,
      T2.ek_netto_bnk_sachk AS `_ek_netto_bnk_sachk`
    FROM dbp_etl.`_artbew_tmp_anr` AS T1_1
    LEFT JOIN `_xxx` AS T2
      ON
        T1.mandant_id = T2.mandant_id
        AND T1.art_id = T2.art_id
        AND T1.dat
          BETWEEN T2.dat_von
          AND T2.dat_bis  -- Ermittelung der Hersteller_id
    LEFT JOIN dbp_data.art_gp_zu_per_1 AS T4
      ON
        T1.mandant_id = T4.mandant_id
        AND T1.art_id = T4.art_id
        AND T1.dat BETWEEN T4.dat_von AND T4.dat_bis
    WHERE T1.mandant_id = 1
    QUALIFY
      (
        ROW_NUMBER()
          OVER (
            PARTITION BY `_mandant_id`, `_art_id`, `_bezugsweg_id`, `_dat`
            ORDER BY
              CASE
                WHEN
                  T1.bezugsweg_id = 1 AND T2.wup_id = -1
                  OR T1.bezugsweg_id = 4 AND T2.wup_id <> -1
                  THEN 1
                ELSE 0
                END
              IS NULL DESC,
              CASE
                WHEN
                  T1.bezugsweg_id = 1 AND T2.wup_id = -1
                  OR T1.bezugsweg_id = 4 AND T2.wup_id <> -1
                  THEN 1
                ELSE 0
                END DESC,
              T2.dat_von IS NULL DESC, T2.dat_von DESC,
              CAST(T2.ek_brutto AS NUMERIC) IS NULL DESC,
              CAST(T2.ek_brutto AS NUMERIC) DESC,
              T2.gp_id IS NULL, T2.gp_id
          ))
      = 1
  ) AS dt1
WHERE
  `_artbew_tmp_anr`.mandant_id = dt1.`_mandant_id`
  AND `_artbew_tmp_anr`.art_id = dt1.`_art_id`
  AND `_artbew_tmp_anr`.bezugsweg_id = dt1.`_bezugsweg_id`
  AND `_artbew_tmp_anr`.dat = dt1.`_dat`;

UPDATE dbp_etl.`_artbew_tmp_anr`
SET
  faktor_fg = 1,
  ek_brutto = dt1.zwge,
  ek_netto = dt1.zwge,
  ek_nettonetto = dt1.zwgm,
  ek_kal_basis = dt1.zwgm,
  ek_mep = dt1.zwgm,
  einstandspreis = dt1.zwgs,
  logkostenzuschlag = 0,
  ek_netto_bnk = dt1.zwge,
  ek_netto_bnk_sachk = dt1.zwgm
FROM
  (
    SELECT
      T0.mandant_id AS `_mandant_id`,
      T0.art_id AS `_art_id`,
      T0.dat AS `_dat`,
      MAX(T1.ek_faktor) AS zwgs,
      MAX(COALESCE(T2.ek_faktor, T1.ek_faktor)) AS zwgm,
      MAX(COALESCE(T3.ek_faktor, T2.ek_faktor, T1.ek_faktor)) AS zwge
    FROM dbp_etl.`_artbew_tmp_anr` AS T0
    INNER JOIN dbp_data.art_man_spanne_per_1 AS T1_1
      ON
        T0.mandant_id = T1.mandant_id
        AND T0.art_id = T1.art_id
        AND T0.dat BETWEEN T1.dat_von AND T1.dat_bis
        AND T1.konditionsart_id = 'ZWGS'
        AND T1.loesch_fg = 0
    LEFT JOIN dbp_data.art_man_spanne_per_1 AS T2
      ON
        T0.mandant_id = T2.mandant_id
        AND T0.art_id = T2.art_id
        AND T0.dat BETWEEN T2.dat_von AND T2.dat_bis
        AND T2.konditionsart_id = 'ZWGM'
        AND T2.loesch_fg = 0
    LEFT JOIN dbp_data.art_man_spanne_per_1 AS T3
      ON
        T0.mandant_id = T3.mandant_id
        AND T0.art_id = T3.art_id
        AND T0.dat BETWEEN T3.dat_von AND T3.dat_bis
        AND T3.konditionsart_id = 'ZWGE'
        AND T3.loesch_fg = 0
    GROUP BY
      `_mandant_id`,
      `_art_id`,
      `_dat`
  ) AS dt1
WHERE
  `_artbew_tmp_anr`.mandant_id = dt1.`_mandant_id`
  AND `_artbew_tmp_anr`.art_id = dt1.`_art_id`
  AND `_artbew_tmp_anr`.dat = dt1.`_dat`;

UPDATE dbp_etl.`_artbew_tmp`
SET
  herst_id = t1.`_herst_id`,
  gp_id = t1.`_gp_id`,
  einkaufsorganisation_id = t1.`_einkaufsorganisation_id`
    -- Wenn mit EKS aus der ZEKP_1 angereichert werden soll, so ist das "faktor_fg" NULL
    ,
  ek_brutto = CAST(
    COALESCE(
      `_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_brutto`,
      `_artbew_tmp`.menge * t1.`_ek_brutto`)
    AS NUMERIC),
  ek_netto = CAST(
    COALESCE(
      `_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_netto`,
      `_artbew_tmp`.menge * t1.`_ek_netto`)
    AS NUMERIC),
  ek_nettonetto = CAST(
    COALESCE(
      `_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_nettonetto`,
      `_artbew_tmp`.menge * t1.`_ek_nettonetto`)
    AS NUMERIC),
  ek_kal_basis = CAST(
    COALESCE(
      `_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_kal_basis`,
      `_artbew_tmp`.menge * t1.`_ek_kal_basis`)
    AS NUMERIC),
  ek_mep = CAST(
    COALESCE(
      `_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_mep`,
      `_artbew_tmp`.menge * t1.`_ek_mep`)
    AS NUMERIC),
  einstandspreis = CAST(
    COALESCE(
      `_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_einstandspreis`,
      `_artbew_tmp`.menge * t1.`_einstandspreis`)
    AS NUMERIC),
  logkostenzuschlag = CAST(
    COALESCE(
      `_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_logkostenzuschlag`,
      `_artbew_tmp`.menge * t1.`_logkostenzuschlag`)
    AS NUMERIC),
  ek_netto_bnk = CAST(
    COALESCE(
      `_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_netto_bnk`,
      `_artbew_tmp`.menge * t1.`_ek_netto_bnk`)
    AS NUMERIC),
  ek_netto_bnk_sachk = CAST(
    COALESCE(
      `_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_netto_bnk_sachk`,
      `_artbew_tmp`.menge * t1.`_ek_netto_bnk_sachk`)
    AS NUMERIC),
  wg_id = t1.`_wg_id`
FROM
  (
    SELECT
      mandant_id AS `_mandant_id`,
      art_id AS `_art_id`,
      bezugsweg_id AS `_bezugsweg_id`,
      dat AS `_dat`,
      herst_id AS `_herst_id`,
      wg_id AS `_wg_id`,
      gp_id AS `_gp_id`,
      einkaufsorganisation_id AS `_einkaufsorganisation_id`,
      ek_brutto AS `_ek_brutto`,
      ek_netto AS `_ek_netto`,
      ek_nettonetto AS `_ek_nettonetto`,
      ek_kal_basis AS `_ek_kal_basis`,
      ek_mep AS `_ek_mep`,
      einstandspreis AS `_einstandspreis`,
      logkostenzuschlag AS `_logkostenzuschlag`,
      ek_netto_bnk AS `_ek_netto_bnk`,
      ek_netto_bnk_sachk AS `_ek_netto_bnk_sachk`,
      faktor_fg AS `_faktor_fg`
    FROM dbp_etl.`_artbew_tmp_anr`
  ) AS t1_1
WHERE
  `_artbew_tmp`.mandant_id = t1.`_mandant_id`
  AND `_artbew_tmp`.art_id = t1.`_art_id`
  AND `_artbew_tmp`.bezugsweg_id
    = t1.`_bezugsweg_id`
  AND `_artbew_tmp`.dat = t1.`_dat`;

UPDATE dbp_etl.`_artbew_tmp`
SET
  ek_brutto = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwge AS NUMERIC),
  ek_netto = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwge AS NUMERIC),
  ek_nettonetto = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwgm AS NUMERIC),
  ek_kal_basis = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwgm AS NUMERIC),
  ek_mep = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwgm AS NUMERIC),
  einstandspreis = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwgs AS NUMERIC),
  logkostenzuschlag = 0,
  ek_netto_bnk = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwge AS NUMERIC),
  ek_netto_bnk_sachk = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwgm AS NUMERIC)
FROM
  (
    SELECT
      T0.mandant_id AS `_mandant_id`,
      T0.art_id AS `_art_id`,
      T0.wup_id AS `_wup_id`,
      T0.dat AS `_dat`,
      MAX(T1.ek_faktor) AS zwgs,
      MAX(COALESCE(T2.ek_faktor, T1.ek_faktor)) AS zwgm,
      MAX(COALESCE(T3.ek_faktor, T2.ek_faktor, T1.ek_faktor)) AS zwge
    FROM dbp_etl.`_artbew_tmp` AS T0
    INNER JOIN dbp_data.art_wup_man_spanne_per_1 AS T1_1
      ON
        T0.mandant_id = T1.mandant_id
        AND T0.art_id = T1.art_id
        AND T0.wup_id = T1.wup_id
        AND T0.dat BETWEEN T1.dat_von AND T1.dat_bis
        AND T1.konditionsart_id = 'ZWGS'
        AND T1.loesch_fg = 0
    LEFT JOIN dbp_data.art_wup_man_spanne_per_1 AS T2
      ON
        T0.mandant_id = T2.mandant_id
        AND T0.art_id = T2.art_id
        AND T0.wup_id = T2.wup_id
        AND T0.dat BETWEEN T2.dat_von AND T2.dat_bis
        AND T2.konditionsart_id = 'ZWGM'
        AND T2.loesch_fg = 0
    LEFT JOIN dbp_data.art_wup_man_spanne_per_1 AS T3
      ON
        T0.mandant_id = T3.mandant_id
        AND T0.art_id = T3.art_id
        AND T0.wup_id = T3.wup_id
        AND T0.dat BETWEEN T3.dat_von AND T3.dat_bis
        AND T3.konditionsart_id = 'ZWGE'
        AND T3.loesch_fg = 0
    GROUP BY
      `_mandant_id`,
      `_art_id`,
      `_wup_id`,
      `_dat`
  ) AS dt1
WHERE
  `_artbew_tmp`.mandant_id = dt1.`_mandant_id`
  AND `_artbew_tmp`.art_id = dt1.`_art_id`
  AND `_artbew_tmp`.wup_id = dt1.`_wup_id`
  AND `_artbew_tmp`.dat = dt1.`_dat`;

UPDATE dbp_etl.`_artbew_tmp`
SET
  ek_brutto = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_brutto` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_netto = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_netto` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_nettonetto = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_nettonetto` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_kal_basis = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_kal_basis` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_mep = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_mep` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  einstandspreis = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_einstandspreis` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  logkostenzuschlag = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_logkostenzuschlag` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_netto_bnk = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_netto_bnk` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_netto_bnk_sachk = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_netto_bnk_sachk` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC)
FROM
  (
    SELECT
      ARTBEW.wup_id AS `_wup_id`,
      SUM(ARTBEW.ek_brutto) AS `_ek_brutto`,
      SUM(ARTBEW.ek_netto) AS `_ek_netto`,
      SUM(ARTBEW.ek_nettonetto) AS `_ek_nettonetto`,
      SUM(ARTBEW.ek_kal_basis) AS `_ek_kal_basis`,
      SUM(ARTBEW.ek_mep) AS `_ek_mep`,
      SUM(ARTBEW.einstandspreis) AS `_einstandspreis`,
      SUM(ARTBEW.logkostenzuschlag) AS `_logkostenzuschlag`,
      SUM(ARTBEW.ek_netto_bnk) AS `_ek_netto_bnk`,
      SUM(ARTBEW.ek_netto_bnk_sachk) AS `_ek_netto_bnk_sachk`,
      SUM(ARTBEW.umsatz_netto) AS `_umsatz_netto`
    FROM dbp_etl.`_artbew_tmp` AS ARTBEW_1
    INNER JOIN dbp_data.wg_filter_zu_1 AS WGFZ
      ON ARTBEW.mandant_id = WGFZ.mandant_id AND ARTBEW.wg_id = WGFZ.wg_id
    WHERE WGFZ.wg_filter_id = 1
    GROUP BY `_wup_id`
  ) AS dt1
WHERE
  `_artbew_tmp`.wup_id = dt1.`_wup_id`
  AND (`_artbew_tmp`.mandant_id, `_artbew_tmp`.wg_id)
    IN (
      SELECT (mandant_id, wg_id)
      FROM dbp_data.wg_filter_zu_1
      WHERE wg_filter_id = 33
      GROUP BY
        mandant_id,
        wg_id
    );

UPDATE dbp_etl.`_artbew_tmp`
SET
  ek_brutto = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_brutto` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_netto = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_netto` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_nettonetto = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_nettonetto` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_kal_basis = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_kal_basis` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_mep = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_mep` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  einstandspreis = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_einstandspreis` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  logkostenzuschlag = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_logkostenzuschlag` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_netto_bnk = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_netto_bnk` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC),
  ek_netto_bnk_sachk = CAST(
    `_artbew_tmp`.umsatz_netto
    * (
      CAST(dt1.`_ek_netto_bnk_sachk` AS FLOAT64)
      / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`))
    AS NUMERIC)
FROM
  (
    SELECT
      ARTBEW.wup_id AS `_wup_id`,
      SUM(ARTBEW.ek_brutto) AS `_ek_brutto`,
      SUM(ARTBEW.ek_netto) AS `_ek_netto`,
      SUM(ARTBEW.ek_nettonetto) AS `_ek_nettonetto`,
      SUM(ARTBEW.ek_kal_basis) AS `_ek_kal_basis`,
      SUM(ARTBEW.ek_mep) AS `_ek_mep`,
      SUM(ARTBEW.einstandspreis) AS `_einstandspreis`,
      SUM(ARTBEW.logkostenzuschlag) AS `_logkostenzuschlag`,
      SUM(ARTBEW.ek_netto_bnk) AS `_ek_netto_bnk`,
      SUM(ARTBEW.ek_netto_bnk_sachk) AS `_ek_netto_bnk_sachk`,
      SUM(ARTBEW.umsatz_netto) AS `_umsatz_netto`
    FROM dbp_etl.`_artbew_tmp` AS ARTBEW_1
    INNER JOIN dbp_data.wg_filter_zu_1 AS WGFZ
      ON ARTBEW.mandant_id = WGFZ.mandant_id AND ARTBEW.wg_id = WGFZ.wg_id
    WHERE WGFZ.wg_filter_id = 32
    GROUP BY `_wup_id`
  ) AS dt1
WHERE
  `_artbew_tmp`.wup_id = dt1.`_wup_id`
  AND (`_artbew_tmp`.mandant_id, `_artbew_tmp`.wg_id)
    IN (
      SELECT (mandant_id, wg_id)
      FROM dbp_data.wg_filter_zu_1
      WHERE wg_filter_id = 34
      GROUP BY
        mandant_id,
        wg_id
    );

CREATE OR REPLACE TEMPORARY TABLE _update
AS
SELECT
  b.*,
  max(a.aktion_id) AS aktion_id_
FROM
  dbp_data.aktion_art_wup_zu_1 AS a
INNER JOIN dbp_etl._artbew_tmp AS b
  ON
    a.art_id = b.art_id
    AND a.mandant_id = b.mandant_id
    AND a.wup_id = b.wup_id
    AND a.nb_id = b.nb_id
INNER JOIN dbp_data.aktion_1 AS c
  ON
    a.mandant_id = c.mandant_id
    AND a.aktion_id = c.aktion_id
    AND b.dat BETWEEN c.dat_von AND c.dat_bis
WHERE
  a.grund_sperrung IS NULL
  AND CASE
    WHEN c.mandant_id = numeric '1' THEN c.preisaktiviert_fg
    WHEN
      c.mandant_id > numeric '1'
      AND a.dat_preisaktiviert <> '1900-01-01'
      AND (c.mandant_id, c.aktion_id)
        NOT IN (
          SELECT AS STRUCT
            mandant_id,
            aktion_id
          FROM
            dbp_data.l_bonuskauf_1
        )
      THEN numeric '1'
    ELSE numeric '0'
    END = numeric '1'
GROUP BY ALL;

UPDATE dbp_etl._artbew_tmp
SET standard_aktion_id = b.aktion_id_
FROM
  (
    SELECT
      _update.mandant_id,
      _update.wup_id,
      _update.nb_id,
      _update.art_id,
      _update.dat,
      max(_update.aktion_id_) AS aktion_id_
    FROM
      _update
    GROUP BY 1, 2, 3, 4, 5
  ) AS b
WHERE
  _artbew_tmp.mandant_id = b.mandant_id
  AND _artbew_tmp.wup_id = b.wup_id
  AND _artbew_tmp.nb_id = b.nb_id
  AND _artbew_tmp.art_id = b.art_id
  AND _artbew_tmp.dat = b.dat;

DELETE FROM dbp_data.artbew_1 AS A
WHERE
  mandant_id = 1
  AND dat IN (SELECT dat FROM dbp_etl.bon_artbew_dat_1)
  AND (mandant_id, wup_id, dat)
    IN (SELECT (mandant_id, wup_id, dat) FROM dbp_etl.`_artbew_tmp`)
  AND bewart_id <> 1010;

DELETE FROM dbp_data.artbew_dra_1 AS D
WHERE
  mandant_id = 1
  AND dat IN (SELECT dat FROM dbp_etl.bon_artbew_dat_1)
  AND (mandant_id, wup_id, dat)
    IN (SELECT (mandant_id, wup_id, dat) FROM dbp_etl.`_artbew_tmp`);

/*2021-09-22 mfialkiewicz adding missing scripts after migration*/
-- START

INSERT INTO dbp_data.artbew_dra_1
  (
    wup_id,
    mandant_id,
    bewart_id,
    gp_id,
    nb_id,
    art_id,
    dat,
    aktion_id,
    ean_kasse,
    menge,
    wrg_1,
    umsatz_netto,
    umsatz_mwst_betrag)
    (
      SELECT
        wup_id,
        mandant_id,
        bewart_id,
        gp_id,
        nb_id,
        art_id,
        dat,
        aktion_id,
        ean_kasse,
        menge_,
        wrg_1,
        umsatz_netto_,
        umsatz_mwst_betrag_
      FROM
        (
          SELECT
            A.wup_id,
            A.mandant_id,
            A.bewart_id,
            COALESCE(A.gp_id, -1) AS gp_id,
            A.nb_id,
            A.art_id,
            A.ean_kasse,
            A.dat,
            A.aktion_id,
            A.wrg_1,
            SUM(A.menge) AS menge_,
            SUM(A.umsatz_netto) AS umsatz_netto_,
            SUM(A.umsatz_mwst_betrag) AS umsatz_mwst_betrag_
          FROM dbp_etl.`_artbew_tmp` AS A
          INNER JOIN dbp_data.art_wg_zu_per_1 AS W
            ON A.mandant_id = W.mandant_id AND A.art_id = W.art_id
          INNER JOIN dbp_data.wg_filter_zu_1 AS WGFZ
            ON
              W.mandant_id = WGFZ.mandant_id
              AND W.arthiertyp_id = WGFZ.arthiertyp_id
              AND W.wg_id = WGFZ.wg_id
          WHERE
            W.arthiertyp_id = 2
            AND W.dat_bis = PARSE_DATE('%F', '9999-12-31')
            AND WGFZ.wg_filter_id
              = 9  -- WG Spenden fuer Aktion_1 Deutschland rundet auf
          GROUP BY
            A.wup_id,
            A.mandant_id,
            A.bewart_id,
            gp_id,
            A.nb_id,
            A.art_id,
            A.ean_kasse,
            A.dat,
            A.aktion_id,
            A.wrg_1
        ) AS a
    );

-- END

DELETE FROM dbp_etl.`_artbew_tmp`
WHERE
  (mandant_id, art_id)
  IN (
    SELECT (AWZP.mandant_id, AWZP.art_id)
    FROM dbp_data.art_wg_zu_per_1 AS AWZP
    INNER JOIN dbp_data.wg_filter_zu_1 AS WGFZ
      ON
        AWZP.mandant_id = WGFZ.mandant_id
        AND AWZP.arthiertyp_id = WGFZ.arthiertyp_id
        AND AWZP.wg_id = WGFZ.wg_id
    WHERE
      AWZP.arthiertyp_id = 2
      AND AWZP.dat_bis = PARSE_DATE('%F', '9999-12-31')
      AND WGFZ.wg_filter_id
        = 9  /* WG Spenden fuer Aktion_1 Deutschland rundet auf */
    GROUP BY
      AWZP.mandant_id,
      AWZP.art_id
  );

DELETE FROM dbp_etl.`_artbew_tmp`
WHERE
  (mandant_id, art_id)
  IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_wg_zu_per_1
    WHERE
      mandant_id = 1
      AND arthiertyp_id = 2
      AND dat_bis = DATE '9999-12-31'
      AND wg_id = 961
  );

DELETE FROM dbp_etl.`_artbew_tmp`
WHERE mandant_id = 1 AND art_id = 2076821600;

-- 12.06.2025, dbay: historical tracking of posten_id

CREATE OR REPLACE TEMPORARY TABLE _tage
AS
SELECT dat
FROM dbp_etl.`_artbew_tmp`
GROUP BY dat;

CREATE OR REPLACE TEMPORARY TABLE _min_tage
AS
SELECT MIN(dat) AS min_dat
FROM dbp_etl.`_artbew_tmp`;

CREATE OR REPLACE TEMPORARY TABLE _art_per
AS
SELECT *
FROM
  (
    SELECT
      A.art_id,
      A.mandant_id,
      A.dat_von,
      A.dat_bis,
      A.mutter_wb_id,
      A.posten_id,
      A.ipn_id,
      A.mwst_id,
      A.oug_id,
      A.iwt_id,
      A.td_update,
      A.td_insert
    FROM dbp_data.art_per_1 AS A
    INNER JOIN `_min_tage` AS B
      ON A.dat_bis >= B.min_dat
  ) AS a
INNER JOIN `_tage` AS B0
  ON B0.dat BETWEEN a.dat_von AND a.dat_bis;

UPDATE dbp_etl.`_artbew_tmp`
SET
  posten_id = b.posten_id
FROM `_art_per` AS b
WHERE
  `_artbew_tmp`.dat = b.dat
  AND `_artbew_tmp`.mandant_id = b.mandant_id
  AND `_artbew_tmp`.art_id = b.art_id;

UPDATE dbp_etl.`_artbew_tmp`
SET
  bewart_det_id = CASE
    WHEN `_artbew_tmp`.bewart_det_id = 100131
      THEN 100130
    WHEN `_artbew_tmp`.bewart_det_id = 100111
      THEN 100110
    WHEN `_artbew_tmp`.bewart_det_id = 100211
      THEN 100210
    WHEN `_artbew_tmp`.bewart_det_id = 100221
      THEN 100220
    WHEN `_artbew_tmp`.bewart_det_id IN (100231, 100241)
      THEN 9999
    ELSE `_artbew_tmp`.bewart_det_id
    END
WHERE
  MOD(bewart_det_id, 10) <> loyalty_berechtigt_fg AND loyalty_berechtigt_fg = 0;

UPDATE dbp_etl.`_artbew_tmp`
SET
  bewart_det_id = CASE
    WHEN `_artbew_tmp`.bewart_det_id = 100130
      THEN 100131
    WHEN `_artbew_tmp`.bewart_det_id = 100110
      THEN 100111
    WHEN `_artbew_tmp`.bewart_det_id = 100210
      THEN 100211
    WHEN `_artbew_tmp`.bewart_det_id = 100220
      THEN 100221
    ELSE `_artbew_tmp`.bewart_det_id
    END
WHERE
  MOD(bewart_det_id, 10) <> loyalty_berechtigt_fg AND loyalty_berechtigt_fg = 1;

INSERT INTO dbp_data.artbew_1
  (
    mandant_id,
    wup_id,
    nb_id,
    dat,
    bewart_id,
    gp_id,
    art_id,
    aktion_id,
    promo_fg,
    ean_kasse,
    standard_aktion_id,
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge,
    wrg_1,
    umrechnungskurs_hist,
    umsatz_netto,
    umsatz_mwst_betrag,
    ek_brutto,
    ek_netto,
    ek_nettonetto,
    ek_kal_basis,
    ek_mep,
    einstandspreis,
    logkostenzuschlag,
    bezugsweg_id,
    ek_netto_bnk,
    ek_netto_bnk_sachk,
    posten_id,
    bewart_det_id,
    wup_bereinigt_fg,
    td_update,
    td_insert,
    aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt)
    (
      SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.bewart_id,
        COALESCE(A.gp_id, -1) AS gp_id,
        A.art_id,
        A.aktion_id,
        CASE
          WHEN A.bewart_det_id IN (100220, 100221, 100231, 100241)
            THEN 1
          ELSE 0
          END AS promo_fg,
        A.ean_kasse,
        A.standard_aktion_id,
        COALESCE(A.einkaufsorganisation_id, 1000) AS einkaufsorganisation_id,
        COALESCE(A.herst_id, -1) AS herst_id,
        A.mwst_id,
        SUM(A.menge) AS menge_,
        A.wrg_1,
        K.umrechnungskurs AS umrechnungskurs_hist,
        SUM(A.umsatz_netto) AS umsatz_netto_,
        SUM(A.umsatz_mwst_betrag) AS umsatz_mwst_betrag_,
        COALESCE(SUM(A.ek_brutto), 0) AS ek_brutto_,
        COALESCE(SUM(A.ek_netto), 0) AS ek_netto_,
        COALESCE(SUM(A.ek_nettonetto), 0) AS ek_nettonetto_,
        COALESCE(SUM(A.ek_kal_basis), 0) AS ek_kal_basis_,
        COALESCE(SUM(A.ek_mep), 0) AS ek_mep_,
        COALESCE(SUM(A.einstandspreis), 0) AS einstandspreis_,
        COALESCE(SUM(A.logkostenzuschlag), 0) AS logkostenzuschlag_,
        A.bezugsweg_id,
        COALESCE(SUM(A.ek_netto_bnk), 0) AS ek_netto_bnk_,
        COALESCE(SUM(A.ek_netto_bnk_sachk), 0) AS ek_netto_bnk_sachk_,
        A.posten_id,
        A.bewart_det_id,
        COALESCE(B.wup_bereinigt_fg, 0) AS wup_bereinigt_fg,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert,
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
      FROM dbp_etl.`_artbew_tmp` AS A
      LEFT JOIN dbp_etl_process.wup_fg_1 AS B
        ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.dat = B.dat
      LEFT JOIN dbp_data.kurs_1 AS K
        ON
          A.wrg_1 = K.von_wrg_id
          AND A.dat BETWEEN K.dat_von AND K.dat_bis
          AND K.nach_wrg_id
            = 'EUR'
          AND K.kurstyp_id = 3
      GROUP BY
        A.art_id,
        A.wup_id,
        A.mandant_id,
        A.bewart_id,
        gp_id,
        einkaufsorganisation_id,
        A.nb_id,
        A.dat,
        herst_id,
        A.mwst_id,
        A.wrg_1,
        A.bezugsweg_id,
        A.posten_id,
        A.aktion_id,
        A.ean_kasse,
        A.bewart_det_id,
        promo_fg,
        wup_bereinigt_fg,
        A.standard_aktion_id,
        umrechnungskurs_hist,
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
    );

-- update dbp_ods.ods_talon_det_1 set artbew_fg = 1
-- where (mandant_id,wup_id,talon_id) in (select mandant_id,wup_id,talon_id from dbp_etl.bon_artbew_tmp_talon_1)
-- ;

CREATE OR REPLACE TABLE dbp_etl.artbew_agg_tmp_1(
  wup_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  nb_id INTEGER NOT NULL,
  dat DATE NOT NULL);

INSERT INTO dbp_etl.artbew_agg_tmp_1
  (wup_id, mandant_id, nb_id, dat)
    (
      SELECT
        wup_id,
        mandant_id,
        nb_id,
        dat
      FROM dbp_etl.`_artbew_tmp`
      GROUP BY
        wup_id,
        mandant_id,
        nb_id,
        dat
    );

INSERT INTO dbp_data.artbew_agg_wt_1
  (mandant_id, wup_id, nb_id, dat)
    (
      SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
      FROM dbp_etl.artbew_agg_tmp_1
      WHERE
        (mandant_id, wup_id, nb_id, dat)
        NOT IN (
          SELECT (mandant_id, wup_id, nb_id, dat)
          FROM dbp_data.artbew_agg_wt_1
        )
      GROUP BY
        wup_id,
        mandant_id,
        nb_id,
        dat
    );

INSERT INTO dbp_etl_process.uapc_artbew_delta_1
  (mandant_id, wup_id, dat, row_id, processed_at, td_insert, td_update)
    (
      SELECT
        mandant_id,
        wup_id,
        dat,
        (
          ROW_NUMBER()
            OVER (
              ORDER BY
                mandant_id IS NULL, mandant_id, wup_id IS NULL, wup_id, dat
                IS NULL, dat
            ))
          + COALESCE(
            (SELECT MAX(row_id) FROM dbp_etl_process.uapc_artbew_delta_1), 0)
          AS row_id,
        CAST(NULL AS TIMESTAMP) AS processed_at,
        CURRENT_TIMESTAMP() AS td_insert,
        CURRENT_TIMESTAMP() AS td_update
      FROM
        (
          SELECT
            mandant_id,
            wup_id,
            dat
          FROM dbp_etl.artbew_agg_tmp_1
          GROUP BY
            wup_id,
            mandant_id,
            dat
        ) AS t0
    );

CREATE OR REPLACE TABLE dbp_etl.art_bestand_vw_sum_artbew_dat_1(
  mandant_id INTEGER NOT NULL,
  dat DATE);

INSERT INTO dbp_etl.art_bestand_vw_sum_artbew_dat_1
  (mandant_id, dat)
    (
      SELECT
        mandant_id,
        dat
      FROM dbp_etl.artbew_agg_tmp_1
      WHERE
        (mandant_id, dat)
        NOT IN (
          SELECT (mandant_id, dat)
          FROM dbp_etl.art_bestand_vw_sum_artbew_dat_1
        )
      GROUP BY
        mandant_id,
        dat
    );

DELETE FROM dbp_etl.artbew_mis_1
WHERE
  (mandant_id, wup_id, dat)
  IN (SELECT (mandant_id, wup_id, dat) FROM dbp_etl.artbew_agg_tmp_1);

INSERT INTO dbp_etl.artbew_mis_1
  (
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    bewart_id,
    dat,
    menge,
    wrg_1,
    umsatz_netto,
    diff_umsatz_netto_konz,
    umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz)
    (
      SELECT
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        1001,
        dat,
        SUM(menge),
        wrg_1,
        SUM(umsatz_netto),
        0 AS diff_umsatz_netto_konz,
        SUM(umsatz_mwst_betrag),
        0 AS diff_umsatz_mwst_betrag_konz
      FROM dbp_etl.`_artbew_tmp`
      GROUP BY
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        5,
        dat,
        wrg_1,
        diff_umsatz_netto_konz,
        diff_umsatz_mwst_betrag_konz
    );

UPDATE dbp_etl.artbew_mis_1
SET
  wg_id = t1.wg_id,
  arthiertyp_id = t1.arthiertyp_id
FROM
  (
    SELECT
      mandant_id,
      art_id,
      wg_id,
      arthiertyp_id
    FROM dbp_data.art_wg_zu_per_1
    WHERE
      arthiertyp_id = 2
      AND dat_bis = DATE '9999-12-31'
    GROUP BY
      mandant_id,
      art_id,
      arthiertyp_id,
      wg_id
  ) AS t1_1
WHERE artbew_mis.mandant_id = t1.mandant_id AND artbew_mis.art_id = t1.art_id;

UPDATE dbp_data.wupcal_1
SET
  datenlieferung_artbew = 1,
  dat_extrakt_umsatz = CURRENT_DATE("Europe/Berlin"),
  umsatz_brutto_ods_verkauf = x1.umsatz_brutto,
  td_update = CURRENT_TIMESTAMP()
FROM
  (
    SELECT
      A.mandant_id AS mandant_id_,
      A.wup_id AS wup_id_,
      W.nb_id AS nb_id_,
      A.dat AS dat_,
      SUM(A.umsatz_brutto) AS umsatz_brutto
    FROM dbp_etl.bon_artbew_tmp_talon_1 AS A
    INNER JOIN dbp_data.wup_1 AS W
      ON A.mandant_id = W.mandant_id AND A.wup_id = W.wup_id
    GROUP BY
      mandant_id_,
      wup_id_,
      nb_id_,
      dat_
  ) AS x1
WHERE
  wupcal.mandant_id = x1.mandant_id_
  AND wupcal.wup_id = x1.wup_id_
  AND wupcal.nb_id = x1.nb_id_
  AND wupcal.dat = x1.dat_;

UPDATE dbp_data.wupcal_1
SET
  bonanzahl = s.anz_kunden_,
  bonanzahl_imbiss = s.anz_kunden_imbiss_,
  umsatz_brutto_ods_kassenabschluss = s.umsatz_brutto_ods_kassenabschluss_,
  datenlieferung_bonanzahl = 1,
  td_update = CURRENT_TIMESTAMP()
FROM
  (
    SELECT
      K.mandant_id AS mandant_id_,
      K.wup_id AS wup_id_,
      K.bon_dat AS dat_,
      SUM(K.anz_kunden) - SUM(K.anz_kunden_imbiss) AS anz_kunden_,
      SUM(K.anz_kunden_imbiss) AS anz_kunden_imbiss_,
      SUM(K.umsatz_brutto) AS umsatz_brutto_ods_kassenabschluss_
    FROM dbp_ods.ods_bon_kassenabschluss_1 AS K
    INNER JOIN
      (SELECT DISTINCT mandant_id, wup_id, dat FROM dbp_etl.artbew_agg_tmp_1) AS a
      ON
        K.mandant_id = a.mandant_id
        AND K.wup_id = a.wup_id
        AND K.bon_dat
          = a.dat
    GROUP BY
      mandant_id_,
      wup_id_,
      dat_
  ) AS s
WHERE
  wupcal.mandant_id = s.mandant_id_
  AND wupcal.wup_id = s.wup_id_
  AND wupcal.dat = s.dat_;

/*
Jetzt kann nachträglich noch eine_1 Kassenabschluss kommen.
Wir benötigen dann die Summe der beiden Werte in der wupcal_1 Spalte.
*/

CREATE OR REPLACE TABLE dbp_etl.wupcal_correction_1
AS
-- sum(umsatz_brutto) AS
-- umsatz_brutto
-- group by all
SELECT DISTINCT
  mandant_id,
  wup_id,
  bon_dat
FROM dbp_ods.ods_bon_kassenabschluss_1
WHERE
  (mandant_id, wup_id, bon_dat)
  IN (
    SELECT (mandant_id, wup_id, bon_dat)
    FROM dbp_ods.ods_bon_kassenabschluss_1
    WHERE
      mandant_id = 1
      AND bon_dat
        BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 7 DAY)
        AND (CURRENT_DATE("Europe/Berlin"))
    GROUP BY
      mandant_id,
      wup_id,
      bon_dat
    HAVING COUNT(1) > 1
  )
ORDER BY
  mandant_id NULLS LAST,
  wup_id NULLS LAST,
  bon_dat DESC NULLS FIRST;

UPDATE dbp_data.wupcal_1
SET
  bonanzahl = s.anz_kunden_,
  bonanzahl_imbiss = s.anz_kunden_imbiss_,
  umsatz_brutto_ods_kassenabschluss = CAST(
    s.umsatz_brutto_ods_kassenabschluss_ AS NUMERIC),
  datenlieferung_bonanzahl = 1,
  wrg_id = s.wrg_id_
FROM
  (
    SELECT
      K.mandant_id AS mandant_id_,
      K.wup_id AS wup_id_,
      K.bon_dat AS dat_,
      SUM(K.anz_kunden) - SUM(K.anz_kunden_imbiss) AS anz_kunden_,
      SUM(K.anz_kunden_imbiss) AS anz_kunden_imbiss_,
      CAST(SUM(K.umsatz_brutto * COALESCE(x.umrech, 1)) AS NUMERIC)
        AS umsatz_brutto_ods_kassenabschluss_,
      MIN(x.wrg_id) AS wrg_id_
    FROM dbp_ods.ods_bon_kassenabschluss_1 AS K
    INNER JOIN dbp_data.mandant_wrg_zu_per_1 AS WRG_1
      ON
        K.mandant_id = WRG.mandant_id
        AND K.bon_dat BETWEEN WRG.dat_von AND WRG.dat_bis
    INNER JOIN dbp_data.mandant_1 AS Y
      ON K.mandant_id = Y.mandant_id
    LEFT JOIN
      (
        SELECT
          mandant_id,
          wrg_id,
          dat_von,
          dat_bis,
          von_wrg_id,
          umrechnungskurs,
          td_update,
          td_insert,
          1 / CAST(umrechnungskurs AS FLOAT64) AS umrech
        FROM dbp_data.mandant_wrg_zu_per_1
        WHERE
          von_wrg_id IS NOT NULL
          AND wrg_id <> von_wrg_id
          AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
      ) AS x
      ON K.mandant_id = x.mandant_id AND WRG.wrg_id = x.von_wrg_id
    INNER JOIN
      (
        SELECT *
        FROM dbp_etl.wupcal_correction_1
        GROUP BY
          mandant_id,
          wup_id,
          bon_dat
      ) AS a
      ON
        K.mandant_id = a.mandant_id
        AND K.wup_id = a.wup_id
        AND K.bon_dat = a.bon_dat
    GROUP BY
      mandant_id_,
      wup_id_,
      dat_
  ) AS s
WHERE
  wupcal.mandant_id = s.mandant_id_
  AND wupcal.wup_id = s.wup_id_
  AND wupcal.dat = s.dat_;

-- CRM-Verarbeitung

/* fuehrend MWST aus Bondaten */ /* fuehrend */  -- Ermittlung nb_id

/* Initialisierung, im Anschluss erfolgt Ermittlung ueber MARC_1 */ INSERT INTO dbp_etl.`_artbew_tmp2`
  (
    art_id,
    wup_id,
    mandant_id,
    bewart_id,
    nb_id,
    dat,
    aktion_id,
    ean_kasse,
    mwst_id,
    menge,
    wrg_1,
    umsatz_netto,
    umsatz_mwst_betrag,
    bezugsweg_id,
    posten_id,
    bewart_det_id,
    kundenkarte_id,
    loyalty_berechtigt_fg)
    (
      SELECT
        COALESCE(t4.art_id, ERF.art_id, 0),
        CAST(p.wup_id AS INTEGER) AS wup_id,
        CAST(p.mandant_id AS INTEGER) AS mandant_id,
        p.bewart_id,
        W.nb_id,
        p.dat,
        p.aktion_id,
        CAST(COALESCE(p.ean_kasse, 0) AS INTEGER) AS ean_kasse,
        COALESCE(MW.mwst_id, MWS.mwst_id),
        SUM(p.menge) AS menge_,
        'EUR' AS wrg_1,
        ROUND(
          CAST(
            SUM(p.umsatz)
            - SUM(
              p.umsatz
              / (1 + COALESCE(MW.mwst, MWS.mwst) / 100)
              * (COALESCE(MW.mwst, MWS.mwst) / 100))
            AS NUMERIC),
          4) AS umsatz_netto,
        CAST(
          SUM(
            p.umsatz
            / (1 + COALESCE(MW.mwst, MWS.mwst) / 100)
            * (COALESCE(MW.mwst, MWS.mwst) / 100))
          AS NUMERIC) AS umsatz_mwst_betrag,
        COALESCE(AW.bezugsweg_id, p.bezugsweg_id),
        COALESCE(t4.posten_id, '') AS posten_id,
        CAST(p.bewart_det_id AS INTEGER) AS bewart_det_id,
        p.kundenkarte_id,
        CAST(p.loyalty_berechtigt_fg AS INTEGER) AS loyalty_berechtigt_fg
      FROM
        (
          SELECT
            mandant_id,
            wup_id,
            dat,
            kl_art_id,
            ean_kasse,
            wg_id,
            CAST(umsatz_brutto AS FLOAT64) AS umsatz,
            mwst_id,
            menge,
            CASE
              WHEN LTRIM(aktion_id) IN ('0', '0000000000', '')
                THEN 1001  /* aktoinsfrei */
              ELSE 1002  /* Sonderaktion */
              END AS bewart_id,
            CASE
              WHEN LTRIM(aktion_id) IN ('0', '0000000000', '')
                THEN ''
              ELSE aktion_id
              END AS aktion_id,
            4 AS bezugsweg_id,
            COALESCE(
              bewart_det_id_zmp,
              CASE
                WHEN
                  LTRIM(aktion_id) IN ('0', '0000000000', '')
                  AND (
                    kundenkarte_id IS NULL AND kundenkarte_typ_id IN (0)
                    OR kundenkarte_typ_id IN (3, 4))
                  THEN 100110
                ELSE
                  CASE
                    WHEN
                      LTRIM(aktion_id) IN ('0', '0000000000', '')
                      AND kundenkarte_typ_id IN (2)
                      AND kundenkarte_id IS NOT NULL
                      THEN 100111
                    ELSE
                      CASE
                        WHEN
                          LTRIM(bby_aktion) IN ('0', '0000000000', '')
                          AND bby_bewart = 1
                          AND customer_promotion_fg = 0
                          AND TRIM(promotion_art) = 'COMMON'
                          AND (
                            kundenkarte_typ_id IN (0)
                            OR kundenkarte_typ_id IN (3, 4)
                            OR kundenkarte_id IS NOT NULL
                            OR kundenkarte_typ_id IN (1, 2)
                              AND kundenkarte_id IS NOT NULL)
                          AND bonuskauf_id IS NOT NULL
                          THEN 100130
                        WHEN
                          LTRIM(bby_aktion) IN ('0', '0000000000', '')
                          AND bby_bewart = 1
                          AND kundenkarte_typ_id IN (2)
                          AND (
                            customer_promotion_fg
                                = 1
                              AND TRIM(promotion_art) = 'CUSTOMER'
                            OR customer_promotion_fg
                              = 1 AND TRIM(promotion_art) = 'PERSONAL'
                            OR customer_promotion_fg
                              = 0 AND TRIM(promotion_art) = 'COMMON')
                          AND kundenkarte_id
                            IS NOT NULL
                          THEN 100131
                        WHEN
                          (
                            kundenkarte_id IS NULL AND kundenkarte_typ_id IN (0)
                            OR kundenkarte_typ_id IN (3, 4))
                          AND (
                            bonuskauf_id
                              IS NULL
                            OR CAST(bonuskauf_id AS FLOAT64) = 0)
                          AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
                          AND aktion_id_obv IS NOT NULL
                          THEN 100210
                        ELSE
                          CASE
                            WHEN
                              kundenkarte_typ_id IN (2)
                              AND (
                                (important IS NULL OR important = 'N')
                                  AND bonuskauf_id IS NOT NULL
                                OR (important IS NULL OR important = 'Y')
                                  AND (
                                    bonuskauf_id IS NULL
                                    OR CAST(bonuskauf_id AS FLOAT64) = 0))
                              AND LTRIM(aktion_id)
                                NOT IN ('0', '0000000000', '')
                              AND kundenkarte_id IS NOT NULL
                              AND aktion_id_obv IS NOT NULL
                              THEN 100211
                            ELSE
                              CASE
                                WHEN
                                  (
                                    kundenkarte_id IS NULL
                                      AND kundenkarte_typ_id IN (0)
                                    OR kundenkarte_typ_id IN (3, 4))
                                  AND customer_promotion_fg = 0
                                  AND promotion_art = 'COMMON'
                                  AND LTRIM(aktion_id)
                                    NOT IN ('0', '0000000000', '')
                                  AND bonuskauf_id IS NOT NULL
                                  THEN 100220
                                ELSE
                                  CASE
                                    WHEN
                                      kundenkarte_typ_id IN (2)
                                      AND customer_promotion_fg = 0
                                      AND promotion_art = 'COMMON'
                                      AND LTRIM(aktion_id)
                                        NOT IN ('0', '0000000000', '')
                                      AND bonuskauf_id IS NOT NULL
                                      AND kundenkarte_id IS NOT NULL
                                      THEN 100221
                                    ELSE
                                      CASE
                                        WHEN
                                          customer_promotion_fg = 1
                                          AND promotion_art = 'CUSTOMER'
                                          AND LTRIM(aktion_id)
                                            NOT IN ('0', '0000000000', '')
                                          AND bonuskauf_id IS NOT NULL
                                          THEN 100231
                                        ELSE
                                          CASE
                                            WHEN
                                              customer_promotion_fg = 1
                                              AND promotion_art IN (
                                                'PERSONAL', 'XTRA')
                                              AND LTRIM(aktion_id)
                                                NOT IN ('0', '0000000000', '')
                                              AND bonuskauf_id IS NOT NULL
                                              THEN 100241
                                            ELSE 9999
                                            END
                                        END
                                    END
                                END
                            END
                        END
                    END
                END) AS bewart_det_id,
            kundenkarte_id,
            loyalty_berechtigt_fg
          FROM dbp_etl.bon_artbew_tmp_talon_1
          WHERE
            dat >= DATE '2022-04-01'
            AND (mandant_id, kl_art_id)
              NOT IN (
                SELECT
                  (
                    CAST(mandant_id AS INTEGER),
                    CAST(FLOOR(art_id / 100) AS INTEGER))
                FROM dbp_data.art_wg_zu_per_1
                WHERE
                  mandant_id = 1
                  AND arthiertyp_id = 2
                  AND dat_bis = DATE '9999-12-31'
                  AND wg_id = 961
              )
            AND wg_id NOT IN (822)
        ) AS p
      INNER JOIN dbp_data.wup_1 AS W
        ON
          p.mandant_id = W.mandant_id
          AND p.wup_id  -- Ermittlung art_id
            = W.wup_id
      LEFT JOIN
        (
          SELECT
            mandant_id,
            art_id,
            kl_art_id,
            posten_id,
            mwst_id
          FROM dbp_data.art_1
          QUALIFY
            (
              ROW_NUMBER()
                OVER (
                  PARTITION BY mandant_id, kl_art_id
                  ORDER BY art_id IS NULL DESC, art_id DESC
                ))
            = 1
        ) AS t4
        ON p.kl_art_id = t4.kl_art_id AND p.mandant_id = t4.mandant_id
      -- Ermittlung art_id für unbekannte Artikel_1 und alle Artikel_1,
      -- deren Kassen-wg nicht mit der wg_id arthiertyp_1 2 der Stammdaten übereinstimmt
      LEFT JOIN dbp_etl_process.dwh_wg_erfass_artikel_1 AS ERF
        ON
          p.mandant_id = ERF.mandant_id
          AND p.wg_id = ERF.wg_id
          AND ERF.arthiertyp_id
            = 2  -- Ermittlung MWST ID fuer Artikel_1 der WG Erfassung
      LEFT JOIN dbp_data.art_1 AS AERF
        ON ERF.mandant_id = AERF.mandant_id AND ERF.art_id = AERF.art_id
      -- Ermittlung der MWST-ID aus den Bondaten (fuehrend)
      LEFT JOIN dbp_data.mwst_per_1 AS MW
        ON
          p.mandant_id = MW.mandant_id
          AND p.dat BETWEEN MW.dat_von AND MW.dat_bis
          AND p.mwst_id = MW.mwst_id
          AND COALESCE(MW.mwst, 0) <> 0
      -- Ermittlung der MWST-ID aus den Stammdaten (falls in Bondaten nicht korrekt gepflegt
      LEFT JOIN dbp_data.mwst_per_1 AS MWS
        ON
          p.mandant_id = MWS.mandant_id
          AND p.dat BETWEEN MWS.dat_von AND MWS.dat_bis
          AND COALESCE(t4.mwst_id, AERF.mwst_id) = MWS.mwst_id
      -- Ermittlung des Bezugsweges (Default ist 4) aus Stammdaten
      LEFT JOIN dbp_data.art_wup_zu_per_1 AS AW
        ON
          p.mandant_id = AW.mandant_id
          AND p.wup_id = AW.wup_id
          -- Artikelnummer aus Stammdaten!!! s.o.
          AND COALESCE(t4.art_id, ERF.art_id, 0) = AW.art_id
          AND p.dat
            BETWEEN AW.dat_von
            AND AW.dat_bis
      GROUP BY
        p.mandant_id,
        wrg_1,
        p.wup_id,
        W.nb_id,
        p.dat,
        posten_id,
        COALESCE(AW.bezugsweg_id, p.bezugsweg_id),
        COALESCE(t4.art_id, ERF.art_id, 0),
        ean_kasse,
        p.bewart_id,
        COALESCE(MW.mwst_id, MWS.mwst_id),
        p.aktion_id,
        p.bewart_det_id,
        p.kundenkarte_id,
        p.loyalty_berechtigt_fg
      HAVING menge_ <> 0 OR SUM(p.umsatz) - umsatz_mwst_betrag <> 0
    );

CREATE OR REPLACE TEMPORARY TABLE _snap_822
AS
SELECT
  p.mandant_id,
  'EUR' AS wrg_1,
  p.wup_id,
  W.nb_id,
  p.dat,
  COALESCE(t2.posten_id, '') AS posten_id,
  COALESCE(AW.bezugsweg_id, p.bezugsweg_id) AS bezugsweg_id,
  COALESCE(t2.art_id, ERF.art_id, 0) AS art_id,
  COALESCE(p.ean_kasse, 0) AS ean_kasse,
  p.bewart_id,
  COALESCE(MW.mwst_id, MWS.mwst_id) AS mwst_id,
  p.aktion_id,
  SUM(p.menge) AS menge_,
  CAST(
    SUM(
      p.umsatz
      / (1 + COALESCE(MW.mwst, MWS.mwst) / 100)
      * (COALESCE(MW.mwst, MWS.mwst) / 100))
    AS NUMERIC) AS umsatz_mwst_betrag,
  SUM(p.umsatz)
    - SUM(
      p.umsatz
      / (1 + COALESCE(MW.mwst, MWS.mwst) / 100)
      * (COALESCE(MW.mwst, MWS.mwst) / 100)) AS umsatz_netto,
  p.bewart_det_id,
  '' AS standard_aktion_id,
  p.kundenkarte_id,
  p.loyalty_berechtigt_fg
FROM
  (
    SELECT
      mandant_id,
      wup_id,
      dat,
      kl_art_id,
      ean_kasse,
      wg_id,
      CAST(umsatz_brutto AS FLOAT64) AS umsatz,
      mwst_id,
      menge,
      CASE
        WHEN LTRIM(aktion_id) IN ('0', '0000000000', '')
          THEN 1001
        ELSE 1002
        END AS bewart_id,
      CASE
        WHEN LTRIM(aktion_id) IN ('0', '0000000000', '')
          THEN ''
        ELSE aktion_id
        END AS aktion_id,
      4 AS bezugsweg_id,
      CASE
        WHEN bewart_det_id <> 888888
          THEN bewart_det_id
        WHEN
          LTRIM(aktion_id) IN ('0', '0000000000', '')
          AND (
            kundenkarte_id IS NULL AND kundenkarte_typ_id IN (0)
            OR kundenkarte_typ_id IN (3, 4))
          THEN 100110
        WHEN
          LTRIM(aktion_id) IN ('0', '0000000000', '')
          AND kundenkarte_typ_id IN (2)
          AND kundenkarte_id IS NOT NULL
          THEN 100111
        WHEN
          LTRIM(bby_aktion) IN ('0', '0000000000', '')
          AND bby_bewart = 1
          AND customer_promotion_fg = 0
          AND TRIM(promotion_art) = 'COMMON'
          AND (
            kundenkarte_typ_id IN (0, 3, 4)
            OR kundenkarte_id IS NOT NULL
            OR kundenkarte_typ_id IN (1, 2) AND kundenkarte_id IS NOT NULL)
          AND bonuskauf_id IS NOT NULL
          THEN 100130
        WHEN
          LTRIM(bby_aktion) IN ('0', '0000000000', '')
          AND bby_bewart = 1
          AND kundenkarte_typ_id IN (2)
          AND (
            customer_promotion_fg
                = 1
              AND TRIM(promotion_art) = 'CUSTOMER'
            OR customer_promotion_fg = 1 AND TRIM(promotion_art) = 'PERSONAL'
            OR customer_promotion_fg = 0 AND TRIM(promotion_art) = 'COMMON')
          AND kundenkarte_id IS NOT NULL
          THEN 100131
        WHEN
          (
            kundenkarte_id IS NULL AND kundenkarte_typ_id IN (0)
            OR kundenkarte_typ_id IN (3, 4))
          AND (bonuskauf_id IS NULL OR CAST(bonuskauf_id AS FLOAT64) = 0)
          AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
          AND aktion_id_obv IS NOT NULL
          THEN 100210
        WHEN
          kundenkarte_typ_id IN (2)
          AND (
            (important IS NULL OR important = 'N') AND bonuskauf_id IS NOT NULL
            OR (important IS NULL OR important = 'Y')
              AND (bonuskauf_id IS NULL OR CAST(bonuskauf_id AS FLOAT64) = 0))
          AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
          AND kundenkarte_id IS NOT NULL
          AND aktion_id_obv IS NOT NULL
          THEN 100211
        WHEN
          (
            kundenkarte_id IS NULL AND kundenkarte_typ_id IN (0)
            OR kundenkarte_typ_id IN (3, 4))
          AND customer_promotion_fg = 0
          AND promotion_art = 'COMMON'
          AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
          AND bonuskauf_id IS NOT NULL
          THEN 100220
        WHEN
          kundenkarte_typ_id IN (2)
          AND customer_promotion_fg = 0
          AND promotion_art = 'COMMON'
          AND LTRIM(aktion_id)
            NOT IN ('0', '0000000000', '')
          AND bonuskauf_id IS NOT NULL
          AND kundenkarte_id IS NOT NULL
          THEN 100221
        WHEN
          customer_promotion_fg = 1
          AND promotion_art = 'CUSTOMER'
          AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
          AND bonuskauf_id IS NOT NULL
          THEN 100231
        WHEN
          customer_promotion_fg = 1
          AND promotion_art IN ('PERSONAL', 'XTRA')
          AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '')
          AND bonuskauf_id IS NOT NULL
          THEN 100241
        ELSE 9999
        END AS bewart_det_id,
      kundenkarte_id,
      loyalty_berechtigt_fg
    FROM `_artbew_822` AS X
    WHERE
      dat >= DATE '2022-04-01'
      AND wg_id IN (822)
  ) AS p
INNER JOIN dbp_data.wup_1 AS W
  ON p.mandant_id = W.mandant_id AND p.wup_id = W.wup_id
LEFT JOIN
  (
    SELECT
      mandant_id,
      art_id,
      kl_art_id,
      posten_id,
      mwst_id
    FROM dbp_data.art_1
    QUALIFY
      (
        ROW_NUMBER()
          OVER (
            PARTITION BY mandant_id, kl_art_id
            ORDER BY art_id IS NULL DESC, art_id DESC
          ))
      = 1
  ) AS t2
  ON p.kl_art_id = t2.kl_art_id AND p.mandant_id = t2.mandant_id
LEFT JOIN dbp_etl_process.dwh_wg_erfass_artikel_1 AS ERF
  ON
    p.mandant_id = ERF.mandant_id
    AND p.wg_id = ERF.wg_id
    AND ERF.arthiertyp_id = 2
LEFT JOIN dbp_data.art_1 AS AERF
  ON ERF.mandant_id = AERF.mandant_id AND ERF.art_id = AERF.art_id
LEFT JOIN dbp_data.mwst_per_1 AS MW
  ON
    p.mandant_id = MW.mandant_id
    AND p.dat BETWEEN MW.dat_von AND MW.dat_bis
    AND p.mwst_id = MW.mwst_id
    AND COALESCE(MW.mwst, 0) <> 0
LEFT JOIN dbp_data.mwst_per_1 AS MWS
  ON
    p.mandant_id = MWS.mandant_id
    AND p.dat BETWEEN MWS.dat_von AND MWS.dat_bis
    AND COALESCE(t2.mwst_id, AERF.mwst_id) = MWS.mwst_id
LEFT JOIN dbp_data.art_wup_zu_per_1 AS AW
  ON
    p.mandant_id = AW.mandant_id
    AND p.wup_id = AW.wup_id
    AND COALESCE(t2.art_id, ERF.art_id, 0) = AW.art_id
    AND p.dat BETWEEN AW.dat_von AND AW.dat_bis
GROUP BY
  p.mandant_id,
  wrg_1,
  p.wup_id,
  W.nb_id,
  p.dat,
  posten_id,
  bezugsweg_id,
  art_id,
  ean_kasse,
  p.bewart_id,
  mwst_id,
  p.aktion_id,
  p.bewart_det_id,
  standard_aktion_id,
  p.kundenkarte_id,
  p.loyalty_berechtigt_fg
HAVING menge_ <> 0 OR SUM(p.umsatz) - umsatz_mwst_betrag <> 0;

INSERT INTO dbp_etl.`_artbew_tmp2`
  (
    art_id,
    wup_id,
    mandant_id,
    bewart_id,
    nb_id,
    dat,
    aktion_id,
    ean_kasse,
    mwst_id,
    menge,
    wrg_1,
    umsatz_netto,
    umsatz_mwst_betrag,
    bezugsweg_id,
    posten_id,
    bewart_det_id,
    kundenkarte_id,
    loyalty_berechtigt_fg)
    (
      SELECT
        art_id,
        CAST(wup_id AS INTEGER) AS wup_id,
        CAST(mandant_id AS INTEGER) AS mandant_id,
        bewart_id,
        nb_id,
        dat,
        aktion_id,
        CAST(ean_kasse AS INTEGER) AS ean_kasse,
        mwst_id,
        menge_,
        wrg_1,
        ROUND(CAST(umsatz_netto AS NUMERIC), 4) AS umsatz_netto,
        umsatz_mwst_betrag,
        bezugsweg_id,
        posten_id,
        CAST(bewart_det_id AS INTEGER) AS bewart_det_id,
        kundenkarte_id,
        CAST(loyalty_berechtigt_fg AS INTEGER) AS loyalty_berechtigt_fg
      FROM `_snap_822`
    );

UPDATE dbp_etl.`_artbew_tmp2`
SET
  bewart_id = 1001
WHERE bewart_det_id IN (100110, 100111, 100121, 100130, 100131);

UPDATE dbp_etl.`_artbew_tmp2`
SET
  bewart_id = 1001,
  bewart_det_id = 100121
FROM
  (
    SELECT
      t7.mandant_id,
      t7.bon_dat,
      t7.wup_id,
      t7.art_id
    FROM
      (
        SELECT
          A.mandant_id,
          A.bon_id,
          A.wup_id,
          A.bon_zeile,
          A.bon_dat,
          t0.art_id,
          COUNT(DISTINCT A.promotion_art)
        FROM dbp_etl.de_bd_for_promotion_1 AS A
        INNER JOIN
          (
            SELECT
              mandant_id,
              art_id,
              kl_art_id
            FROM dbp_data.art_1
            QUALIFY
              (
                ROW_NUMBER()
                  OVER (
                    PARTITION BY mandant_id, kl_art_id
                    ORDER BY art_id IS NULL DESC, art_id DESC
                  ))
              = 1
          ) AS t0
          ON A.mandant_id = t0.mandant_id AND A.kl_art_id = t0.kl_art_id
        WHERE
          (A.mandant_id, A.bon_id, A.bon_zeile, A.bon_dat, A.wup_id)
          IN (
            SELECT (mandant_id, bon_id, bon_zeile, bon_dat, wup_id)
            FROM dbp_etl.de_bd_for_promotion_1
            WHERE promotion_art IN ('PERSONAL_SMP')
            GROUP BY
              mandant_id,
              bon_id,
              bon_zeile,
              bon_dat,
              wup_id
          )
        GROUP BY
          A.mandant_id,
          A.bon_id,
          A.wup_id,
          A.bon_zeile,
          A.bon_dat,
          t0.art_id
        HAVING COUNT(DISTINCT A.promotion_art) = 1
      ) AS t7
    GROUP BY
      t7.mandant_id,
      t7.wup_id,
      t7.bon_dat,
      t7.art_id
  ) AS b
WHERE
  `_artbew_tmp2`.mandant_id = b.mandant_id
  AND `_artbew_tmp2`.art_id = b.art_id
  AND `_artbew_tmp2`.dat = b.bon_dat
  AND `_artbew_tmp2`.wup_id = b.wup_id
  AND `_artbew_tmp2`.bewart_det_id = 9999
  AND `_artbew_tmp2`.bewart_id = 1002;

DELETE FROM dbp_etl.`_artbew_tmp2`
WHERE mandant_id = 1 AND art_id = 2076821600;

UPDATE dbp_etl.`_artbew_tmp2`
SET
  bewart_det_id = CASE
    WHEN `_artbew_tmp2`.bewart_det_id = 100131
      THEN 100130
    WHEN `_artbew_tmp2`.bewart_det_id = 100111
      THEN 100110
    WHEN `_artbew_tmp2`.bewart_det_id = 100211
      THEN 100210
    WHEN `_artbew_tmp2`.bewart_det_id = 100221
      THEN 100220
    WHEN `_artbew_tmp2`.bewart_det_id IN (100231, 100241)
      THEN 9999
    ELSE `_artbew_tmp2`.bewart_det_id
    END
WHERE
  MOD(bewart_det_id, 10) <> loyalty_berechtigt_fg AND loyalty_berechtigt_fg = 0;

UPDATE dbp_etl.`_artbew_tmp2`
SET
  bewart_det_id = CASE
    WHEN `_artbew_tmp2`.bewart_det_id = 100130
      THEN 100131
    WHEN `_artbew_tmp2`.bewart_det_id = 100110
      THEN 100111
    WHEN `_artbew_tmp2`.bewart_det_id = 100210
      THEN 100211
    WHEN `_artbew_tmp2`.bewart_det_id = 100220
      THEN 100221
    ELSE `_artbew_tmp2`.bewart_det_id
    END
WHERE
  MOD(bewart_det_id, 10) <> loyalty_berechtigt_fg AND loyalty_berechtigt_fg = 1;

DELETE FROM dbp_data.crm_kartebew_1 AS A
WHERE
  mandant_id = 1
  AND dat IN (SELECT dat FROM dbp_etl.bon_artbew_dat_1)
  AND (mandant_id, wup_id, dat)
    IN (
      SELECT (mandant_id, wup_id, dat)
      FROM dbp_etl.`_artbew_tmp2`
    );


INSERT INTO dbp_data.crm_kartebew_1
  (
    mandant_id,
    wup_id,
    nb_id,
    kundenkarte_id,
    dat,
    wrg_id,
    umsatz_netto_sa,
    umsatz_netto_af,
    umsatz_brutto_sa,
    umsatz_brutto_af,
    anz_bons,
    td_insert,
    td_update,
    loyalty_berechtigt_fg)
SELECT
  aktc.mandant_id,
  aktc.wup_id,
  aktc.nb_id,
  aktc.kundenkarte_id,
  aktc.dat,
  aktc.wrg_1,
  sum(
    CASE
      WHEN aktc.bewart_id = numeric '1002' THEN aktc.umsatz_netto
      ELSE numeric '0'
      END) AS umsatz_netto_sa,
  sum(
    CASE
      WHEN aktc.bewart_id = numeric '1001' THEN aktc.umsatz_netto
      ELSE numeric '0'
      END) AS umsatz_netto_af,
  sum(
    CASE
      WHEN aktc.bewart_id = numeric '1002'
        THEN aktc.umsatz_netto + aktc.umsatz_mwst_betrag
      ELSE numeric '0'
      END) AS umsatz_brutto_sa,
  sum(
    CASE
      WHEN aktc.bewart_id = numeric '1001'
        THEN aktc.umsatz_netto + aktc.umsatz_mwst_betrag
      ELSE numeric '0'
      END) AS umsatz_brutto_af,
  max(k.anz_bon) AS anz_bons,
  current_timestamp(),
  current_timestamp(),
  CAST(CASE
    WHEN aktc.dat >= '2025-03-01' THEN aktc.loyalty_berechtigt_fg
    ELSE -numeric '1'
    END AS INT64) AS loyalty_berechtigt_fg
FROM
  dbp_etl._artbew_tmp2 AS aktc
INNER JOIN dbp_etl._crm_keys AS k
  ON
    aktc.mandant_id = k.mandant_id
    AND aktc.wup_id = k.wup_id
    AND aktc.kundenkarte_id = k.kundenkarte_id
    AND aktc.dat = k.dat
LEFT OUTER JOIN dbp_data.bewart_det_ecommerce_1 AS bde
  ON
    aktc.mandant_id = bde.mandant_id
    AND aktc.kundenkarte_id = bde.kundenkarte_id
WHERE
  aktc.kundenkarte_id IS NOT NULL
  AND bde.kundenkarte_id IS NULL
GROUP BY ALL;

-- DROP TABLE IF EXISTS dbp_etl.bon_artbew_tmp_talon_1;

DROP TABLE IF EXISTS dbp_etl.bon_artbew_dat_1;

DROP TABLE IF EXISTS dbp_etl.bon_artbew_tag_1;
