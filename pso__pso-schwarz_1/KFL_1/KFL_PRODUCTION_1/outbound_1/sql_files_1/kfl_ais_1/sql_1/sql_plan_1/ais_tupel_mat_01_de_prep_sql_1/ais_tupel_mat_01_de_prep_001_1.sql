CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen_1
WHERE dat_bis = DATE '9999-12-31';


DROP TABLE IF EXISTS dbp_etl.bf_artbew_wg_art_wo_sum_de_1;


CREATE TABLE IF NOT EXISTS dbp_etl.bf_artbew_wg_art_wo_sum_de_1 (
    mandant_id INTEGER,
    kjwo INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    bewart_id INTEGER,
    menge NUMERIC(29, 3),
    umsatz_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


DROP TABLE IF EXISTS dbp_etl.bf_listung_markt_kw_1;


CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_kw_1 (
    mandant_id INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    kjwo INTEGER,
    absatz NUMERIC(29, 3),
    absatz_sa NUMERIC(29, 3),
    absatz_af NUMERIC(29, 3),
    umsatz NUMERIC(29, 4),
    umsatz_sa NUMERIC(29, 4),
    umsatz_af NUMERIC(29, 4),
    ertrag NUMERIC(29, 4),
    ertrag_sa NUMERIC(29, 4),
    ertrag_af NUMERIC(29, 4),
    anzahl_wochen_mit_absatz INTEGER,
    anzahl_wochen_mit_absatz_sa INTEGER,
    anzahl_wochen_mit_absatz_af INTEGER
);


CREATE OR REPLACE TEMPORARY TABLE _art_leistung_1 AS
SELECT
    mandant_id,
    art_matching_id,
    art_nielsen_id,
    gtin_id,
    art_id,
    umrech_faktor,
    status_1,
    MAX(kl_wg_id) OVER (
        PARTITION BY art_matching_id ORDER BY kl_wg_id IS NULL, kl_wg_id RANGE BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS kl_wg_id,
    MAX(kl_owg_id) OVER (
        PARTITION BY art_matching_id ORDER BY kl_owg_id IS NULL, kl_owg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_owg_id,
    MAX(kl_uwg_id) OVER (
        PARTITION BY art_matching_id ORDER BY kl_uwg_id IS NULL, kl_uwg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_1
WHERE art_id <> -1;


INSERT INTO `_art_leistung_1`
(
    SELECT
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        gtin_id,
        art_id,
        umrech_faktor,
        status_1,
        MAX(kl_wg_id) OVER (
            PARTITION BY art_matching_id ORDER BY kl_wg_id IS NULL, kl_wg_id RANGE BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ) AS kl_wg_id,
        MAX(kl_owg_id) OVER (
            PARTITION BY art_matching_id ORDER BY kl_owg_id IS NULL, kl_owg_id RANGE BETWEEN
            UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS kl_owg_id,
        MAX(kl_uwg_id) OVER (
            PARTITION BY art_matching_id ORDER BY kl_uwg_id IS NULL, kl_uwg_id RANGE BETWEEN
            UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_1
    WHERE
        status_1 = 'G'
        AND art_id NOT IN (
            SELECT art_id
            FROM `_art_leistung_1`
        )
);


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_1st_base AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    COUNT(DISTINCT x.kjwo) AS anz,
    SUM(A.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK()
        OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC) AS
    rang_umsatz_uwg,
    DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo_1 AS A
INNER JOIN (SELECT
    kjwo,
    MIN(kjmo) AS kjmo
FROM dbp_data.tag_1
GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        gtin_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_1
    GROUP BY
        mandant_id,
        gtin_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.gtin_id = c.gtin_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market_1 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
    AND A.mandant_id = 1
    AND B.gtin_id NOT IN (-9999, -9998)
GROUP BY
    A.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id;


INSERT INTO `_artikel_anteil_uwg_ranking_1st_base`
(
    SELECT
        A.mandant_id,
        c.art_matching_id,
        c.kl_wg_id,
        c.kl_owg_id,
        c.kl_uwg_id,
        COUNT(DISTINCT x.kjwo) AS anz,
        SUM(A.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
        SUM(A.menge) AS menge_,
        SUM(A.umsatz_brutto) AS umsatz_,
        SUM(A.menge_af) AS menge_af_,
        SUM(A.umsatz_brutto_af) AS umsatz_af_,
        SUM(A.menge_sa) AS menge_sa_,
        SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
        SUM(0) AS umsatz_anteil_kum_uwg,
        DENSE_RANK()
            OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC) AS
        rang_umsatz_uwg,
        DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS rang_absatz_uwg
        ,
        0 AS rang_umsatz_wg
    FROM dbp_data.art_nielsen_fakten_kjwo_1 AS A
    INNER JOIN (SELECT
        kjwo,
        MIN(kjmo) AS kjmo
    FROM dbp_data.tag_1
    GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
    INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_nielsen_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id
        FROM dbp_etl.art_matching_nielsen_per_1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_nielsen_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id
    ) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
    INNER JOIN dbp_data.nielsen_market_1 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

    WHERE
        A.kjwo IN (
            SELECT kjwo
            FROM dbp_data.art_nielsen_fakten_kjwo_1
            WHERE mandant_id = 1
            GROUP BY kjwo
            QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
        )
        AND D.nielsen_market_cluster_id = 2
        AND B.gtin_id IN (-9999, -9998)
        AND A.mandant_id = 1
    GROUP BY
        A.mandant_id,
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
FROM `_artikel_anteil_uwg_ranking_1st_base` AS A
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
WHERE art_nielsen_id <> -1
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
    DENSE_RANK() OVER (PARTITION BY MIN(kl_wg_id) ORDER BY SUM(umsatz__) IS NULL DESC, SUM(umsatz__) DESC)
        AS
        rang_umsatz_wg
FROM `_artikel_anteil_uwg_ranking`
GROUP BY art_matching_id;


UPDATE `_artikel_anteil_uwg_leistung_base1` SET
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg,
    distr_gew = CAST(b.distr_gew_ AS INT64)
FROM `_artikel_anteil_uwg_ranking` AS b
WHERE
    `_artikel_anteil_uwg_leistung_base1`.art_matching_id = b.art_matching_id AND `_artikel_anteil_uwg_leistung_base1`
    .kl_uwg_id = b.kl_uwg_id AND `_artikel_anteil_uwg_leistung_base1`.kl_owg_id = b.kl_owg_id;


UPDATE `_artikel_anteil_uwg_leistung_base1` SET
    rang_umsatz_wg = b.rang_umsatz_wg
FROM `_artikel_anteil_wg_ranking` AS b
WHERE `_artikel_anteil_uwg_leistung_base1`.art_matching_id = b.art_matching_id;


UPDATE `_artikel_anteil_uwg_ranking` SET
    rang_umsatz_wg = b.rang_umsatz_wg
FROM `_artikel_anteil_wg_ranking` AS b
WHERE `_artikel_anteil_uwg_ranking`.art_matching_id = b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_1 AS
SELECT
    b.art_matching_id,
    b.art_id,
    b.umrech_faktor,
    b.status_1,
    0 AS distr_gew,
    A.monat_1,
    A.anz_monate,
    A.wg_id,
    A.wug_id,
    A.art_nr,
    A.art_bez,
    A.art_status,
    A.akt_lieferant,
    A.zek_1,
    A.eigenmarke,
    A.bio,
    A.tierwohl,
    A.vegan,
    A.posten_food,
    A.posten_nonfood,
    A.gluten,
    A.mwst,
    A.disc_pe,
    A.disc_marke,
    A.lcf,
    A.k_listung,
    A.ost_basis,
    A.ost_gross,
    A.sued_ost,
    A.sued_west,
    A.west,
    A.nord,
    A.kol_bst,
    A.kol_la,
    A.rlz_dz,
    A.rlz,
    A.k1_absatz,
    A.k1_markt_wochen,
    A.k1_absatz_mt_wo,
    A.k2_absatz,
    A.k2_markt_wochen,
    A.k2_absatz_mt_wo,
    A.k3_absatz,
    A.k3_markt_wochen,
    A.k3_absatz_mt_wo,
    A.k4_absatz,
    A.k4_markt_wochen,
    A.k4_absatz_mt_wo,
    A.k5_absatz,
    A.k5_markt_wochen,
    A.k5_absatz_mt_wo,
    A.ost_basis_absatz,
    A.ost_basis_markt_wochen,
    A.ost_basis_absatz_mt_wo,
    A.ost_gross_absatz,
    A.ost_gross_markt_wochen,
    A.ost_gross_absatz_mt_wo,
    A.sued_ost_absatz,
    A.sued_ost_markt_wochen,
    A.sued_ost_absatz_mt_wo,
    A.sued_west_absatz,
    A.sued_west_markt_wochen,
    A.sued_west_absatz_mt_wo,
    A.west_absatz,
    A.west_markt_wochen,
    A.west_absatz_mt_wo,
    A.nord_absatz,
    A.nord_markt_wochen,
    A.nord_absatz_mt_wo,
    A.total_absatz,
    A.total_absatz_mt_wo,
    A.stg_absatz_vj,
    A.schnelldreherquote,
    A.aktion_absatz,
    A.kassenumsatz,
    A.stueck_re_mep,
    A.total_re_mep,
    A.stg_re_mep_vj,
    A.avg_spanne_mep,
    A.avg_spanne_af_mep,
    A.avg_spanne_sa_mep,
    A.abschr_o_werb,
    A.abschr_o_werb_umsatz,
    A.kb,
    A.vk_pk_1,
    A.vk_pk_4,
    A.sp_kb_pk_1,
    A.sp_kb_pk_4,
    A.total_af_absatz,
    A.absatz_af_markt_wochen,
    A.total_absatz_af_mt_wo,
    A.total_sa_absatz,
    A.absatz_sa_markt_tage,
    A.total_absatz_sa_mt_tag,
    A.stueck_re_mep_af,
    A.stueck_re_mep_sa,
    A.af_re_mep,
    A.sa_re_mep,
    A.total_umsatz_netto,
    A.total_umsatz_netto_mt_wo,
    A.af_umsatz_netto,
    A.af_umsatz_netto_mt_wo,
    A.sa_umsatz_netto,
    A.sa_umsatz_netto_mt_tag,
    A.total_re_mep_mt_wo,
    A.af_re_mep_mt_wo,
    A.sa_re_mep_mt_tag,
    A.anz_maerkte,
    A.anz_wo_mit_absatz,
    A.anz_wo_listung_1,
    A.anz_listung_as_is,
    A.kol_la_bzw,
    A.kol_bst_bzw,
    A.lagerprozent,
    A.td_update,
    A.td_insert
FROM dbp_etl.bf_sort_sal_export_1 AS A
INNER JOIN (
    SELECT
        art_matching_id,
        CAST(FLOOR(art_id / 100) AS INTEGER) AS kl_art_id,
        art_id,
        umrech_faktor,
        status_1
    FROM `_art_leistung_1`
    GROUP BY
        art_matching_id,
        kl_art_id,
        art_id,
        umrech_faktor,
        status_1
)
    AS b ON ROUND(CAST(A.art_nr AS BIGNUMERIC), 0
) = b.kl_art_id;


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_2 AS
SELECT
    art_matching_id,
    status_1,
    umrech_faktor,
    0 AS kl_wg_id,
    0 AS kl_owg_id,
    0 AS kl_uwg_id,
    NULL AS rang_umsatz_wg,
    NULL AS rang_umsatz_uwg,
    NULL AS rang_absatz_uwg,
    art_id,
    CAST(FLOOR(art_id / 100) AS INTEGER) AS kl_art_id,
    wug_id,
    art_bez,
    art_status,
    ROUND(CAST(SUBSTR(akt_lieferant, 1, INSTR(akt_lieferant, ':') - 1) AS BIGNUMERIC), 0) AS gp_id,
    akt_lieferant,
    zek_1,
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
    /* Index-AF */ 0 AS index_af_id,
    af_umsatz_netto_mt_wo AS umsatz_af_pro_markt_woche,
    -- af_umsatz_netto/anz_wo_listung_1 AS umsatz_af_pro_markt_woche,
    total_absatz_af_mt_wo * umrech_faktor
        AS
        absatz_af_pro_markt_woche,
    -- total_af_absatz/anz_wo_listung_1 AS absatz_af_pro_markt_woche,
    af_re_mep_mt_wo AS ertrag_af_pro_markt_woche,
    0 AS bonreichweite_af,
    IFNULL(af_re_mep_mt_wo / IF(af_umsatz_netto_mt_wo = 0, NULL, af_umsatz_netto_mt_wo), 0) AS spanne_af,
    /* Index-SA */ 0 AS index_sa_id,
    IFNULL(
        sa_umsatz_netto / IF(absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage), 0) * 6.00 AS
    umsatz_sa_pro_markt_woche,
    IFNULL(
        total_sa_absatz * umrech_faktor / IF(absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage), 0) * 6.00 AS
    absatz_sa_pro_markt_woche,
    IFNULL(sa_re_mep / IF(absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage), 0) * 6.00 AS ertrag_sa_pro_markt_woche,
    0 AS bonreichweite_sa,
    IFNULL(IFNULL(sa_re_mep / IF(
        absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage), 0) * 6.00 / IF(IFNULL(sa_umsatz_netto
    / IF(
        absatz_sa_markt_tage = 0, NULL, absatz_sa_markt_tage
    ), 0) * 6.00 = 0, NULL, IFNULL(
        sa_umsatz_netto / IF(
            absatz_sa_markt_tage
            = 0, NULL, absatz_sa_markt_tage
        ), 0
    ) * 6.00), 0) AS spanne_sa,
    /* Kennzahlen */ aktion_absatz * umrech_faktor AS aktionsanteil_absatz,
    total_absatz * umrech_faktor AS absatz_total,
    /* Bon */ schnelldreherquote / 100 AS schnelldreherquote,
    0 AS schnelldreherquote_wg,
    0 AS schnelldreherquote_owg,
    CASE
        WHEN kol_la_bzw IS NOT NULL
            THEN IFNULL(rlz * lagerprozent * COALESCE(
                total_absatz_af_mt_wo * umrech_faktor / 6, total_absatz_sa_mt_tag *
                umrech_faktor
            ) / IF(kol_la_bzw = 0, NULL, kol_la_bzw
            ), 0)
        ELSE CAST(IFNULL(rlz_dz * COALESCE(total_absatz_af_mt_wo * umrech_faktor / 6, total_absatz_sa_mt_tag * umrech_faktor) / IF(kol_bst_bzw = 0, NULL, kol_bst_bzw), 0) AS FLOAT64)
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
    /* Bewertung */ vk_pk_1 AS vk_preis,
    CASE
        WHEN af_umsatz_netto <> 0
            THEN IFNULL(af_umsatz_netto * ((100 + mwst) / 100) / IF(total_af_absatz = 0, NULL, total_af_absatz), 0)
        ELSE IFNULL(sa_umsatz_netto * ((100 + mwst) / 100) / IF(total_sa_absatz = 0, NULL, total_sa_absatz), 0)
    END AS durchschnittspreis,
    0 AS preislagenverteilung,
    0 AS marktanteilbewertung,
    /* zur Berechnung */ anz_wo_mit_absatz,
    anz_wo_listung_1,
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


UPDATE `_sal_snap_2` SET
    bonreichweite_af = CAST(b.krw_af AS INT64),
    bonreichweite_sa = CAST(b.krw_sa AS INT64) FROM (SELECT
    kl_art_id,
    SUM(krw_af) AS krw_af,
    SUM(krw_sa) AS krw_sa,
    SUM(cpq_total) AS cpq_total,
    SUM(rb_total) AS rb_total
FROM dbp_etl.bf_bons_sort_export_1
WHERE
    bereich = 'alle'
    AND mandant_id = 1
GROUP BY kl_art_id) AS b
WHERE `_sal_snap_2`.kl_art_id = b.kl_art_id;


CREATE OR REPLACE TEMPORARY TABLE _step1 AS
SELECT
    B.mandant_id,
    B.art_id,
    C.wg_id,
    SUM(A.artikel_bons_af) AS art_bons_af,
    SUM(A.artikel_bons_sa) AS art_bons_sa,
    SUM(A.cpq_total) AS cpq_total_artikel,
    SUM(A.cherry_bons_af) AS cp_bons_af,
    SUM(A.cherry_bons_sa) AS cp_bons_sa,
    SUM(A.bons) AS bons,
    SUM(A.rb_total) AS rb_total
FROM dbp_etl.bf_bons_sort_export_1 AS A
INNER JOIN dbp_data.art_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.kl_art_id = B.kl_art_id AND B.dat_bis
        = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.art_wg_zu_per_1 AS C
    ON
        A.mandant_id = C.mandant_id AND B.art_id = C.art_id AND C.arthiertyp_id
        = 2 AND C.dat_bis = PARSE_DATE('%F', '9999-12-31')
WHERE
    A.bereich = 'alle'
    AND A.mandant_id = 1
GROUP BY
    B.mandant_id,
    B.art_id,
    C.wg_id;


CREATE OR REPLACE TEMPORARY TABLE _step2 AS
SELECT
    mandant_id,
    wg_id,
    (
        SUM(CAST(cp_bons_af AS FLOAT64)) + SUM(CAST(cp_bons_sa AS FLOAT64))) / IF(
        SUM(CAST(art_bons_af AS FLOAT64) + CAST(art_bons_sa AS FLOAT64)
        ) = 0, NULL, SUM(CAST(art_bons_af AS FLOAT64) + CAST(art_bons_sa AS FLOAT64))
    ) AS cpq_total_wg
FROM `_step1`
GROUP BY
    mandant_id,
    wg_id;


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_2_multis AS
SELECT
    A.art_matching_id,
    A.status_1,
    A.umrech_faktor,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    A.rang_umsatz_wg,
    A.rang_umsatz_uwg,
    A.rang_absatz_uwg,
    A.art_id,
    A.kl_art_id,
    A.wug_id,
    A.art_bez,
    A.art_status,
    A.gp_id,
    A.akt_lieferant,
    A.zek_1,
    A.disc_pe,
    A.disc_marke,
    A.lcf,
    A.vegan,
    A.gluten,
    A.bio,
    A.eigenmarke,
    A.tierwohl,
    A.posten_food,
    A.posten_nonfood,
    A.mwst,
    A.k_listung,
    A.ost_basis,
    A.ost_gross,
    A.sued_ost,
    A.sued_west,
    A.west,
    A.nord,
    A.anz_maerkte,
    A.gewichtete_distribution,
    A.index_af_id,
    A.umsatz_af_pro_markt_woche,
    A.absatz_af_pro_markt_woche,
    A.ertrag_af_pro_markt_woche,
    A.bonreichweite_af,
    A.spanne_af,
    A.index_sa_id,
    A.umsatz_sa_pro_markt_woche,
    A.absatz_sa_pro_markt_woche,
    A.ertrag_sa_pro_markt_woche,
    A.bonreichweite_sa,
    A.spanne_sa,
    A.aktionsanteil_absatz,
    A.absatz_total,
    A.schnelldreherquote,
    A.schnelldreherquote_wg,
    A.schnelldreherquote_owg,
    A.kolliabverkaufsquote,
    A.kolliabverkaufsquote_wg,
    A.kolliabverkaufsquote_owg,
    A.abschriftsanteil,
    A.abschriftsanteil_wg,
    A.abschriftsanteil_owg,
    A.cherrypicker_quote,
    A.cherrypicker_quote_wg,
    A.cherrypicker_quote_owg,
    A.restbon,
    A.restbon_wg,
    A.restbon_owg,
    A.vk_preis,
    A.durchschnittspreis,
    A.preislagenverteilung,
    A.marktanteilbewertung,
    A.anz_wo_mit_absatz,
    A.anz_wo_listung_1,
    A.kol_la_bzw,
    A.kol_bst_bzw,
    A.rlz_dz,
    A.rlz,
    A.lagerprozent,
    A.total_absatz_af_mt_wo,
    A.total_absatz_sa_mt_tag,
    A.total_af_absatz,
    A.total_sa_absatz,
    A.af_umsatz_netto,
    A.sa_umsatz_netto,
    A.absatz_sa_markt_tage,
    A.absatz_af_markt_wochen,
    A.abschr_o_werb,
    A.kassenumsatz
FROM `_sal_snap_2` AS A
INNER JOIN (
    SELECT art_matching_id
    FROM `_sal_snap_2`
    WHERE status_1 IN ('G', 'T')
    GROUP BY art_matching_id
    HAVING COUNT(*) > 1
) AS b
    ON A.art_matching_id = b.art_matching_id;


UPDATE `_sal_snap_2_multis` SET
    art_id = t8.art_id,
    wug_id = t8.wug_id,
    art_bez = t8.art_bez,
    art_status = t8.art_status,
    gp_id = t8.gp_id,
    akt_lieferant = t8.akt_lieferant,
    zek_1 = t8.zek_1,
    disc_pe = t8.disc_pe,
    disc_marke = t8.disc_marke,
    lcf = t8.lcf,
    vegan = t8.vegan,
    gluten = t8.gluten,
    bio = t8.bio,
    eigenmarke = t8.eigenmarke,
    tierwohl = t8.tierwohl,
    posten_food = t8.posten_food,
    posten_nonfood = t8.posten_nonfood,
    mwst = t8.mwst,
    k_listung = t8.k_listung,
    ost_basis = t8.ost_basis,
    ost_gross = t8.ost_gross,
    sued_ost = t8.sued_ost,
    sued_west = t8.sued_west,
    west = t8.west,
    nord = t8.nord,
    anz_maerkte = t8.anz_maerkte FROM (
    SELECT
        Y.art_matching_id,
        Y.status_1,
        Y.umrech_faktor,
        Y.kl_wg_id,
        Y.kl_owg_id,
        Y.kl_uwg_id,
        Y.rang_umsatz_wg,
        Y.rang_umsatz_uwg,
        Y.rang_absatz_uwg,
        Y.art_id,
        Y.kl_art_id,
        Y.wug_id,
        Y.art_bez,
        Y.art_status,
        Y.gp_id,
        Y.akt_lieferant,
        Y.zek_1,
        Y.disc_pe,
        Y.disc_marke,
        Y.lcf,
        Y.vegan,
        Y.gluten,
        Y.bio,
        Y.eigenmarke,
        Y.tierwohl,
        Y.posten_food,
        Y.posten_nonfood,
        Y.mwst,
        Y.k_listung,
        Y.ost_basis,
        Y.ost_gross,
        Y.sued_ost,
        Y.sued_west,
        Y.west,
        Y.nord,
        Y.anz_maerkte,
        Y.gewichtete_distribution,
        Y.index_af_id,
        Y.umsatz_af_pro_markt_woche,
        Y.absatz_af_pro_markt_woche,
        Y.ertrag_af_pro_markt_woche,
        Y.bonreichweite_af,
        Y.spanne_af,
        Y.index_sa_id,
        Y.umsatz_sa_pro_markt_woche,
        Y.absatz_sa_pro_markt_woche,
        Y.ertrag_sa_pro_markt_woche,
        Y.bonreichweite_sa,
        Y.spanne_sa,
        Y.aktionsanteil_absatz,
        Y.absatz_total,
        Y.schnelldreherquote,
        Y.schnelldreherquote_wg,
        Y.schnelldreherquote_owg,
        Y.kolliabverkaufsquote,
        Y.kolliabverkaufsquote_wg,
        Y.kolliabverkaufsquote_owg,
        Y.abschriftsanteil,
        Y.abschriftsanteil_wg,
        Y.abschriftsanteil_owg,
        Y.cherrypicker_quote,
        Y.cherrypicker_quote_wg,
        Y.cherrypicker_quote_owg,
        Y.restbon,
        Y.restbon_wg,
        Y.restbon_owg,
        Y.vk_preis,
        Y.durchschnittspreis,
        Y.preislagenverteilung,
        Y.marktanteilbewertung,
        Y.anz_wo_mit_absatz,
        Y.anz_wo_listung_1,
        Y.kol_la_bzw,
        Y.kol_bst_bzw,
        Y.rlz_dz,
        Y.rlz,
        Y.lagerprozent,
        Y.total_absatz_af_mt_wo,
        Y.total_absatz_sa_mt_tag,
        Y.total_af_absatz,
        Y.total_sa_absatz,
        Y.af_umsatz_netto,
        Y.sa_umsatz_netto,
        Y.absatz_sa_markt_tage,
        Y.absatz_af_markt_wochen,
        Y.abschr_o_werb,
        Y.kassenumsatz
    FROM `_sal_snap_2_multis` AS Y
    INNER JOIN (
        SELECT
            X.art_matching_id,
            X.kl_art_id
        FROM `_sal_snap_2_multis` AS X
        INNER JOIN (SELECT
            art_id,
            MAX(dat_von) AS dat_von
        FROM dbp_data.art_wup_zu_per_1
        WHERE
            mandant_id = 1
            AND listung_id = 1
        GROUP BY art_id) AS y ON X.kl_art_id = CAST(FLOOR(y.art_id / 100) AS INTEGER)
        GROUP BY
            X.art_matching_id,
            X.kl_art_id,
            y.art_id,
            Y.dat_von
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY
            X.art_matching_id ORDER BY X.art_matching_id IS NULL DESC, X.art_matching_id
        DESC, dat_von IS NULL DESC, dat_von DESC, X.kl_art_id IS NULL DESC, X.kl_art_id DESC)) = 1
    ) AS x1
        ON
            Y.art_matching_id
            = x1.art_matching_id AND Y.kl_art_id = x1.kl_art_id
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY
            Y.art_matching_id ORDER BY
            Y.art_matching_id IS NULL DESC, Y.art_matching_id
            DESC, Y.kl_art_id IS NULL DESC, Y.kl_art_id DESC
    )) = 1
) AS t8
WHERE `_sal_snap_2_multis`.art_matching_id = t8.art_matching_id;


INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_de_1
(
    SELECT
        A.mandant_id,
        C.kjwo,
        B.wg_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.bewart_id,
        CAST(A.menge * d.umrech_faktor AS NUMERIC),
        A.umsatz_netto,
        A.ek_mep
    FROM dbp_data.artbew_wo_sum_1 AS A
    INNER JOIN dbp_data.woche_kj_kl_1 AS C ON A.kjwo_kl = C.kjwo_kl
    INNER JOIN dbp_data.art_wg_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MAX(status_1) AS status_1,
            MAX(umrech_faktor) AS umrech_faktor
        FROM dbp_etl.art_matching_nielsen_per_1
        WHERE
            mandant_id = 1
            AND art_id <> -1
        GROUP BY
            mandant_id,
            art_id
    ) AS d ON A.art_id = d.art_id AND A.mandant_id = d.mandant_id
    WHERE
        C.kjwo IN (
            SELECT kjwo
            FROM dbp_data.art_nielsen_fakten_kjwo_1
            WHERE mandant_id = 1
            GROUP BY kjwo
            QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
        )
        AND d.status_1 IN ('T', 'G')
        AND A.mandant_id = 1
);


INSERT INTO dbp_etl.bf_listung_markt_kw_1 (
    mandant_id, wg_id, art_id, wup_id, nb_id, kreistyp_gruppe_id,
    kjwo, absatz, absatz_sa, absatz_af, umsatz, umsatz_sa, umsatz_af, ertrag, ertrag_sa, ertrag_af,
    anzahl_wochen_mit_absatz, anzahl_wochen_mit_absatz_sa, anzahl_wochen_mit_absatz_af
)
(
    SELECT
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.kjwo,
        IFNULL(SUM(V01.menge), 0) AS absatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_af,
        IFNULL(SUM(V01.umsatz_netto), 0) AS umsatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_af,
        IFNULL(SUM(V01.umsatz_netto - V01.ek_mep), 0) AS ertrag,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_af,
        IFNULL(CASE
            WHEN IFNULL(SUM(V01.menge), 0) > 0
                THEN COUNT(DISTINCT V01.kjwo)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz,
        IFNULL(CASE
            WHEN
                IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.menge
                    ELSE NULL
                END), 0) > 0 AND IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.menge
                    ELSE NULL
                END), 0) IS NOT NULL
                THEN COUNT(DISTINCT CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.kjwo
                    ELSE NULL
                END)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz_sa,
        IFNULL(CASE
            WHEN
                IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.menge
                    ELSE NULL
                END), 0) > 0 AND IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.menge
                    ELSE NULL
                END), 0) IS NOT NULL
                THEN COUNT(DISTINCT CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.kjwo
                    ELSE NULL
                END)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz_af
    FROM dbp_etl.bf_artbew_wg_art_wo_sum_de_1 AS V01
    INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id

    INNER JOIN dbp_data.wup_1 AS V04
        ON
            V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
            = V04.mandant_id
    WHERE
        V01.mandant_id = 1
        AND V03.arthiertyp_id = 2
        AND V03.dat_bis = PARSE_DATE('%F', '9999-12-31')
    GROUP BY
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.kjwo
);


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen AS
SELECT
    A.kjwo,
    b.art_matching_id,
    A.wup_id,
    IFNULL(SUM(A.absatz), 0) AS absatz_,
    IFNULL(SUM(A.absatz_af), 0) AS absatz_af_,
    IFNULL(SUM(A.absatz_sa), 0) AS absatz_sa_,
    IFNULL(SUM(A.umsatz), 0) AS umsatz_,
    IFNULL(SUM(A.umsatz_af), 0) AS umsatz_af_,
    IFNULL(SUM(A.umsatz_sa), 0) AS umsatz_sa_,
    IFNULL(SUM(A.ertrag), 0) AS ertrag_,
    IFNULL(SUM(A.ertrag_af), 0) AS ertrag_af_,
    IFNULL(SUM(A.ertrag_sa), 0) AS ertrag_sa_,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.absatz), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.absatz_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.absatz_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_sa,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_sa,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.ertrag), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_ertrag,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.ertrag_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_ertrag_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.ertrag_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_ertrag_sa
