CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE
    dat_bis = CAST('9999-12-31' AS DATE);

DROP TABLE IF EXISTS dbp_etl.bf_artbew_wg_art_wo_sum_de;

CREATE TABLE IF NOT EXISTS dbp_etl.bf_artbew_wg_art_wo_sum_de (
    mandant_id INT64,
    kjwo INT64,
    wg_id INT64,
    art_id INT64,
    wup_id INT64,
    nb_id INT64,
    bewart_id INT64,
    menge NUMERIC(29, 3),
    umsatz_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);

DROP TABLE IF EXISTS dbp_etl.bf_listung_markt_kw;

CREATE TABLE IF NOT EXISTS dbp_etl.bf_listung_markt_kw (
    mandant_id INT64,
    wg_id INT64,
    art_id INT64,
    wup_id INT64,
    nb_id INT64,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    kjwo INT64,
    absatz NUMERIC(29, 3),
    absatz_sa NUMERIC(29, 3),
    absatz_af NUMERIC(29, 3),
    umsatz NUMERIC(29, 4),
    umsatz_sa NUMERIC(29, 4),
    umsatz_af NUMERIC(29, 4),
    ertrag NUMERIC(29, 4),
    ertrag_sa NUMERIC(29, 4),
    ertrag_af NUMERIC(29, 4),
    anzahl_wochen_mit_absatz INT64,
    anzahl_wochen_mit_absatz_sa INT64,
    anzahl_wochen_mit_absatz_af INT64
);

CREATE OR REPLACE TEMPORARY TABLE _art_leistung_1 AS
SELECT
    mandant_id,
    art_matching_id,
    art_nielsen_id,
    gtin_id,
    art_id,
    umrech_faktor,
    status,
    MAX(kl_wg_id) OVER (
        PARTITION BY art_matching_id
        ORDER BY kl_wg_id IS NULL, kl_wg_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_wg_id,
    MAX(kl_owg_id) OVER (
        PARTITION BY art_matching_id
        ORDER BY kl_owg_id IS NULL, kl_owg_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_owg_id,
    MAX(kl_uwg_id) OVER (
        PARTITION BY art_matching_id
        ORDER BY kl_uwg_id IS NULL, kl_uwg_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per
WHERE
    art_id <> -1
    AND art_id IN (
        SELECT DISTINCT art_id
        FROM dbp_etl.kl_basis_listung
    )
    AND NOT (art_matching_id, art_id) IN (
        SELECT (art_matching_id, art_id)
        FROM dbp_etl.not_listed_basis
    );

INSERT INTO `_art_leistung_1`
(
    SELECT
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        gtin_id,
        art_id,
        umrech_faktor,
        status,
        MAX(kl_wg_id) OVER (
            PARTITION BY art_matching_id
            ORDER BY kl_wg_id IS NULL, kl_wg_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS kl_wg_id,
        MAX(kl_owg_id) OVER (
            PARTITION BY art_matching_id
            ORDER BY kl_owg_id IS NULL, kl_owg_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS kl_owg_id,
        MAX(kl_uwg_id) OVER (
            PARTITION BY art_matching_id
            ORDER BY kl_uwg_id IS NULL, kl_uwg_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
    WHERE
        status = 'G' AND NOT art_id IN (
            SELECT art_id
            FROM `_art_leistung_1`
        )
);

CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_1st_base AS
SELECT
    a.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    COUNT(DISTINCT x.kjwo) AS anz,
    SUM(a.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
    SUM(a.menge) AS menge_,
    SUM(a.umsatz_brutto) AS umsatz_,
    SUM(a.menge_af) AS menge_af_,
    SUM(a.umsatz_brutto_af) AS umsatz_af_,
    SUM(a.menge_sa) AS menge_sa_,
    SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK() OVER (
        PARTITION BY c.kl_owg_id
        ORDER BY SUM(a.umsatz_brutto) IS NULL DESC, SUM(a.umsatz_brutto) DESC
    ) AS rang_umsatz_uwg,
    DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(a.menge) IS NULL DESC, SUM(a.menge) DESC) AS rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo AS a
INNER JOIN (
    SELECT
        kjwo,
        MIN(kjmo) AS kjmo
    FROM dbp_data.tag
    GROUP BY
        kjwo
) AS x
    ON a.kjwo = x.kjwo
INNER JOIN `_art_nielsen` AS b
    ON a.mandant_id = b.mandant_id AND a.art_nielsen_id = b.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        gtin_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        mandant_id,
        gtin_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c
    ON b.gtin_id = c.gtin_id AND b.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market AS d
    ON a.mandant_id = d.mandant_id AND a.nielsen_market_id = d.nielsen_market_id
WHERE
    a.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE
            mandant_id = 1
        GROUP BY
            kjwo
        QUALIFY
            (
                (
                    RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)
                ) * -1
            ) BETWEEN -52 AND (
                -1
            )
    )
    AND d.nielsen_market_cluster_id = 2
    AND a.mandant_id = 1
    AND NOT b.gtin_id IN (-9999, -9998)
GROUP BY
    a.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id;

INSERT INTO `_artikel_anteil_uwg_ranking_1st_base`
(
    SELECT
        a.mandant_id,
        c.art_matching_id,
        c.kl_wg_id,
        c.kl_owg_id,
        c.kl_uwg_id,
        COUNT(DISTINCT x.kjwo) AS anz,
        SUM(a.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
        SUM(a.menge) AS menge_,
        SUM(a.umsatz_brutto) AS umsatz_,
        SUM(a.menge_af) AS menge_af_,
        SUM(a.umsatz_brutto_af) AS umsatz_af_,
        SUM(a.menge_sa) AS menge_sa_,
        SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
        SUM(0) AS umsatz_anteil_kum_uwg,
        DENSE_RANK() OVER (
            PARTITION BY c.kl_owg_id
            ORDER BY SUM(a.umsatz_brutto) IS NULL DESC, SUM(a.umsatz_brutto) DESC
        ) AS rang_umsatz_uwg,
        DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(a.menge) IS NULL DESC, SUM(a.menge) DESC) AS rang_absatz_uwg,
        0 AS rang_umsatz_wg
    FROM dbp_data.art_nielsen_fakten_kjwo AS a
    INNER JOIN (
        SELECT
            kjwo,
            MIN(kjmo) AS kjmo
        FROM dbp_data.tag
        GROUP BY
            kjwo
    ) AS x
        ON a.kjwo = x.kjwo
    INNER JOIN `_art_nielsen` AS b
        ON a.mandant_id = b.mandant_id AND a.art_nielsen_id = b.art_nielsen_id
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_nielsen_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id
        FROM dbp_etl.art_matching_nielsen_per
        GROUP BY
            mandant_id,
            art_matching_id,
            art_nielsen_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id
    ) AS c
        ON b.art_nielsen_id = c.art_nielsen_id AND b.mandant_id = c.mandant_id
    INNER JOIN dbp_data.nielsen_market AS d
        ON a.mandant_id = d.mandant_id AND a.nielsen_market_id = d.nielsen_market_id
    WHERE
        a.kjwo IN (
            SELECT kjwo
            FROM dbp_data.art_nielsen_fakten_kjwo
            WHERE
                mandant_id = 1
            GROUP BY
                kjwo
            QUALIFY
                (
                    (
                        RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)
                    ) * -1
                ) BETWEEN -52 AND (
                    -1
                )
        )
        AND d.nielsen_market_cluster_id = 2
        AND b.gtin_id IN (-9999, -9998)
        AND a.mandant_id = 1
    GROUP BY
        a.mandant_id,
        c.art_matching_id,
        c.kl_wg_id,
        c.kl_owg_id,
        c.kl_uwg_id
);

CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking AS
SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    MAX(anz) AS anz,
    SUM(distr_gew_) AS distr_gew_,
    SUM(menge_) AS menge__,
    SUM(umsatz_) AS umsatz__,
    SUM(menge_af_) AS menge_af_,
    SUM(umsatz_af_) AS umsatz_af_,
    SUM(menge_sa_) AS menge_sa_,
    SUM(umsatz_sa_) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK() OVER (PARTITION BY kl_owg_id ORDER BY SUM(umsatz_) IS NULL DESC, SUM(umsatz_) DESC) AS rang_umsatz_uwg,
    DENSE_RANK() OVER (PARTITION BY kl_owg_id ORDER BY SUM(menge_) IS NULL DESC, SUM(menge_) DESC) AS rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM `_artikel_anteil_uwg_ranking_1st_base` AS a
GROUP BY
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;

CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_leistung_base1 AS
SELECT
    MAX(art_nielsen_id) AS art_nielsen_id,
    art_matching_id,
    MAX(art_id) AS art_id,
    kl_owg_id,
    kl_uwg_id,
    0 AS distr_gew,
    NULL AS rang_umsatz_wg,
    NULL AS rang_umsatz_uwg,
    NULL AS rang_absatz_uwg
FROM `_art_leistung_1`
WHERE
    art_nielsen_id <> -1
GROUP BY
    art_matching_id,
    kl_owg_id,
    kl_uwg_id,
    distr_gew;

CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_wg_ranking AS
SELECT
    art_matching_id,
    MIN(kl_wg_id) AS kl_wg_id_,
    SUM(umsatz__) AS umsatz___,
    DENSE_RANK() OVER (
        PARTITION BY MIN(kl_wg_id)
        ORDER BY SUM(umsatz__) IS NULL DESC, SUM(umsatz__) DESC
    ) AS rang_umsatz_wg
FROM `_artikel_anteil_uwg_ranking`
GROUP BY
    art_matching_id;

UPDATE `_artikel_anteil_uwg_leistung_base1` SET rang_umsatz_uwg = b.rang_umsatz_uwg, rang_absatz_uwg = b.rang_absatz_uwg, distr_gew = CAST(b.distr_gew_ AS INT64)
FROM `_artikel_anteil_uwg_ranking` AS b
WHERE
    `_artikel_anteil_uwg_leistung_base1`.art_matching_id = b.art_matching_id
    AND `_artikel_anteil_uwg_leistung_base1`.kl_uwg_id = b.kl_uwg_id
    AND `_artikel_anteil_uwg_leistung_base1`.kl_owg_id = b.kl_owg_id;

UPDATE `_artikel_anteil_uwg_leistung_base1` SET rang_umsatz_wg = b.rang_umsatz_wg
FROM `_artikel_anteil_wg_ranking` AS b
WHERE
    `_artikel_anteil_uwg_leistung_base1`.art_matching_id = b.art_matching_id;

UPDATE `_artikel_anteil_uwg_ranking` SET rang_umsatz_wg = b.rang_umsatz_wg
FROM `_artikel_anteil_wg_ranking` AS b
WHERE
    `_artikel_anteil_uwg_ranking`.art_matching_id = b.art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _sal_snap_1 AS
SELECT
    b.art_matching_id,
    b.art_id,
    b.umrech_faktor,
    b.status,
    0 AS distr_gew,
    a.monat,
    a.anz_monate,
    a.wg_id,
    a.wug_id,
    a.art_nr,
    a.art_bez,
    a.art_status,
    a.akt_lieferant,
    a.zek,
    a.eigenmarke,
    a.bio,
    a.tierwohl,
    a.vegan,
    a.posten_food,
    a.posten_nonfood,
    a.gluten,
    a.mwst,
    a.disc_pe,
    a.disc_marke,
    a.lcf,
    a.k_listung,
    a.ost_basis,
    a.ost_gross,
    a.sued_ost,
    a.sued_west,
    a.west,
    a.nord,
    a.kol_bst,
    a.kol_la,
    a.rlz_dz,
    a.rlz,
    a.k1_absatz,
    a.k1_markt_wochen,
    a.k1_absatz_mt_wo,
    a.k2_absatz,
    a.k2_markt_wochen,
    a.k2_absatz_mt_wo,
    a.k3_absatz,
    a.k3_markt_wochen,
    a.k3_absatz_mt_wo,
    a.k4_absatz,
    a.k4_markt_wochen,
    a.k4_absatz_mt_wo,
    a.k5_absatz,
    a.k5_markt_wochen,
    a.k5_absatz_mt_wo,
    a.ost_basis_absatz,
    a.ost_basis_markt_wochen,
    a.ost_basis_absatz_mt_wo,
    a.ost_gross_absatz,
    a.ost_gross_markt_wochen,
    a.ost_gross_absatz_mt_wo,
    a.sued_ost_absatz,
    a.sued_ost_markt_wochen,
    a.sued_ost_absatz_mt_wo,
    a.sued_west_absatz,
    a.sued_west_markt_wochen,
    a.sued_west_absatz_mt_wo,
    a.west_absatz,
    a.west_markt_wochen,
    a.west_absatz_mt_wo,
    a.nord_absatz,
    a.nord_markt_wochen,
    a.nord_absatz_mt_wo,
    a.total_absatz,
    a.total_absatz_mt_wo,
    a.stg_absatz_vj,
    a.schnelldreherquote,
    a.aktion_absatz,
    a.kassenumsatz,
    a.stueck_re_mep,
    a.total_re_mep,
    a.stg_re_mep_vj,
    a.avg_spanne_mep,
    a.avg_spanne_af_mep,
    a.avg_spanne_sa_mep,
    a.abschr_o_werb,
    a.abschr_o_werb_umsatz,
    a.kb,
    a.vk_pk_1,
    a.vk_pk_4,
    a.sp_kb_pk_1,
    a.sp_kb_pk_4,
    a.total_af_absatz,
    a.absatz_af_markt_wochen,
    a.total_absatz_af_mt_wo,
    a.total_sa_absatz,
    a.absatz_sa_markt_tage,
    a.total_absatz_sa_mt_tag,
    a.stueck_re_mep_af,
    a.stueck_re_mep_sa,
    a.af_re_mep,
    a.sa_re_mep,
    a.total_umsatz_netto,
    a.total_umsatz_netto_mt_wo,
    a.af_umsatz_netto,
    a.af_umsatz_netto_mt_wo,
    a.sa_umsatz_netto,
    a.sa_umsatz_netto_mt_tag,
    a.total_re_mep_mt_wo,
    a.af_re_mep_mt_wo,
    a.sa_re_mep_mt_tag,
    a.anz_maerkte,
    a.anz_wo_mit_absatz,
    a.anz_wo_listung,
    a.anz_listung_as_is,
    a.kol_la_bzw,
    a.kol_bst_bzw,
    a.lagerprozent,
    a.td_update,
    a.td_insert
FROM dbp_etl.bf_sort_sal_export AS a
INNER JOIN (
    SELECT
        art_matching_id,
        CAST(FLOOR(art_id / 100) AS INT64) AS kl_art_id,
        art_id,
        umrech_faktor,
        status
    FROM `_art_leistung_1`
    GROUP BY
        art_matching_id,
        kl_art_id,
        art_id,
        umrech_faktor,
        status
) AS b
    ON ROUND(CAST(a.art_nr AS BIGNUMERIC), 0) = b.kl_art_id;

CREATE OR REPLACE TEMPORARY TABLE _sal_snap_2 AS
SELECT
    art_matching_id,
    status,
    umrech_faktor,
    0 AS kl_wg_id,
    0 AS kl_owg_id,
    0 AS kl_uwg_id,
    NULL AS rang_umsatz_wg,
    NULL AS rang_umsatz_uwg,
    NULL AS rang_absatz_uwg,
    art_id,
    CAST(FLOOR(art_id / 100) AS INT64) AS kl_art_id,
    wug_id,
    art_bez,
    art_status,
    ROUND(CAST(SUBSTR(akt_lieferant, 1, INSTR(akt_lieferant, ':') - 1) AS BIGNUMERIC), 0) AS gp_id,
    akt_lieferant,
    zek,
    disc_pe,
    disc_marke,
    lcf,
    vegan,
    gluten,
    bio,
    eigenmarke,
    tierwohl,
    posten_food,
    posten_nonfood,
    mwst,
    k_listung,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    nord,
    anz_maerkte,
    distr_gew AS gewichtete_distribution,
    0 AS index_af_id, /* Index-AF */
    af_umsatz_netto_mt_wo AS umsatz_af_pro_markt_woche,
    total_absatz_af_mt_wo /* af_umsatz_netto/anz_wo_listung AS umsatz_af_pro_markt_woche, */ * umrech_faktor AS absatz_af_pro_markt_woche,
    af_re_mep_mt_wo AS ertrag_af_pro_markt_woche, /* total_af_absatz/anz_wo_listung AS absatz_af_pro_markt_woche, */
    0 AS bonreichweite_af,
    IFNULL(af_re_mep_mt_wo / IF(af_umsatz_netto_mt_wo = 0, NULL, af_umsatz_netto_mt_wo), 0) AS spanne_af,
    0 AS index_sa_id, /* Index-SA */
    IFNULL(sa_umsatz_netto / IF(absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage), 0) * 6.00 AS umsatz_sa_pro_markt_woche,
    IFNULL(
        total_sa_absatz * umrech_faktor / IF(absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage),
        0
    ) * 6.00 AS absatz_sa_pro_markt_woche,
    IFNULL(sa_re_mep / IF(absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage), 0) * 6.00 AS ertrag_sa_pro_markt_woche,
    0 AS bonreichweite_sa,
    IFNULL(
        IFNULL(sa_re_mep / IF(absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage), 0) * 6.00 / IF(
            IFNULL(sa_umsatz_netto / IF(absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage), 0) * 6.00 = 0,
            NULL,
            IFNULL(sa_umsatz_netto / IF(absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage), 0) * 6.00
        ),
        0
    ) AS spanne_sa,
    aktion_absatz /* Kennzahlen */ * umrech_faktor AS aktionsanteil_absatz,
    total_absatz * umrech_faktor AS absatz_total,
    schnelldreherquote /* Bon */ / 100 AS schnelldreherquote,
    0 AS schnelldreherquote_wg,
    0 AS schnelldreherquote_owg,
    CASE
        WHEN NOT kol_la_bzw IS NULL
            THEN IFNULL(
                rlz * lagerprozent * COALESCE(total_absatz_af_mt_wo * umrech_faktor / 6, total_absatz_sa_mt_tag * umrech_faktor) / IF(kol_la_bzw = 0, NULL, kol_la_bzw),
                0
            )
        ELSE CAST(IFNULL(
            rlz_dz * COALESCE(total_absatz_af_mt_wo * umrech_faktor / 6, total_absatz_sa_mt_tag * umrech_faktor) / IF(kol_bst_bzw = 0, NULL, kol_bst_bzw),
            0
        ) AS FLOAT64)
    END AS kolliabverkaufsquote,
    0 AS kolliabverkaufsquote_wg,
    0 AS kolliabverkaufsquote_owg,
    IFNULL(abschr_o_werb / IF(kassenumsatz = 0, NULL, kassenumsatz), 0) AS abschriftsanteil,
    0 AS abschriftsanteil_wg,
    0 AS abschriftsanteil_owg,
    0 AS cherrypicker_quote,
    0 AS cherrypicker_quote_wg,
    0 AS cherrypicker_quote_owg,
    0 AS restbon,
    0 AS restbon_wg,
    0 AS restbon_owg,
    vk_pk_1 AS vk_preis, /* Bewertung */
    CASE
        WHEN af_umsatz_netto <> 0
            THEN IFNULL(
                af_umsatz_netto * (
                    (
                        100 + mwst
                    ) / 100
                ) / IF(total_af_absatz = 0, NULL, total_af_absatz),
                0
            )
        ELSE IFNULL(
            sa_umsatz_netto * (
                (
                    100 + mwst
                ) / 100
            ) / IF(total_sa_absatz = 0, NULL, total_sa_absatz),
            0
        )
    END AS durchschnittspreis,
    0 AS preislagenverteilung,
    0 AS marktanteilbewertung,
    anz_wo_mit_absatz, /* zur Berechnung */
    anz_wo_listung,
    kol_la_bzw,
    kol_bst_bzw,
    rlz_dz,
    rlz,
    lagerprozent,
    total_absatz_af_mt_wo * umrech_faktor AS total_absatz_af_mt_wo,
    total_absatz_sa_mt_tag * umrech_faktor AS total_absatz_sa_mt_tag,
    total_af_absatz * umrech_faktor AS total_af_absatz,
    total_sa_absatz * umrech_faktor AS total_sa_absatz,
    af_umsatz_netto,
    sa_umsatz_netto,
    absatz_sa_markt_tage * umrech_faktor AS absatz_sa_markt_tage,
    absatz_af_markt_wochen * umrech_faktor AS absatz_af_markt_wochen,
    CAST(abschr_o_werb AS FLOAT64) AS abschr_o_werb,
    CAST(kassenumsatz AS FLOAT64) AS kassenumsatz
FROM `_sal_snap_1`;

UPDATE `_sal_snap_2` SET bonreichweite_af = CAST(b.krw_af AS INT64), bonreichweite_sa = CAST(b.krw_sa AS INT64)
FROM (
    SELECT
        kl_art_id,
        SUM(krw_af) AS krw_af,
        SUM(krw_sa) AS krw_sa,
        SUM(cpq_total) AS cpq_total,
        SUM(rb_total) AS rb_total
    FROM dbp_etl.bf_bons_sort_export
    WHERE
        bereich = 'alle' AND mandant_id = 1
    GROUP BY
        kl_art_id
) AS b
WHERE
    `_sal_snap_2`.kl_art_id = b.kl_art_id;

CREATE OR REPLACE TEMPORARY TABLE _step1 AS
SELECT
    b.mandant_id,
    b.art_id,
    c.wg_id,
    SUM(a.artikel_bons_af) AS art_bons_af,
    SUM(a.artikel_bons_sa) AS art_bons_sa,
    SUM(a.cpq_total) AS cpq_total_artikel,
    SUM(a.cherry_bons_af) AS cp_bons_af,
    SUM(a.cherry_bons_sa) AS cp_bons_sa,
    SUM(a.bons) AS bons,
    SUM(a.rb_total) AS rb_total
FROM dbp_etl.bf_bons_sort_export AS a
INNER JOIN dbp_data.art AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.kl_art_id = b.kl_art_id
        AND b.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.art_wg_zu_per AS c
    ON
        a.mandant_id = c.mandant_id
        AND b.art_id = c.art_id
        AND c.arthiertyp_id = 2
        AND c.dat_bis = PARSE_DATE('%F', '9999-12-31')
WHERE
    a.bereich = 'alle' AND a.mandant_id = 1
GROUP BY
    b.mandant_id,
    b.art_id,
    c.wg_id;

CREATE OR REPLACE TEMPORARY TABLE _step2 AS
SELECT
    mandant_id,
    wg_id,
    (
        SUM(CAST(cp_bons_af AS FLOAT64)) + SUM(CAST(cp_bons_sa AS FLOAT64))
    ) / IF(
        SUM(CAST(art_bons_af AS FLOAT64) + CAST(art_bons_sa AS FLOAT64)) = 0,
        NULL,
        SUM(CAST(art_bons_af AS FLOAT64) + CAST(art_bons_sa AS FLOAT64))
    ) AS cpq_total_wg
FROM `_step1`
GROUP BY
    mandant_id,
    wg_id;

CREATE OR REPLACE TEMPORARY TABLE _sal_snap_2_multis AS
SELECT
    a.art_matching_id,
    a.status,
    a.umrech_faktor,
    a.kl_wg_id,
    a.kl_owg_id,
    a.kl_uwg_id,
    a.rang_umsatz_wg,
    a.rang_umsatz_uwg,
    a.rang_absatz_uwg,
    a.art_id,
    a.kl_art_id,
    a.wug_id,
    a.art_bez,
    a.art_status,
    a.gp_id,
    a.akt_lieferant,
    a.zek,
    a.disc_pe,
    a.disc_marke,
    a.lcf,
    a.vegan,
    a.gluten,
    a.bio,
    a.eigenmarke,
    a.tierwohl,
    a.posten_food,
    a.posten_nonfood,
    a.mwst,
    a.k_listung,
    a.ost_basis,
    a.ost_gross,
    a.sued_ost,
    a.sued_west,
    a.west,
    a.nord,
    a.anz_maerkte,
    a.gewichtete_distribution,
    a.index_af_id,
    a.umsatz_af_pro_markt_woche,
    a.absatz_af_pro_markt_woche,
    a.ertrag_af_pro_markt_woche,
    a.bonreichweite_af,
    a.spanne_af,
    a.index_sa_id,
    a.umsatz_sa_pro_markt_woche,
    a.absatz_sa_pro_markt_woche,
    a.ertrag_sa_pro_markt_woche,
    a.bonreichweite_sa,
    a.spanne_sa,
    a.aktionsanteil_absatz,
    a.absatz_total,
    a.schnelldreherquote,
    a.schnelldreherquote_wg,
    a.schnelldreherquote_owg,
    a.kolliabverkaufsquote,
    a.kolliabverkaufsquote_wg,
    a.kolliabverkaufsquote_owg,
    a.abschriftsanteil,
    a.abschriftsanteil_wg,
    a.abschriftsanteil_owg,
    a.cherrypicker_quote,
    a.cherrypicker_quote_wg,
    a.cherrypicker_quote_owg,
    a.restbon,
    a.restbon_wg,
    a.restbon_owg,
    a.vk_preis,
    a.durchschnittspreis,
    a.preislagenverteilung,
    a.marktanteilbewertung,
    a.anz_wo_mit_absatz,
    a.anz_wo_listung,
    a.kol_la_bzw,
    a.kol_bst_bzw,
    a.rlz_dz,
    a.rlz,
    a.lagerprozent,
    a.total_absatz_af_mt_wo,
    a.total_absatz_sa_mt_tag,
    a.total_af_absatz,
    a.total_sa_absatz,
    a.af_umsatz_netto,
    a.sa_umsatz_netto,
    a.absatz_sa_markt_tage,
    a.absatz_af_markt_wochen,
    a.abschr_o_werb,
    a.kassenumsatz
FROM `_sal_snap_2` AS a
INNER JOIN (
    SELECT art_matching_id
    FROM `_sal_snap_2`
    WHERE
        status IN ('G', 'T')
    GROUP BY
        art_matching_id
    HAVING
        COUNT(*) > 1
) AS b
    ON a.art_matching_id = b.art_matching_id;

UPDATE `_sal_snap_2_multis` SET art_id = t8.art_id, wug_id = t8.wug_id, art_bez = t8.art_bez, art_status = t8.art_status, gp_id = t8.gp_id, akt_lieferant = t8.akt_lieferant, zek = t8.zek, disc_pe = t8.disc_pe, disc_marke = t8.disc_marke, lcf = t8.lcf, vegan = t8.vegan, gluten = t8.gluten, bio = t8.bio, eigenmarke = t8.eigenmarke, tierwohl = t8.tierwohl, posten_food = t8.posten_food, posten_nonfood = t8.posten_nonfood, mwst = t8.mwst, k_listung = t8.k_listung, ost_basis = t8.ost_basis, ost_gross = t8.ost_gross, sued_ost = t8.sued_ost, sued_west = t8.sued_west, west = t8.west, nord = t8.nord, anz_maerkte = t8.anz_maerkte
FROM (
    SELECT
        y.art_matching_id,
        y.status,
        y.umrech_faktor,
        y.kl_wg_id,
        y.kl_owg_id,
        y.kl_uwg_id,
        y.rang_umsatz_wg,
        y.rang_umsatz_uwg,
        y.rang_absatz_uwg,
        y.art_id,
        y.kl_art_id,
        y.wug_id,
        y.art_bez,
        y.art_status,
        y.gp_id,
        y.akt_lieferant,
        y.zek,
        y.disc_pe,
        y.disc_marke,
        y.lcf,
        y.vegan,
        y.gluten,
        y.bio,
        y.eigenmarke,
        y.tierwohl,
        y.posten_food,
        y.posten_nonfood,
        y.mwst,
        y.k_listung,
        y.ost_basis,
        y.ost_gross,
        y.sued_ost,
        y.sued_west,
        y.west,
        y.nord,
        y.anz_maerkte,
        y.gewichtete_distribution,
        y.index_af_id,
        y.umsatz_af_pro_markt_woche,
        y.absatz_af_pro_markt_woche,
        y.ertrag_af_pro_markt_woche,
        y.bonreichweite_af,
        y.spanne_af,
        y.index_sa_id,
        y.umsatz_sa_pro_markt_woche,
        y.absatz_sa_pro_markt_woche,
        y.ertrag_sa_pro_markt_woche,
        y.bonreichweite_sa,
        y.spanne_sa,
        y.aktionsanteil_absatz,
        y.absatz_total,
        y.schnelldreherquote,
        y.schnelldreherquote_wg,
        y.schnelldreherquote_owg,
        y.kolliabverkaufsquote,
        y.kolliabverkaufsquote_wg,
        y.kolliabverkaufsquote_owg,
        y.abschriftsanteil,
        y.abschriftsanteil_wg,
        y.abschriftsanteil_owg,
        y.cherrypicker_quote,
        y.cherrypicker_quote_wg,
        y.cherrypicker_quote_owg,
        y.restbon,
        y.restbon_wg,
        y.restbon_owg,
        y.vk_preis,
        y.durchschnittspreis,
        y.preislagenverteilung,
        y.marktanteilbewertung,
        y.anz_wo_mit_absatz,
        y.anz_wo_listung,
        y.kol_la_bzw,
        y.kol_bst_bzw,
        y.rlz_dz,
        y.rlz,
        y.lagerprozent,
        y.total_absatz_af_mt_wo,
        y.total_absatz_sa_mt_tag,
        y.total_af_absatz,
        y.total_sa_absatz,
        y.af_umsatz_netto,
        y.sa_umsatz_netto,
        y.absatz_sa_markt_tage,
        y.absatz_af_markt_wochen,
        y.abschr_o_werb,
        y.kassenumsatz
    FROM `_sal_snap_2_multis` AS y
    INNER JOIN (
        SELECT
            x.art_matching_id,
            x.kl_art_id
        FROM `_sal_snap_2_multis` AS x
        INNER JOIN (
            SELECT
                art_id,
                MAX(dat_von) AS dat_von
            FROM dbp_data.art_wup_zu_per
            WHERE
                mandant_id = 1 AND listung_id = 1
            GROUP BY
                art_id
        ) AS y
            ON x.kl_art_id = CAST(FLOOR(y.art_id / 100) AS INT64)
        GROUP BY
            x.art_matching_id,
            x.kl_art_id,
            y.art_id
        QUALIFY
            (
                ROW_NUMBER() OVER (
                    PARTITION BY x.art_matching_id
                    ORDER BY x.art_matching_id IS NULL DESC, x.art_matching_id DESC, MAX(dat_von) IS NULL DESC, MAX(dat_von) DESC, x.kl_art_id IS NULL DESC, x.kl_art_id DESC
                )
            ) = 1
    ) AS x1
        ON y.art_matching_id = x1.art_matching_id AND y.kl_art_id = x1.kl_art_id
    QUALIFY
        (
            ROW_NUMBER() OVER (
                PARTITION BY y.art_matching_id
                ORDER BY y.art_matching_id IS NULL DESC, y.art_matching_id DESC, y.kl_art_id IS NULL DESC, y.kl_art_id DESC
            )
        ) = 1
) AS t8
WHERE
    `_sal_snap_2_multis`.art_matching_id = t8.art_matching_id;

INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_de
(
    SELECT
        a.mandant_id,
        c.kjwo,
        b.wg_id,
        a.art_id,
        a.wup_id,
        a.nb_id,
        a.bewart_id,
        CAST(a.menge * d.umrech_faktor AS NUMERIC) AS menge,
        a.umsatz_netto,
        a.ek_mep
    FROM dbp_data.artbew_wo_sum AS a
    INNER JOIN dbp_data.woche_kj_kl AS c
        ON a.kjwo_kl = c.kjwo_kl
    INNER JOIN dbp_data.art_wg_zu_per AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.art_id = b.art_id
            AND b.arthiertyp_id = 2
            AND b.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_etl.art_matching_nielsen_per AS d
        ON a.art_id = d.art_id
    WHERE
        c.kjwo IN (
            SELECT kjwo
            FROM dbp_data.art_nielsen_fakten_kjwo
            WHERE
                mandant_id = 1
            GROUP BY
                kjwo
            QUALIFY
                (
                    (
                        RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)
                    ) * -1
                ) BETWEEN -52 AND (
                    -1
                )
        )
        AND d.status IN ('T', 'G')
        AND a.mandant_id = 1
);

INSERT INTO dbp_etl.bf_listung_markt_kw (
    mandant_id,
    wg_id,
    art_id,
    wup_id,
    nb_id,
    kreistyp_gruppe_id,
    kjwo,
    absatz,
    absatz_sa,
    absatz_af,
    umsatz,
    umsatz_sa,
    umsatz_af,
    ertrag,
    ertrag_sa,
    ertrag_af,
    anzahl_wochen_mit_absatz,
    anzahl_wochen_mit_absatz_sa,
    anzahl_wochen_mit_absatz_af
)
(
    SELECT
        v01.mandant_id,
        v01.wg_id,
        v01.art_id,
        v01.wup_id,
        v01.nb_id,
        v04.kreistyp_gruppe_id,
        v01.kjwo,
        IFNULL(SUM(v01.menge), 0) AS absatz,
        CAST(IFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END), 0) AS NUMERIC) AS absatz_sa,
        CAST(IFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE NULL END), 0) AS NUMERIC) AS absatz_af,
        IFNULL(SUM(v01.umsatz_netto), 0) AS umsatz,
        CAST(IFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto ELSE NULL END), 0) AS NUMERIC) AS umsatz_sa,
        CAST(IFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto ELSE NULL END), 0) AS NUMERIC) AS umsatz_af,
        IFNULL(SUM(v01.umsatz_netto - v01.ek_mep), 0) AS ertrag,
        CAST(IFNULL(
            SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto - v01.ek_mep ELSE NULL END),
            0
        ) AS NUMERIC) AS ertrag_sa,
        CAST(IFNULL(
            SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto - v01.ek_mep ELSE NULL END),
            0
        ) AS NUMERIC) AS ertrag_af,
        IFNULL(
            CASE WHEN IFNULL(SUM(v01.menge), 0) > 0 THEN COUNT(DISTINCT v01.kjwo) ELSE NULL END,
            0
        ) AS anzahl_wochen_mit_absatz,
        IFNULL(
            CASE
                WHEN
                    IFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END), 0) > 0
                    AND NOT IFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END), 0) IS NULL
                    THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo ELSE NULL END)
                ELSE NULL
            END,
            0
        ) AS anzahl_wochen_mit_absatz_sa,
        IFNULL(
            CASE
                WHEN
                    IFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE NULL END), 0) > 0
                    AND NOT IFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE NULL END), 0) IS NULL
                    THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo ELSE NULL END)
                ELSE NULL
            END,
            0
        ) AS anzahl_wochen_mit_absatz_af
    FROM dbp_etl.bf_artbew_wg_art_wo_sum_de AS v01
    INNER JOIN dbp_data.art_wg_zu_per AS v03
        ON v01.art_id = v03.art_id AND v01.mandant_id = v03.mandant_id
    INNER JOIN dbp_data.wup AS v04
        ON
            v01.wup_id = v04.wup_id
            AND v01.nb_id = v04.nb_id
            AND v01.mandant_id = v04.mandant_id
    WHERE
        v01.mandant_id = 1
        AND v03.arthiertyp_id = 2
        AND v03.dat_bis = PARSE_DATE('%F', '9999-12-31')
    GROUP BY
        v01.mandant_id,
        v01.wg_id,
        v01.art_id,
        v01.wup_id,
        v01.nb_id,
        v04.kreistyp_gruppe_id,
        v01.kjwo
);

