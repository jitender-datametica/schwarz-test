--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.dbp_etl.KMO_ARTBEW_BON_1' does not exist or not authorized.


-- AND i.vk_aktion_brutto <> 0
-- Ermittlung Promotionsbetrag pro Bon Zeile

-- im abschließenden INSERT INTO in die Zieltabelle verschluesselt initialisiert (s.u.)
-- AND i.aktion_id <> ''

-- ,umrechnungskurs
-- ,umrechnungskurs
-- AND i.vk_aktion_brutto <> 0

-- Ermittlung der Promotionsbetraege pro Bonzeile und Kennzeichnung promo_fg
-- AND i.vk_aktion_brutto <> 0

-- AND i.vk_aktion_brutto <> 0
-- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0

-- AND i.vk_aktion_brutto <> 0
-- AND i.vk_aktion_brutto <> 0
-- AND i.vk_aktion_brutto <> 0

-- AND i.vk_aktion_brutto <> 0
-- AND i.vk_aktion_brutto <> 0
-- AND i.vk_aktion_brutto <> 0

-- AND i.aktion_id <> ''
-- AND i.aktion_id <> ''
INSERT INTO dbp_etl.artbew_kmo_tmp_1 (
    wup_id,
    mandant_id, bewart_id, bewart_det_id, gp_id, nb_id, art_id, dat, aktion_id, promo_fg, ean_kasse,
    einkaufsorganisation_id, herst_id, mwst_id, menge, wrg_1, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz, bezugsweg_id, posten_id, pv_aktion, pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby,
    pv_aktion_kdn_bby, pv_aktion_kdp_bby
)
(
    SELECT
        l.wup_id,
        l.mandant_id,
        CASE
            WHEN
                l.mandant_id IN (4) -- bartosiewiczadm - cloud migration
                -- AND l.dat_booking >= 1200319 THEN
                AND l.dat_booking
                >= DATE '2020-03-19' OR l.mandant_id IN (6) -- bartosiewiczadm - cloud migration

                -- AND l.dat_booking >= 1200914 THEN
                AND l.dat_booking >= DATE '2020-09-14' OR l.mandant_id IN (5)
                -- bartosiewiczadm - cloud migration
                -- AND l.dat_booking >= 1201119 THEN
                AND l.dat_booking >= DATE '2020-11-19'
                OR l.mandant_id IN (2, 3, 7, 8)
                THEN CASE
                    WHEN l.aktion_id <> ''
                        THEN 1002
                    ELSE 1001
                END
            ELSE COALESCE(R.bewart_id, 1001)
        END AS bewart_id,
        l.bewart_det_id,
        -1 AS gp_id,
        l.lkp_nb_id AS nb_id,
        l.lkp_art_id AS art_id,
        l.dat_booking AS dat,
        CASE
            WHEN
                l.mandant_id IN (4) AND l.dat_booking >= DATE '2020-03-19' OR l.mandant_id IN (6) AND l.dat_booking >=
                DATE '2020-09-14' OR l.mandant_id IN (5) AND l.dat_booking >= DATE '2020-11-19' OR l.mandant_id IN (2, 3, 7, 8)
                THEN l.aktion_id
            ELSE COALESCE(R.aktion_id, '')
        END AS aktion_id,
        l.promo_fg,
        l.ean_kasse,
        -1 AS einkaufsorganisation_id,
        -1 AS herst_id,
        l.lkp_mwst_id AS mwst_id,
        l.menge,
        l.lkp_wrg AS wrg_1,
        CAST(l.umsatz_brutto / (1 + l.lkp_mwst / 100) AS NUMERIC) AS umsatz_netto,
        CAST(CAST(l.umsatz_brutto / (1 + l.lkp_mwst / 100) AS NUMERIC) * l.lkp_umrechnungskurs AS NUMERIC) AS diff_umsatz_netto_konz,
        l.umsatz_brutto - CAST(l.umsatz_brutto / (1 + l.lkp_mwst / 100) AS NUMERIC) AS umsatz_mwst_betrag,
        CAST(
            (l.umsatz_brutto - CAST(l.umsatz_brutto / (1 + l.lkp_mwst / 100) AS NUMERIC)) * l.lkp_umrechnungskurs AS NUMERIC) AS
        diff_umsatz_mwst_betrag_konz,
        0 AS bezugsweg_id,
        COALESCE(l.lkp_posten_id, ' ') AS posten_id,
        CAST(l.pv_aktion AS NUMERIC) AS pv_aktion,
        CAST(l.pv_bby AS NUMERIC) AS pv_bby,
        CAST(l.pv_kdn_bby AS NUMERIC) AS pv_kdn_bby,
        CAST(l.pv_kdp_bby AS NUMERIC) AS pv_kdp_bby,
        CAST(l.pv_aktion_bby AS NUMERIC) AS pv_aktion_bby,
        CAST(l.pv_aktion_kdn_bby AS NUMERIC) AS pv_aktion_kdn_bby,
        CAST(l.pv_aktion_kdp_bby AS NUMERIC) AS pv_aktion_kdp_bby
    FROM (
        SELECT
            mandant_id,
            wup_id,
            lkp_nb_id,
            lkp_art_id,
            lkp_posten_id,
            dat_booking,
            lkp_mwst,
            lkp_mwst_id,
            lkp_wrg,
            lkp_umrechnungskurs,
            promo_fg,
            ean_kasse,
            aktion_id,
            SUM(umsatz_brutto_) AS umsatz_brutto,
            SUM(menge_) AS menge,
            SUM(umsatz_promotion_brutto_) AS umsatz_promotion_brutto,
            9999 AS bewart_det_id,
            SUM(CASE
                WHEN
                    mandant_id IN (4) AND dat_booking >= DATE '2020-03-19' OR mandant_id IN (6) AND dat_booking >=
                    DATE '2020-09-14' OR mandant_id IN (5) AND dat_booking >= DATE '2020-11-19' OR mandant_id IN (2, 3, 7, 8)
                    THEN CASE
                        WHEN
                            aktion_id <> '' AND (bonuskauf_id IS NULL OR CAST(bonuskauf_id AS FLOAT64) = 0) AND kundenkarte_id IS NULL
                            AND kundenkarte_typ_id = 0 AND vk_aktion_brutto IS NOT NULL
                            THEN COALESCE((vk_aktion_brutto / (1 + lkp_mwst / 100) - vk_brutto / (1 + lkp_mwst / 100)) * menge_, 0)
                        ELSE CASE
                            WHEN
                                aktion_id <> '' AND (
                                    bonuskauf_id IS NULL OR CAST(bonuskauf_id AS FLOAT64) = 0) AND kundenkarte_typ_id IN (
                                    1,
                                    2
                                ) AND kundenkarte_id IS NOT NULL AND bde_kundenkarte_id IS NOT NULL AND vk_aktion_brutto IS NOT NULL
                                THEN COALESCE((vk_aktion_brutto / (1 + lkp_mwst / 100) - vk_brutto / (1 + lkp_mwst / 100)) * menge_, 0)
                            ELSE CASE
                                WHEN
                                    aktion_id <> '' AND (bonuskauf_id IS NULL OR CAST(bonuskauf_id AS FLOAT64) = 0) AND kundenkarte_typ_id IN
                                    (1, 2) AND bde_kundenkarte_id IS NULL AND kundenkarte_id IS NOT NULL AND vk_aktion_brutto IS NOT NULL
                                    THEN COALESCE((vk_aktion_brutto / (1 + lkp_mwst / 100) - vk_brutto / (1 + lkp_mwst / 100)) * menge_, 0)
                                ELSE 0
                            END
                        END
                    END
                ELSE 0
            END) AS pv_aktion,
            SUM(CASE
                WHEN
                    mandant_id IN (4) AND dat_booking >= DATE '2020-03-19' OR mandant_id IN (6) AND dat_booking >=
                    DATE '2020-09-14' OR mandant_id IN (5) AND dat_booking >= DATE '2020-11-19' OR mandant_id IN (2, 3, 7, 8)
                    THEN CASE
                        WHEN
                            kundenkarte_id IS NULL AND aktion_id <> '' AND kundenkarte_typ_id = 0 AND CAST(bonuskauf_id AS FLOAT64) <> 0
                            AND (aktion_typ_id IS NULL OR aktion_typ_id = '') AND konditionsart_id <> 'N'
                            THEN COALESCE(betrag_promo_brutto_null / (1 + lkp_mwst / 100), 0)
                        ELSE CASE
                            WHEN
                                kundenkarte_id IS NOT NULL AND aktion_id <> '' AND kundenkarte_typ_id IN (1, 2) AND CAST(bonuskauf_id AS FLOAT64)
                                <> 0 AND (aktion_typ_id IS NULL OR aktion_typ_id = '' OR aktion_typ_id IN ('KDP', 'KDN')) AND
                                konditionsart_id <> 'N' AND bde_kundenkarte_id IS NOT NULL
                                THEN COALESCE(betrag_promo_brutto_null / (1 + lkp_mwst / 100), 0)
                            ELSE CASE
                                WHEN
                                    aktion_id <> '' AND kundenkarte_typ_id IN (1, 2) AND bde_kundenkarte_id IS NULL AND CAST(bonuskauf_id AS FLOAT64)
                                    <> 0 AND (aktion_typ_id IS NULL OR aktion_typ_id = '') AND konditionsart_id <> 'N' AND kundenkarte_id
                                    IS NOT NULL
                                    THEN COALESCE(betrag_promo_brutto_null / (1 + lkp_mwst / 100), 0)
                                ELSE CASE
                                    WHEN
                                        bonuskauf_id IS NOT NULL AND aktion_typ_id IN ('KDN', 'KPB') AND bde_kundenkarte_id IS NULL AND
                                        betrag_promo_brutto_null IS NOT NULL
                                        THEN COALESCE(betrag_promo_brutto_null / (1 + lkp_mwst / 100), 0)
                                    ELSE CASE
                                        WHEN
                                            bonuskauf_id IS NOT NULL AND aktion_typ_id = 'KDP' AND bde_kundenkarte_id IS NULL AND
                                            betrag_promo_brutto_null IS NOT NULL
                                            THEN COALESCE(betrag_promo_brutto_null / (1 + lkp_mwst / 100), 0)
                                        ELSE 0
                                    END
                                END
                            END
                        END
                    END
                ELSE 0
            END) AS pv_bby,
            SUM(CASE
                WHEN
                    mandant_id IN (4) AND dat_booking >= DATE '2020-03-19' OR mandant_id IN (6) AND dat_booking >=
                    DATE '2020-09-14' OR mandant_id IN (5) AND dat_booking >= DATE '2020-11-19' OR mandant_id IN (2, 3, 7, 8)
                    THEN CASE
                        WHEN bonuskauf_id IS NOT NULL AND aktion_typ_id IN ('KDN', 'KPB') AND bde_kundenkarte_id IS NULL
                            THEN COALESCE(betrag_promo_brutto_kdn / (1 + lkp_mwst / 100), 0)
                        ELSE CASE
                            WHEN
                                bonuskauf_id IS NOT NULL AND aktion_typ_id = 'KDP' AND bde_kundenkarte_id IS NULL AND
                                betrag_promo_brutto_kdn IS NOT NULL
                                THEN COALESCE(betrag_promo_brutto_kdn / (1 + lkp_mwst / 100), 0)
                            ELSE 0
                        END
                    END
                ELSE 0
            END) AS pv_kdn_bby,
            SUM(CASE
                WHEN
                    mandant_id IN (4) AND dat_booking >= DATE '2020-03-19' OR mandant_id IN (6) AND dat_booking >=
                    DATE '2020-09-14' OR mandant_id IN (5) AND dat_booking >= DATE '2020-11-19' OR mandant_id IN (2, 3, 7, 8)
                    THEN CASE
                        WHEN bonuskauf_id IS NOT NULL AND aktion_typ_id = 'KDP' AND bde_kundenkarte_id IS NULL
                            THEN COALESCE(betrag_promo_brutto_kdp / (1 + lkp_mwst / 100), 0)
                        ELSE 0
                    END
                ELSE 0
            END) AS pv_kdp_bby,
            SUM(CASE
                WHEN
                    mandant_id IN (4) AND dat_booking >= DATE '2020-03-19' OR mandant_id IN (6) AND dat_booking >=
                    DATE '2020-09-14' OR mandant_id IN (5) AND dat_booking >= DATE '2020-11-19' OR mandant_id IN (2, 3, 7, 8)
                    THEN CASE
                        WHEN
                            aktion_id <> '' AND kundenkarte_id IS NULL AND kundenkarte_typ_id = 0 AND CAST(bonuskauf_id AS FLOAT64) <> 0
                            AND (aktion_typ_id IS NULL OR aktion_typ_id = '') AND vk_aktion_brutto IS NOT NULL
                            THEN COALESCE((vk_aktion_brutto / (1 + lkp_mwst / 100) - vk_brutto / (1 + lkp_mwst / 100)) * menge_, 0)
                        ELSE CASE
                            WHEN
                                aktion_id <> '' AND kundenkarte_id IS NULL AND kundenkarte_typ_id = 0 AND CAST(bonuskauf_id AS FLOAT64) <>
                                0 AND (aktion_typ_id IS NULL OR aktion_typ_id = '' OR aktion_typ_id IN ('KDP', 'KDN')) AND
                                bde_kundenkarte_id IS NOT NULL AND vk_aktion_brutto IS NOT NULL
                                THEN COALESCE((vk_aktion_brutto / (1 + lkp_mwst / 100) - vk_brutto / (1 + lkp_mwst / 100)) * menge_, 0)
                            ELSE CASE
                                WHEN
                                    aktion_id <> '' AND kundenkarte_typ_id IN (1, 2) AND bde_kundenkarte_id IS NULL AND CAST(bonuskauf_id AS FLOAT64)
                                    <> 0 AND (aktion_typ_id IS NULL OR aktion_typ_id = '') AND kundenkarte_id IS NOT NULL AND vk_aktion_brutto
                                    IS NOT NULL
                                    THEN COALESCE((vk_aktion_brutto / (1 + lkp_mwst / 100) - vk_brutto / (1 + lkp_mwst / 100)) * menge_, 0)
                                ELSE 0
                            END
                        END
                    END
                ELSE 0
            END) AS pv_aktion_bby,
            SUM(CASE
                WHEN
                    mandant_id IN (4) AND dat_booking >= DATE '2020-03-19' OR mandant_id IN (6) AND dat_booking >=
                    DATE '2020-09-14' OR mandant_id IN (5) AND dat_booking >= DATE '2020-11-19' OR mandant_id IN (2, 3, 7, 8)
                    THEN CASE
                        WHEN
                            aktion_id <> '' AND kundenkarte_id IS NULL AND kundenkarte_typ_id = 0 AND aktion_typ_id IN ('KDN', 'KPB')
                            AND bde_kundenkarte_id IS NULL AND bonuskauf_id IS NOT NULL AND vk_aktion_brutto IS NOT NULL
                            THEN COALESCE((vk_aktion_brutto / (1 + lkp_mwst / 100) - vk_brutto / (1 + lkp_mwst / 100)) * menge_, 0)
                        ELSE CASE
                            WHEN
                                aktion_id <> '' AND kundenkarte_typ_id IN (1, 2) AND aktion_typ_id IN ('KDN', 'KPB') AND bde_kundenkarte_id
                                IS NULL AND kundenkarte_id IS NOT NULL AND bonuskauf_id IS NOT NULL AND vk_aktion_brutto IS NOT NULL
                                THEN COALESCE((vk_aktion_brutto / (1 + lkp_mwst / 100) - vk_brutto / (1 + lkp_mwst / 100)) * menge_, 0)
                            ELSE 0
                        END
                    END
                ELSE 0
            END) AS pv_aktion_kdn_bby,
            SUM(CASE
                WHEN
                    mandant_id IN (4) AND dat_booking >= DATE '2020-03-19' OR mandant_id IN (6) AND dat_booking >=
                    DATE '2020-09-14' OR mandant_id IN (5) AND dat_booking >= DATE '2020-11-19' OR mandant_id IN (2, 3, 7, 8)
                    THEN CASE
                        WHEN
                            aktion_id <> '' AND kundenkarte_id IS NULL AND kundenkarte_typ_id = 0 AND bde_kundenkarte_id IS NULL AND
                            aktion_typ_id = 'KDP' AND bonuskauf_id IS NOT NULL AND vk_aktion_brutto IS NOT NULL
                            THEN COALESCE((vk_aktion_brutto / (1 + lkp_mwst / 100) - vk_brutto / (1 + lkp_mwst / 100)) * menge_, 0)
                        ELSE CASE
                            WHEN
                                aktion_id <> '' AND kundenkarte_typ_id IN (1, 2) AND bde_kundenkarte_id IS NULL AND aktion_typ_id = 'KDP'
                                AND kundenkarte_id IS NOT NULL AND bonuskauf_id IS NOT NULL AND vk_aktion_brutto IS NOT NULL
                                THEN COALESCE((vk_aktion_brutto / (1 + lkp_mwst / 100) - vk_brutto / (1 + lkp_mwst / 100)) * menge_, 0)
                            ELSE 0
                        END
                    END
                ELSE 0
            END) AS pv_aktion_kdp_bby
        FROM (
            SELECT
                Z.mandant_id,
                Z.wup_id,
                Z.lkp_nb_id,
                Z.lkp_art_id,
                Z.lkp_posten_id,
                Z.dat_booking,
                Z.lkp_mwst,
                Z.lkp_mwst_id,
                Z.lkp_wrg,
                Z.lkp_umrechnungskurs,
                CASE
                    WHEN COALESCE(p.promotion_brutto, 0) <> 0 AND CAST(Z.bonuskauf_id AS FLOAT64) <> 0
                        THEN 1
                    ELSE 0
                END AS promo_fg,
                Z.ean_kasse,
                CASE
                    WHEN p.mandant_id IN (4) AND Z.dat_booking >= DATE '2020-03-19' AND p.aktion_id <> ''
                        THEN p.aktion_id
                    WHEN p.mandant_id IN (4) AND Z.dat_booking >= DATE '2020-03-19' AND p.aktion_id = ''
                        THEN Z.aktion_id
                    WHEN p.mandant_id IN (6) AND Z.dat_booking >= DATE '2020-09-14' AND p.aktion_id <> ''
                        THEN p.aktion_id
                    WHEN p.mandant_id IN (6) AND Z.dat_booking >= DATE '2020-09-14' AND p.aktion_id = ''
                        THEN Z.aktion_id
                    WHEN p.mandant_id IN (5) AND Z.dat_booking >= DATE '2020-11-19' AND p.aktion_id <> ''
                        THEN p.aktion_id
                    WHEN p.mandant_id IN (5) AND Z.dat_booking >= DATE '2020-11-19' AND p.aktion_id = ''
                        THEN Z.aktion_id
                    WHEN p.mandant_id IN (2, 3, 7, 8) AND p.aktion_id <> ''
                        THEN p.aktion_id
                    ELSE Z.aktion_id
                END AS aktion_id,
                Z.kundenkarte_id,
                Z.kundenkarte_typ_id,
                Z.bonuskauf_id,
                Z.aktion_typ_id,
                Z.konditionsart_id,
                Z.vk_aktion_brutto,
                Z.vk_brutto,
                Z.bonuskauf_id_lb,
                Z.bde_kundenkarte_id,
                SUM(Z.betrag_promo_brutto_kdn) AS betrag_promo_brutto_kdn,
                SUM(Z.betrag_promo_brutto_kdp) AS betrag_promo_brutto_kdp,
                SUM(Z.betrag_promo_brutto_null) AS betrag_promo_brutto_null,
                SUM(Z.umsatz_brutto) AS umsatz_brutto_,
                SUM(Z.menge) AS menge_,
                SUM(COALESCE(p.promotion_brutto, 0)) AS umsatz_promotion_brutto_
            FROM dbp_etl.kmo_artbew_bon_1 AS Z
            LEFT JOIN (
                SELECT
                    A.mandant_id,
                    A.bon_id,
                    A.dat_booking,
                    A.bon_zeile,
                    MAX(COALESCE(B.aktion_id, '')) AS aktion_id,
                    SUM(A.umsatz_brutto) AS promotion_brutto
                FROM dbp_etl.kmo_artbew_bon_promotion_1 AS A
                LEFT JOIN dbp_data.l_bonuskauf_1 AS B
                    ON
                        A.mandant_id = B.mandant_id AND A.bonuskauf_id = B.bonuskauf_id
                        AND A.dat_booking BETWEEN B.dat_von AND B.dat_bis
                GROUP BY
                    A.mandant_id,
                    A.bon_id,
                    A.dat_booking,
                    A.bon_zeile
            ) AS p ON Z.mandant_id = p.mandant_id AND Z.bon_id = p.bon_id AND Z.dat_booking = p.dat_booking AND Z.bon_zeile = p.bon_zeile
            GROUP BY
                Z.mandant_id,
                Z.wup_id,
                Z.lkp_nb_id,
                Z.lkp_art_id,
                Z.lkp_posten_id,
                Z.dat_booking,
                Z.lkp_mwst,
                Z.lkp_mwst_id,
                Z.lkp_wrg,
                Z.lkp_umrechnungskurs,
                promo_fg,
                Z.ean_kasse,
                aktion_id,
                Z.kundenkarte_id,
                Z.kundenkarte_typ_id,
                Z.bonuskauf_id,
                Z.aktion_typ_id,
                Z.konditionsart_id,
                Z.vk_aktion_brutto,
                Z.vk_brutto,
                Z.bonuskauf_id_lb,
                Z.bde_kundenkarte_id
        ) AS i
        GROUP BY
            mandant_id,
            wup_id,
            lkp_nb_id,
            lkp_art_id,
            lkp_posten_id,
            dat_booking,
            lkp_mwst,
            lkp_mwst_id,
            lkp_wrg,
            lkp_umrechnungskurs,
            promo_fg,
            ean_kasse,
            aktion_id,
            bewart_det_id
    ) AS l
    LEFT JOIN
        dbp_etl_process.marktabschriften_stamm_1
            AS R
        ON
            l.mandant_id = R.mandant_id AND l.lkp_art_id =
            R.art_id AND l.wup_id = R.wup_id AND l.lkp_nb_id = R.nb_id AND l.dat_booking = R.dat
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.dbp_etl.KMO_ARTBEW_BON_1' does not exist or not authorized.


-- Ermittlung Promotionsbetrag pro Bon Zeile
-- ,umrechnungskurs
-- Berechnung im Vergleich zur Wpuums auftreten.

-- Bonzeilen zusammenfassen damit keine Rundungsdifferenzen bei der MWST

-- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0

-- Ermittlung der Promotionsbetraege pro Bonzeile und Kennzeichnung promo_fg
-- ,umrechnungskurs

-- im abschließenden INSERT INTO in die Zieltabelle verschluesselt initialisiert (s.u.)
INSERT INTO
dbp_etl.artbew_kmo_tmp_crm_1 (
    wup_id, mandant_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id, promo_fg,
    ean_kasse, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg_1, umsatz_netto, diff_umsatz_netto_konz,
    umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, bezugsweg_id, posten_id, kundenkarte_id, bon_id
)
(
    SELECT
        l.wup_id,
        l.mandant_id,
        CASE
            WHEN
                l.mandant_id IN (4) AND l.dat_booking >= DATE '2020-03-19' OR l.mandant_id IN (6) AND l.dat_booking >=
                DATE '2020-09-14' OR l.mandant_id IN (5) AND l.dat_booking >= DATE '2020-11-19' OR l.mandant_id IN (2, 7)
                THEN CASE
                    WHEN l.aktion_id <> ''
                        THEN 1002
                    ELSE 1001
                END
            ELSE COALESCE(R.bewart_id, 1001)
        END AS bewart_id,
        -1 AS gp_id,
        l.lkp_nb_id AS nb_id,
        l.lkp_art_id AS art_id,
        l.dat_booking AS dat,
        CASE
            WHEN
                l.mandant_id IN (4) AND l.dat_booking >= DATE '2020-03-19' OR l.mandant_id IN (6) AND l.dat_booking >=
                DATE '2020-09-14' OR l.mandant_id IN (5) AND l.dat_booking >= DATE '2020-11-19' OR l.mandant_id IN (2, 7)
                THEN l.aktion_id
            ELSE COALESCE(R.aktion_id, '')
        END AS aktion_id,
        l.promo_fg,
        l.ean_kasse,
        -1 AS einkaufsorganisation_id,
        -1 AS herst_id,
        l.lkp_mwst_id AS mwst_id,
        l.menge_ AS menge,
        l.lkp_wrg AS wrg_1,
        CAST(l.umsatz_brutto_ / (1 + l.lkp_mwst / 100) AS NUMERIC) AS umsatz_netto,
        CAST(CAST(l.umsatz_brutto_ / (1 + l.lkp_mwst / 100) AS NUMERIC) * l.lkp_umrechnungskurs AS NUMERIC) AS diff_umsatz_netto_konz,
        l.umsatz_brutto_ - CAST(l.umsatz_brutto_ / (1 + l.lkp_mwst / 100) AS NUMERIC) AS umsatz_mwst_betrag,
        CAST(
            (l.umsatz_brutto_ - CAST(l.umsatz_brutto_ / (1 + l.lkp_mwst / 100) AS NUMERIC)) * l.lkp_umrechnungskurs AS NUMERIC) AS
        diff_umsatz_mwst_betrag_konz,
        0 AS bezugsweg_id,
        COALESCE(l.lkp_posten_id, ' ') AS posten_id,
        l.kundenkarte_id,
        l.bon_id
    FROM (
        SELECT
            Z.mandant_id,
            Z.wup_id,
            Z.lkp_nb_id,
            Z.lkp_art_id,
            Z.lkp_posten_id,
            Z.dat_booking,
            Z.lkp_mwst,
            Z.lkp_mwst_id,
            Z.lkp_wrg,
            Z.lkp_umrechnungskurs,
            CASE
                WHEN COALESCE(p.promotion_brutto, 0) <> 0
                    THEN 1
                ELSE 0
            END AS promo_fg,
            Z.ean_kasse,
            CASE
                WHEN p.mandant_id IN (4) AND Z.dat_booking >= DATE '2020-03-19' AND p.aktion_id <> ''
                    THEN p.aktion_id
                WHEN p.mandant_id IN (4) AND Z.dat_booking >= DATE '2020-03-19' AND p.aktion_id = ''
                    THEN Z.aktion_id
                WHEN p.mandant_id IN (6) AND Z.dat_booking >= DATE '2020-09-14' AND p.aktion_id <> ''
                    THEN p.aktion_id
                WHEN p.mandant_id IN (6) AND Z.dat_booking >= DATE '2020-09-14' AND p.aktion_id = ''
                    THEN Z.aktion_id
                WHEN p.mandant_id IN (5) AND Z.dat_booking >= DATE '2020-11-19' AND p.aktion_id <> ''
                    THEN p.aktion_id
                WHEN p.mandant_id IN (5) AND Z.dat_booking >= DATE '2020-11-19' AND p.aktion_id = ''
                    THEN Z.aktion_id
                WHEN p.mandant_id IN (2, 7) AND p.aktion_id <> ''
                    THEN p.aktion_id
                ELSE Z.aktion_id
            END AS aktion_id,
            Z.kundenkarte_id,
            Z.bon_id,
            SUM(Z.umsatz_brutto) AS umsatz_brutto_,
            SUM(Z.menge) AS menge_,
            SUM(COALESCE(p.promotion_brutto, 0)) AS umsatz_promotion_brutto_
        FROM dbp_etl.kmo_artbew_bon_1 AS Z
        LEFT JOIN (
            SELECT
                A.mandant_id,
                A.bon_id,
                A.dat_booking,
                A.bon_zeile,
                MAX(COALESCE(B.aktion_id, '')) AS aktion_id,
                SUM(A.umsatz_brutto) AS promotion_brutto
            FROM dbp_etl.kmo_artbew_bon_promotion_1 AS A
            LEFT JOIN dbp_data.l_bonuskauf_1 AS B
                ON
                    A.mandant_id = B.mandant_id AND A.bonuskauf_id = B.bonuskauf_id
                    AND A.dat_booking BETWEEN B.dat_von AND B.dat_bis
            GROUP BY
                A.mandant_id,
                A.bon_id,
                A.dat_booking,
                A.bon_zeile
        ) AS p
            ON
                Z.mandant_id = p.mandant_id AND Z.bon_id = p.bon_id AND Z.dat_booking = p.dat_booking AND Z.bon_zeile
                = p.bon_zeile
        WHERE Z.mandant_id IN (2, 4, 7, 6, 5)
        GROUP BY
            Z.mandant_id,
            Z.wup_id,
            Z.lkp_nb_id,
            Z.lkp_art_id,
            Z.lkp_posten_id,
            Z.dat_booking,
            Z.lkp_mwst,
            Z.lkp_mwst_id,
            Z.lkp_wrg,
            Z.lkp_umrechnungskurs,
            promo_fg,
            Z.ean_kasse,
            aktion_id,
            Z.kundenkarte_id,
            Z.bon_id
    ) AS l
    LEFT JOIN dbp_etl_process.marktabschriften_stamm_1 AS R
        ON
            l.mandant_id = R.mandant_id AND l.lkp_art_id =
            R.art_id AND l.wup_id = R.wup_id AND l.lkp_nb_id = R.nb_id AND l.dat_booking = R.dat
    GROUP BY
        l.mandant_id,
        l.wup_id,
        nb_id,
        art_id,
        gp_id,
        einkaufsorganisation_id,
        bewart_id,
        dat,
        aktion_id,
        herst_id,
        mwst_id,
        wrg_1,
        posten_id,
        bezugsweg_id,
        menge,
        umsatz_netto,
        umsatz_mwst_betrag,
        l.promo_fg,
        l.ean_kasse,
        diff_umsatz_netto_konz,
        diff_umsatz_mwst_betrag_konz,
        l.kundenkarte_id,
        l.bon_id
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DATA.artbew_1 a
--WHERE a.dat = DBX_LOAD.kmo_artbew_bon_dat.dat
--AND (a.mandant_id, a.wup_id, a.dat) IN
--(
--SELECT
--mandant_id
--,wup_id
--,dat
--FROM DBX_LOAD.artbew_kmo_tmp_1
--)
--AND a.bewart_id <> 1010
--;
--
--Comment from validation checker
--error line 2 at position 14
--WHERE a.dat =  ^^^> dbp_etl.kmo_artbew_bon_dat.dat
--invalid identifier 'dbp_etl.KMO_ARTBEW_BON_DAT.DAT'
--translated statement


DELETE FROM dbp_data.artbew_1 AS A
WHERE dat IN (
    SELECT dat
    FROM dbp_etl.kmo_artbew_bon_dat_1) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_kmo_tmp_1
) AND bewart_id <> 1010;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DATA.artbew_promotion_zu_1 a
--WHERE a.dat = DBX_LOAD.kmo_artbew_bon_dat.dat
--AND (a.mandant_id, a.wup_id, a.dat) IN
--(
--SELECT
--mandant_id
--,wup_id
--,dat
--FROM DBX_LOAD.artbew_kmo_tmp_1
--WHERE promo_fg = 1
--)
---- Promotionsbetraege aus Wpuums bis auf weiteres stehen lassen
--AND a.konditionsart_id <> 'RB19'
--;
--
--Comment from validation checker
--error line 2 at position 14
--WHERE a.dat =  ^^^> dbp_etl.kmo_artbew_bon_dat.dat
--invalid identifier 'dbp_etl.KMO_ARTBEW_BON_DAT.DAT'
--translated statement


DELETE FROM dbp_data.artbew_promotion_zu_1 AS A
WHERE dat IN (
    SELECT dat
    FROM dbp_etl.kmo_artbew_bon_dat_1) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_kmo_tmp_1
    WHERE promo_fg = 1
) AND konditionsart_id <> 'RB19';