FROM dbp_etl.bf_listung_markt_kw_1 AS A
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        status_1
    FROM dbp_etl.art_matching_nielsen_per_1
    GROUP BY
        art_matching_id,
        art_id,
        status_1
) AS b ON A.art_id = b.art_id
WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND b.status_1 IN ('T', 'G')
GROUP BY
    A.kjwo,
    b.art_matching_id,
    A.wup_id;


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
GROUP BY art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _woche AS
SELECT kjwo
FROM dbp_data.art_nielsen_fakten_kjwo_1
WHERE mandant_id = 1
GROUP BY kjwo
QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre (
    kjwo INTEGER,
    matching_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT64
);


INSERT INTO zzsp07_pre
(
    SELECT
        A11.kjwo,
        b.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(CASE
            WHEN SUM(A11.absatz) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz
    FROM dbp_etl.bf_listung_markt_kw_1 AS A11
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id,
            MAX(status_1) AS status_1
        FROM dbp_etl.art_matching_nielsen_per_1
        WHERE
            mandant_id = 1
            AND art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS b
        ON
            A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id AND b.status_1 IN ('G', 'T'
            )
    WHERE
        A11.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE wg_filter_id = 11
        )
        AND A11.kjwo BETWEEN (
            SELECT MIN(kjwo)
            FROM `_woche`) AND (
            SELECT MAX(kjwo)
            FROM `_woche`
        )
        AND A11.mandant_id = 1
    GROUP BY
        A11.kjwo,
        matching_id,
        A11.mandant_id,
        A11.wup_id
);


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre (
    kjwo INTEGER,
    matching_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_listung_1 FLOAT64
);