CREATE OR REPLACE TEMPORARY TABLE _anz_wochen AS
SELECT
    a.kjwo,
    b.art_matching_id,
    a.wup_id,
    IFNULL(SUM(a.absatz), 0) AS absatz_,
    IFNULL(SUM(a.absatz_af), 0) AS absatz_af_,
    IFNULL(SUM(a.absatz_sa), 0) AS absatz_sa_,
    IFNULL(SUM(a.umsatz), 0) AS umsatz_,
    IFNULL(SUM(a.umsatz_af), 0) AS umsatz_af_,
    IFNULL(SUM(a.umsatz_sa), 0) AS umsatz_sa_,
    IFNULL(SUM(a.ertrag), 0) AS ertrag_,
    IFNULL(SUM(a.ertrag_af), 0) AS ertrag_af_,
    IFNULL(SUM(a.ertrag_sa), 0) AS ertrag_sa_,
    IFNULL(
        CASE WHEN IFNULL(SUM(a.absatz), 0) > 0 THEN COUNT(DISTINCT a.kjwo) ELSE NULL END,
        0
    ) AS anzahl_wochen_mit_absatz,
    IFNULL(
        CASE WHEN IFNULL(SUM(a.absatz_af), 0) > 0 THEN COUNT(DISTINCT a.kjwo) ELSE NULL END,
        0
    ) AS anzahl_wochen_mit_absatz_af,
    IFNULL(
        CASE WHEN IFNULL(SUM(a.absatz_sa), 0) > 0 THEN COUNT(DISTINCT a.kjwo) ELSE NULL END,
        0
    ) AS anzahl_wochen_mit_absatz_sa,
    IFNULL(
        CASE WHEN IFNULL(SUM(a.umsatz), 0) > 0 THEN COUNT(DISTINCT a.kjwo) ELSE NULL END,
        0
    ) AS anzahl_wochen_mit_umsatz,
    IFNULL(
        CASE WHEN IFNULL(SUM(a.umsatz_af), 0) > 0 THEN COUNT(DISTINCT a.kjwo) ELSE NULL END,
        0
    ) AS anzahl_wochen_mit_umsatz_af,
    IFNULL(
        CASE WHEN IFNULL(SUM(a.umsatz_sa), 0) > 0 THEN COUNT(DISTINCT a.kjwo) ELSE NULL END,
        0
    ) AS anzahl_wochen_mit_umsatz_sa,
    IFNULL(
        CASE WHEN IFNULL(SUM(a.ertrag), 0) > 0 THEN COUNT(DISTINCT a.kjwo) ELSE NULL END,
        0
    ) AS anzahl_wochen_mit_ertrag,
    IFNULL(
        CASE WHEN IFNULL(SUM(a.ertrag_af), 0) > 0 THEN COUNT(DISTINCT a.kjwo) ELSE NULL END,
        0
    ) AS anzahl_wochen_mit_ertrag_af,
    IFNULL(
        CASE WHEN IFNULL(SUM(a.ertrag_sa), 0) > 0 THEN COUNT(DISTINCT a.kjwo) ELSE NULL END,
        0
    ) AS anzahl_wochen_mit_ertrag_sa