--[OK] statement is translated correctly (syntax and type checks are fine)


-- ,umrechnungskurs
-- ,umrechnungskurs
-- ,umrechnungskurs
INSERT INTO dbp_data.artbew_1 (
    mandant_id,
    wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id, promo_fg, ean_kasse, einkaufsorganisation_id, herst_id,
    mwst_id, menge, wrg_1, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto,
    ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis, logkostenzuschlag, bezugsweg_id, ek_netto_bnk,
    ek_netto_bnk_sachk, posten_id, bewart_det_id, pv_aktion, pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby,
    pv_aktion_kdn_bby, pv_aktion_kdp_bby
)
(SELECT
    mandant_id,
    wup_id,
    nb_id,
    dat,
    bewart_id,
    gp_id,
    art_id,
    aktion_id,
    promo_fg,
    ean_kasse -- ,umrechnungskurs
    ,
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge_sum,
    wrg_1,
    umsatz_netto_sum,
    diff_umsatz_netto_konz,
    umsatz_mwst_betrag_sum,
    diff_umsatz_mwst_betrag_konz,
    zero_enc AS ek_brutto,
    zero_enc AS ek_netto,
    zero_enc AS ek_nettonetto,
    zero_enc AS ek_kal_basis,
    zero_enc AS ek_mep,
    zero_enc AS einstandspreis,
    0 AS logkostenzuschlag,
    bezugsweg_id,
    zero_enc AS ek_netto_bnk,
    zero_enc AS ek_netto_bnk_sachk,
    posten_id,
    bewart_det_id,
    pv_aktion,
    pv_bby,
    pv_kdn_bby,
    pv_kdp_bby,
    pv_aktion_bby,
    pv_aktion_kdn_bby,
    pv_aktion_kdp_bby
FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        promo_fg,
        gp_id,
        einkaufsorganisation_id,
        bewart_id,
        dat,
        aktion_id,
        herst_id,
        mwst_id,
        wrg_1,
        posten_id,
        bezugsweg_id,
        0 AS zero_enc,
        ean_kasse,
        bewart_det_id,
        pv_aktion,
        pv_bby,
        pv_kdn_bby,
        pv_kdp_bby,
        pv_aktion_bby,
        pv_aktion_kdn_bby,
        pv_aktion_kdp_bby,
        SUM(menge) AS menge_sum,
        SUM(umsatz_netto) AS umsatz_netto_sum,
        SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum,
        SUM(diff_umsatz_netto_konz) AS diff_umsatz_netto_konz,
        SUM(diff_umsatz_mwst_betrag_konz) AS diff_umsatz_mwst_betrag_konz
    FROM dbp_etl.artbew_kmo_tmp_1
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        promo_fg,
        gp_id,
        einkaufsorganisation_id,
        bewart_id,
        dat,
        aktion_id,
        herst_id,
        mwst_id,
        wrg_1,
        posten_id,
        bezugsweg_id,
        zero_enc,
        ean_kasse,
        bewart_det_id,
        pv_aktion,
        pv_bby,
        pv_kdn_bby,
        pv_kdp_bby,
        pv_aktion_bby,
        pv_aktion_kdn_bby,
        pv_aktion_kdp_bby
) AS t0);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.dbp_etl.KMO_ARTBEW_BON_1' does not exist or not authorized.