INSERT INTO zzsp08_pre
(
    SELECT
        A11.kjwo,
        b.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(COUNT(DISTINCT A11.kjwo) AS FLOAT64) AS anz_wo_listung_1
    FROM dbp_data.art_wup_listung_kjwo_1 AS A11
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id,
            MAX(status_1) AS status_1
        FROM dbp_etl.art_matching_nielsen_per_1
        WHERE
            mandant_id = 1
            AND art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS b
        ON
            A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id AND b.status_1 IN ('G', 'T'
            )
    WHERE
        A11.mandant_id = 1
        AND A11.kjwo BETWEEN (
            SELECT MIN(kjwo)
            FROM `_woche`) AND (
            SELECT MAX(kjwo)
            FROM `_woche`
        )
    GROUP BY
        A11.kjwo,
        matching_id,
        A11.mandant_id,
        A11.wup_id
);


CREATE OR REPLACE TEMPORARY TABLE _mm AS
SELECT
    A.kjwo,
    A.matching_id,
    A.mandant_id,
    A.wup_id,
    A.anz_wo_listung_1,
    B.anz_wo_mit_absatz
FROM zzsp08_pre AS A
INNER JOIN zzsp07_pre
    AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.matching_id AND A.wup_id = B.wup_id AND
A.kjwo = B.kjwo;


INSERT INTO `_mm`
(SELECT
    kjwo,
    matching_id,
    mandant_id,
    wup_id,
    anz_wo_listung_1,
    0
FROM zzsp08_pre
WHERE (
    kjwo, matching_id, mandant_id, wup_id) NOT IN (
    SELECT (kjwo, matching_id, mandant_id, wup_id)
    FROM `_mm`
));


CREATE OR REPLACE TEMPORARY TABLE zzsp07 (
    matching_id INTEGER,
    mandant_id INTEGER,
    anz_wo_mit_absatz FLOAT64
);