FROM dbp_etl.bf_listung_markt_kw AS a
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        status
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        art_matching_id,
        art_id,
        status
) AS b
    ON a.art_id = b.art_id
WHERE
    a.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE
            mandant_id = 1
        GROUP BY
            kjwo
        QUALIFY
            (
                (
                    RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)
                ) * -1
            ) BETWEEN -52 AND (
                -1
            )
    )
    AND b.status IN ('T', 'G')
GROUP BY
    a.kjwo,
    b.art_matching_id,
    a.wup_id;

CREATE OR REPLACE TEMPORARY TABLE _anz_wochen1 AS
SELECT
    art_matching_id,
    SUM(absatz_) AS absatz,
    SUM(absatz_af_) AS absatz_af,
    SUM(absatz_sa_) AS absatz_sa,
    SUM(umsatz_) AS umsatz,
    SUM(umsatz_af_) AS umsatz_af,
    SUM(umsatz_sa_) AS umsatz_sa,
    SUM(ertrag_) AS ertrag,
    SUM(ertrag_af_) AS ertrag_af,
    SUM(ertrag_sa_) AS ertrag_sa,
    SUM(anzahl_wochen_mit_umsatz) AS anzahl_wochen_mit_umsatz,
    SUM(anzahl_wochen_mit_umsatz_af) AS anzahl_wochen_mit_umsatz_af,
    SUM(anzahl_wochen_mit_umsatz_sa) AS anzahl_wochen_mit_umsatz_sa,
    SUM(anzahl_wochen_mit_ertrag) AS anzahl_wochen_mit_ertrag,
    SUM(anzahl_wochen_mit_ertrag_af) AS anzahl_wochen_mit_ertrag_af,
    SUM(anzahl_wochen_mit_ertrag_sa) AS anzahl_wochen_mit_ertrag_sa,
    SUM(anzahl_wochen_mit_absatz) AS anzahl_wochen_mit_absatz,
    SUM(anzahl_wochen_mit_absatz_af) AS anzahl_wochen_mit_absatz_af,
    SUM(anzahl_wochen_mit_absatz_sa) AS anzahl_wochen_mit_absatz_sa
FROM `_anz_wochen`
GROUP BY
    art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _woche AS
SELECT kjwo
FROM dbp_data.art_nielsen_fakten_kjwo
WHERE
    mandant_id = 1
GROUP BY
    kjwo
QUALIFY
    (
        (
            RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)
        ) * -1
    ) BETWEEN -52 AND (
        -1
    );

CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre (
    kjwo INT64,
    matching_id INT64,
    mandant_id INT64,
    wup_id INT64,
    anz_wo_mit_absatz FLOAT64
);

INSERT INTO zzsp07_pre
(
    SELECT
        a11.kjwo,
        b.art_matching_id AS matching_id,
        a11.mandant_id,
        a11.wup_id,
        CAST(CASE WHEN SUM(a11.absatz) > 0 THEN 1 ELSE 0 END AS FLOAT64) AS anz_wo_mit_absatz
    FROM dbp_etl.bf_listung_markt_kw AS a11
    INNER JOIN dbp_etl.art_matching_nielsen_per AS b
        ON a11.art_id = b.art_id AND b.status IN ('G', 'T')
    WHERE
        a11.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu
            WHERE
                wg_filter_id = 11
        )
        AND a11.kjwo BETWEEN (
            SELECT MIN(kjwo)
            FROM `_woche`
        ) AND (
            SELECT MAX(kjwo)
            FROM `_woche`
        )
        AND a11.mandant_id = 1
    GROUP BY
        a11.kjwo,
        matching_id,
        a11.mandant_id,
        a11.wup_id
);

CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre (
    kjwo INT64,
    matching_id INT64,
    mandant_id INT64,
    wup_id INT64,
    anz_wo_listung FLOAT64
);

INSERT INTO zzsp08_pre
(
    SELECT
        a11.kjwo,
        b.art_matching_id AS matching_id,
        a11.mandant_id,
        a11.wup_id,
        CAST(COUNT(DISTINCT a11.kjwo) AS FLOAT64) AS anz_wo_listung
    FROM dbp_data.art_wup_listung_kjwo AS a11
    INNER JOIN dbp_etl.art_matching_nielsen_per AS b
        ON a11.art_id = b.art_id AND b.status IN ('G', 'T')
    WHERE
        a11.mandant_id = 1
        AND a11.kjwo BETWEEN (
            SELECT MIN(kjwo)
            FROM `_woche`
        ) AND (
            SELECT MAX(kjwo)
            FROM `_woche`
        )
    GROUP BY
        a11.kjwo,
        matching_id,
        a11.mandant_id,
        a11.wup_id
);

CREATE OR REPLACE TEMPORARY TABLE _mm AS
SELECT
    a.kjwo,
    a.matching_id,
    a.mandant_id,
    a.wup_id,
    a.anz_wo_listung,
    b.anz_wo_mit_absatz
FROM zzsp08_pre AS a
INNER JOIN zzsp07_pre AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.matching_id = b.matching_id
        AND a.wup_id = b.wup_id
        AND a.kjwo = b.kjwo;

INSERT INTO `_mm`
(
    SELECT
        kjwo,
        matching_id,
        mandant_id,
        wup_id,
        anz_wo_listung,
        0
    FROM zzsp08_pre
    WHERE
        NOT (kjwo, matching_id, mandant_id, wup_id) IN (
            SELECT (kjwo, matching_id, mandant_id, wup_id)
            FROM `_mm`
        )
);

CREATE OR REPLACE TEMPORARY TABLE zzsp07 (
    matching_id INT64,
    mandant_id INT64,
    anz_wo_mit_absatz FLOAT64
);

INSERT INTO zzsp07
(
    SELECT
        matching_id,
        mandant_id,
        SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz
    FROM `_mm` AS a11
    WHERE
        anz_wo_mit_absatz <> 0
    GROUP BY
        matching_id,
        mandant_id
);

CREATE OR REPLACE TEMPORARY TABLE zzsp08 (
    matching_id INT64,
    mandant_id INT64,
    anz_wo_listung FLOAT64
);

INSERT INTO zzsp08
(
    SELECT
        matching_id,
        mandant_id,
        SUM(anz_wo_listung) AS anz_wo_listung
    FROM `_mm` AS a11
    GROUP BY
        matching_id,
        mandant_id
);

CREATE OR REPLACE TEMPORARY TABLE zzoj09 (
    matching_id INT64,
    mandant_id INT64
);

INSERT INTO zzoj09
(
    SELECT
        matching_id,
        mandant_id
    FROM (
        SELECT
            matching_id,
            mandant_id
        FROM zzsp07 AS pa11
        GROUP BY
            matching_id,
            mandant_id
        UNION DISTINCT
        SELECT
            matching_id,
            mandant_id
        FROM zzsp08 AS pa11
        GROUP BY
            matching_id,
            mandant_id
    ) AS t3
);

CREATE OR REPLACE TEMPORARY TABLE zzmd0a_xxx (
    matching_id INT64,
    mandant_id INT64,
    wjxbfs1 FLOAT64,
    anz_wo_listung FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    schnelldreherquote FLOAT64
);

INSERT INTO zzmd0a_xxx
(
    SELECT
        pa11.matching_id,
        pa11.mandant_id,
        1.0 AS wjxbfs1,
        pa13.anz_wo_listung,
        pa12.anz_wo_mit_absatz,
        ROUND(
            pa12.anz_wo_mit_absatz / IF(pa13.anz_wo_listung = 0, NULL, pa13.anz_wo_listung) * 100,
            1
        ) AS schnelldreherquote
    FROM zzoj09 AS pa11
    LEFT JOIN zzsp07 AS pa12
        ON pa11.matching_id = pa12.matching_id AND pa11.mandant_id = pa12.mandant_id
    LEFT JOIN zzsp08 AS pa13
        ON pa11.matching_id = pa13.matching_id AND pa11.mandant_id = pa13.mandant_id
);

CREATE OR REPLACE TEMPORARY TABLE `_sal_snap_2_multis1` AS
(
    WITH sorted_source AS (
        SELECT *
        FROM `_sal_snap_2_multis`
        ORDER BY
            art_matching_id,
            status,
            kl_art_id
    )

    SELECT
        x.art_matching_id,
        x.status,
        MAX(x.umrech_faktor) AS umrech_faktor,
        MAX(x.kl_wg_id) AS kl_wg_id,
        MAX(x.kl_owg_id) AS kl_owg_id,
        MAX(x.kl_uwg_id) AS kl_uwg_id,
        MAX(x.rang_umsatz_wg) AS rang_umsatz_wg,
        MAX(x.rang_umsatz_uwg) AS rang_umsatz_uwg,
        MAX(x.rang_absatz_uwg) AS rang_absatz_uwg,
        MAX(x.art_id) AS art_id,
        SUBSTR(
            REPLACE(
                TRIM(
                    STRING_AGG(

                        LPAD(CAST(CAST(LPAD(CAST(x.kl_art_id AS STRING), 8, '0') AS INT64) AS STRING), 8, '0'),
                        ','

                    ),
                    ','
                ),
                ' ',
                ''
            ),
            1,
            300
        ) AS kl_art_id,
        MAX(x.wug_id) AS wug_id,
        MAX(x.art_bez) AS art_bez,
        MAX(x.art_status) AS art_status,
        MAX(x.gp_id) AS gp_id,
        MAX(x.akt_lieferant) AS akt_lieferant,
        MAX(x.zek) AS zek,
        MAX(x.disc_pe) AS disc_pe,
        MAX(x.disc_marke) AS disc_marke,
        MAX(x.lcf) AS lcf,
        MAX(x.vegan) AS vegan,
        MAX(x.gluten) AS gluten,
        MAX(x.bio) AS bio,
        MAX(x.eigenmarke) AS eigenmarke,
        MAX(x.tierwohl) AS tierwohl,
        MAX(x.posten_food) AS posten_food,
        MAX(x.posten_nonfood) AS posten_nonfood,
        MAX(x.mwst) AS mwst,
        MAX(x.k_listung) AS k_listung,
        MAX(x.ost_basis) AS ost_basis,
        MAX(x.ost_gross) AS ost_gross,
        MAX(x.sued_ost) AS sued_ost,
        MAX(x.sued_west) AS sued_west,
        MAX(x.west) AS west,
        MAX(x.nord) AS nord,
        MAX(x.anz_maerkte) AS anz_maerkte,
        COALESCE(SUM(x.gewichtete_distribution) / NULLIF(COUNT(*), 0), 0) AS gewichtete_distribution,
        MAX(x.index_af_id) AS index_af_id, /* Index AF */
        COALESCE(MAX(y.umsatz_af) / NULLIF(MAX(y.anzahl_wochen_mit_umsatz_af), 0), 0) AS umsatz_af_pro_markt_woche_,
        COALESCE(MAX(y.absatz_af) / NULLIF(MAX(y.anzahl_wochen_mit_absatz_af), 0), 0) AS absatz_af_pro_markt_woche_,
        COALESCE(MAX(y.ertrag_af) / NULLIF(MAX(y.anzahl_wochen_mit_ertrag_af), 0), 0) AS ertrag_af_pro_markt_woche_,
        SUM(x.bonreichweite_af) AS bonreichweite_af,
        COALESCE(
            (
                MAX(y.ertrag_af) / NULLIF(MAX(y.anzahl_wochen_mit_ertrag_af), 0)
            ) / NULLIF((
                MAX(y.umsatz_af) / NULLIF(MAX(y.anzahl_wochen_mit_umsatz_af), 0)
            ), 0),
            0
        ) AS spanne_af,
        MAX(x.index_sa_id) AS index_sa_id, /* Index SA */
        COALESCE(MAX(y.umsatz_sa) / NULLIF(MAX(y.anzahl_wochen_mit_umsatz_sa), 0), 0) AS umsatz_sa_pro_markt_woche_,
        COALESCE(MAX(y.absatz_sa) / NULLIF(MAX(y.anzahl_wochen_mit_absatz_sa), 0), 0) AS absatz_sa_pro_markt_woche_,
        COALESCE(MAX(y.ertrag_sa) / NULLIF(MAX(y.anzahl_wochen_mit_ertrag_sa), 0), 0) AS ertrag_sa_pro_markt_woche_,
        SUM(x.bonreichweite_sa) AS bonreichweite_sa,
        COALESCE(
            (
                MAX(y.ertrag_sa) / NULLIF(MAX(y.anzahl_wochen_mit_ertrag_sa), 0)
            ) / NULLIF((
                MAX(y.umsatz_sa) / NULLIF(MAX(y.anzahl_wochen_mit_umsatz_sa), 0)
            ), 0),
            0
        ) AS spanne_sa,
        COALESCE(SUM(total_sa_absatz) / NULLIF(SUM(x.absatz_total), 0), 0) AS aktionsanteil_absatz, /* Kennzahlen */
        SUM(x.absatz_total) AS absatz_total,
        COALESCE(
            SUM(CAST(x.anz_wo_mit_absatz AS FLOAT64)) / NULLIF(SUM(CAST(x.anz_wo_listung AS FLOAT64)), 0),
            0
        ) AS schnelldreherquote, /* Bon */
        SUM(schnelldreherquote_wg) AS schnelldreherquote_wg,
        SUM(schnelldreherquote_owg) AS schnelldreherquote_owg,
        CASE
            WHEN NOT MAX(kol_la_bzw) IS NULL
                THEN COALESCE(
                    (
                        (
                            MAX(rlz) / NULLIF(COUNT(*), 0)
                        ) * MAX(lagerprozent)
                    ) * COALESCE(
                        (
                            SUM(total_af_absatz) / NULLIF(SUM(absatz_af_markt_wochen), 0)
                        ) / 6,
                        SUM(total_sa_absatz) / NULLIF(SUM(absatz_sa_markt_tage), 0)
                    ) / NULLIF(MAX(CASE WHEN umrech_faktor = 1 THEN kol_la_bzw ELSE 1 END), 0),
                    0
                )
            ELSE COALESCE(
                (
                    MAX(rlz_dz) / NULLIF(COUNT(*), 0)
                ) * COALESCE(
                    (
                        SUM(total_af_absatz) / NULLIF(SUM(absatz_af_markt_wochen), 0)
                    ) / 6,
                    SUM(total_sa_absatz) / NULLIF(SUM(absatz_sa_markt_tage), 0)
                ) / NULLIF(MAX(CASE WHEN umrech_faktor = 1 THEN kol_bst_bzw ELSE 1 END), 0),
                0
            )
        END AS kolliabverkaufsquote,
        SUM(kolliabverkaufsquote_wg) AS kolliabverkaufsquote_wg,
        SUM(kolliabverkaufsquote_owg) AS kolliabverkaufsquote_owg,
        COALESCE(
            SUM(CAST(abschr_o_werb AS FLOAT64)) / NULLIF(SUM(CAST(kassenumsatz AS FLOAT64)), 0),
            0
        ) AS abschriftsanteil,
        SUM(abschriftsanteil_wg) AS abschriftsanteil_wg,
        SUM(abschriftsanteil_owg) AS abschriftsanteil_owg,
        SUM(cherrypicker_quote) AS cherrypicker_quote,
        SUM(cherrypicker_quote_wg) AS cherrypicker_quote_wg,
        SUM(cherrypicker_quote_owg) AS cherrypicker_quote_owg,
        SUM(restbon) AS restbon,
        SUM(restbon_wg) AS restbon_wg,
        SUM(restbon_owg) AS restbon_owg,
        MAX(vk_preis) AS vk_preis, /* Bewertung */ /* -> muessen wir aendern! */
        CASE
            WHEN SUM(af_umsatz_netto) <> 0
                THEN COALESCE(
                    SUM((
                        af_umsatz_netto * (
                            (
                                100 + mwst
                            ) / 100
                        )
                    )) / NULLIF(SUM(total_af_absatz), 0),
                    0
                )
            ELSE COALESCE(
                SUM((
                    sa_umsatz_netto * (
                        (
                            100 + mwst
                        ) / 100
                    )
                )) / NULLIF(SUM(total_sa_absatz), 0),
                0
            )
        END AS durchschnittspreis, /* --> brutto! */
        SUM(preislagenverteilung) AS preislagenverteilung,
        SUM(marktanteilbewertung) AS marktanteilbewertung,
        SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz, /* Berechnung */
        SUM(anz_wo_listung) AS anz_wo_listung,
        MAX(kol_la_bzw) AS kol_la_bzw,
        MAX(kol_bst_bzw) AS kol_bst_bzw,
        MAX(rlz_dz) AS rlz_dz,
        MAX(rlz) AS rlz,
        MAX(lagerprozent) AS lagerprozent,
        SUM(total_absatz_af_mt_wo) AS total_absatz_af_mt_wo,
        SUM(total_absatz_sa_mt_tag) AS total_absatz_sa_mt_tag,
        SUM(total_af_absatz) AS total_af_absatz,
        SUM(total_sa_absatz) AS total_sa_absatz,
        SUM(af_umsatz_netto) AS af_umsatz_netto,
        SUM(sa_umsatz_netto) AS sa_umsatz_netto,
        SUM(absatz_sa_markt_tage) AS absatz_sa_markt_tage,
        SUM(absatz_af_markt_wochen) AS absatz_af_markt_wochen,
        SUM(abschr_o_werb) AS abschr_o_werb,
        SUM(kassenumsatz) AS kassenumsatz
    FROM sorted_source AS x
    LEFT JOIN `_step1` AS z
        ON 1 = z.mandant_id AND x.art_id = z.art_id
    LEFT JOIN `_anz_wochen1` AS y
        ON x.art_matching_id = y.art_matching_id
    WHERE
        NOT x.art_matching_id IN (
            SELECT art_matching_id
            FROM dbp_etl.art_matching_nielsen_per
            WHERE
                gtin_id IN (-9998, -9999)
        )
    GROUP BY
        1,
        2
);

UPDATE `_sal_snap_2_multis1` SET schnelldreherquote = b.sdq / 100
FROM (
    SELECT
        schnelldreherquote AS sdq,
        matching_id
    FROM zzmd0a_xxx
) AS b
WHERE
    `_sal_snap_2_multis1`.art_matching_id = b.matching_id;

DELETE FROM `_sal_snap_2`
WHERE
    art_matching_id IN (
        SELECT art_matching_id
        FROM `_sal_snap_2_multis1`
    );