INSERT INTO dbp_data.artbew_promotion_zu_1 (
    art_id, mandant_id, wup_id, nb_id, dat, bonuskauf_id,
    konditionsart_id, ean_kasse, wrg_id, betrag_promo_netto, betrag_mwst, umrechnungskurs, system_id, menge_promo,
    umsatz_promo_netto, umsatz_mwst
)
(
    SELECT
        L.lkp_art_id AS art_id,
        L.mandant_id,
        L.wup_id,
        L.lkp_nb_id AS nb_id,
        L.dat_booking AS dat,
        P.bonuskauf_id,
        P.konditionsart_id,
        L.ean_kasse,
        L.lkp_wrg AS wrg_id,
        SUM(ROUND(CAST(P.umsatz_brutto / (1 + L.lkp_mwst / 100) AS NUMERIC), 4)),
        SUM(P.umsatz_brutto - ROUND(CAST(P.umsatz_brutto / (1 + L.lkp_mwst / 100) AS NUMERIC), 4)),
        ROUND(CAST(L.lkp_umrechnungskurs AS NUMERIC), 5) AS umrechnungskurs,
        COALESCE(K.system_id, 0) AS system_id,
        SUM(P.menge_promo),
        SUM(ROUND(CAST(P.umsatz_promo_brutto / (1 + L.lkp_mwst / 100) AS NUMERIC), 4)),
        SUM(P.umsatz_promo_brutto - ROUND(CAST(P.umsatz_promo_brutto / (1 + L.lkp_mwst / 100) AS NUMERIC), 4))
    FROM dbp_etl.kmo_artbew_bon_1 AS L
    INNER JOIN dbp_etl.kmo_artbew_bon_promotion_1 AS P
        ON
            L.mandant_id = P.mandant_id AND L.bon_id = P.bon_id
            AND L.dat_booking = P.dat_booking AND L.bon_zeile = P.bon_zeile
    -- Ermittlung System_id fuer oben eingetragene Konditionsarten

    LEFT JOIN dbp_data.l_konditionsart_1 AS K ON P.mandant_id = K.mandant_id AND P.konditionsart_id = K.konditionsart_id

    GROUP BY
        L.mandant_id,
        L.wup_id,
        nb_id,
        art_id,
        dat,
        P.bonuskauf_id,
        P.konditionsart_id,
        wrg_id,
        umrechnungskurs,
        system_id,
        L.ean_kasse
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.artbew_agg_wt_1 (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_etl.artbew_kmo_tmp_1
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_data.artbew_agg_wt_1
    )
    GROUP BY
        wup_id,
        mandant_id,
        nb_id,
        dat
);


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.wupcal_1 SET
    datenlieferung_artbew = 1,
    dat_extrakt_umsatz = CURRENT_DATE("Europe/Berlin"),
    umsatz_brutto_ods_verkauf = x1.umsatz_netto_sum + x1.umsatz_mwst_betrag_sum FROM (
    SELECT
        mandant_id AS mandant_id_,
        wup_id AS wup_id_,
        nb_id AS nb_id_,
        dat AS dat_,
        SUM(umsatz_netto) AS umsatz_netto_sum,
        SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum
    FROM dbp_etl.artbew_kmo_tmp_1
    GROUP BY
        mandant_id_,
        wup_id_,
        nb_id_,
        dat_
) AS x1
WHERE wupcal.mandant_id = x1.mandant_id_ AND wupcal.wup_id = x1.wup_id_ AND wupcal.nb_id = x1.nb_id_ AND wupcal.dat = x1.dat_;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.