INSERT INTO zzsp07
(
    SELECT
        matching_id,
        mandant_id,
        SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz
    FROM `_mm` AS A11
    WHERE anz_wo_mit_absatz <> 0
    GROUP BY
        matching_id,
        mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE zzsp08 (
    matching_id INTEGER,
    mandant_id INTEGER,
    anz_wo_listung_1 FLOAT64
);


INSERT INTO zzsp08
(
    SELECT
        matching_id,
        mandant_id,
        SUM(anz_wo_listung_1) AS anz_wo_listung_1
    FROM `_mm` AS A11
    GROUP BY
        matching_id,
        mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE zzoj09 (
    matching_id INTEGER,
    mandant_id INTEGER
);


INSERT INTO zzoj09
(SELECT
    matching_id,
    mandant_id
FROM (
    SELECT
        matching_id,
        mandant_id
    FROM zzsp07 AS PA11
    GROUP BY
        matching_id,
        mandant_id
    UNION DISTINCT
    SELECT
        matching_id,
        mandant_id
    FROM zzsp08 AS PA11
    GROUP BY
        matching_id,
        mandant_id
) AS t3);


CREATE OR REPLACE TEMPORARY TABLE zzmd0a_xxx (
    matching_id INTEGER,
    mandant_id INTEGER,
    wjxbfs1 FLOAT64,
    anz_wo_listung_1 FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    schnelldreherquote FLOAT64
);


INSERT INTO zzmd0a_xxx
(
    SELECT
        PA11.matching_id,
        PA11.mandant_id,
        1.0 AS wjxbfs1,
        PA13.anz_wo_listung_1,
        PA12.anz_wo_mit_absatz,
        ROUND(PA12.anz_wo_mit_absatz / IF(PA13.anz_wo_listung_1 = 0, NULL, PA13.anz_wo_listung_1) * 100, 1) AS schnelldreherquote
    FROM zzoj09 AS PA11
    LEFT JOIN zzsp07 AS PA12 ON PA11.matching_id = PA12.matching_id AND PA11.mandant_id = PA12.mandant_id
    LEFT JOIN zzsp08 AS PA13 ON PA11.matching_id = PA13.matching_id AND PA11.mandant_id = PA13.mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_2_multis1
AS
SELECT
    X.ART_MATCHING_ID,
    X.STATUS_1,
    max(X.UMRECH_FAKTOR) AS UMRECH_FAKTOR,
    max(X.KL_WG_ID) AS KL_WG_ID,
    max(X.KL_OWG_ID) AS KL_OWG_ID,
    max(X.KL_UWG_ID) AS KL_UWG_ID,
    max(X.RANG_UMSATZ_WG) AS RANG_UMSATZ_WG,
    max(X.RANG_UMSATZ_UWG) AS RANG_UMSATZ_UWG,
    max(X.RANG_ABSATZ_UWG) AS RANG_ABSATZ_UWG,
    max(X.ART_ID) AS ART_ID,
    substr(replace(trim(string_agg(lpad(substr(CAST(round(CAST(lpad(CAST(X.KL_ART_ID as STRING), 8, '0') as BIGNUMERIC), 0) as STRING), 1, 8), 8, '0'), ',' ORDER BY if(X.KL_ART_ID IS NULL, 0, 1) DESC, X.KL_ART_ID), ','), ' ', ''), 1, 300) AS KL_ART_ID,
    max(X.WUG_ID) AS WUG_ID,
    max(X.ART_BEZ) AS ART_BEZ,
    max(X.ART_STATUS) AS ART_STATUS,
    max(X.GP_ID) AS GP_ID,
    max(X.AKT_LIEFERANT) AS AKT_LIEFERANT,
    max(X.ZEK_1) AS ZEK_1,
    max(X.DISC_PE) AS DISC_PE,
    max(X.DISC_MARKE) AS DISC_MARKE,
    max(X.LCF) AS LCF,
    max(X.VEGAN) AS VEGAN,
    max(X.GLUTEN) AS GLUTEN,
    max(X.BIO) AS BIO,
    max(X.EIGENMARKE) AS EIGENMARKE,
    max(X.TIERWOHL) AS TIERWOHL,
    max(X.POSTEN_FOOD) AS POSTEN_FOOD,
    max(X.POSTEN_NONFOOD) AS POSTEN_NONFOOD,
    max(X.MWST) AS MWST,
    max(X.K_LISTUNG) AS K_LISTUNG,
    max(X.OST_BASIS) AS OST_BASIS,
    max(X.OST_GROSS) AS OST_GROSS,
    max(X.SUED_OST) AS SUED_OST,
    max(X.SUED_WEST) AS SUED_WEST,
    max(X.WEST) AS WEST,
    max(X.NORD) AS NORD,
    max(X.ANZ_MAERKTE) AS ANZ_MAERKTE,
    coalesce(sum(X.GEWICHTETE_DISTRIBUTION) / nullif(count(*), 0), 0) AS GEWICHTETE_DISTRIBUTION,
    /* Index AF */
    max(X.INDEX_AF_ID) AS INDEX_AF_ID,
    coalesce(max(Y.UMSATZ_AF) / nullif(max(Y.ANZAHL_WOCHEN_MIT_UMSATZ_AF), 0), 0) AS UMSATZ_AF_PRO_MARKT_WOCHE_,
    coalesce(max(Y.ABSATZ_AF) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ABSATZ_AF), 0), 0) AS ABSATZ_AF_PRO_MARKT_WOCHE_,
    coalesce(max(Y.ERTRAG_AF) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ERTRAG_AF), 0), 0) AS ERTRAG_AF_PRO_MARKT_WOCHE_,
    sum(X.BONREICHWEITE_AF) AS BONREICHWEITE_AF,
    coalesce(coalesce(max(Y.ERTRAG_AF) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ERTRAG_AF), 0), 0) / nullif(coalesce(max(Y.UMSATZ_AF) / nullif(max(Y.ANZAHL_WOCHEN_MIT_UMSATZ_AF), 0), 0), 0), 0) AS SPANNE_AF,
    /* Index SA */
    max(X.INDEX_SA_ID) AS INDEX_SA_ID,
    coalesce(max(Y.UMSATZ_SA) / nullif(max(Y.ANZAHL_WOCHEN_MIT_UMSATZ_SA), 0), 0) AS UMSATZ_SA_PRO_MARKT_WOCHE_,
    coalesce(max(Y.ABSATZ_SA) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ABSATZ_SA), 0), 0) AS ABSATZ_SA_PRO_MARKT_WOCHE_,
    coalesce(max(Y.ERTRAG_SA) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ERTRAG_SA), 0), 0) AS ERTRAG_SA_PRO_MARKT_WOCHE_,
    sum(X.BONREICHWEITE_SA) AS BONREICHWEITE_SA,
    coalesce(coalesce(max(Y.ERTRAG_SA) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ERTRAG_SA), 0), 0) / nullif(coalesce(max(Y.UMSATZ_SA) / nullif(max(Y.ANZAHL_WOCHEN_MIT_UMSATZ_SA), 0), 0), 0), 0) AS SPANNE_SA,
    /* Kennzahlen */
    coalesce(sum(TOTAL_SA_ABSATZ) / nullif(sum(X.ABSATZ_TOTAL), 0), 0) AS AKTIONSANTEIL_ABSATZ,
    sum(X.ABSATZ_TOTAL) AS ABSATZ_TOTAL,
    /* Bon */
    coalesce(sum(CAST(/* expression of unknown or erroneous type */ X.ANZ_WO_MIT_ABSATZ as FLOAT64)) / nullif(sum(CAST(/* expression of unknown or erroneous type */ X.ANZ_WO_LISTUNG_1 as FLOAT64)), 0.0), 0.0) AS SCHNELLDREHERQUOTE,
    sum(SCHNELLDREHERQUOTE_WG) AS SCHNELLDREHERQUOTE_WG,
    sum(SCHNELLDREHERQUOTE_OWG) AS SCHNELLDREHERQUOTE_OWG,
    CASE
        WHEN max(KOL_LA_BZW) IS NOT NULL
            THEN coalesce(max(RLZ) / count(*) * max(LAGERPROZENT) * coalesce(sum(TOTAL_AF_ABSATZ) / sum(ABSATZ_AF_MARKT_WOCHEN) / 6, sum(TOTAL_SA_ABSATZ) / sum(ABSATZ_SA_MARKT_TAGE)) / nullif(CASE
                WHEN max(X.UMRECH_FAKTOR) = 1 THEN max(KOL_LA_BZW)
                ELSE 1
            END, 0), 0)
        ELSE coalesce(max(RLZ_DZ) / count(*) * coalesce(sum(TOTAL_AF_ABSATZ) / sum(ABSATZ_AF_MARKT_WOCHEN) / 6, sum(TOTAL_SA_ABSATZ) / sum(ABSATZ_SA_MARKT_TAGE)) / nullif(CASE
            WHEN max(X.UMRECH_FAKTOR) = 1 THEN max(KOL_BST_BZW)
            ELSE 1
        END, 0), 0)
    END AS KOLLIABVERKAUFSQUOTE,
    sum(KOLLIABVERKAUFSQUOTE_WG) AS KOLLIABVERKAUFSQUOTE_WG,
    sum(KOLLIABVERKAUFSQUOTE_OWG) AS KOLLIABVERKAUFSQUOTE_OWG,
    coalesce(sum(CAST(ABSCHR_O_WERB as FLOAT64)) / nullif(sum(CAST(KASSENUMSATZ as FLOAT64)), 0.0), 0.0) AS ABSCHRIFTSANTEIL,
    sum(ABSCHRIFTSANTEIL_WG) AS ABSCHRIFTSANTEIL_WG,
    sum(ABSCHRIFTSANTEIL_OWG) AS ABSCHRIFTSANTEIL_OWG,
    sum(CHERRYPICKER_QUOTE) / count(*) AS CHERRYPICKER_QUOTE,
    sum(CHERRYPICKER_QUOTE_WG) AS CHERRYPICKER_QUOTE_WG,
    sum(CHERRYPICKER_QUOTE_OWG) AS CHERRYPICKER_QUOTE_OWG,
    sum(RESTBON) AS RESTBON,
    sum(RESTBON_WG) AS RESTBON_WG,
    sum(RESTBON_OWG) AS RESTBON_OWG,
    /* Bewertung */
    max(VK_PREIS) /*-> muessen wir aendern!*/ AS VK_PREIS,
    CASE
        WHEN sum(AF_UMSATZ_NETTO) <> 0 THEN coalesce((sum(AF_UMSATZ_NETTO) * ((100 + max(X.MWST)) / 100)) / nullif(sum(TOTAL_AF_ABSATZ), 0), 0)
        ELSE coalesce((sum(SA_UMSATZ_NETTO) * ((100 + max(X.MWST)) / 100)) / nullif(sum(TOTAL_SA_ABSATZ), 0), 0)
    END AS DURCHSCHNITTSPREIS,
    ----> brutto!
    sum(PREISLAGENVERTEILUNG) AS PREISLAGENVERTEILUNG,
    sum(MARKTANTEILBEWERTUNG) AS MARKTANTEILBEWERTUNG,
    /* Berechnung */
    sum(ANZ_WO_MIT_ABSATZ) AS ANZ_WO_MIT_ABSATZ,
    sum(ANZ_WO_LISTUNG_1) AS ANZ_WO_LISTUNG_1,
    max(KOL_LA_BZW) AS KOL_LA_BZW,
    max(KOL_BST_BZW) AS KOL_BST_BZW,
    max(RLZ_DZ) AS RLZ_DZ,
    max(RLZ) AS RLZ,
    max(LAGERPROZENT) AS LAGERPROZENT,
    sum(TOTAL_ABSATZ_AF_MT_WO) AS TOTAL_ABSATZ_AF_MT_WO,
    sum(TOTAL_ABSATZ_SA_MT_TAG) AS TOTAL_ABSATZ_SA_MT_TAG,
    sum(TOTAL_AF_ABSATZ) AS TOTAL_AF_ABSATZ,
    sum(TOTAL_SA_ABSATZ) AS TOTAL_SA_ABSATZ,
    sum(AF_UMSATZ_NETTO) AS AF_UMSATZ_NETTO,
    sum(SA_UMSATZ_NETTO) AS SA_UMSATZ_NETTO,
    sum(ABSATZ_SA_MARKT_TAGE) AS ABSATZ_SA_MARKT_TAGE,
    sum(ABSATZ_AF_MARKT_WOCHEN) AS ABSATZ_AF_MARKT_WOCHEN,
    sum(ABSCHR_O_WERB) AS ABSCHR_O_WERB,
    sum(KASSENUMSATZ) AS KASSENUMSATZ
FROM
    _sal_snap_2_multis AS X
LEFT OUTER JOIN _step1 AS Z
    ON
        1 = Z.MANDANT_ID
        AND X.ART_ID = Z.ART_ID