CREATE OR REPLACE TEMPORARY TABLE _sal_snap_final AS
SELECT
    1 AS mandant_id,
    d.kjmo_sort AS kjmo,
    `_sal_snap_2`.art_matching_id,
    ' ' AS status,
    `_sal_snap_2`.umrech_faktor,
    `_sal_snap_2`.kl_wg_id,
    `_sal_snap_2`.kl_owg_id,
    `_sal_snap_2`.kl_uwg_id,
    `_sal_snap_2`.rang_umsatz_wg,
    `_sal_snap_2`.rang_umsatz_uwg,
    `_sal_snap_2`.rang_absatz_uwg,
    `_sal_snap_2`.art_id,
    CAST(`_sal_snap_2`.kl_art_id AS STRING) AS kl_art_id,
    `_sal_snap_2`.wug_id,
    `_sal_snap_2`.art_bez,
    `_sal_snap_2`.art_status,
    `_sal_snap_2`.gp_id,
    `_sal_snap_2`.akt_lieferant,
    `_sal_snap_2`.zek AS zek_id,
    `_sal_snap_2`.disc_pe,
    `_sal_snap_2`.disc_marke,
    `_sal_snap_2`.lcf,
    `_sal_snap_2`.vegan,
    `_sal_snap_2`.gluten,
    `_sal_snap_2`.bio,
    `_sal_snap_2`.eigenmarke,
    `_sal_snap_2`.tierwohl,
    `_sal_snap_2`.posten_food,
    `_sal_snap_2`.posten_nonfood,
    `_sal_snap_2`.mwst,
    `_sal_snap_2`.k_listung,
    `_sal_snap_2`.ost_basis,
    `_sal_snap_2`.ost_gross,
    `_sal_snap_2`.sued_ost,
    `_sal_snap_2`.sued_west,
    `_sal_snap_2`.west,
    `_sal_snap_2`.nord,
    `_sal_snap_2`.anz_maerkte,
    `_sal_snap_2`.gewichtete_distribution,
    `_sal_snap_2`.index_af_id,
    `_sal_snap_2`.umsatz_af_pro_markt_woche,
    `_sal_snap_2`.absatz_af_pro_markt_woche,
    `_sal_snap_2`.ertrag_af_pro_markt_woche,
    `_sal_snap_2`.bonreichweite_af,
    `_sal_snap_2`.spanne_af,
    `_sal_snap_2`.index_sa_id,
    `_sal_snap_2`.umsatz_sa_pro_markt_woche,
    `_sal_snap_2`.absatz_sa_pro_markt_woche,
    `_sal_snap_2`.ertrag_sa_pro_markt_woche,
    `_sal_snap_2`.bonreichweite_sa,
    `_sal_snap_2`.spanne_sa,
    `_sal_snap_2`.aktionsanteil_absatz,
    `_sal_snap_2`.absatz_total,
    `_sal_snap_2`.schnelldreherquote,
    `_sal_snap_2`.schnelldreherquote_wg,
    `_sal_snap_2`.schnelldreherquote_owg,
    `_sal_snap_2`.kolliabverkaufsquote,
    `_sal_snap_2`.kolliabverkaufsquote_wg,
    `_sal_snap_2`.kolliabverkaufsquote_owg,
    `_sal_snap_2`.abschriftsanteil,
    `_sal_snap_2`.abschriftsanteil_wg,
    `_sal_snap_2`.abschriftsanteil_owg,
    `_sal_snap_2`.cherrypicker_quote,
    `_sal_snap_2`.cherrypicker_quote_wg,
    `_sal_snap_2`.cherrypicker_quote_owg,
    `_sal_snap_2`.restbon,
    `_sal_snap_2`.restbon_wg,
    `_sal_snap_2`.restbon_owg,
    `_sal_snap_2`.vk_preis,
    `_sal_snap_2`.durchschnittspreis,
    `_sal_snap_2`.preislagenverteilung,
    `_sal_snap_2`.marktanteilbewertung, /* zur Berechnung */
    `_sal_snap_2`.anz_wo_mit_absatz,
    `_sal_snap_2`.anz_wo_listung,
    `_sal_snap_2`.kol_la_bzw,
    `_sal_snap_2`.kol_bst_bzw,
    `_sal_snap_2`.rlz_dz,
    `_sal_snap_2`.rlz,
    `_sal_snap_2`.lagerprozent,
    `_sal_snap_2`.total_absatz_af_mt_wo,
    `_sal_snap_2`.total_absatz_sa_mt_tag,
    `_sal_snap_2`.total_af_absatz,
    `_sal_snap_2`.total_sa_absatz,
    `_sal_snap_2`.af_umsatz_netto,
    `_sal_snap_2`.sa_umsatz_netto,
    `_sal_snap_2`.absatz_sa_markt_tage,
    `_sal_snap_2`.absatz_af_markt_wochen,
    `_sal_snap_2`.abschr_o_werb,
    `_sal_snap_2`.kassenumsatz
FROM `_sal_snap_2`
INNER JOIN (
    SELECT MAX(kjwo) AS max_kjwo
    FROM dbp_data.art_nielsen_fakten_kjwo
    WHERE
        mandant_id = 1
) AS c
    ON TRUE
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS d
    ON c.max_kjwo = d.kjwo_bis;

INSERT INTO `_sal_snap_final`
SELECT
    1 AS mandant_id,
    d.kjmo_sort AS kjmo,
    a.*
    REPLACE (CAST(a.gewichtete_distribution AS INT64) AS gewichtete_distribution)
FROM `_sal_snap_2_multis1` AS a
JOIN (
    SELECT MAX(kjwo) AS max_kjwo
    FROM dbp_data.art_nielsen_fakten_kjwo
    WHERE
        mandant_id = 1
) AS c
    ON 1 = 1
JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS d
    ON c.max_kjwo = d.kjwo_bis;

DELETE FROM `_sal_snap_final`
WHERE
    art_id IN (
        SELECT art_id
        FROM `_sal_snap_final`
        GROUP BY
            art_id
        HAVING
            COUNT(*) > 1
    )
    AND NOT (art_id, art_matching_id) IN (
        SELECT (art_id, MIN(art_matching_id))
        FROM `_sal_snap_final`
        GROUP BY
            art_id
        HAVING
            COUNT(*) > 1
    );

DELETE FROM `_sal_snap_final`
WHERE
    art_id IN (
        SELECT art_id
        FROM `_sal_snap_final`
        GROUP BY
            art_id
        HAVING
            COUNT(*) > 1
    )
    AND umsatz_af_pro_markt_woche = 0;

UPDATE `_sal_snap_final` SET kl_wg_id = b.kl_wg_id, kl_owg_id = b.kl_owg_id, kl_uwg_id = b.kl_uwg_id
FROM (
    SELECT
        art_id,
        MAX(kl_wg_id) AS kl_wg_id,
        MAX(kl_owg_id) AS kl_owg_id,
        MAX(kl_uwg_id) AS kl_uwg_id
    FROM `_art_leistung_1`
    GROUP BY
        art_id
) AS b
WHERE
    `_sal_snap_final`.art_id = b.art_id;

UPDATE `_sal_snap_final` SET rang_umsatz_wg = b.rang_umsatz_wg, rang_umsatz_uwg = b.rang_umsatz_uwg, rang_absatz_uwg = b.rang_absatz_uwg, gewichtete_distribution = CAST(b.distr_gew AS INT64)
FROM (
    SELECT
        art_matching_id,
        MIN(rang_umsatz_wg) AS rang_umsatz_wg,
        MIN(rang_umsatz_uwg) AS rang_umsatz_uwg,
        MIN(rang_absatz_uwg) AS rang_absatz_uwg,
        SUM(distr_gew) / COUNT(*) AS distr_gew
    FROM `_artikel_anteil_uwg_leistung_base1`
    GROUP BY
        art_matching_id
) AS b
WHERE
    `_sal_snap_final`.art_matching_id = b.art_matching_id;

UPDATE `_sal_snap_final` SET rang_umsatz_wg = b.next_rang_ums_wg, rang_umsatz_uwg = CAST(b.next_rang_ums_uwg AS INT64), rang_absatz_uwg = CAST(b.next_rang_abs_uwg AS INT64)
FROM (
    SELECT
        kl_owg_id,
        MAX(rang_umsatz_wg) AS next_rang_ums_wg,
        MAX(rang_umsatz_uwg) AS next_rang_ums_uwg,
        MAX(rang_absatz_uwg) AS next_rang_abs_uwg
    FROM `_artikel_anteil_uwg_ranking`
    GROUP BY
        kl_owg_id
) AS b
WHERE
    `_sal_snap_final`.kl_owg_id = b.kl_owg_id
    AND `_sal_snap_final`.rang_umsatz_wg IS NULL
    AND `_sal_snap_final`.rang_umsatz_uwg IS NULL
    AND `_sal_snap_final`.rang_absatz_uwg IS NULL;

UPDATE `_sal_snap_final` SET rang_umsatz_wg = b.next_rang_ums_wg
FROM (
    SELECT
        kl_wg_id,
        MAX(rang_umsatz_wg) + 1 AS next_rang_ums_wg
    FROM `_artikel_anteil_uwg_ranking`
    GROUP BY
        kl_wg_id
) AS b
WHERE
    `_sal_snap_final`.kl_wg_id = b.kl_wg_id
    AND `_sal_snap_final`.rang_umsatz_wg IS NULL;

UPDATE `_sal_snap_final` SET rang_umsatz_uwg = CAST(b.next_rang_ums_uwg AS INT64), rang_absatz_uwg = CAST(b.next_rang_abs_uwg AS INT64)
FROM (
    SELECT
        kl_owg_id,
        COALESCE(CAST(MAX(rang_umsatz_uwg) AS BIGNUMERIC), 0) + 1 AS next_rang_ums_uwg,
        COALESCE(CAST(MAX(rang_absatz_uwg) AS BIGNUMERIC), 0) + 1 AS next_rang_abs_uwg
    FROM `_sal_snap_final` AS a
    GROUP BY
        kl_owg_id
) AS b
WHERE
    `_sal_snap_final`.kl_owg_id = b.kl_owg_id
    AND `_sal_snap_final`.rang_umsatz_uwg IS NULL
    AND `_sal_snap_final`.rang_absatz_uwg IS NULL;

UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET rang_umsatz_wg = CAST(b.next_rang_ums_wg AS INT64)
FROM (
    SELECT
        kl_wg_id,
        MAX(COALESCE(CAST(rang_umsatz_wg AS BIGNUMERIC), 0)) + 1 AS next_rang_ums_wg
    FROM `_sal_snap_final`
    GROUP BY
        kl_wg_id
) AS b
WHERE
    `_sal_snap_final0`.kl_wg_id = b.kl_wg_id
    AND `_sal_snap_final0`.rang_umsatz_wg IS NULL;

UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET rang_umsatz_uwg = CAST(b.next_rang_ums_uwg AS INT64), rang_absatz_uwg = CAST(b.next_rang_abs_uwg AS INT64)
FROM (
    SELECT
        kl_owg_id,
        MAX(COALESCE(CAST(rang_umsatz_uwg AS BIGNUMERIC), 0)) + 1 AS next_rang_ums_uwg,
        MAX(COALESCE(CAST(rang_absatz_uwg AS BIGNUMERIC), 0)) + 1 AS next_rang_abs_uwg
    FROM `_sal_snap_final`
    GROUP BY
        kl_owg_id
) AS b
WHERE
    `_sal_snap_final0`.kl_owg_id = b.kl_owg_id
    AND `_sal_snap_final0`.rang_umsatz_uwg IS NULL
    AND `_sal_snap_final0`.rang_absatz_uwg IS NULL;

UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET schnelldreherquote_wg = CAST(b.schnelldreherquote_wg AS INT64), kolliabverkaufsquote_wg = CAST(b.kolliabverkaufsquote_wg AS INT64), abschriftsanteil_wg = CAST(b.abschriftsanteil_wg AS INT64)
FROM (
    SELECT
        kl_wg_id,
        SUM(CAST(anz_wo_mit_absatz AS FLOAT64)) / IF(SUM(CAST(anz_wo_listung AS FLOAT64)) = 0, NULL, SUM(CAST(anz_wo_listung AS FLOAT64))) AS schnelldreherquote_wg,
        CASE
            WHEN NOT MAX(kol_la_bzw) IS NULL
                THEN IFNULL(
                    SUM(rlz) / COUNT(*) * MAX(lagerprozent) * COALESCE(
                        SUM(total_af_absatz) / IF(SUM(absatz_af_markt_wochen) = 0, NULL, SUM(absatz_af_markt_wochen)) / 6,
                        SUM(total_sa_absatz) / IF(SUM(absatz_sa_markt_tage) = 0, NULL, SUM(absatz_sa_markt_tage))
                    ) / IF(MAX(kol_la_bzw) = 0, NULL, MAX(kol_la_bzw)),
                    0
                )
            ELSE IFNULL(
                SUM(rlz_dz) / COUNT(*) * COALESCE(
                    SUM(total_af_absatz) / IF(SUM(absatz_af_markt_wochen) = 0, NULL, SUM(absatz_af_markt_wochen)) / 6,
                    SUM(total_sa_absatz) / IF(SUM(absatz_sa_markt_tage) = 0, NULL, SUM(absatz_sa_markt_tage))
                ) / IF(MAX(kol_bst_bzw) = 0, NULL, MAX(kol_bst_bzw)),
                0
            )
        END AS kolliabverkaufsquote_wg,
        SUM(abschr_o_werb) / IF(SUM(kassenumsatz) = 0, NULL, SUM(kassenumsatz)) AS abschriftsanteil_wg
    FROM `_sal_snap_final`
    GROUP BY
        kl_wg_id
) AS b
WHERE
    `_sal_snap_final0`.kl_wg_id = b.kl_wg_id;

UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET schnelldreherquote_owg = CAST(b.schnelldreherquote_owg AS INT64), kolliabverkaufsquote_owg = CAST(b.kolliabverkaufsquote_owg AS INT64), abschriftsanteil_owg = CAST(b.abschriftsanteil_owg AS INT64)
FROM (
    SELECT
        kl_owg_id,
        SUM(CAST(anz_wo_mit_absatz AS FLOAT64)) / IF(SUM(CAST(anz_wo_listung AS FLOAT64)) = 0, NULL, SUM(CAST(anz_wo_listung AS FLOAT64))) AS schnelldreherquote_owg,
        CASE
            WHEN NOT MAX(kol_la_bzw) IS NULL
                THEN IFNULL(
                    SUM(rlz) / COUNT(*) * MAX(lagerprozent) * COALESCE(
                        SUM(total_af_absatz) / IF(SUM(absatz_af_markt_wochen) = 0, NULL, SUM(absatz_af_markt_wochen)) / 6,
                        SUM(total_sa_absatz) / IF(SUM(absatz_sa_markt_tage) = 0, NULL, SUM(absatz_sa_markt_tage))
                    ) / IF(MAX(kol_la_bzw) = 0, NULL, MAX(kol_la_bzw)),
                    0
                )
            ELSE IFNULL(
                SUM(rlz_dz) / COUNT(*) * COALESCE(
                    SUM(total_af_absatz) / IF(SUM(absatz_af_markt_wochen) = 0, NULL, SUM(absatz_af_markt_wochen)) / 6,
                    SUM(total_sa_absatz) / IF(SUM(absatz_sa_markt_tage) = 0, NULL, SUM(absatz_sa_markt_tage))
                ) / IF(MAX(kol_bst_bzw) = 0, NULL, MAX(kol_bst_bzw)),
                0
            )
        END AS kolliabverkaufsquote_owg,
        SUM(abschr_o_werb) / IF(SUM(kassenumsatz) = 0, NULL, SUM(kassenumsatz)) AS abschriftsanteil_owg
    FROM `_sal_snap_final`
    GROUP BY
        kl_owg_id
) AS b
WHERE
    `_sal_snap_final0`.kl_owg_id = b.kl_owg_id;

/* Index AF */ /* Index SA */
CREATE OR REPLACE TEMPORARY TABLE _index01 (
    mandant_id INT64,
    kjmo INT64,
    art_matching_id INT64,
    kl_wg_id INT64,
    kl_owg_id INT64,
    kl_uwg_id INT64,
    art_id INT64,
    umsatz_af_pro_markt_woche FLOAT64,
    absatz_af_pro_markt_woche FLOAT64,
    ertrag_af_pro_markt_woche FLOAT64,
    bonreichweite_af FLOAT64,
    umsatz_sa_pro_markt_woche FLOAT64,
    absatz_sa_pro_markt_woche FLOAT64,
    ertrag_sa_pro_markt_woche FLOAT64,
    bonreichweite_sa FLOAT64,
    index_af INT64,
    index_sa INT64
);

INSERT INTO `_index01`
(
    SELECT
        mandant_id,
        kjmo,
        art_matching_id,
        CAST(kl_wg_id AS INT64) AS kl_wg_id,
        CAST(kl_owg_id AS INT64) AS kl_owg_id,
        CAST(kl_uwg_id AS INT64) AS kl_uwg_id,
        art_id,
        umsatz_af_pro_markt_woche, /* Index AF */
        absatz_af_pro_markt_woche,
        ertrag_af_pro_markt_woche,
        bonreichweite_af,
        CAST(umsatz_sa_pro_markt_woche AS FLOAT64) AS umsatz_sa_pro_markt_woche,
        CAST(absatz_sa_pro_markt_woche AS FLOAT64) AS absatz_sa_pro_markt_woche,
        CAST(ertrag_sa_pro_markt_woche AS FLOAT64) AS ertrag_sa_pro_markt_woche,
        bonreichweite_sa,
        0 AS index_af,
        0 AS index_sa
    FROM `_sal_snap_final`
    WHERE
        NOT art_id IS NULL
);

/* Index SA */ /* Index AF */
CREATE OR REPLACE TEMPORARY TABLE _index02 AS
SELECT
    kl_wg_id,
    AVG(umsatz_af_pro_markt_woche) AS avg_umsatz_af_pro_markt_woche,
    AVG(absatz_af_pro_markt_woche) AS avg_absatz_af_pro_markt_woche,
    AVG(ertrag_af_pro_markt_woche) AS avg_ertrag_af_pro_markt_woche,
    AVG(bonreichweite_af) AS avg_bonreichweite_af,
    AVG(umsatz_sa_pro_markt_woche) AS avg_umsatz_sa_pro_markt_woche,
    AVG(absatz_sa_pro_markt_woche) AS avg_absatz_sa_pro_markt_woche,
    AVG(ertrag_sa_pro_markt_woche) AS avg_ertrag_sa_pro_markt_woche,
    AVG(bonreichweite_sa) AS avg_bonreichweite_sa,
    COUNT(*) AS anz_art
FROM `_index01`
GROUP BY
    kl_wg_id;