UPDATE dbp_data.wupcal_1 SET
    bonanzahl = S.anz_kunden_,
    bonanzahl_imbiss = S.anz_kunden_imbiss_,
    umsatz_brutto_ods_kassenabschluss = S.umsatz_brutto_ods_kassenabschluss_,
    datenlieferung_bonanzahl = 1 FROM (
    SELECT
        K.mandant_id AS mandant_id_,
        K.wup_id AS wup_id_,
        K.bon_dat AS dat_,
        SUM(K.anz_kunden) - SUM(K.anz_kunden_imbiss) AS anz_kunden_,
        SUM(K.anz_kunden_imbiss) AS anz_kunden_imbiss_,
        SUM(K.umsatz_brutto) AS umsatz_brutto_ods_kassenabschluss_
    FROM dbp_ods.ods_bon_kassenabschluss_1 AS K
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        wup_id,
        dat
    FROM dbp_etl.artbew_kmo_tmp_1) AS a
        ON
            K.mandant_id = a.mandant_id AND K.wup_id = a.wup_id AND K.bon_dat
            = a.dat
    GROUP BY
        mandant_id_,
        wup_id_,
        dat_
) AS S
WHERE wupcal.mandant_id = S.mandant_id_ AND wupcal.wup_id = S.wup_id_ AND wupcal.dat = S.dat_;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.wup_1 SET
    kassentyp = 'KPO'