LEFT OUTER JOIN _anz_wochen1 AS Y ON X.ART_MATCHING_ID = Y.ART_MATCHING_ID
WHERE
    X.ART_MATCHING_ID NOT IN (
        SELECT X.ART_MATCHING_ID
        FROM
            dbp_etl.art_matching_nielsen_per_1
        WHERE GTIN_ID IN (
            -9998, -9999
        )
    )
GROUP BY 1, 2;


UPDATE _sal_snap_2_multis1 SET SCHNELLDREHERQUOTE = B.SDQ / 100 FROM (
    SELECT
        ZZMD0A_XXX.SCHNELLDREHERQUOTE AS SDQ,
        ZZMD0A_XXX.MATCHING_ID
    FROM
        zzmd0a_xxx
) AS B
WHERE _sal_snap_2_multis1.ART_MATCHING_ID = B.MATCHING_ID;


DELETE FROM _sal_snap_2
WHERE _SAL_SNAP_2.ART_MATCHING_ID IN (
    SELECT ART_MATCHING_ID
    FROM
        _sal_snap_2_multis1
);


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_final AS
SELECT
    1 AS mandant_id,
    D.kjmo_sort AS kjmo,
    `_sal_snap_2`.art_matching_id,
    ' ' AS status_1,
    `_sal_snap_2`.umrech_faktor,
    `_sal_snap_2`.kl_wg_id,
    `_sal_snap_2`.kl_owg_id,
    `_sal_snap_2`.kl_uwg_id,
    `_sal_snap_2`.rang_umsatz_wg,
    `_sal_snap_2`.rang_umsatz_uwg,
    `_sal_snap_2`.rang_absatz_uwg,
    `_sal_snap_2`.art_id,
    CAST(SUBSTR(SUBSTR(CAST(`_sal_snap_2`.kl_art_id AS STRING), 1, 11), 1, 300) AS STRING) AS kl_art_id,
    `_sal_snap_2`.wug_id,
    `_sal_snap_2`.art_bez,
    `_sal_snap_2`.art_status,
    `_sal_snap_2`.gp_id,
    `_sal_snap_2`.akt_lieferant,
    `_sal_snap_2`.zek_1 AS zek_id,
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
    CAST(`_sal_snap_2`.gewichtete_distribution AS INT64) AS gewichtete_distribution,
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
    `_sal_snap_2`.marktanteilbewertung /* zur Berechnung */,
    `_sal_snap_2`.anz_wo_mit_absatz,
    `_sal_snap_2`.anz_wo_listung_1,
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
    FROM dbp_data.art_nielsen_fakten_kjwo_1
    WHERE mandant_id = 1
) AS c
    ON TRUE
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS D ON c.max_kjwo = D.kjwo_bis;


INSERT INTO _sal_snap_final
SELECT
    1 AS MANDANT_ID,
    D.KJMO_SORT AS KJMO,
    A.ART_MATCHING_ID,
    A.STATUS_1,
    A.UMRECH_FAKTOR,
    A.KL_WG_ID,
    A.KL_OWG_ID,
    A.KL_UWG_ID,
    A.RANG_UMSATZ_WG,
    A.RANG_UMSATZ_UWG,
    A.RANG_ABSATZ_UWG,
    A.ART_ID,
    A.KL_ART_ID,
    A.WUG_ID,
    A.ART_BEZ,
    A.ART_STATUS,
    A.GP_ID,
    A.AKT_LIEFERANT,
    A.ZEK_1,
    A.DISC_PE,
    A.DISC_MARKE,
    A.LCF,
    A.VEGAN,
    A.GLUTEN,
    A.BIO,
    A.EIGENMARKE,
    A.TIERWOHL,
    A.POSTEN_FOOD,
    A.POSTEN_NONFOOD,
    A.MWST,
    A.K_LISTUNG,
    A.OST_BASIS,
    A.OST_GROSS,
    A.SUED_OST,
    A.SUED_WEST,
    A.WEST,
    A.NORD,
    A.ANZ_MAERKTE,
    CAST(A.GEWICHTETE_DISTRIBUTION AS INT64),
    A.INDEX_AF_ID,
    A.UMSATZ_AF_PRO_MARKT_WOCHE_,
    A.ABSATZ_AF_PRO_MARKT_WOCHE_,
    A.ERTRAG_AF_PRO_MARKT_WOCHE_,
    A.BONREICHWEITE_AF,
    A.SPANNE_AF,
    A.INDEX_SA_ID,
    A.UMSATZ_SA_PRO_MARKT_WOCHE_,
    A.ABSATZ_SA_PRO_MARKT_WOCHE_,
    A.ERTRAG_SA_PRO_MARKT_WOCHE_,
    A.BONREICHWEITE_SA,
    A.SPANNE_SA,
    A.AKTIONSANTEIL_ABSATZ,
    A.ABSATZ_TOTAL,
    A.SCHNELLDREHERQUOTE,
    A.SCHNELLDREHERQUOTE_WG,
    A.SCHNELLDREHERQUOTE_OWG,
    A.KOLLIABVERKAUFSQUOTE,
    A.KOLLIABVERKAUFSQUOTE_WG,
    A.KOLLIABVERKAUFSQUOTE_OWG,
    A.ABSCHRIFTSANTEIL,
    A.ABSCHRIFTSANTEIL_WG,
    A.ABSCHRIFTSANTEIL_OWG,
    CAST(A.CHERRYPICKER_QUOTE AS INT64),
    A.CHERRYPICKER_QUOTE_WG,
    A.CHERRYPICKER_QUOTE_OWG,
    A.RESTBON,
    A.RESTBON_WG,
    A.RESTBON_OWG,
    A.VK_PREIS,
    A.DURCHSCHNITTSPREIS,
    A.PREISLAGENVERTEILUNG,
    A.MARKTANTEILBEWERTUNG,
    A.ANZ_WO_MIT_ABSATZ,
    A.ANZ_WO_LISTUNG_1,
    A.KOL_LA_BZW,
    A.KOL_BST_BZW,
    A.RLZ_DZ,
    A.RLZ,
    A.LAGERPROZENT,
    A.TOTAL_ABSATZ_AF_MT_WO,
    A.TOTAL_ABSATZ_SA_MT_TAG,
    A.TOTAL_AF_ABSATZ,
    A.TOTAL_SA_ABSATZ,
    A.AF_UMSATZ_NETTO,
    A.SA_UMSATZ_NETTO,
    A.ABSATZ_SA_MARKT_TAGE,
    A.ABSATZ_AF_MARKT_WOCHEN,
    A.ABSCHR_O_WERB,
    A.KASSENUMSATZ
FROM
    _sal_snap_2_multis1 AS A
INNER JOIN (
    SELECT max(ART_NIELSEN_FAKTEN_KJWO.KJWO) AS MAX_KJWO
    FROM
        dbp_data.art_nielsen_fakten_kjwo_1
    WHERE ART_NIELSEN_FAKTEN_KJWO.MANDANT_ID = 1
) AS C ON 1 = 1
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS D ON C.MAX_KJWO = D.KJWO_BIS;


DELETE FROM `_sal_snap_final`
WHERE art_id IN (
    SELECT art_id
    FROM `_sal_snap_final`
    GROUP BY art_id
    HAVING COUNT(*) > 1) AND (art_id, art_matching_id) NOT IN (
    SELECT (art_id, MIN(art_matching_id))
    FROM `_sal_snap_final`
    GROUP BY art_id
    HAVING COUNT(*) > 1
);


DELETE FROM `_sal_snap_final`
WHERE art_id IN (
    SELECT art_id
    FROM `_sal_snap_final`
    GROUP BY art_id
    HAVING COUNT(*) > 1
) AND umsatz_af_pro_markt_woche = 0;


UPDATE `_sal_snap_final` SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id FROM (SELECT
    art_id,
    MAX(kl_wg_id) AS kl_wg_id,
    MAX(kl_owg_id) AS kl_owg_id,
    MAX(kl_uwg_id) AS kl_uwg_id
FROM `_art_leistung_1`
GROUP BY art_id) AS b
WHERE `_sal_snap_final`.art_id = b.art_id;


UPDATE `_sal_snap_final` SET
    rang_umsatz_wg = b.rang_umsatz_wg,
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg,
    gewichtete_distribution = CAST(ROUND(b.distr_gew) AS INT64)
FROM (SELECT
    art_matching_id,
    MIN(rang_umsatz_wg) AS rang_umsatz_wg,
    MIN(rang_umsatz_uwg) AS rang_umsatz_uwg,
    MIN(rang_absatz_uwg) AS rang_absatz_uwg,
    SUM(distr_gew) / COUNT(*) AS distr_gew
FROM `_artikel_anteil_uwg_leistung_base1`
GROUP BY art_matching_id) AS b
WHERE `_sal_snap_final`.art_matching_id = b.art_matching_id;


UPDATE `_sal_snap_final` SET
    rang_umsatz_wg = b.next_rang_ums_wg,
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg FROM (SELECT
    kl_owg_id,
    MAX(rang_umsatz_wg) AS next_rang_ums_wg,
    MAX(rang_umsatz_uwg) AS next_rang_ums_uwg,
    MAX(rang_absatz_uwg) AS next_rang_abs_uwg
FROM `_artikel_anteil_uwg_ranking`
GROUP BY kl_owg_id) AS b
WHERE
    `_sal_snap_final`.kl_owg_id = b.kl_owg_id AND `_sal_snap_final`.rang_umsatz_wg IS NULL AND `_sal_snap_final`.rang_umsatz_uwg
    IS NULL AND `_sal_snap_final`.rang_absatz_uwg IS NULL;


UPDATE `_sal_snap_final` SET
    rang_umsatz_wg = b.next_rang_ums_wg FROM (SELECT
    kl_wg_id,
    MAX(rang_umsatz_wg) + 1 AS next_rang_ums_wg
FROM `_artikel_anteil_uwg_ranking`
GROUP BY kl_wg_id) AS b
WHERE `_sal_snap_final`.kl_wg_id = b.kl_wg_id AND `_sal_snap_final`.rang_umsatz_wg IS NULL;