CREATE OR REPLACE TEMPORARY TABLE _index03 AS
/* Index AF */ /* double_bonreichweite_af/anz_art_ AS varianz_bonreichweite_af, */ /* */ /* SQRT(varianz_bonreichweite_af) AS std_bonreichweite_af, */ /* Index SA */ /* double_bonreichweite_sa/anz_art_ AS varianz_bonreichweite_sa, */ /* */ /* , */ /* SQRT(varianz_bonreichweite_sa) AS std_bonreichweite_sa */
SELECT
    a.kl_wg_id,
    MAX(b.anz_art) AS anz_art_,
    SUM(
        (
            a.umsatz_af_pro_markt_woche - b.avg_umsatz_af_pro_markt_woche
        ) * (
            a.umsatz_af_pro_markt_woche - b.avg_umsatz_af_pro_markt_woche
        )
    ) AS double_umsatz_af, /* */
    SUM(
        (
            a.absatz_af_pro_markt_woche - b.avg_absatz_af_pro_markt_woche
        ) * (
            a.absatz_af_pro_markt_woche - b.avg_absatz_af_pro_markt_woche
        )
    ) AS double_absatz_af,
    SUM(
        (
            a.ertrag_af_pro_markt_woche - b.avg_ertrag_af_pro_markt_woche
        ) * (
            a.ertrag_af_pro_markt_woche - b.avg_ertrag_af_pro_markt_woche
        )
    ) AS double_ertrag_af,
    SUM(
        (
            a.bonreichweite_af - b.avg_bonreichweite_af
        ) * (
            a.bonreichweite_af - b.avg_bonreichweite_af
        )
    ) AS double_bonreichweite_af,
    SUM(
        (
            a.umsatz_af_pro_markt_woche - b.avg_umsatz_af_pro_markt_woche
        ) * (
            a.umsatz_af_pro_markt_woche - b.avg_umsatz_af_pro_markt_woche
        )
    ) /* */ / MAX(b.anz_art) AS varianz_umsatz_af,
    SUM(
        (
            a.absatz_af_pro_markt_woche - b.avg_absatz_af_pro_markt_woche
        ) * (
            a.absatz_af_pro_markt_woche - b.avg_absatz_af_pro_markt_woche
        )
    ) / MAX(b.anz_art) AS varianz_absatz_af,
    SUM(
        (
            a.ertrag_af_pro_markt_woche - b.avg_ertrag_af_pro_markt_woche
        ) * (
            a.ertrag_af_pro_markt_woche - b.avg_ertrag_af_pro_markt_woche
        )
    ) / MAX(b.anz_art) AS varianz_ertrag_af,
    SQRT(
        SUM(
            (
                a.umsatz_af_pro_markt_woche - b.avg_umsatz_af_pro_markt_woche
            ) * (
                a.umsatz_af_pro_markt_woche - b.avg_umsatz_af_pro_markt_woche
            )
        ) / MAX(b.anz_art)
    ) AS std_umsatz_af,
    SQRT(
        SUM(
            (
                a.absatz_af_pro_markt_woche - b.avg_absatz_af_pro_markt_woche
            ) * (
                a.absatz_af_pro_markt_woche - b.avg_absatz_af_pro_markt_woche
            )
        ) / MAX(b.anz_art)
    ) AS std_absatz_af,
    SQRT(
        SUM(
            (
                a.ertrag_af_pro_markt_woche - b.avg_ertrag_af_pro_markt_woche
            ) * (
                a.ertrag_af_pro_markt_woche - b.avg_ertrag_af_pro_markt_woche
            )
        ) / MAX(b.anz_art)
    ) AS std_ertrag_af,
    SUM(
        (
            a.umsatz_sa_pro_markt_woche - b.avg_umsatz_sa_pro_markt_woche
        ) * (
            a.umsatz_sa_pro_markt_woche - b.avg_umsatz_sa_pro_markt_woche
        )
    ) AS double_umsatz_sa, /* */
    SUM(
        (
            a.absatz_sa_pro_markt_woche - b.avg_absatz_sa_pro_markt_woche
        ) * (
            a.absatz_sa_pro_markt_woche - b.avg_absatz_sa_pro_markt_woche
        )
    ) AS double_absatz_sa,
    SUM(
        (
            a.ertrag_sa_pro_markt_woche - b.avg_ertrag_sa_pro_markt_woche
        ) * (
            a.ertrag_sa_pro_markt_woche - b.avg_ertrag_sa_pro_markt_woche
        )
    ) AS double_ertrag_sa,
    SUM(
        (
            a.bonreichweite_sa - b.avg_bonreichweite_sa
        ) * (
            a.bonreichweite_af - b.avg_bonreichweite_sa
        )
    ) AS double_bonreichweite_sa,
    SUM(
        (
            a.umsatz_sa_pro_markt_woche - b.avg_umsatz_sa_pro_markt_woche
        ) * (
            a.umsatz_sa_pro_markt_woche - b.avg_umsatz_sa_pro_markt_woche
        )
    ) /* */ / MAX(b.anz_art) AS varianz_umsatz_sa,
    SUM(
        (
            a.absatz_sa_pro_markt_woche - b.avg_absatz_sa_pro_markt_woche
        ) * (
            a.absatz_sa_pro_markt_woche - b.avg_absatz_sa_pro_markt_woche
        )
    ) / MAX(b.anz_art) AS varianz_absatz_sa,
    SUM(
        (
            a.ertrag_sa_pro_markt_woche - b.avg_ertrag_sa_pro_markt_woche
        ) * (
            a.ertrag_sa_pro_markt_woche - b.avg_ertrag_sa_pro_markt_woche
        )
    ) / MAX(b.anz_art) AS varianz_ertrag_sa,
    SQRT(
        SUM(
            (
                a.umsatz_sa_pro_markt_woche - b.avg_umsatz_sa_pro_markt_woche
            ) * (
                a.umsatz_sa_pro_markt_woche - b.avg_umsatz_sa_pro_markt_woche
            )
        ) / MAX(b.anz_art)
    ) AS std_umsatz_sa,
    SQRT(
        SUM(
            (
                a.absatz_sa_pro_markt_woche - b.avg_absatz_sa_pro_markt_woche
            ) * (
                a.absatz_sa_pro_markt_woche - b.avg_absatz_sa_pro_markt_woche
            )
        ) / MAX(b.anz_art)
    ) AS std_absatz_sa,
    SQRT(
        SUM(
            (
                a.ertrag_sa_pro_markt_woche - b.avg_ertrag_sa_pro_markt_woche
            ) * (
                a.ertrag_sa_pro_markt_woche - b.avg_ertrag_sa_pro_markt_woche
            )
        ) / MAX(b.anz_art)
    ) AS std_ertrag_sa
FROM `_index01` AS a
INNER JOIN `_index02` AS b
    ON a.kl_wg_id = b.kl_wg_id
GROUP BY
    a.kl_wg_id;

CREATE OR REPLACE TEMPORARY TABLE _index04 AS
/* Index AF */ /* (a.bonreichweite_af-b.avg_bonreichweite_af)/c.std_bonreichweite_af AS standardisierung_bonreichweite_af, */ /* Index SA */
SELECT
    a.mandant_id,
    a.kjmo,
    a.art_matching_id,
    a.kl_wg_id,
    a.kl_owg_id,
    a.kl_uwg_id,
    a.art_id,
    a.umsatz_af_pro_markt_woche,
    a.absatz_af_pro_markt_woche,
    a.ertrag_af_pro_markt_woche,
    a.bonreichweite_af,
    a.umsatz_sa_pro_markt_woche,
    a.absatz_sa_pro_markt_woche,
    a.ertrag_sa_pro_markt_woche,
    a.bonreichweite_sa,
    a.index_af,
    a.index_sa,
    IFNULL(
        (
            a.umsatz_af_pro_markt_woche - b.avg_umsatz_af_pro_markt_woche
        ) / IF(c.std_umsatz_af = 0, NULL, c.std_umsatz_af),
        0
    ) AS standardisierung_umsatz_af,
    IFNULL(
        (
            a.absatz_af_pro_markt_woche - b.avg_absatz_af_pro_markt_woche
        ) / IF(c.std_absatz_af = 0, NULL, c.std_absatz_af),
        0
    ) AS standardisierung_absatz_af,
    IFNULL(
        (
            a.ertrag_af_pro_markt_woche - b.avg_ertrag_af_pro_markt_woche
        ) / IF(c.std_ertrag_af = 0, NULL, c.std_ertrag_af),
        0
    ) AS standardisierung_ertrag_af,
    IFNULL(
        (
            a.umsatz_af_pro_markt_woche - b.avg_umsatz_af_pro_markt_woche
        ) / IF(c.std_umsatz_af = 0, NULL, c.std_umsatz_af),
        0
    ) * 0.25 + IFNULL(
        (
            a.absatz_af_pro_markt_woche - b.avg_absatz_af_pro_markt_woche
        ) / IF(c.std_absatz_af = 0, NULL, c.std_absatz_af),
        0
    ) * 0.25 + IFNULL(
        (
            a.ertrag_af_pro_markt_woche - b.avg_ertrag_af_pro_markt_woche
        ) / IF(c.std_ertrag_af = 0, NULL, c.std_ertrag_af),
        0
    ) * 0.25 AS temp_af,
    50 * (
        IFNULL(
            (
                a.umsatz_af_pro_markt_woche - b.avg_umsatz_af_pro_markt_woche
            ) / IF(c.std_umsatz_af = 0, NULL, c.std_umsatz_af),
            0
        ) * 0.25 + IFNULL(
            (
                a.absatz_af_pro_markt_woche - b.avg_absatz_af_pro_markt_woche
            ) / IF(c.std_absatz_af = 0, NULL, c.std_absatz_af),
            0
        ) * 0.25 + IFNULL(
            (
                a.ertrag_af_pro_markt_woche - b.avg_ertrag_af_pro_markt_woche
            ) / IF(c.std_ertrag_af = 0, NULL, c.std_ertrag_af),
            0
        ) * 0.25 + 1
    ) + 50 AS index_af_tmp,
    IFNULL(
        (
            a.umsatz_sa_pro_markt_woche - b.avg_umsatz_sa_pro_markt_woche
        ) / IF(c.std_umsatz_sa = 0, NULL, c.std_umsatz_sa),
        0
    ) AS standardisierung_umsatz_sa,
    IFNULL(
        (
            a.absatz_sa_pro_markt_woche - b.avg_absatz_sa_pro_markt_woche
        ) / IF(c.std_absatz_sa = 0, NULL, c.std_absatz_sa),
        0
    ) AS standardisierung_absatz_sa,
    IFNULL(
        (
            a.ertrag_sa_pro_markt_woche - b.avg_ertrag_sa_pro_markt_woche
        ) / IF(c.std_ertrag_sa = 0, NULL, c.std_ertrag_sa),
        0
    ) AS standardisierung_ertrag_sa,
    IFNULL(
        (
            a.umsatz_sa_pro_markt_woche - b.avg_umsatz_sa_pro_markt_woche
        ) / IF(c.std_umsatz_sa = 0, NULL, c.std_umsatz_sa),
        0
    ) * 0.25 + IFNULL(
        (
            a.absatz_sa_pro_markt_woche - b.avg_absatz_sa_pro_markt_woche
        ) / IF(c.std_absatz_sa = 0, NULL, c.std_absatz_sa),
        0
    ) * 0.25 + IFNULL(
        (
            a.ertrag_sa_pro_markt_woche - b.avg_ertrag_sa_pro_markt_woche
        ) / IF(c.std_ertrag_sa = 0, NULL, c.std_ertrag_sa),
        0
    ) * 0.25 AS temp_sa,
    50 /* (a.bonreichweite_sa-b.avg_bonreichweite_sa)/c.std_bonreichweite_sa AS standardisierung_bonreichweite_sa, */ * (
        IFNULL(
            (
                a.umsatz_sa_pro_markt_woche - b.avg_umsatz_sa_pro_markt_woche
            ) / IF(c.std_umsatz_sa = 0, NULL, c.std_umsatz_sa),
            0
        ) * 0.25 + IFNULL(
            (
                a.absatz_sa_pro_markt_woche - b.avg_absatz_sa_pro_markt_woche
            ) / IF(c.std_absatz_sa = 0, NULL, c.std_absatz_sa),
            0
        ) * 0.25 + IFNULL(
            (
                a.ertrag_sa_pro_markt_woche - b.avg_ertrag_sa_pro_markt_woche
            ) / IF(c.std_ertrag_sa = 0, NULL, c.std_ertrag_sa),
            0
        ) * 0.25 + 1
    ) + 50 AS index_sa_tmp
FROM `_index01` AS a
INNER JOIN `_index02` AS b
    ON a.kl_wg_id = b.kl_wg_id
INNER JOIN `_index03` AS c
    ON a.kl_wg_id = c.kl_wg_id;

CREATE OR REPLACE TEMPORARY TABLE _index05_af AS
SELECT
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    MAX(l_af_quartil) AS l_af_quartil,
    MAX(m_af_quartil) AS m_af_quartil,
    MAX(h_af_quartil) AS h_af_quartil
FROM (
    SELECT DISTINCT
        a.mandant_id AS kl_wg_id,
        a.kjmo AS kl_owg_id,
        a.art_matching_id AS kl_uwg_id,
        PERCENTILE_CONT(a.index_af_tmp, 0.5) OVER (PARTITION BY a.mandant_id, a.kjmo, a.art_matching_id)  AS l_af_quartil,
        0 AS m_af_quartil,
        0 AS h_af_quartil
    FROM `_index04` AS a
    INNER JOIN (
        SELECT
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            APPROX_QUANTILES(index_af_tmp, 2)[OFFSET(1)] AS med_1
        FROM `_index04`
        GROUP BY
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            index_af_tmp
    ) AS b
        ON
            a.kl_wg_id = b.kl_wg_id
            AND a.kl_uwg_id = b.kl_uwg_id
            AND a.kl_owg_id = b.kl_owg_id
            AND a.index_af_tmp <= b.med_1
    UNION ALL
    SELECT
        a.kl_wg_id,
        a.kl_owg_id,
        a.kl_uwg_id,
        MAX(0) AS l_af_quartil,
        MAX(t4.med_1) AS m_af_quartil,
        MAX(0) AS h_af_quartil
    FROM `_index04` AS a
    INNER JOIN (
        SELECT DISTINCT
            mandant_id AS kl_wg_id,
            kjmo AS kl_owg_id,
            art_matching_id AS kl_uwg_id,
            PERCENTILE_CONT(index_af_tmp, 0.5) OVER (PARTITION BY mandant_id, kjmo, art_matching_id) AS med_1
        FROM `_index04`
    ) AS t4
        ON
            a.kl_wg_id = t4.kl_wg_id
            AND a.kl_uwg_id = t4.kl_uwg_id
            AND a.kl_owg_id = t4.kl_owg_id
            AND a.index_af_tmp <= t4.med_1
    GROUP BY
        a.kl_wg_id,
        a.kl_owg_id,
        a.kl_uwg_id
    UNION ALL
    SELECT DISTINCT
        a.mandant_id AS kl_wg_id,
        a.kjmo AS kl_owg_id,
        a.art_matching_id AS kl_uwg_id,
        0 AS l_af_quartil,
        0 AS m_af_quartil,
        PERCENTILE_CONT(a.index_af_tmp, 0.5) OVER (PARTITION BY a.mandant_id, a.kjmo, a.art_matching_id) AS h_af_quartil
    FROM `_index04` AS a
    INNER JOIN (
        SELECT
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            APPROX_QUANTILES(index_af_tmp, 2)[OFFSET(1)] AS med_1
        FROM `_index04`
        GROUP BY
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            index_af_tmp
    ) AS b
        ON
            a.kl_wg_id = b.kl_wg_id
            AND a.kl_uwg_id = b.kl_uwg_id
            AND a.kl_owg_id = b.kl_owg_id
            AND a.index_af_tmp > b.med_1
) AS x
GROUP BY
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;

CREATE OR REPLACE TEMPORARY TABLE _index05_sa AS
SELECT
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    MAX(l_sa_quartil) AS l_sa_quartil,
    MAX(m_sa_quartil) + 2 AS m_sa_quartil,
    MAX(h_sa_quartil) AS h_sa_quartil
FROM (
    SELECT DISTINCT
        a.mandant_id AS kl_wg_id,
        a.kjmo AS kl_owg_id,
        a.art_matching_id AS kl_uwg_id,
        PERCENTILE_CONT(a.index_sa_tmp, 0.5) OVER (PARTITION BY a.mandant_id, a.kjmo, a.art_matching_id)  AS l_sa_quartil,
        0 AS m_sa_quartil,
        0 AS h_sa_quartil
    FROM `_index04` AS a
    INNER JOIN (
        SELECT
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            APPROX_QUANTILES(index_sa_tmp, 2)[OFFSET(1)] AS med_1
        FROM `_index04`
        GROUP BY
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            index_sa_tmp
    ) AS b
        ON
            a.kl_wg_id = b.kl_wg_id
            AND a.kl_uwg_id = b.kl_uwg_id
            AND a.kl_owg_id = b.kl_owg_id
            AND a.index_sa_tmp <= b.med_1
    UNION ALL
    SELECT
        a.kl_wg_id,
        a.kl_owg_id,
        a.kl_uwg_id,
        MAX(0) AS l_sa_quartil,
        MAX(t4.med_1) AS m_sa_quartil,
        MAX(0) AS h_sa_quartil
    FROM `_index04` AS a
    INNER JOIN (
        SELECT DISTINCT
            mandant_id AS kl_wg_id,
            kjmo AS kl_owg_id,
            art_matching_id AS kl_uwg_id,
            PERCENTILE_CONT(index_sa_tmp, 0.5) OVER (PARTITION BY mandant_id, kjmo, art_matching_id) AS med_1
        FROM `_index04`
    ) AS t4
        ON
            a.kl_wg_id = t4.kl_wg_id
            AND a.kl_uwg_id = t4.kl_uwg_id
            AND a.kl_owg_id = t4.kl_owg_id
            AND a.index_sa_tmp <= t4.med_1
    GROUP BY
        a.kl_wg_id,
        a.kl_owg_id,
        a.kl_uwg_id
    UNION ALL
    SELECT DISTINCT
        a.mandant_id AS kl_wg_id,
        a.kjmo AS kl_owg_id,
        a.art_matching_id AS kl_uwg_id,
        0 AS l_sa_quartil,
        0 AS m_sa_quartil,
        PERCENTILE_CONT(a.index_sa_tmp, 0.5) OVER (PARTITION BY a.mandant_id, a.kjmo, a.art_matching_id) AS h_sa_quartil
    FROM `_index04` AS a
    INNER JOIN (
        SELECT
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            APPROX_QUANTILES(index_sa_tmp, 2)[OFFSET(1)] AS med_1
        FROM `_index04`
        GROUP BY
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            index_sa_tmp
    ) AS b
        ON
            a.kl_wg_id = b.kl_wg_id
            AND a.kl_uwg_id = b.kl_uwg_id
            AND a.kl_owg_id = b.kl_owg_id
            AND a.index_sa_tmp > b.med_1
) AS x
GROUP BY
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;

UPDATE `_index04` SET
    index_af = CASE
        WHEN `_index04`.index_af_tmp < b.l_af_quartil
            THEN 1
        WHEN `_index04`.index_af_tmp BETWEEN b.l_af_quartil AND b.m_af_quartil
            THEN 2
        ELSE 3
    END