WHERE (
    mandant_id, nb_id, wup_id) IN (
    SELECT (mandant_id, nb_id, wup_id)
    FROM dbp_etl.artbew_kmo_tmp_1
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.dbp_etl.KMO_ARTBEW_BON_1' does not exist or not authorized.


INSERT INTO dbp_etl.kmo_wpuums_art_gp_wup_zu_1 (
    mandant_id, art_id, wup_id, nb_id, dat, bezugsweg_id,
    anz_ek_infosatz, anz_ek_orderbuch, bq_gp_id, bq_ekorg, bq_findung_id, regel_gp_id, regel_ekorg, ref_wup_id, ref_nb_id,
    kreistyp_gruppe_id, wg_id, umrechnungskurs
)
(
    SELECT
        mandant_id,
        lkp_art_id,
        wup_id,
        lkp_nb_id,
        dat_booking,
        0 AS bezugsweg_id,
        0 AS anz_ek_infosatz,
        0 AS anz_ek_orderbuch,
        0 AS bq_gp_id,
        0 AS bq_ekorg,
        0 AS bq_findung_id,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        0 AS ref_wup_id,
        0 AS ref_nb_id,
        '' AS kreistyp_gruppe_id,
        0 AS wg_id,
        lkp_umrechnungskurs
    FROM dbp_etl.kmo_artbew_bon_1 AS A
    WHERE (
        mandant_id, wup_id, lkp_nb_id, lkp_art_id, dat_booking) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, art_id, dat)
        FROM dbp_etl.kmo_wpuums_art_gp_wup_zu_1
    )
    GROUP BY
        mandant_id,
        dat_booking,
        wup_id,
        lkp_art_id,
        lkp_nb_id,
        lkp_umrechnungskurs
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.