UPDATE `_sal_snap_final` SET
    rang_umsatz_uwg = CAST(b.next_rang_ums_uwg AS INT64),
    rang_absatz_uwg = CAST(b.next_rang_abs_uwg AS INT64) FROM (SELECT
    kl_owg_id,
    COALESCE(CAST(MAX(rang_umsatz_uwg) AS BIGNUMERIC), 0) + 1 AS next_rang_ums_uwg,
    COALESCE(CAST(MAX(rang_absatz_uwg) AS BIGNUMERIC), 0) + 1 AS next_rang_abs_uwg
FROM `_sal_snap_final` AS A
GROUP BY kl_owg_id) AS b
WHERE
    `_sal_snap_final`.kl_owg_id = b.kl_owg_id AND `_sal_snap_final`.rang_umsatz_uwg IS NULL AND `_sal_snap_final`.rang_absatz_uwg
    IS NULL;


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    rang_umsatz_wg = CAST(b.next_rang_ums_wg AS INT64) FROM (SELECT
    kl_wg_id,
    MAX(COALESCE(CAST(rang_umsatz_wg AS BIGNUMERIC), 0)) + 1 AS next_rang_ums_wg
FROM `_sal_snap_final`
GROUP BY kl_wg_id) AS b
WHERE `_sal_snap_final0`.kl_wg_id = b.kl_wg_id AND `_sal_snap_final0`.rang_umsatz_wg IS NULL;


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    rang_umsatz_uwg = CAST(b.next_rang_ums_uwg AS INT64),
    rang_absatz_uwg = CAST(b.next_rang_abs_uwg AS INT64) FROM (SELECT
    kl_owg_id,
    MAX(COALESCE(CAST(rang_umsatz_uwg AS BIGNUMERIC), 0)) + 1 AS next_rang_ums_uwg,
    MAX(COALESCE(CAST(rang_absatz_uwg AS BIGNUMERIC), 0)) + 1 AS next_rang_abs_uwg
FROM `_sal_snap_final`
GROUP BY kl_owg_id) AS b
WHERE
    `_sal_snap_final0`.kl_owg_id = b.kl_owg_id AND `_sal_snap_final0`.rang_umsatz_uwg IS NULL AND `_sal_snap_final0`.rang_absatz_uwg
    IS NULL;


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    schnelldreherquote_wg = CAST(b.schnelldreherquote_wg AS INT64),
    kolliabverkaufsquote_wg = CAST(b.kolliabverkaufsquote_wg AS INT64),
    abschriftsanteil_wg = CAST(b.abschriftsanteil_wg AS INT64) FROM (SELECT
    kl_wg_id,
    SUM(
        CAST(anz_wo_mit_absatz AS FLOAT64)) / IF(
        SUM(CAST(anz_wo_listung_1 AS FLOAT64)) = 0, NULL, SUM(CAST(anz_wo_listung_1 AS FLOAT64)
        )
    ) AS schnelldreherquote_wg,
    CASE
        WHEN MAX(kol_la_bzw) IS NOT NULL
            THEN IFNULL(SUM(rlz) / COUNT(*) * MAX(lagerprozent) * COALESCE(SUM(
                total_af_absatz) / IF(SUM(absatz_af_markt_wochen
            ) = 0, NULL, SUM(absatz_af_markt_wochen)) / 6, SUM(total_sa_absatz) / IF(
                SUM(absatz_sa_markt_tage) = 0,
                NULL, SUM(absatz_sa_markt_tage)
            )) / IF(MAX(kol_la_bzw
            ) = 0, NULL, MAX(kol_la_bzw
            )), 0)
        ELSE IFNULL(SUM(rlz_dz) / COUNT(*) * COALESCE(SUM(
            total_af_absatz) / IF(
            SUM(absatz_af_markt_wochen) = 0, NULL, SUM(absatz_af_markt_wochen
            )
        ) / 6, SUM(total_sa_absatz
        ) / IF(SUM(absatz_sa_markt_tage) = 0, NULL, SUM(absatz_sa_markt_tage)
        )) / IF(MAX(kol_bst_bzw
        ) = 0, NULL, MAX(kol_bst_bzw)), 0)
    END AS kolliabverkaufsquote_wg,
    SUM(abschr_o_werb) / IF(SUM(kassenumsatz) = 0, NULL, SUM(kassenumsatz)) AS abschriftsanteil_wg
FROM `_sal_snap_final`
GROUP BY kl_wg_id) AS b
WHERE `_sal_snap_final0`.kl_wg_id = b.kl_wg_id;


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    schnelldreherquote_owg = CAST(b.schnelldreherquote_owg AS INT64),
    kolliabverkaufsquote_owg = CAST(b.kolliabverkaufsquote_owg AS INT64),
    abschriftsanteil_owg = CAST(b.abschriftsanteil_owg AS INT64) FROM (SELECT
    kl_owg_id,
    SUM(
        CAST(anz_wo_mit_absatz AS FLOAT64)) / IF(
        SUM(CAST(anz_wo_listung_1 AS FLOAT64)) = 0, NULL, SUM(CAST(anz_wo_listung_1 AS FLOAT64)
        )
    ) AS schnelldreherquote_owg,
    CASE
        WHEN MAX(kol_la_bzw) IS NOT NULL
            THEN IFNULL(SUM(rlz) / COUNT(*) * MAX(lagerprozent) * COALESCE(SUM(
                total_af_absatz) / IF(SUM(absatz_af_markt_wochen
            ) = 0, NULL, SUM(absatz_af_markt_wochen)) / 6, SUM(total_sa_absatz) / IF(
                SUM(absatz_sa_markt_tage) = 0,
                NULL, SUM(absatz_sa_markt_tage)
            )) / IF(MAX(kol_la_bzw
            ) = 0, NULL, MAX(kol_la_bzw
            )), 0)
        ELSE IFNULL(SUM(rlz_dz) / COUNT(*) * COALESCE(SUM(
            total_af_absatz) / IF(
            SUM(absatz_af_markt_wochen) = 0, NULL, SUM(absatz_af_markt_wochen
            )
        ) / 6, SUM(total_sa_absatz
        ) / IF(SUM(absatz_sa_markt_tage) = 0, NULL, SUM(absatz_sa_markt_tage)
        )) / IF(MAX(kol_bst_bzw
        ) = 0, NULL, MAX(kol_bst_bzw)), 0)
    END AS kolliabverkaufsquote_owg,
    SUM(abschr_o_werb) / IF(SUM(kassenumsatz) = 0, NULL, SUM(kassenumsatz)) AS abschriftsanteil_owg
FROM `_sal_snap_final`
GROUP BY kl_owg_id) AS b
WHERE `_sal_snap_final0`.kl_owg_id = b.kl_owg_id;


/* Index AF */ /* Index SA */ CREATE OR REPLACE TEMPORARY TABLE _index01 (
    mandant_id INTEGER,
    kjmo INTEGER,
    art_matching_id INTEGER,
    kl_wg_id INTEGER,
    kl_owg_id INTEGER,
    kl_uwg_id INTEGER,
    art_id INTEGER,
    umsatz_af_pro_markt_woche FLOAT64,
    absatz_af_pro_markt_woche FLOAT64,
    ertrag_af_pro_markt_woche FLOAT64,
    bonreichweite_af FLOAT64,
    umsatz_sa_pro_markt_woche FLOAT64,
    absatz_sa_pro_markt_woche FLOAT64,
    ertrag_sa_pro_markt_woche FLOAT64,
    bonreichweite_sa FLOAT64,
    index_af INTEGER,
    index_sa INTEGER
);


INSERT INTO `_index01`
(SELECT
    mandant_id,
    kjmo,
    art_matching_id,
    CAST(kl_wg_id AS INTEGER) AS kl_wg_id,
    CAST(kl_owg_id AS INTEGER) AS kl_owg_id,
    CAST(kl_uwg_id AS INTEGER) AS kl_uwg_id,
    art_id,
    /* Index AF */ umsatz_af_pro_markt_woche,
    absatz_af_pro_markt_woche,
    ertrag_af_pro_markt_woche,
    bonreichweite_af,
    CAST(/* Index SA */ umsatz_sa_pro_markt_woche AS FLOAT64) AS umsatz_sa_pro_markt_woche,
    CAST(absatz_sa_pro_markt_woche AS FLOAT64) AS absatz_sa_pro_markt_woche,
    CAST(ertrag_sa_pro_markt_woche AS FLOAT64) AS ertrag_sa_pro_markt_woche,
    bonreichweite_sa,
    0 AS index_af,
    0 AS index_sa
FROM `_sal_snap_final`
WHERE art_id IS NOT NULL);


/* Index AF */ /* Index SA */ CREATE OR REPLACE TEMPORARY TABLE _index02 AS
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
GROUP BY kl_wg_id;


CREATE OR REPLACE TEMPORARY TABLE _index03 AS
/* Index AF */ -- double_bonreichweite_af/anz_art_ AS varianz_bonreichweite_af,
-- 

-- SQRT(varianz_bonreichweite_af) AS std_bonreichweite_af,
/* Index SA */
-- double_bonreichweite_sa/anz_art_ AS varianz_bonreichweite_sa,
-- 
-- ,

-- SQRT(varianz_bonreichweite_sa) AS std_bonreichweite_sa
SELECT
    A.kl_wg_id,
    MAX(B.anz_art) AS anz_art_,
    -- 
    SUM(
        (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche) * (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche
        )
    ) AS double_umsatz_af,
    SUM(
        (A.absatz_af_pro_markt_woche - B.avg_absatz_af_pro_markt_woche) * (A.absatz_af_pro_markt_woche - B.avg_absatz_af_pro_markt_woche
        )
    ) AS double_absatz_af,
    SUM(
        (A.ertrag_af_pro_markt_woche - B.avg_ertrag_af_pro_markt_woche) * (A.ertrag_af_pro_markt_woche - B.avg_ertrag_af_pro_markt_woche
        )
    ) AS double_ertrag_af,
    SUM(
        (A.bonreichweite_af - B.avg_bonreichweite_af) * (A.bonreichweite_af - B.avg_bonreichweite_af)) AS
    double_bonreichweite_af,
    -- 
    SUM(
        (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche) * (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche
        )
    ) / MAX(B.anz_art
    ) AS varianz_umsatz_af,
    SUM(
        (A.absatz_af_pro_markt_woche - B.avg_absatz_af_pro_markt_woche) * (A.absatz_af_pro_markt_woche - B.avg_absatz_af_pro_markt_woche
        )
    ) / MAX(B.anz_art
    ) AS varianz_absatz_af,
    SUM(
        (A.ertrag_af_pro_markt_woche - B.avg_ertrag_af_pro_markt_woche) * (A.ertrag_af_pro_markt_woche - B.avg_ertrag_af_pro_markt_woche
        )
    ) / MAX(B.anz_art
    ) AS varianz_ertrag_af,
    SQRT(-- 
        SUM(
            (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche) * (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche
            )
        ) / MAX(B.anz_art
        )
    ) AS std_umsatz_af,
    SQRT(SUM(
        (A.absatz_af_pro_markt_woche - B.avg_absatz_af_pro_markt_woche) * (A.absatz_af_pro_markt_woche - B.avg_absatz_af_pro_markt_woche
        )
    ) / MAX(B.anz_art
    )) AS std_absatz_af,
    SQRT(SUM(
        (A.ertrag_af_pro_markt_woche - B.avg_ertrag_af_pro_markt_woche) * (A.ertrag_af_pro_markt_woche - B.avg_ertrag_af_pro_markt_woche
        )
    ) / MAX(B.anz_art
    )) AS std_ertrag_af,
    -- 
    SUM(
        (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche) * (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche
        )
    ) AS double_umsatz_sa,
    SUM(
        (A.absatz_sa_pro_markt_woche - B.avg_absatz_sa_pro_markt_woche) * (A.absatz_sa_pro_markt_woche - B.avg_absatz_sa_pro_markt_woche
        )
    ) AS double_absatz_sa,
    SUM(
        (A.ertrag_sa_pro_markt_woche - B.avg_ertrag_sa_pro_markt_woche) * (A.ertrag_sa_pro_markt_woche - B.avg_ertrag_sa_pro_markt_woche
        )
    ) AS double_ertrag_sa,
    SUM(
        (A.bonreichweite_sa - B.avg_bonreichweite_sa) * (A.bonreichweite_af - B.avg_bonreichweite_sa)) AS
    double_bonreichweite_sa,
    -- 
    SUM(
        (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche) * (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche
        )
    ) / MAX(B.anz_art
    ) AS varianz_umsatz_sa,
    SUM(
        (A.absatz_sa_pro_markt_woche - B.avg_absatz_sa_pro_markt_woche) * (A.absatz_sa_pro_markt_woche - B.avg_absatz_sa_pro_markt_woche
        )
    ) / MAX(B.anz_art
    ) AS varianz_absatz_sa,
    SUM(
        (A.ertrag_sa_pro_markt_woche - B.avg_ertrag_sa_pro_markt_woche) * (A.ertrag_sa_pro_markt_woche - B.avg_ertrag_sa_pro_markt_woche
        )
    ) / MAX(B.anz_art
    ) AS varianz_ertrag_sa,
    SQRT(-- 
        SUM(
            (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche) * (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche
            )
        ) / MAX(B.anz_art
        )
    ) AS std_umsatz_sa,
    SQRT(SUM(
        (A.absatz_sa_pro_markt_woche - B.avg_absatz_sa_pro_markt_woche) * (A.absatz_sa_pro_markt_woche - B.avg_absatz_sa_pro_markt_woche
        )
    ) / MAX(B.anz_art
    )) AS std_absatz_sa,
    SQRT(SUM(
        (A.ertrag_sa_pro_markt_woche - B.avg_ertrag_sa_pro_markt_woche) * (A.ertrag_sa_pro_markt_woche - B.avg_ertrag_sa_pro_markt_woche
        )
    ) / MAX(B.anz_art
    )) AS std_ertrag_sa