FROM `_index05_af` AS b
WHERE
    `_index04`.kl_wg_id = b.kl_wg_id
    AND `_index04`.kl_uwg_id = b.kl_uwg_id
    AND `_index04`.kl_owg_id = b.kl_owg_id;

UPDATE `_index04` SET
    index_sa = CASE
        WHEN `_index04`.index_sa_tmp < b.l_sa_quartil
            THEN 1
        WHEN `_index04`.index_sa_tmp BETWEEN b.l_sa_quartil AND b.m_sa_quartil
            THEN 2
        ELSE 3
    END
FROM `_index05_sa` AS b
WHERE
    `_index04`.kl_wg_id = b.kl_wg_id
    AND `_index04`.kl_uwg_id = b.kl_uwg_id
    AND `_index04`.kl_owg_id = b.kl_owg_id;

UPDATE `_sal_snap_final` SET index_af_id = b.index_af, index_sa_id = b.index_sa
FROM (
    SELECT
        art_id,
        MAX(index_af) AS index_af,
        MAX(index_sa) AS index_sa
    FROM `_index04`
    GROUP BY
        art_id
) AS b
WHERE
    `_sal_snap_final`.art_id = b.art_id;

CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_kl AS
SELECT
    b.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    b.gtin_id,
    COUNT(DISTINCT x.kjmo) AS anz,
    COUNT(DISTINCT a.kjwo) AS anz_wochen,
    SUM(a.distr_gew) / COUNT(DISTINCT a.kjwo) AS distr_gew_,
    SUM(a.menge) AS menge_,
    SUM(a.umsatz_brutto) AS umsatz_,
    SUM(a.anz_maerkte) AS anz_maerkte,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK() OVER (
        PARTITION BY c.kl_owg_id
        ORDER BY SUM(a.umsatz_brutto) IS NULL DESC, SUM(a.umsatz_brutto) DESC
    ) AS rang_umsatz_uwg,
    DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(a.menge) IS NULL DESC, SUM(a.menge) DESC) AS rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo AS a
INNER JOIN (
    SELECT
        kjwo,
        MIN(kjmo) AS kjmo
    FROM dbp_data.tag
    GROUP BY
        kjwo
) AS x
    ON a.kjwo = x.kjwo
INNER JOIN `_art_nielsen` AS b
    ON a.mandant_id = b.mandant_id AND a.art_nielsen_id = b.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c
    ON b.art_nielsen_id = c.art_nielsen_id AND b.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market AS d
    ON a.mandant_id = d.mandant_id AND a.nielsen_market_id = d.nielsen_market_id
WHERE
    a.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE
            mandant_id = 1
        GROUP BY
            kjwo
        QUALIFY
            (
                (
                    RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)
                ) * -1
            ) BETWEEN -52 AND (
                -1
            )
    )
    AND d.nielsen_market_cluster_id = 1
    AND a.mandant_id = 1
GROUP BY
    b.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    b.gtin_id;

CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_x AS
SELECT
    b.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    b.gtin_id,
    COUNT(DISTINCT x.kjwo) AS anz,
    SUM(a.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
    SUM(a.menge) AS menge_,
    SUM(a.umsatz_brutto) AS umsatz_,
    SUM(a.menge_af) AS menge_af_,
    SUM(a.umsatz_brutto_af) AS umsatz_af_,
    SUM(a.menge_sa) AS menge_sa_,
    SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK() OVER (
        PARTITION BY c.kl_owg_id
        ORDER BY SUM(a.umsatz_brutto) IS NULL DESC, SUM(a.umsatz_brutto) DESC
    ) AS rang_umsatz_uwg,
    DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(a.menge) IS NULL DESC, SUM(a.menge) DESC) AS rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo AS a
INNER JOIN (
    SELECT
        kjwo,
        MIN(kjmo) AS kjmo
    FROM dbp_data.tag
    GROUP BY
        kjwo
) AS x
    ON a.kjwo = x.kjwo
INNER JOIN `_art_nielsen` AS b
    ON a.mandant_id = b.mandant_id AND a.art_nielsen_id = b.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c
    ON b.art_nielsen_id = c.art_nielsen_id AND b.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market AS d
    ON a.mandant_id = d.mandant_id AND a.nielsen_market_id = d.nielsen_market_id
WHERE
    a.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE
            mandant_id = 1
        GROUP BY
            kjwo
        QUALIFY
            (
                (
                    RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)
                ) * -1
            ) BETWEEN -52 AND (
                -1
            )
    )
    AND d.nielsen_market_cluster_id = 2
    AND a.mandant_id = 1
GROUP BY
    b.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    b.gtin_id;

CREATE OR REPLACE TEMPORARY TABLE _kl_ma_owg_1 AS
SELECT
    a.kl_owg_id,
    SUM(a.umsatz__) AS umsatz_x,
    SUM(b.umsatz_kl) AS umsatz_kl_x,
    SUM(b.umsatz_kl) / CAST(SUM(a.umsatz__) AS FLOAT64) * 100.00 AS marktanteil_owg
FROM (
    SELECT
        kl_owg_id,
        SUM(umsatz_) AS umsatz__
    FROM `_artikel_anteil_uwg_ranking_x`
    GROUP BY
        kl_owg_id
) AS a
INNER JOIN (
    SELECT
        kl_owg_id,
        SUM(umsatz_) AS umsatz_kl
    FROM `_artikel_anteil_uwg_ranking_kl`
    GROUP BY
        kl_owg_id
) AS b
    ON a.kl_owg_id = b.kl_owg_id
GROUP BY
    a.kl_owg_id;

CREATE OR REPLACE TEMPORARY TABLE _kl_ma_uwg_1 AS
SELECT
    a.kl_owg_id,
    a.kl_uwg_id,
    SUM(a.umsatz__) AS umsatz_x,
    SUM(b.umsatz_kl) AS umsatz_kl_x,
    IFNULL(SUM(b.umsatz_kl) / IF(SUM(a.umsatz__) = 0, NULL, SUM(a.umsatz__)), 0) * 100.00 AS marktanteil_uwg
FROM (
    SELECT
        kl_owg_id,
        kl_uwg_id,
        SUM(umsatz_) AS umsatz__
    FROM `_artikel_anteil_uwg_ranking_x`
    GROUP BY
        kl_owg_id,
        kl_uwg_id
) AS a
INNER JOIN (
    SELECT
        kl_owg_id,
        kl_uwg_id,
        SUM(umsatz_) AS umsatz_kl
    FROM `_artikel_anteil_uwg_ranking_kl`
    GROUP BY
        kl_owg_id,
        kl_uwg_id
) AS b
    ON a.kl_owg_id = b.kl_owg_id AND a.kl_uwg_id = b.kl_uwg_id
GROUP BY
    a.kl_owg_id,
    a.kl_uwg_id;

UPDATE `_sal_snap_final` SET marktanteilbewertung = CAST(b.indexpunkt AS INT64)
FROM (
    SELECT
        b.kl_owg_id,
        b.kl_uwg_id,
        a.marktanteil_owg,
        b.marktanteil_uwg,
        IFNULL(b.marktanteil_uwg / IF(a.marktanteil_owg = 0, NULL, a.marktanteil_owg), 0) AS indexpunkt
    FROM `_kl_ma_owg_1` AS a
    INNER JOIN `_kl_ma_uwg_1` AS b
        ON a.kl_owg_id = b.kl_owg_id
) AS b
WHERE
    `_sal_snap_final`.kl_uwg_id = b.kl_uwg_id
    AND `_sal_snap_final`.kl_owg_id = b.kl_owg_id;

CREATE OR REPLACE TEMPORARY TABLE _preis_wg_kl AS
SELECT
    kjmo,
    wg_id AS kl_owg_id,
    wug_id AS kl_uwg_id,
    ROUND(CAST(durchschnitt_preis_kasse AS BIGNUMERIC), 0) + 1 AS preis,
    COUNT(*) AS anz_artikel
FROM dbp_data.art_kl_preislage_zu_per AS a
WHERE
    NOT durchschnitt_preis_kasse IS NULL
    AND mandant_id = 1
    AND (kjmo, kjwo_update) IN (
        SELECT (MAX(kjmo), MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    )
GROUP BY
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    preis;

CREATE OR REPLACE TEMPORARY TABLE _preis_wg_nielsen AS
SELECT
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    ROUND(CAST(durchschnitt_preis_kasse AS BIGNUMERIC), 0) + 1 AS preis,
    COUNT(*) AS anz_artikel
FROM dbp_data.art_nielsen_preislage_zu_per AS a
WHERE
    NOT durchschnitt_preis_kasse IS NULL
    AND (kjmo, art_matching_id) IN (
        SELECT (kjmo, art_matching_id)
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
            AND (kjmo, kjwo_update) IN (
                SELECT (MAX(kjmo), MAX(kjwo_update))
                FROM dbp_data.art_kl_preislage_zu_per
                WHERE
                    mandant_id = 1
            )
        GROUP BY
            kjmo,
        art_matching_id
    )
    AND mandant_id = 1
GROUP BY
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    preis;

CREATE OR REPLACE TEMPORARY TABLE _preis_wg AS
/* WHEN a.anz_artikel BETWEEN b.anz_artikel*(-1.1) AND b.anz_artikel*1.1 THEN 2 */
SELECT
    COALESCE(a.kjmo, b.kjmo) AS kjmo,
    COALESCE(a.kl_owg_id, b.kl_owg_id) AS kl_owg_id,
    COALESCE(a.kl_uwg_id, b.kl_uwg_id) AS kl_uwg_id,
    COALESCE(a.preis, b.preis) AS preis,
    CASE
        WHEN COALESCE(a.anz_artikel, 0) > COALESCE(b.anz_artikel, 0)
            THEN 3
        WHEN COALESCE(a.anz_artikel, 0) < COALESCE(b.anz_artikel, 0)
            THEN 1
        ELSE 2
    END AS preislage_id
FROM `_preis_wg_kl` AS a
FULL JOIN `_preis_wg_nielsen` AS b
    ON
        a.kjmo = b.kjmo
        AND a.kl_uwg_id = b.kl_uwg_id
        AND a.kl_owg_id = b.kl_owg_id
        AND a.preis = b.preis;

UPDATE `_sal_snap_final` SET preislagenverteilung = CAST(b.preislage_id AS INT64)
FROM `_preis_wg` AS b
WHERE
    `_sal_snap_final`.kl_uwg_id = b.kl_uwg_id
    AND `_sal_snap_final`.kl_owg_id = b.kl_owg_id
    AND ROUND(CAST(`_sal_snap_final`.durchschnittspreis AS BIGNUMERIC), 0) = b.preis;

UPDATE `_sal_snap_final` SET preislagenverteilung = 2
WHERE
    preislagenverteilung = 0;

DELETE FROM dbp_data.sortiment_leistung
WHERE
    mandant_id = 1
    AND (kjmo, kjwo_update) IN (
        SELECT (MAX(kjmo), MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    );

/* Potenzial -------------------------- */ /* ,anz_maerkte */
INSERT INTO dbp_data.sortiment_leistung (
    mandant_id,
    kjmo,
    matching_id,
    kjwo_update,
    wrg_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    owg_id,
    wg_id,
    wug_id,
    rang_umsatz_wg,
    rang_umsatz_uwg,
    rang_absatz_uwg,
    art_id,
    kl_art_id,
    art_bez,
    art_status,
    gp_id,
    akt_lieferant,
    zek_id,
    disc_pe,
    disc_marke,
    lcf,
    vegan,
    gluten,
    bio,
    eigenmarke,
    tierwohl,
    posten_food,
    posten_nonfood,
    mwst,
    gewichtete_distribution,
    index_af_id,
    umsatz_af_pro_markt_woche,
    absatz_af_pro_markt_woche,
    ertrag_af_pro_markt_woche,
    bonreichweite_af,
    spanne_af,
    index_sa_id,
    umsatz_sa_pro_markt_woche,
    absatz_sa_pro_markt_woche,
    ertrag_sa_pro_markt_woche,
    bonreichweite_sa,
    spanne_sa,
    aktionsanteil_absatz,
    absatz_total,
    schnelldreherquote,
    schnelldreherquote_wg,
    schnelldreherquote_owg,
    kolliabverkaufsquote,
    kolliabverkaufsquote_wg,
    kolliabverkaufsquote_owg,
    abschriftsanteil,
    abschriftsanteil_wg,
    abschriftsanteil_owg,
    cherrypicker_quote,
    cherrypicker_quote_wg,
    cherrypicker_quote_owg,
    restbon,
    restbon_wg,
    restbon_owg,
    vk_preis,
    durchschnittspreis,
    preislagenverteilung,
    marktanteilbewertung,
    produktwissen_vp,
    lieferantenwissen_vp,
    produktwissen_pflege,
    lieferantenwissen_pflege,
    listung_sst_pflege,
    ost_basis_pflege,
    ost_gross_pflege,
    sued_ost_pflege,
    sued_west_pflege,
    west_pflege,
    nord_pflege,
    vorschlag,
    stk_re_pflege,
    umsatz_hr,
    absatz_hr,
    rohertrag_hr,
    nielsen_art_bez,
    gtin,
    distr_gew,
    umsatz_anteil_uwg,
    umsatz_anteil_uwg_kumuliert,
    durchschnitt_anz_maerkte,
    durchschnitt_preis,
    kl_markt_anteil_owg,
    umsatz_artikel,
    absatz_artikel,
    anz_monate,
    anz_wochen,
    eigenmarke_fg,
    listung_sst_mvke,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    nord,
    anz_maerkte_sst,
    anz_maerkte_baustein_sonstige,
    anz_maerkte_listung_einzel,
    anz_maerkte_listung_gesamt,
    listungsaktion
)
(
    SELECT
        a.mandant_id,
        a.kjmo,
        a.art_matching_id,
        z.kjwo,
        x.default_wrg AS wrg_id,
        CAST(a.kl_wg_id AS INT64) AS kl_wg_id,
        CAST(a.kl_owg_id AS INT64) AS kl_owg_id,
        CAST(a.kl_uwg_id AS INT64) AS kl_uwg_id,
        CAST(a.kl_wg_id AS INT64) AS owg_id,
        CAST(a.kl_owg_id AS INT64) AS wg_id,
        CAST(a.kl_uwg_id AS INT64) AS wug_id,
        CAST(a.rang_umsatz_wg AS INT64) AS rang_umsatz_wg,
        CAST(a.rang_umsatz_uwg AS INT64) AS rang_umsatz_uwg,
        CAST(a.rang_absatz_uwg AS INT64) AS rang_absatz_uwg,
        a.art_id,
        a.kl_art_id,
        a.art_bez,
        SUBSTR(a.art_status, 1, 2) AS art_status,
        CAST(a.gp_id AS INT64) AS gp_id,
        a.akt_lieferant,
        a.zek_id,
        a.disc_pe,
        a.disc_marke,
        SUBSTR(a.lcf, 1, 1) AS lcf,
        SUBSTR(a.vegan, 1, 1) AS vegan,
        SUBSTR(a.gluten, 1, 1) AS gluten,
        SUBSTR(a.bio, 1, 1) AS bio,
        SUBSTR(a.eigenmarke, 1, 2) AS eigenmarke,
        a.tierwohl,
        SUBSTR(a.posten_food, 1, 1) AS posten_food,
        SUBSTR(a.posten_nonfood, 1, 1) AS posten_nonfood,
        a.mwst,
        a.gewichtete_distribution,
        a.index_af_id,
        ROUND(CAST(a.umsatz_af_pro_markt_woche AS NUMERIC), 5) AS umsatz_af_pro_markt_woche,
        ROUND(CAST(a.absatz_af_pro_markt_woche AS NUMERIC), 5) AS absatz_af_pro_markt_woche,
        ROUND(CAST(a.ertrag_af_pro_markt_woche AS NUMERIC), 5) AS ertrag_af_pro_markt_woche,
        ROUND(CAST(a.bonreichweite_af AS NUMERIC), 5) AS bonreichweite_af,
        ROUND(CAST(a.spanne_af AS NUMERIC), 5) AS spanne_af,
        a.index_sa_id,
        CAST(a.umsatz_sa_pro_markt_woche AS NUMERIC) AS umsatz_sa_pro_markt_woche,
        CAST(a.absatz_sa_pro_markt_woche AS NUMERIC) AS absatz_sa_pro_markt_woche,
        CAST(a.ertrag_sa_pro_markt_woche AS NUMERIC) AS ertrag_sa_pro_markt_woche,
        ROUND(CAST(a.bonreichweite_sa AS NUMERIC), 5) AS bonreichweite_sa,
        ROUND(CAST(a.spanne_sa AS NUMERIC), 5) AS spanne_sa,
        ROUND(CAST(a.aktionsanteil_absatz AS NUMERIC), 5) AS aktionsanteil_absatz,
        ROUND(CAST(a.absatz_total AS NUMERIC), 5) AS absatz_total,
        ROUND(CAST(a.schnelldreherquote AS NUMERIC), 5) AS schnelldreherquote,
        ROUND(CAST(a.schnelldreherquote_wg AS NUMERIC), 5) AS schnelldreherquote_wg,
        ROUND(CAST(a.schnelldreherquote_owg AS NUMERIC), 5) AS schnelldreherquote_owg,
        ROUND(CAST(a.kolliabverkaufsquote AS NUMERIC), 5) AS kolliabverkaufsquote,
        ROUND(CAST(a.kolliabverkaufsquote_wg AS NUMERIC), 5) AS kolliabverkaufsquote_wg,
        ROUND(CAST(a.kolliabverkaufsquote_owg AS NUMERIC), 5) AS kolliabverkaufsquote_owg,
        ROUND(CAST(a.abschriftsanteil AS NUMERIC), 5) AS abschriftsanteil,
        ROUND(CAST(a.abschriftsanteil_wg AS NUMERIC), 5) AS abschriftsanteil_wg,
        ROUND(CAST(a.abschriftsanteil_owg AS NUMERIC), 5) AS abschriftsanteil_owg,
        ROUND(CAST(a.cherrypicker_quote AS NUMERIC), 5) AS cherrypicker_quote,
        ROUND(CAST(a.cherrypicker_quote_wg AS NUMERIC), 5) AS cherrypicker_quote_wg,
        ROUND(CAST(a.cherrypicker_quote_owg AS NUMERIC), 5) AS cherrypicker_quote_owg,
        a.restbon,
        a.restbon_wg,
        a.restbon_owg,
        ROUND(CAST(a.vk_preis AS NUMERIC), 5) AS vk_preis,
        CAST(a.durchschnittspreis AS NUMERIC) AS durchschnittspreis,
        ROUND(CAST(a.preislagenverteilung AS NUMERIC), 5) AS preislagenverteilung,
        ROUND(CAST(a.marktanteilbewertung /* TS -------------------------- */ AS NUMERIC), 5) AS marktanteilbewertung,
        ' ' AS produktwissen_vp,
        ' ' AS lieferantenwissen_vp,
        ' ' AS produktwissen_pflege,
        ' ' AS lieferantenwissen_pflege,
        ' ' AS listung_sst_pflege,
        ' ' AS ost_basis_pflege,
        ' ' AS ost_gross_pflege,
        ' ' AS sued_ost_pflege,
        ' ' AS sued_west_pflege,
        ' ' AS west_pflege,
        ' ' AS nord_pflege,
        ' ' AS vorschlag,
        ' ' AS stk_re_pflege,
        NULL AS umsatz_hr,
        NULL AS absatz_hr,
        NULL AS rohertrag_hr,
        CAST(NULL AS STRING) AS nielsen_art_bez,
        CAST(NULL AS STRING) AS gtin,
        NULL AS distr_gew,
        NULL AS umsatz_anteil_uwg,
        NULL AS umsatz_anteil_uwg_kumuliert,
        CAST(NULL AS INT64) AS durchschnitt_anz_maerkte,
        NULL AS durchschnitt_preis,
        NULL AS kl_markt_anteil_owg,
        NULL AS umsatz_artikel,
        NULL AS absatz_artikel,
        CAST(NULL AS INT64) AS anz_monate,
        CAST(NULL AS INT64) AS anz_wochen,
        CAST(NULL AS INT64) AS eigenmarke_fg,
        TRIM(a.k_listung) AS listung_sst_mvke,
        a.ost_basis,
        a.ost_gross,
        a.sued_ost,
        a.sued_west,
        a.west,
        a.nord, /* ,anz_maerkte */
        0 AS anz_maerkte_sst,
        0 AS anz_maerkte_baustein_sonstige,
        0 AS anz_maerkte_listung_einzel,
        0 AS anz_maerkte_listung_gesamt,
        ' ' AS listungsaktion
    FROM `_sal_snap_final` AS a
    INNER JOIN dbp_data.mandant AS x
        ON a.mandant_id = x.mandant_id
    INNER JOIN dbp_data.woche AS z
        ON TRUE
    WHERE
        z.kjwo IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE
                mandant_id = 1
        )
);

INSERT INTO dbp_data.sortiment_leistung (
    mandant_id,
    kjmo,
    matching_id,
    kjwo_update,
    wrg_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    owg_id,
    wg_id,
    wug_id,
    rang_umsatz_wg,
    rang_umsatz_uwg,
    rang_absatz_uwg,
    art_id,
    kl_art_id,
    zek_id,
    nielsen_art_bez,
    gtin,
    distr_gew,
    umsatz_anteil_uwg,
    umsatz_anteil_uwg_kumuliert,
    durchschnitt_anz_maerkte,
    durchschnitt_preis,
    kl_markt_anteil_owg,
    umsatz_artikel,
    absatz_artikel,
    anz_monate,
    anz_wochen,
    eigenmarke_fg
)
(
    SELECT
        1 AS mandant_id,
        a.kjmo,
        a.art_matching_id,
        z.kjwo AS kjwo_update,
        'EUR' AS wrg_id,
        a.kl_wg_id,
        a.kl_owg_id,
        a.kl_uwg_id,
        a.kl_wg_id AS owg_id,
        a.kl_owg_id AS wg_id,
        a.kl_uwg_id AS wug_id,
        a.rang_umsatz_wg,
        a.rang_umsatz_uwg,
        a.rang_absatz_uwg,
        a.art_id,
        a.kl_art_id,
        '-99' AS zek_id,
        a.art_nielsen_bez,
        a.gtin_id,
        a.distr_gew,
        a.umsatz_anteil_uwg,
        a.umsatz_anteil_uwg_kumuliert,
        a.durchschnitt_anz_maerkte,
        a.durchschnitt_preis,
        a.kl_markt_anteil_owg,
        a.umsatz_artikel,
        a.absatz_artikel,
        a.anz_monate,
        a.anz_wochen,
        a.eigenmarke_fg
    FROM dbp_etl.sortiment_potenziale AS a
    INNER JOIN dbp_data.woche AS z
        ON TRUE
    WHERE
        z.kjwo IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE
                mandant_id = 1
        )
);