UPDATE dbp_ods.bon_load_status_1 SET
    artbew_fg = 1
WHERE xml_name IN (
    SELECT xml_name
    FROM dbp_etl.kmo_artbew_bon_delta_1
);


DELETE FROM dbp_data.crm_kartebew_1 AS A
WHERE dat IN (
    SELECT DISTINCT *
    FROM dbp_etl.kmo_artbew_bon_dat_1) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM (SELECT DISTINCT
        mandant_id,
        wup_id,
        dat
    FROM dbp_etl.artbew_kmo_tmp_crm_1) AS t3
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.crm_kartebew_1 (
    mandant_id, wup_id, nb_id, kundenkarte_id, dat, wrg_id,
    umsatz_netto_sa, umsatz_netto_af, umsatz_brutto_sa, umsatz_brutto_af, anz_bons
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        kundenkarte_id,
        dat,
        wrg_1,
        SUM(CASE
            WHEN bewart_id = 1002
                THEN umsatz_netto
            ELSE 0
        END) AS umsatz_netto_sa,
        SUM(CASE
            WHEN bewart_id = 1001
                THEN umsatz_netto
            ELSE 0
        END) AS umsatz_netto_af,
        SUM(CASE
            WHEN bewart_id = 1002
                THEN umsatz_netto + umsatz_mwst_betrag
            ELSE 0
        END) AS umsatz_brutto_sa,
        SUM(CASE
            WHEN bewart_id = 1001
                THEN umsatz_netto + umsatz_mwst_betrag
            ELSE 0
        END) AS umsatz_brutto_af,
        COUNT(DISTINCT bon_id) AS anz_bons
    FROM dbp_etl.artbew_kmo_tmp_crm_1
    WHERE kundenkarte_id IS NOT NULL
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        kundenkarte_id,
        dat,
        wrg_1
);