FROM `_index01` AS A
INNER JOIN `_index02` AS B ON A.kl_wg_id = B.kl_wg_id
GROUP BY A.kl_wg_id;


CREATE OR REPLACE TEMPORARY TABLE _index04 AS
/* Index AF */
-- (a.bonreichweite_af-b.avg_bonreichweite_af)/c.std_bonreichweite_af AS standardisierung_bonreichweite_af,

/* Index SA */ SELECT
    A.mandant_id,
    A.kjmo,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    A.art_id,
    A.umsatz_af_pro_markt_woche,
    A.absatz_af_pro_markt_woche,
    A.ertrag_af_pro_markt_woche,
    A.bonreichweite_af,
    A.umsatz_sa_pro_markt_woche,
    A.absatz_sa_pro_markt_woche,
    A.ertrag_sa_pro_markt_woche,
    A.bonreichweite_sa,
    A.index_af,
    A.index_sa,
    IFNULL(
        (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche) / IF(C.std_umsatz_af = 0, NULL, C.std_umsatz_af
        ), 0
    ) AS standardisierung_umsatz_af,
    IFNULL(
        (A.absatz_af_pro_markt_woche - B.avg_absatz_af_pro_markt_woche) / IF(C.std_absatz_af = 0, NULL, C.std_absatz_af
        ), 0
    ) AS standardisierung_absatz_af,
    IFNULL(
        (A.ertrag_af_pro_markt_woche - B.avg_ertrag_af_pro_markt_woche) / IF(C.std_ertrag_af = 0, NULL, C.std_ertrag_af
        ), 0
    ) AS standardisierung_ertrag_af,
    IFNULL(
        (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche) / IF(C.std_umsatz_af = 0, NULL, C.std_umsatz_af
        ), 0) * 0.25 + IFNULL((
        A.absatz_af_pro_markt_woche - B.avg_absatz_af_pro_markt_woche) / IF(
        C.std_absatz_af = 0,
        NULL, C.std_absatz_af
    ), 0
    ) * 0.25 + IFNULL(
        (A.ertrag_af_pro_markt_woche - B.avg_ertrag_af_pro_markt_woche
        ) / IF(C.std_ertrag_af = 0, NULL, C.std_ertrag_af
        ), 0
    ) * 0.25 AS temp_af,
    50 * (IFNULL(
        (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche) / IF(C.std_umsatz_af = 0, NULL, C.std_umsatz_af
        ), 0) * 0.25 + IFNULL((
        A.absatz_af_pro_markt_woche - B.avg_absatz_af_pro_markt_woche) / IF(
        C.std_absatz_af =
        0, NULL, C.std_absatz_af
    ), 0
    ) * 0.25 + IFNULL(
        (A.ertrag_af_pro_markt_woche - B.avg_ertrag_af_pro_markt_woche
        ) / IF(C.std_ertrag_af = 0, NULL, C.std_ertrag_af), 0
    ) * 0.25 + 1) + 50 AS index_af_tmp,
    IFNULL(
        (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche) / IF(C.std_umsatz_sa = 0, NULL, C.std_umsatz_sa
        ), 0
    ) AS standardisierung_umsatz_sa,
    IFNULL(
        (A.absatz_sa_pro_markt_woche - B.avg_absatz_sa_pro_markt_woche) / IF(C.std_absatz_sa = 0, NULL, C.std_absatz_sa
        ), 0
    ) AS standardisierung_absatz_sa,
    IFNULL(
        (A.ertrag_sa_pro_markt_woche - B.avg_ertrag_sa_pro_markt_woche) / IF(C.std_ertrag_sa = 0, NULL, C.std_ertrag_sa
        ), 0
    ) AS standardisierung_ertrag_sa,
    IFNULL(
        (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche) / IF(C.std_umsatz_sa = 0, NULL, C.std_umsatz_sa
        ), 0) * 0.25 + IFNULL((
        A.absatz_sa_pro_markt_woche - B.avg_absatz_sa_pro_markt_woche) / IF(
        C.std_absatz_sa = 0,
        NULL, C.std_absatz_sa
    ), 0
    ) * 0.25 + IFNULL(
        (A.ertrag_sa_pro_markt_woche - B.avg_ertrag_sa_pro_markt_woche
        ) / IF(C.std_ertrag_sa = 0, NULL, C.std_ertrag_sa
        ), 0
    ) * 0.25 AS temp_sa,
    -- (a.bonreichweite_sa-b.avg_bonreichweite_sa)/c.std_bonreichweite_sa AS standardisierung_bonreichweite_sa,
    50 * (IFNULL(
        (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche) / IF(C.std_umsatz_sa = 0, NULL, C.std_umsatz_sa
        ), 0) * 0.25 + IFNULL((
        A.absatz_sa_pro_markt_woche - B.avg_absatz_sa_pro_markt_woche) / IF(
        C.std_absatz_sa =
        0, NULL, C.std_absatz_sa
    ), 0
    ) * 0.25 + IFNULL(
        (A.ertrag_sa_pro_markt_woche - B.avg_ertrag_sa_pro_markt_woche
        ) / IF(C.std_ertrag_sa = 0, NULL, C.std_ertrag_sa), 0
    ) * 0.25 + 1) + 50 AS index_sa_tmp
FROM `_index01` AS A
INNER JOIN `_index02` AS B ON A.kl_wg_id = B.kl_wg_id
INNER JOIN `_index03` AS C ON A.kl_wg_id = C.kl_wg_id;


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
        A.mandant_id AS kl_wg_id,
        A.kjmo AS kl_owg_id,
        A.art_matching_id AS kl_uwg_id,
        CAST(PERCENTILE_CONT(A.index_af_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id) AS BIGNUMERIC)
            AS l_af_quartil,
        0 AS m_af_quartil,
        0 AS h_af_quartil
    FROM `_index04` AS A
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id,
        PERCENTILE_CONT(index_af_tmp, 0.5) OVER (PARTITION BY mandant_id, kl_wg_id, kl_owg_id, kl_uwg_id) AS med_1
    FROM `_index04`) AS b
        ON
            A.kl_wg_id = b.kl_wg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.kl_owg_id = b.kl_owg_id AND A.index_af_tmp
            <= b.med_1
    UNION ALL
    SELECT
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id,
        MAX(0) AS l_af_quartil,
        MAX(t4.med_1) AS m_af_quartil,
        MAX(0) AS h_af_quartil
    FROM `_index04` AS A
    INNER JOIN (SELECT DISTINCT
        mandant_id AS kl_wg_id,
        kjmo AS kl_owg_id,
        art_matching_id AS kl_uwg_id,
        PERCENTILE_CONT(index_af_tmp, 0.5) OVER (PARTITION BY mandant_id, kjmo, art_matching_id) AS med_1
    FROM `_index04`) AS t4
        ON
            A.kl_wg_id = t4.kl_wg_id AND A.kl_uwg_id = t4.kl_uwg_id AND A.kl_owg_id = t4.kl_owg_id
            AND A.index_af_tmp <= t4.med_1
    GROUP BY
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id
    UNION ALL
    SELECT DISTINCT
        A.mandant_id AS kl_wg_id,
        A.kjmo AS kl_owg_id,
        A.art_matching_id AS kl_uwg_id,
        0 AS l_af_quartil,
        0 AS m_af_quartil,
        PERCENTILE_CONT(A.index_af_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id) AS h_af_quartil
    FROM `_index04` AS A
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id,
        PERCENTILE_CONT(index_af_tmp, 0.5) OVER (PARTITION BY mandant_id, kl_wg_id, kl_owg_id, kl_uwg_id) AS med_1
    FROM `_index04`) AS b
        ON
            A.kl_wg_id = b.kl_wg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.kl_owg_id = b.kl_owg_id AND A.index_af_tmp
            > b.med_1
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
    MAX(m_sa_quartil) AS m_sa_quartil,
    MAX(h_sa_quartil) AS h_sa_quartil
FROM (
    SELECT DISTINCT
        A.mandant_id AS kl_wg_id,
        A.kjmo AS kl_owg_id,
        A.art_matching_id AS kl_uwg_id,
        CAST(PERCENTILE_CONT(A.index_sa_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id) AS BIGNUMERIC)
            AS l_sa_quartil,
        0 AS m_sa_quartil,
        0 AS h_sa_quartil
    FROM `_index04` AS A
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id,
        PERCENTILE_CONT(index_af_tmp, 0.5) OVER (PARTITION BY mandant_id, kl_wg_id, kl_owg_id, kl_uwg_id) AS med_1
    FROM `_index04`) AS b
        ON
            A.kl_wg_id = b.kl_wg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.kl_owg_id = b.kl_owg_id AND A.index_sa_tmp
            <= b.med_1
    UNION ALL
    SELECT
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id,
        MAX(0) AS l_sa_quartil,
        MAX(t4.med_1) AS m_sa_quartil,
        MAX(0) AS h_sa_quartil
    FROM `_index04` AS A
    INNER JOIN (SELECT DISTINCT
        mandant_id AS kl_wg_id,
        kjmo AS kl_owg_id,
        art_matching_id AS kl_uwg_id,
        PERCENTILE_CONT(index_sa_tmp, 0.5) OVER (PARTITION BY mandant_id, kjmo, art_matching_id) AS med_1
    FROM `_index04`) AS t4
        ON
            A.kl_wg_id = t4.kl_wg_id AND A.kl_uwg_id = t4.kl_uwg_id AND A.kl_owg_id = t4.kl_owg_id
            AND A.index_sa_tmp <= t4.med_1
    GROUP BY
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id
    UNION ALL
    SELECT DISTINCT
        A.mandant_id AS kl_wg_id,
        A.kjmo AS kl_owg_id,
        A.art_matching_id AS kl_uwg_id,
        0 AS l_sa_quartil,
        0 AS m_sa_quartil,
        PERCENTILE_CONT(A.index_sa_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id) AS h_sa_quartil
    FROM `_index04` AS A
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id,
        PERCENTILE_CONT(index_af_tmp, 0.5) OVER (PARTITION BY mandant_id, kl_wg_id, kl_owg_id, kl_uwg_id) AS med_1
    FROM `_index04`) AS b
        ON
            A.kl_wg_id = b.kl_wg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.kl_owg_id = b.kl_owg_id AND A.index_sa_tmp
            > b.med_1
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
WHERE `_index04`.kl_wg_id = b.kl_wg_id AND `_index04`.kl_uwg_id = b.kl_uwg_id AND `_index04`.kl_owg_id = b.kl_owg_id;


UPDATE `_index04` SET
    index_sa = CASE
        WHEN `_index04`.index_sa_tmp < b.l_sa_quartil
            THEN 1
        WHEN `_index04`.index_sa_tmp BETWEEN b.l_sa_quartil AND b.m_sa_quartil
            THEN 2
        ELSE 3
    END