UPDATE dbp_data.sortiment_leistung SET art_id = NULL
WHERE
    art_id = -1;

UPDATE dbp_data.sortiment_leistung SET
    art_id = CASE
        WHEN b.fg_a = 1
            THEN b.art_a
        WHEN
            b.fg_b = 1 AND (
                b.fg_c1 = 1 OR b.fg_c2 = 1
            )
            THEN b.art_b
        WHEN b.fg_b = 1 AND b.fg_d1 = 1
            THEN b.art_b
        WHEN b.fg_b = 1 AND b.fg_d2 = 1 AND b.status_d2 = ''
            THEN b.art_d2
        WHEN b.fg_b = 1 AND b.fg_d2 = 1 AND b.status_d2 = 'L'
            THEN b.art_b
        WHEN b.fg_b = 1
            THEN b.art_b
        WHEN
            b.fg_c1 = 1 AND (
                b.fg_d1 = 1 OR b.fg_d2 = 1
            )
            THEN b.art_c1
        WHEN b.fg_c1 = 1
            THEN b.art_c1
        WHEN
            b.fg_c2 = 1 AND (
                b.fg_d1 = 1 OR b.fg_d2 = 1
            )
            THEN b.art_c2
        WHEN b.fg_c2 = 1
            THEN b.art_c2
        WHEN b.fg_d1 = 1
            THEN b.art_d1
        WHEN b.fg_d2 = 1
            THEN b.art_d2
        ELSE NULL
    END
FROM dbp_etl.anzeige_artikel AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id
    AND sortiment_leistung.mandant_id = 1
    AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    );

CREATE OR REPLACE TEMPORARY TABLE _check_visibility AS
SELECT
    x.mandant_id,
    x.art_matching_id,
    MIN(x.art_id) AS art_id
FROM dbp_etl.art_matching_nielsen_per AS x
INNER JOIN (
    SELECT
        a.mandant_id,
        a.art_matching_id,
        MIN(a.list_kz) AS list_kz
    FROM dbp_etl.art_matching_nielsen_per AS a
    INNER JOIN (
        SELECT
            mandant_id,
            matching_id
        FROM dbp_data.sortiment_leistung
        WHERE
            mandant_id = 1
            AND INSTR(kl_art_id, ',') > 0
            AND kjwo_update IN (
                SELECT MAX(kjwo_update) AS a1290333724
                FROM dbp_data.art_kl_preislage_zu_per
                WHERE
                    mandant_id = 1
            )
    ) AS b
        ON a.mandant_id = b.mandant_id AND a.art_matching_id = b.matching_id
    GROUP BY
        a.mandant_id,
        a.art_matching_id
) AS y
    ON
        x.mandant_id = y.mandant_id
        AND x.art_matching_id = y.art_matching_id
        AND x.list_kz = y.list_kz
GROUP BY
    x.mandant_id,
    x.art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _upd_visibility AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.kjwo_update,
    b.art_id,
    c.loesch_id
FROM dbp_data.sortiment_leistung AS a
INNER JOIN `_check_visibility` AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.matching_id = b.art_matching_id
        AND a.art_id <> b.art_id
INNER JOIN dbp_data.art AS c
    ON a.mandant_id = c.mandant_id AND b.art_id = c.art_id
WHERE
    a.mandant_id = 1
    AND a.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    );

UPDATE dbp_data.sortiment_leistung SET art_id = b.art_id, art_status = b.loesch_id
FROM (
    SELECT DISTINCT *
    FROM `_upd_visibility`
) AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id
    AND sortiment_leistung.matching_id = b.matching_id
    AND sortiment_leistung.kjwo_update = b.kjwo_update;

UPDATE dbp_data.sortiment_leistung SET kl_art_id = CAST(CAST(FLOOR(sortiment_leistung.art_id / 100) AS INT64) AS STRING), wug_id = b.wug_id, art_bez = b.art_bez, art_status = b.art_status, gp_id = CAST(ROUND(CAST(SUBSTR(b.akt_lieferant, 1, INSTR(b.akt_lieferant, ':') - 1) AS BIGNUMERIC), 0) AS INT64), akt_lieferant = b.akt_lieferant, zek_id = b.zek, disc_pe = b.disc_pe, disc_marke = b.disc_marke, lcf = b.lcf, vegan = b.vegan, gluten = b.gluten, bio = b.bio, eigenmarke = b.eigenmarke, tierwohl = b.tierwohl, posten_food = b.posten_food, posten_nonfood = b.posten_nonfood, mwst = b.mwst, listung_sst_mvke = TRIM(b.k_listung), ost_basis = b.ost_basis, ost_gross = b.ost_gross, sued_ost = b.sued_ost, sued_west = b.sued_west, west = b.west, nord = b.nord /* ,anz_maerkte = b.anz_listung_as_is */, durchschnittspreis = ROUND(CAST(b.stueck_re_mep AS NUMERIC), 5)
FROM dbp_etl.bf_sort_sal_export AS b
WHERE
    NOT sortiment_leistung.art_id IS NULL
    AND sortiment_leistung.vk_preis IS NULL
    AND CAST(FLOOR(sortiment_leistung.art_id / 100) AS INT64) = ROUND(CAST(b.art_nr AS BIGNUMERIC), 0)
    AND sortiment_leistung.mandant_id = 1
    AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    )
    AND NOT sortiment_leistung.gtin IS NULL;

UPDATE dbp_data.sortiment_leistung SET art_id = NULL
WHERE
    art_id = -1
    AND mandant_id = 1
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    );

CREATE OR REPLACE TEMPORARY TABLE _murks_xxx1 AS
SELECT
    mandant_id,
    kjmo,
    matching_id,
    kjwo_update,
    wrg_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    owg_id,
    wg_id,
    wug_id,
    rang_umsatz_wg,
    rang_umsatz_uwg,
    rang_absatz_uwg,
    art_id,
    kl_art_id,
    art_bez,
    art_status,
    gp_id,
    akt_lieferant,
    zek_id,
    disc_pe,
    disc_marke,
    lcf,
    vegan,
    gluten,
    bio,
    eigenmarke,
    tierwohl,
    posten_food,
    posten_nonfood,
    mwst,
    listung_k_sst_mvke,
    gewichtete_distribution,
    index_af_id,
    umsatz_af_pro_markt_woche,
    absatz_af_pro_markt_woche,
    ertrag_af_pro_markt_woche,
    bonreichweite_af,
    spanne_af,
    index_sa_id,
    umsatz_sa_pro_markt_woche,
    absatz_sa_pro_markt_woche,
    ertrag_sa_pro_markt_woche,
    bonreichweite_sa,
    spanne_sa,
    aktionsanteil_absatz,
    absatz_total,
    schnelldreherquote,
    schnelldreherquote_wg,
    schnelldreherquote_owg,
    kolliabverkaufsquote,
    kolliabverkaufsquote_wg,
    kolliabverkaufsquote_owg,
    abschriftsanteil,
    abschriftsanteil_wg,
    abschriftsanteil_owg,
    cherrypicker_quote,
    cherrypicker_quote_wg,
    cherrypicker_quote_owg,
    restbon,
    restbon_wg,
    restbon_owg,
    vk_preis,
    durchschnittspreis,
    preislagenverteilung,
    marktanteilbewertung,
    produktwissen_vp,
    lieferantenwissen_vp,
    produktwissen_pflege,
    lieferantenwissen_pflege,
    listung_sst_pflege,
    ost_basis_pflege,
    ost_gross_pflege,
    sued_ost_pflege,
    sued_west_pflege,
    west_pflege,
    nord_pflege,
    vorschlag,
    stk_re_pflege,
    umsatz_hr,
    absatz_hr,
    rohertrag_hr,
    nielsen_art_bez,
    gtin,
    distr_gew,
    umsatz_anteil_uwg,
    umsatz_anteil_uwg_kumuliert,
    durchschnitt_anz_maerkte,
    durchschnitt_preis,
    kl_markt_anteil_owg,
    umsatz_artikel,
    absatz_artikel,
    anz_monate,
    anz_wochen,
    eigenmarke_fg,
    listung_sst_mvke,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    nord,
    anz_maerkte_sst,
    anz_maerkte_baustein_sonstige,
    anz_maerkte_listung_einzel,
    anz_maerkte_listung_gesamt,
    listungsaktion,
    anz_maerkte_k_sst,
    listung_k_sst_pflege,
    muki_wb_kz,
    muki_wb_kl_art_id_verkettung,
    muki_vk_kz,
    muki_vk_kl_art_id_verkettung,
    muki_ek_kz,
    muki_ek_kl_art_id_verkettung,
    absatz_total_vj,
    max_anz_maerkte_sst,
    max_anz_maerkte_k_sst,
    kassenumsatz_kl_absolut_brutto,
    kassenumsatz_kl_absolut_netto,
    abschriften_wert_netto_absolut,
    td_update,
    td_insert
FROM dbp_data.sortiment_leistung AS a
WHERE
    kl_art_id IS NULL
    AND vk_preis IS NULL
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung
        WHERE
            mandant_id = 1
    )
    AND NOT art_id IS NULL
    AND NOT gtin IS NULL;

CREATE OR REPLACE TEMPORARY TABLE _murks_xxx2 AS
SELECT DISTINCT
    a.kjmo,
    a.art_id,
    b.kl_art_id,
    a132.wug_id,
    a133.art_bez,
    b.loesch_id AS art_status,
    b.zek_id AS zek,
    b.aldi_id AS disc_pe,
    b.discount_id AS disc_marke,
    b.lactose_fg AS lcf,
    b.vegan_fg AS vegan,
    b.gluten_fg AS gluten,
    b.bio_fg AS bio,
    b.eigenmarke_id AS eigenmarke,
    b.tierwohl_kz AS tierwohl,
    COALESCE(x.mwst, 0) AS mwst,
    'N/A' AS k_listung,
    CASE WHEN b.posten_id = 'PF' THEN 'X' ELSE ' ' END AS posten_food,
    CASE WHEN b.posten_id = 'PN' THEN 'X' ELSE ' ' END AS posten_nonfood,
    TRIM(CAST(a126.akt_gp_id AS STRING) || ':' || a134.akt_gp_name) AS akt_lieferant
FROM `_murks_xxx1` AS a
INNER JOIN dbp_msi_view2.mv_art AS b
    ON a.art_id = b.art_id AND b.mandant_id = 1
INNER JOIN dbp_msi_view2.mv_art_wg_zu_per AS a132
    ON a.art_id = a132.art_id AND b.mandant_id = a132.mandant_id
INNER JOIN dbp_msi_view2.mv_art_spr_zu AS a133
    ON a.art_id = a133.art_id AND b.mandant_id = a133.mandant_id
LEFT JOIN dbp_data.mwst_per AS x
    ON
        b.mandant_id = x.mandant_id
        AND b.mwst_id = x.mwst_id
        AND x.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_msi_view2.mv_art_gp_aktuell AS a126
    ON a.art_id = a126.art_id AND b.mandant_id = a126.mandant_id
INNER JOIN dbp_msi_view2.mv_gp_aktuell AS a134
    ON a126.akt_gp_id = a134.akt_gp_id;

UPDATE dbp_data.sortiment_leistung SET kl_art_id = CAST(CAST(FLOOR(sortiment_leistung.art_id / 100) AS INT64) AS STRING), wug_id = b.wug_id, art_bez = b.art_bez, art_status = b.art_status, gp_id = CAST(ROUND(CAST(SUBSTR(b.akt_lieferant, 1, INSTR(b.akt_lieferant, ':') - 1) AS BIGNUMERIC), 0) AS INT64), akt_lieferant = b.akt_lieferant, zek_id = b.zek, disc_pe = CAST(b.disc_pe AS INT64), disc_marke = CAST(b.disc_marke AS INT64), lcf = b.lcf, vegan = b.vegan, gluten = b.gluten, bio = b.bio, eigenmarke = b.eigenmarke
FROM `_murks_xxx2` AS b
WHERE
    sortiment_leistung.art_id = b.art_id
    AND sortiment_leistung.mandant_id = 1
    AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    );

UPDATE dbp_data.sortiment_leistung SET akt_lieferant = b.hersteller_bez
FROM (
    SELECT
        gtin_id,
        art_nielsen_bez,
        MAX(hersteller_bez) AS hersteller_bez
    FROM `_art_nielsen`
    WHERE
        mandant_id = 1
    GROUP BY
        art_nielsen_bez,
        gtin_id
) AS b
WHERE
    ROUND(CAST(sortiment_leistung.gtin AS BIGNUMERIC), 0) = b.gtin_id
    AND sortiment_leistung.nielsen_art_bez = b.art_nielsen_bez
    AND sortiment_leistung.mandant_id = 1
    AND sortiment_leistung.art_id IS NULL;

UPDATE dbp_data.sortiment_leistung SET eigenmarke = '-1'
WHERE
    kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    )
    AND gtin = '-9999'
    AND mandant_id = 1;

CREATE OR REPLACE TEMPORARY TABLE _step1_absatz_vj AS
SELECT
    c.kjmo_sort AS kjmo,
    b.art_id,
    SUM(a.menge * b.umrech_faktor) AS absatz_vj
FROM dbp_data.artbew AS a
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS c
    ON a.dat BETWEEN DATE_SUB(c.dat_von, INTERVAL '365' DAY) AND (
        DATE_SUB(c.dat_bis, INTERVAL '365' DAY)
    )
INNER JOIN (
    SELECT
        art_id,
        MAX(umrech_faktor) AS umrech_faktor
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        art_id
) AS b
    ON a.art_id = b.art_id
WHERE
    a.mandant_id = 1
    AND c.kjmo_sort IN (
        SELECT MAX(kjmo) AS a1886105636
        FROM dbp_data.sortiment_leistung
        WHERE
            mandant_id = 1
    )
GROUP BY
    kjmo,
    b.art_id;

CREATE OR REPLACE TEMPORARY TABLE _step2_absatz_vj AS
SELECT
    a.kjmo,
    b.art_matching_id,
    b.art_id,
    a.absatz_vj
FROM `_step1_absatz_vj` AS a
INNER JOIN (
    SELECT
        art_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        art_id,
        art_matching_id
) AS b
    ON a.art_id = b.art_id
GROUP BY
    a.kjmo,
    b.art_matching_id,
    b.art_id,
    a.absatz_vj;

UPDATE dbp_data.sortiment_leistung SET absatz_total_vj = CAST(b.absatz_vj AS NUMERIC)
FROM (
    SELECT
        kjmo,
        art_matching_id,
        SUM(absatz_vj) AS absatz_vj
    FROM `_step2_absatz_vj`
    GROUP BY
        kjmo,
        art_matching_id
) AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id
    AND sortiment_leistung.kjmo = b.kjmo
    AND sortiment_leistung.mandant_id = 1
    AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    );

UPDATE dbp_data.sortiment_leistung SET kassenumsatz_kl_absolut_brutto = 0, kassenumsatz_kl_absolut_netto = 0, abschriften_wert_netto_absolut = 0
WHERE
    mandant_id = 1
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    );

CREATE OR REPLACE TEMPORARY TABLE _step1_umsatz_brutto AS
SELECT
    c.kjmo_sort AS kjmo,
    b.art_id,
    SUM(a.umsatz_netto) AS umsatz_netto,
    SUM(a.umsatz_netto + a.umsatz_mwst_betrag) AS umsatz_brutto