DELETE FROM dbp_data.crm_kartebew_1
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 14 DAY) AND (CURRENT_DATE("Europe/Berlin")) AND mandant_id = 1;


INSERT INTO dbp_data.crm_kartebew_1 (
    mandant_id, wup_id, nb_id, kundenkarte_id, dat, wrg_id,
    umsatz_netto_sa, umsatz_netto_af, umsatz_brutto_sa, umsatz_brutto_af, anz_bons
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        0 AS nb_id,
        A.kundenkarte_id,
        A.bon_dat AS dat,
        'EUR' AS wrg_id,
        SUM(CASE
            WHEN Z.aktion_id NOT IN ('', '0', '0000000000')
                THEN CAST(Z.umsatz_brutto * 100 / (100 + D.mwst) AS NUMERIC)
            ELSE 0
        END) AS umsatz_netto_sa,
        SUM(CASE
            WHEN Z.aktion_id IN ('', '0', '0000000000')
                THEN CAST(Z.umsatz_brutto * 100 / (100 + D.mwst) AS NUMERIC)
            ELSE 0
        END) AS umsatz_netto_af,
        SUM(CASE
            WHEN Z.aktion_id NOT IN ('', '0', '0000000000')
                THEN Z.umsatz_brutto
            ELSE 0
        END) AS umsatz_brutto_sa,
        SUM(CASE
            WHEN Z.aktion_id IN ('', '0', '0000000000')
                THEN Z.umsatz_brutto
            ELSE 0
        END) AS umsatz_brutto_af,
        COUNT(DISTINCT A.bon_id) AS anz_bons
    FROM dbp_ods.ods_bon_kopf_1 AS A
    INNER JOIN dbp_ods.ods_bon_verkauf_1 AS Z
        ON
            A.mandant_id = Z.mandant_id AND A.bon_id = Z.bon_id AND A.wup_id
            = Z.wup_id AND A.bon_dat = Z.bon_dat
    INNER JOIN dbp_data.mwst_per_1 AS D
        ON
            A.mandant_id = D.mandant_id AND Z.mwst_id = D.mwst_id AND A.bon_dat
            BETWEEN D.dat_von AND D.dat_bis
    WHERE
        A.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 14 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        AND A.mandant_id = 1
        AND A.kundenkarte_id IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.wup_id,
        nb_id,
        A.kundenkarte_id,
        dat,
        wrg_id
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.artbew_kmo_tmp_1;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.artbew_kmo_tmp_crm_1;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_aktion_relevant_1;