FROM `_index05_sa` AS b
WHERE `_index04`.kl_wg_id = b.kl_wg_id AND `_index04`.kl_uwg_id = b.kl_uwg_id AND `_index04`.kl_owg_id = b.kl_owg_id;


UPDATE `_sal_snap_final` SET
    index_af_id = b.index_af,
    index_sa_id = b.index_sa FROM (SELECT
    art_id,
    MAX(index_af) AS index_af,
    MAX(index_sa) AS index_sa
FROM `_index04`
GROUP BY art_id) AS b
WHERE `_sal_snap_final`.art_id = b.art_id;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_kl AS
SELECT
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    COUNT(DISTINCT x.kjmo) AS anz,
    COUNT(DISTINCT A.kjwo) AS anz_wochen,
    SUM(A.distr_gew) / COUNT(DISTINCT A.kjwo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.anz_maerkte) AS anz_maerkte,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK()
        OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC) AS
    rang_umsatz_uwg,
    DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo_1 AS A
INNER JOIN (SELECT
    kjwo,
    MIN(kjmo) AS kjmo
FROM dbp_data.tag_1
GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_1
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market_1 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 1
    AND A.mandant_id = 1
GROUP BY
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_x AS
SELECT
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    COUNT(DISTINCT x.kjwo) AS anz,
    SUM(A.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK()
        OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC) AS
    rang_umsatz_uwg,
    DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo_1 AS A
INNER JOIN (SELECT
    kjwo,
    MIN(kjmo) AS kjmo
FROM dbp_data.tag_1
GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_1
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market_1 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
    AND A.mandant_id = 1
GROUP BY
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _kl_ma_owg_1 AS
SELECT
    a.kl_owg_id,
    SUM(a.umsatz__) AS umsatz_x,
    SUM(b.umsatz_kl) AS umsatz_kl_x,
    SUM(b.umsatz_kl) / CAST(SUM(a.umsatz__) AS FLOAT64) * 100.00 AS marktanteil_owg
FROM (SELECT
    kl_owg_id,
    SUM(umsatz_) AS umsatz__
FROM `_artikel_anteil_uwg_ranking_x`
GROUP BY kl_owg_id) AS a
INNER JOIN (SELECT
    kl_owg_id,
    SUM(umsatz_) AS umsatz_kl
FROM `_artikel_anteil_uwg_ranking_kl`
GROUP BY kl_owg_id) AS b ON a.kl_owg_id = b.kl_owg_id
GROUP BY a.kl_owg_id;


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
) AS b ON a.kl_owg_id = b.kl_owg_id AND a.kl_uwg_id = b.kl_uwg_id
GROUP BY
    a.kl_owg_id,
    a.kl_uwg_id;


UPDATE `_sal_snap_final` SET
    marktanteilbewertung = CAST(b.indexpunkt AS INT64) FROM (
    SELECT
        B.kl_owg_id,
        B.kl_uwg_id,
        A.marktanteil_owg,
        B.marktanteil_uwg,
        IFNULL(B.marktanteil_uwg / IF(A.marktanteil_owg = 0, NULL, A.marktanteil_owg), 0) AS indexpunkt
    FROM `_kl_ma_owg_1` AS A
    INNER JOIN `_kl_ma_uwg_1` AS B ON A.kl_owg_id = B.kl_owg_id
) AS b
WHERE `_sal_snap_final`.kl_uwg_id = b.kl_uwg_id AND `_sal_snap_final`.kl_owg_id = b.kl_owg_id;


CREATE OR REPLACE TEMPORARY TABLE _preis_wg_kl AS
SELECT
    kjmo,
    wg_id AS kl_owg_id,
    wug_id AS kl_uwg_id,
    ROUND(CAST(durchschnitt_preis_kasse AS BIGNUMERIC), 0) + 1 AS preis,
    COUNT(*) AS anz_artikel
FROM dbp_data.art_kl_preislage_zu_per_1 AS A
WHERE
    durchschnitt_preis_kasse IS NOT NULL
    AND kjmo IN (
        SELECT MIN(B.kjmo) AS kjmo
        FROM (
            SELECT MAX(kjwo) AS kjwo
            FROM dbp_data.art_nielsen_fakten_kjwo_1
            WHERE mandant_id = 1
        ) AS a
        INNER JOIN dbp_data.tag_1 AS B ON a.kjwo = B.kjwo
    )
    AND mandant_id = 1
    AND (
        kjmo, kjwo_update) IN (
        SELECT (MAX(kjmo), MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
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
FROM dbp_data.art_nielsen_preislage_zu_per_1 AS A
WHERE
    durchschnitt_preis_kasse IS NOT NULL
    AND (
        kjmo, art_matching_id) IN (
        SELECT (kjmo, art_matching_id)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE
            kjmo IN (
                SELECT MIN(B.kjmo) AS kjmo
                FROM (
                    SELECT MAX(kjwo) AS kjwo
                    FROM dbp_data.art_nielsen_fakten_kjwo_1
                    WHERE mandant_id = 1
                ) AS a
                INNER JOIN dbp_data.tag_1 AS B ON a.kjwo = B.kjwo
            )
            AND mandant_id = 1
            AND (
                kjmo, kjwo_update) IN (
                SELECT (MAX(kjmo), MAX(kjwo_update))
                FROM dbp_data.art_kl_preislage_zu_per_1
                WHERE mandant_id = 1
            )
        GROUP BY kjmo,
        art_matching_id
    )
    AND mandant_id = 1
GROUP BY
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    preis;


CREATE OR REPLACE TEMPORARY TABLE _preis_wg AS
-- WHEN a.anz_artikel BETWEEN b.anz_artikel*(-1.1) AND b.anz_artikel*1.1 THEN 2
SELECT
    COALESCE(A.kjmo, B.kjmo) AS kjmo
    ,
    COALESCE(A.kl_owg_id, B.kl_owg_id) AS kl_owg_id,
    COALESCE(A.kl_uwg_id, B.kl_uwg_id) AS kl_uwg_id,
    COALESCE(A.preis, B.preis) AS preis,
    CASE
        WHEN COALESCE(A.anz_artikel, 0) > COALESCE(B.anz_artikel, 0)
            THEN 3
        WHEN COALESCE(A.anz_artikel, 0) < COALESCE(B.anz_artikel, 0)
            THEN 1
        ELSE 2
    END AS preislage_id
FROM `_preis_wg_kl` AS A
FULL JOIN `_preis_wg_nielsen` AS B ON A.kjmo = B.kjmo AND A.kl_uwg_id = B.kl_uwg_id AND A.kl_owg_id = B.kl_owg_id AND A.preis = B.preis;


UPDATE `_sal_snap_final` SET
    preislagenverteilung = CAST(b.preislage_id AS INT64)
FROM `_preis_wg` AS b
WHERE `_sal_snap_final`.kl_uwg_id = b.kl_uwg_id AND `_sal_snap_final`.kl_owg_id = b.kl_owg_id AND ROUND(
    CAST(`_sal_snap_final`.durchschnittspreis AS BIGNUMERIC),
    0
) = b.preis;


UPDATE `_sal_snap_final` SET
    preislagenverteilung = 2
WHERE preislagenverteilung = 0;


DROP TABLE IF EXISTS dbp_etl.sal_snap_final_de_1;


CREATE TABLE IF NOT EXISTS dbp_etl.sal_snap_final_de_1 AS
SELECT *
FROM `_sal_snap_final`;


DROP TABLE IF EXISTS dbp_etl.sal_snap2_de_1;


CREATE TABLE IF NOT EXISTS dbp_etl.sal_snap2_de_1 AS
SELECT *
FROM `_sal_snap_2`;


DROP TABLE IF EXISTS dbp_etl.sal_snap2_multis_de_1;

CREATE TABLE IF NOT EXISTS dbp_etl.sal_snap2_multis_de_1
AS
SELECT *
FROM
    _sal_snap_2_multis1;


CREATE OR REPLACE TEMPORARY TABLE _clear AS
SELECT
    A.mandant_id,
    A.kjmo,
    A.art_matching_id,
    A.status_1,
    A.umrech_faktor,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    A.rang_umsatz_wg,
    A.rang_umsatz_uwg,
    A.rang_absatz_uwg,
    A.art_id,
    A.kl_art_id,
    A.wug_id,
    A.art_bez,
    A.art_status,
    A.gp_id,
    A.akt_lieferant,
    A.zek_id,
    A.disc_pe,
    A.disc_marke,
    A.lcf,
    A.vegan,
    A.gluten,
    A.bio,
    A.eigenmarke,
    A.tierwohl,
    A.posten_food,
    A.posten_nonfood,
    A.mwst,
    A.k_listung,
    A.ost_basis,
    A.ost_gross,
    A.sued_ost,
    A.sued_west,
    A.west,
    A.nord,
    A.anz_maerkte,
    A.gewichtete_distribution,
    A.index_af_id,
    A.umsatz_af_pro_markt_woche,
    A.absatz_af_pro_markt_woche,
    A.ertrag_af_pro_markt_woche,
    A.bonreichweite_af,
    A.spanne_af,
    A.index_sa_id,
    A.umsatz_sa_pro_markt_woche,
    A.absatz_sa_pro_markt_woche,
    A.ertrag_sa_pro_markt_woche,
    A.bonreichweite_sa,
    A.spanne_sa,
    A.aktionsanteil_absatz,
    A.absatz_total,
    A.schnelldreherquote,
    A.schnelldreherquote_wg,
    A.schnelldreherquote_owg,
    A.kolliabverkaufsquote,
    A.kolliabverkaufsquote_wg,
    A.kolliabverkaufsquote_owg,
    A.abschriftsanteil,
    A.abschriftsanteil_wg,
    A.abschriftsanteil_owg,
    A.cherrypicker_quote,
    A.cherrypicker_quote_wg,
    A.cherrypicker_quote_owg,
    A.restbon,
    A.restbon_wg,
    A.restbon_owg,
    A.vk_preis,
    A.durchschnittspreis,
    A.preislagenverteilung,
    A.marktanteilbewertung,
    A.anz_wo_mit_absatz,
    A.anz_wo_listung_1,
    A.kol_la_bzw,
    A.kol_bst_bzw,
    A.rlz_dz,
    A.rlz,
    A.lagerprozent,
    A.total_absatz_af_mt_wo,
    A.total_absatz_sa_mt_tag,
    A.total_af_absatz,
    A.total_sa_absatz,
    A.af_umsatz_netto,
    A.sa_umsatz_netto,
    A.absatz_sa_markt_tage,
    A.absatz_af_markt_wochen,
    A.abschr_o_werb,
    A.kassenumsatz
FROM dbp_etl.sal_snap_final_de_1 AS A
INNER JOIN dbp_data.sortiment_leistung_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.kjmo = B.kjmo AND A.art_matching_id
        = B.matching_id AND A.kl_art_id = B.kl_art_id
WHERE (A.mandant_id, A.kjmo, A.art_matching_id, A.lagerprozent) IN (SELECT (
    mandant_id, kjmo, art_matching_id,
    lagerprozent
)
FROM dbp_etl.sal_snap_final_de_1
WHERE status_1 <> ' '
GROUP BY
    mandant_id,
    kjmo,
    art_matching_id,
    lagerprozent
HAVING COUNT(*) > 1)
AND B.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


DELETE FROM dbp_etl.sal_snap_final_de_1
WHERE (
    mandant_id, kjmo, art_matching_id, lagerprozent) IN (SELECT (mandant_id, kjmo, art_matching_id, lagerprozent)
FROM `_clear`) AND (mandant_id, kjmo, art_matching_id, lagerprozent, kl_art_id) NOT IN (
    SELECT (
        mandant_id, kjmo,
        art_matching_id, lagerprozent, kl_art_id
    )
    FROM `_clear`
);