FROM dbp_data.artbew AS a
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS c
    ON a.dat BETWEEN c.dat_von AND c.dat_bis
INNER JOIN (
    SELECT art_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        art_id
) AS b
    ON a.art_id = b.art_id
WHERE
    a.mandant_id = 1
    AND c.kjmo_sort IN (
        SELECT MAX(kjmo) AS a1886105636
        FROM dbp_data.sortiment_leistung
        WHERE
            mandant_id = 1
    )
GROUP BY
    kjmo,
    b.art_id;

CREATE OR REPLACE TEMPORARY TABLE _step2_umsatz_brutto AS
SELECT
    a.kjmo,
    b.art_matching_id,
    b.art_id,
    a.umsatz_netto,
    a.umsatz_brutto
FROM `_step1_umsatz_brutto` AS a
INNER JOIN (
    SELECT
        art_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        art_id,
        art_matching_id
) AS b
    ON a.art_id = b.art_id
GROUP BY
    a.kjmo,
    b.art_matching_id,
    b.art_id,
    a.umsatz_netto,
    a.umsatz_brutto;

UPDATE dbp_data.sortiment_leistung SET kassenumsatz_kl_absolut_brutto = b.umsatz_brutto, kassenumsatz_kl_absolut_netto = b.umsatz_netto
FROM (
    SELECT
        kjmo,
        art_matching_id,
        SUM(umsatz_netto) AS umsatz_netto,
        SUM(umsatz_brutto) AS umsatz_brutto
    FROM `_step2_umsatz_brutto`
    GROUP BY
        kjmo,
        art_matching_id
) AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id
    AND sortiment_leistung.kjmo = b.kjmo
    AND sortiment_leistung.mandant_id = 1
    AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    );

CREATE OR REPLACE TEMPORARY TABLE _step1_abschr AS
SELECT
    c.kjmo_sort AS kjmo,
    b.art_id,
    SUM(a.abschriftenbetrag_netto) AS abschriftenbetrag_netto
FROM dbp_msi_view2.mv_marktabschriften AS a
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS c
    ON a.dat BETWEEN c.dat_von AND c.dat_bis
INNER JOIN (
    SELECT art_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        art_id
) AS b
    ON a.art_id = b.art_id
WHERE
    a.mandant_id = 1
    AND c.kjmo_sort IN (
        SELECT MAX(kjmo) AS a1886105636
        FROM dbp_data.sortiment_leistung
        WHERE
            mandant_id = 1
    )
    AND a.abschriftenart_id <> -1
GROUP BY
    kjmo,
    b.art_id;

CREATE OR REPLACE TEMPORARY TABLE _step2_abschr AS
SELECT
    a.kjmo,
    b.art_matching_id,
    b.art_id,
    a.abschriftenbetrag_netto
FROM `_step1_abschr` AS a
INNER JOIN (
    SELECT
        art_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        art_id,
        art_matching_id
) AS b
    ON a.art_id = b.art_id
GROUP BY
    a.kjmo,
    b.art_matching_id,
    b.art_id,
    a.abschriftenbetrag_netto;

UPDATE dbp_data.sortiment_leistung SET abschriften_wert_netto_absolut = CAST(b.abschriftenbetrag_netto AS NUMERIC)
FROM (
    SELECT
        kjmo,
        art_matching_id,
        SUM(abschriftenbetrag_netto) AS abschriftenbetrag_netto
    FROM `_step2_abschr`
    GROUP BY
        kjmo,
        art_matching_id
) AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id
    AND sortiment_leistung.kjmo = b.kjmo
    AND sortiment_leistung.mandant_id = 1
    AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            mandant_id = 1
    );

/* 18.01.2022, -dbay- */ /* proper handling of duplicates */
INSERT INTO dbp_etl_process.matching_art_nielsen_zu
(
    SELECT
        mandant_id,
        kjwo_update,
        art_matching_id,
        art_nielsen_id,
        gtin_id
    FROM dbp_etl.art_matching_nielsen_per
    WHERE
        (mandant_id, art_matching_id) IN (
            SELECT (mandant_id, matching_id)
            FROM dbp_data.sortiment_leistung
            WHERE
                mandant_id = 1
                AND kjwo_update IN (
                    SELECT MAX(kjwo_update) AS kjwo_update
                    FROM dbp_data.sortiment_leistung
                    WHERE
                        mandant_id = 1
                )
            GROUP BY
                mandant_id,
                matching_id
            HAVING
                COUNT(*) > 1
        )
        AND art_nielsen_id <> -1
        AND NOT (mandant_id, art_matching_id, art_nielsen_id, kjwo_update) IN (
            SELECT (mandant_id, art_matching_id, art_nielsen_id, kjwo_update)
            FROM dbp_etl_process.matching_art_nielsen_zu
        )
    GROUP BY
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        gtin_id,
        kjwo_update
);


CREATE OR REPLACE TEMPORARY TABLE _sorti_agg AS
SELECT mandant_id,
 kjmo,
 matching_id,
 kjwo_update,
 MAX(wrg_id) AS wrg_id,
 MAX(kl_wg_id) AS kl_wg_id,
 MAX(kl_owg_id) AS kl_owg_id,
 MAX(kl_uwg_id) AS kl_uwg_id,
 MAX(owg_id) AS owg_id,
 MAX(wg_id) AS wg_id,
 MAX(wug_id) AS wug_id,
 MAX(rang_umsatz_wg) AS rang_umsatz_wg,
 MAX(rang_umsatz_uwg) AS rang_umsatz_uwg,
 MAX(rang_absatz_uwg) AS rang_absatz_uwg,
 MAX(art_id) AS art_id,
 MAX(kl_art_id) AS kl_art_id,
 MAX(art_bez) AS art_bez,
 MAX(art_status) AS art_status,
 MAX(gp_id) AS gp_id,
 MAX(akt_lieferant) AS akt_lieferant,
 MAX(zek_id) AS zek_id,
 MAX(disc_pe) AS disc_pe,
 MAX(disc_marke) AS disc_marke,
 MAX(lcf) AS lcf,
 MAX(vegan) AS vegan,
 MAX(gluten) AS gluten,
 MAX(bio) AS bio,
 MAX(eigenmarke) AS eigenmarke,
 MAX(tierwohl) AS tierwohl,
 MAX(posten_food) AS posten_food,
 MAX(posten_nonfood) AS posten_nonfood,
 MAX(mwst) AS mwst,
 MAX(listung_k_sst_mvke) AS listung_k_sst_mvke,
 MAX(gewichtete_distribution) AS gewichtete_distribution,
 MAX(index_af_id) AS index_af_id,
 MAX(umsatz_af_pro_markt_woche) AS umsatz_af_pro_markt_woche,
 MAX(absatz_af_pro_markt_woche) AS absatz_af_pro_markt_woche,
 MAX(ertrag_af_pro_markt_woche) AS ertrag_af_pro_markt_woche,
 MAX(bonreichweite_af) AS bonreichweite_af,
 MAX(spanne_af) AS spanne_af,
 MAX(index_sa_id) AS index_sa_id,
 MAX(umsatz_sa_pro_markt_woche) AS umsatz_sa_pro_markt_woche,
 MAX(absatz_sa_pro_markt_woche) AS absatz_sa_pro_markt_woche,
 MAX(ertrag_sa_pro_markt_woche) AS ertrag_sa_pro_markt_woche,
 MAX(bonreichweite_sa) AS bonreichweite_sa,
 MAX(spanne_sa) AS spanne_sa,
 MAX(aktionsanteil_absatz) AS aktionsanteil_absatz,
 MAX(absatz_total) AS absatz_total,
 MAX(schnelldreherquote) AS schnelldreherquote,
 MAX(schnelldreherquote_wg) AS schnelldreherquote_wg,
 MAX(schnelldreherquote_owg) AS schnelldreherquote_owg,
 MAX(kolliabverkaufsquote) AS kolliabverkaufsquote,
 MAX(kolliabverkaufsquote_wg) AS kolliabverkaufsquote_wg,
 MAX(kolliabverkaufsquote_owg) AS kolliabverkaufsquote_owg,
 MAX(abschriftsanteil) AS abschriftsanteil,
 MAX(abschriftsanteil_wg) AS abschriftsanteil_wg,
 MAX(abschriftsanteil_owg) AS abschriftsanteil_owg,
 MAX(cherrypicker_quote) AS cherrypicker_quote,
 MAX(cherrypicker_quote_wg) AS cherrypicker_quote_wg,
 MAX(cherrypicker_quote_owg) AS cherrypicker_quote_owg,
 MAX(restbon) AS restbon,
 MAX(restbon_wg) AS restbon_wg,
 MAX(restbon_owg) AS restbon_owg,
 MAX(vk_preis) AS vk_preis,
 MAX(durchschnittspreis) AS durchschnittspreis,
 MAX(preislagenverteilung) AS preislagenverteilung,
 MAX(marktanteilbewertung) AS marktanteilbewertung,
 MAX(produktwissen_vp) AS produktwissen_vp,
 MAX(lieferantenwissen_vp) AS lieferantenwissen_vp,
 MAX(produktwissen_pflege) AS produktwissen_pflege,
 MAX(lieferantenwissen_pflege) AS lieferantenwissen_pflege,
 MAX(listung_sst_pflege) AS listung_sst_pflege,
 MAX(ost_basis_pflege) AS ost_basis_pflege,
 MAX(ost_gross_pflege) AS ost_gross_pflege,
 MAX(sued_ost_pflege) AS sued_ost_pflege,
 MAX(sued_west_pflege) AS sued_west_pflege,
 MAX(west_pflege) AS west_pflege,
 MAX(nord_pflege) AS nord_pflege,
 MAX(vorschlag) AS vorschlag,
 MAX(stk_re_pflege) AS stk_re_pflege,
 MAX(umsatz_hr) AS umsatz_hr,
 MAX(absatz_hr) AS absatz_hr,
 MAX(rohertrag_hr) AS rohertrag_hr,
 MAX(nielsen_art_bez) AS nielsen_art_bez,
 MAX(gtin) AS gtin,
 MAX(distr_gew) AS distr_gew,
 MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
 MAX(umsatz_anteil_uwg_kumuliert) AS umsatz_anteil_uwg_kumuliert,
 MAX(durchschnitt_anz_maerkte) AS durchschnitt_anz_maerkte,
 MAX(durchschnitt_preis) AS durchschnitt_preis,
 MAX(kl_markt_anteil_owg) AS kl_markt_anteil_owg,
 MAX(umsatz_artikel) AS umsatz_artikel,
 MAX(absatz_artikel) AS absatz_artikel,
 MAX(anz_monate) AS anz_monate,
 MAX(anz_wochen) AS anz_wochen,
 MAX(eigenmarke_fg) AS eigenmarke_fg,
 MAX(listung_sst_mvke) AS listung_sst_mvke,
 MAX(ost_basis) AS ost_basis,
 MAX(ost_gross) AS ost_gross,
 MAX(sued_ost) AS sued_ost,
 MAX(sued_west) AS sued_west,
 MAX(west) AS west,
 MAX(nord) AS nord,
 MAX(anz_maerkte_sst) AS anz_maerkte_sst,
 MAX(anz_maerkte_baustein_sonstige) AS anz_maerkte_baustein_sonstige,
 MAX(anz_maerkte_listung_einzel) AS anz_maerkte_listung_einzel,
 MAX(anz_maerkte_listung_gesamt) AS anz_maerkte_listung_gesamt,
 MAX(listungsaktion) AS listungsaktion,
 MAX(anz_maerkte_k_sst) AS anz_maerkte_k_sst,
 MAX(listung_k_sst_pflege) AS listung_k_sst_pflege,
 MAX(muki_wb_kz) AS muki_wb_kz,
 MAX(muki_wb_kl_art_id_verkettung) AS muki_wb_kl_art_id_verkettung,
 MAX(muki_vk_kz) AS muki_vk_kz,
 MAX(muki_vk_kl_art_id_verkettung) AS muki_vk_kl_art_id_verkettung,
 MAX(muki_ek_kz) AS muki_ek_kz,
 MAX(muki_ek_kl_art_id_verkettung) AS muki_ek_kl_art_id_verkettung,
 MAX(absatz_total_vj) AS absatz_total_vj,
 MAX(max_anz_maerkte_sst) AS max_anz_maerkte_sst,
 MAX(max_anz_maerkte_k_sst) AS max_anz_maerkte_k_sst,
 MAX(kassenumsatz_kl_absolut_brutto) AS kassenumsatz_kl_absolut_brutto,
 MAX(kassenumsatz_kl_absolut_netto) AS kassenumsatz_kl_absolut_netto,
 MAX(abschriften_wert_netto_absolut) AS abschriften_wert_netto_absolut,
 MAX(CURRENT_TIMESTAMP()) AS td_insert,
 MAX(CURRENT_TIMESTAMP()) AS td_update
FROM dbp_data.sortiment_leistung
WHERE (mandant_id, matching_id, kjwo_update) IN (SELECT (mandant_id, art_matching_id, kjwo_update)
   FROM dbp_etl_process.matching_art_nielsen_zu
   WHERE mandant_id = 1
    AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
      FROM dbp_data.sortiment_leistung
      WHERE mandant_id = 1))
GROUP BY mandant_id,
 kjmo,
 matching_id,
 kjwo_update;

DELETE FROM dbp_data.sortiment_leistung
WHERE
    (mandant_id, kjwo_update, matching_id) IN (
        SELECT (mandant_id, kjwo_update, matching_id)
        FROM `_sorti_agg`
    );

INSERT INTO dbp_data.sortiment_leistung
(SELECT mandant_id,
  kjmo,
  matching_id,
  kjwo_update,
  wrg_id,
  kl_wg_id,
  kl_owg_id,
  kl_uwg_id,
  owg_id,
  wg_id,
  wug_id,
  rang_umsatz_wg,
  rang_umsatz_uwg,
  rang_absatz_uwg,
  art_id,
  kl_art_id,
  art_bez,
  art_status,
  gp_id,
  akt_lieferant,
  zek_id,
  disc_pe,
  disc_marke,
  lcf,
  vegan,
  gluten,
  bio,
  eigenmarke,
  tierwohl,
  posten_food,
  posten_nonfood,
  mwst,
  listung_k_sst_mvke,
  gewichtete_distribution,
  index_af_id,
  umsatz_af_pro_markt_woche,
  absatz_af_pro_markt_woche,
  ertrag_af_pro_markt_woche,
  bonreichweite_af,
  spanne_af,
  index_sa_id,
  umsatz_sa_pro_markt_woche,
  absatz_sa_pro_markt_woche,
  ertrag_sa_pro_markt_woche,
  bonreichweite_sa,
  spanne_sa,
  aktionsanteil_absatz,
  absatz_total,
  schnelldreherquote,
  schnelldreherquote_wg,
  schnelldreherquote_owg,
  kolliabverkaufsquote,
  kolliabverkaufsquote_wg,
  kolliabverkaufsquote_owg,
  abschriftsanteil,
  abschriftsanteil_wg,
  abschriftsanteil_owg,
  cherrypicker_quote,
  cherrypicker_quote_wg,
  cherrypicker_quote_owg,
  restbon,
  restbon_wg,
  restbon_owg,
  vk_preis,
  durchschnittspreis,
  preislagenverteilung,
  marktanteilbewertung,
  produktwissen_vp,
  lieferantenwissen_vp,
  produktwissen_pflege,
  lieferantenwissen_pflege,
  listung_sst_pflege,
  ost_basis_pflege,
  ost_gross_pflege,
  sued_ost_pflege,
  sued_west_pflege,
  west_pflege,
  nord_pflege,
  vorschlag,
  stk_re_pflege,
  umsatz_hr,
  absatz_hr,
  rohertrag_hr,
  nielsen_art_bez,
  gtin,
  distr_gew,
  umsatz_anteil_uwg,
  umsatz_anteil_uwg_kumuliert,
  durchschnitt_anz_maerkte,
  durchschnitt_preis,
  kl_markt_anteil_owg,
  umsatz_artikel,
  absatz_artikel,
  anz_monate,
  anz_wochen,
  eigenmarke_fg,
  listung_sst_mvke,
  ost_basis,
  ost_gross,
  sued_ost,
  sued_west,
  west,
  nord,
  anz_maerkte_sst,
  anz_maerkte_baustein_sonstige,
  anz_maerkte_listung_einzel,
  anz_maerkte_listung_gesamt,
  listungsaktion,
  anz_maerkte_k_sst,
  listung_k_sst_pflege,
  muki_wb_kz,
  muki_wb_kl_art_id_verkettung,
  muki_vk_kz,
  muki_vk_kl_art_id_verkettung,
  muki_ek_kz,
  muki_ek_kl_art_id_verkettung,
  absatz_total_vj,
  max_anz_maerkte_sst,
  max_anz_maerkte_k_sst,
  kassenumsatz_kl_absolut_brutto,
  kassenumsatz_kl_absolut_netto,
  abschriften_wert_netto_absolut,
  td_insert,
  td_update
 FROM `_sorti_agg` AS A);

/* kl_old de */
CREATE OR REPLACE TEMPORARY TABLE _upd1 AS
SELECT DISTINCT
    kjwo_update,
    mandant_id,
    art_id,
    gtin_id
FROM dbp_etl.art_matching_nielsen_per
WHERE
    kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl.art_matching_nielsen_per
    )
    AND art_nielsen_id <> -1
    AND art_id <> -1
    AND NOT gtin_id IN (-9999, -9998);

CREATE OR REPLACE TEMPORARY TABLE _upd2 AS
SELECT DISTINCT
    kjwo_update,
    mandant_id,
    art_matching_id,
    art_nielsen_id,
    gtin_id
FROM dbp_etl.art_matching_nielsen_per
WHERE
    kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl.art_matching_nielsen_per
    )
    AND NOT gtin_id IN (-9999, -9998);

UPDATE dbp_data.sortiment_leistung SET gtin = CAST(b.gtin_id AS STRING)
FROM (
    SELECT
        kjwo_update,
        mandant_id,
        art_id,
        MAX(gtin_id) AS gtin_id
    FROM `_upd1`
    GROUP BY
        kjwo_update,
        mandant_id,
        art_id
) AS b
WHERE
    sortiment_leistung.kjwo_update = b.kjwo_update
    AND sortiment_leistung.mandant_id = b.mandant_id
    AND sortiment_leistung.art_id = b.art_id
    AND sortiment_leistung.gtin IS NULL;

UPDATE dbp_data.sortiment_leistung SET gtin = CAST(b.gtin_id AS STRING)
FROM (
    SELECT
        kjwo_update,
        mandant_id,
        art_matching_id,
        MAX(gtin_id) AS gtin_id
    FROM `_upd2`
    WHERE
        art_nielsen_id <> -1
    GROUP BY
        kjwo_update,
        mandant_id,
        art_matching_id
) AS b
WHERE
    sortiment_leistung.kjwo_update = b.kjwo_update
    AND sortiment_leistung.mandant_id = b.mandant_id
    AND sortiment_leistung.matching_id = b.art_matching_id
    AND sortiment_leistung.gtin IS NULL
    AND NOT sortiment_leistung.art_id IS NULL;
