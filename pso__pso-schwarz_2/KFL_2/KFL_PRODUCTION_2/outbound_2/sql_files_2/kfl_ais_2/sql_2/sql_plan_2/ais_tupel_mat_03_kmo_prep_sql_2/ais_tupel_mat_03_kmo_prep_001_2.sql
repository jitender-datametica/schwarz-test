CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen_2
WHERE dat_bis = DATE '9999-12-31';


DROP TABLE IF EXISTS dbp_etl.bf_listung_markt_kw_kmo_2;


CREATE TABLE IF NOT EXISTS dbp_etl.bf_listung_markt_kw_kmo_2 (
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
    art_id,
    status_2,
    MAX(kl_wg_id) OVER (
        PARTITION BY mandant_id, art_matching_id ORDER BY kl_wg_id IS NULL, kl_wg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_wg_id,
    MAX(kl_owg_id) OVER (
        PARTITION BY mandant_id, art_matching_id ORDER BY kl_owg_id IS NULL, kl_owg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_owg_id,
    MAX(kl_uwg_id) OVER (
        PARTITION BY mandant_id, art_matching_id ORDER BY kl_uwg_id IS NULL, kl_uwg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo_2
WHERE
    art_id <> -1
    AND mandant_id > 1;


CREATE OR REPLACE TEMPORARY TABLE _track_min_arts AS
SELECT
    a.mandant_id,
    a.art_matching_id,
    a.art_id,
    c.owg_id,
    B.wg_id,
    B.wug_id
FROM (
    SELECT DISTINCT
        mandant_id,
        art_matching_id,
        MIN(art_id) OVER (
            PARTITION BY mandant_id, art_matching_id ORDER BY art_id IS NULL, art_id RANGE BETWEEN
            UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS art_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_2
    WHERE
        status_2 = 'T'
        AND mandant_id > 1
        AND art_id <> -1
) AS a
INNER JOIN dbp_data.art_wg_zu_per_2 AS B
    ON
        a.mandant_id = B.mandant_id AND a.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN (
    SELECT *
    FROM dbp_data.wg_per_2
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND owg_id NOT IN (-1, -3)
) AS c
    ON a.mandant_id = c.mandant_id AND B.wg_id = c.wg_id;


UPDATE `_art_leistung_1` SET
    kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id FROM (
    SELECT
        a.mandant_id,
        a.art_matching_id,
        B.wg_id,
        B.wug_id
    FROM (
        SELECT DISTINCT
            mandant_id,
            art_matching_id,
            MIN(art_id) OVER (
                PARTITION BY mandant_id, art_matching_id ORDER BY art_id IS NULL, art_id RANGE BETWEEN
                UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS art_id
        FROM dbp_etl.art_matching_nielsen_per_kmo_2
        WHERE
            status_2 = 'T'
            AND mandant_id > 1
            AND art_id <> -1
    ) AS a
    INNER JOIN
        dbp_data.art_wg_zu_per_2
            AS B
        ON
            a.mandant_id = B.mandant_id AND a.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
) AS b
WHERE
    `_art_leistung_1`.mandant_id = b.mandant_id AND `_art_leistung_1`.art_matching_id = b.art_matching_id AND
    `_art_leistung_1`.status_2 = 'T';


UPDATE `_art_leistung_1` SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per_2
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND owg_id NOT IN (-1, -3)
) AS b
WHERE `_art_leistung_1`.mandant_id = b.mandant_id AND `_art_leistung_1`.kl_owg_id = b.wg_id;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking AS
SELECT
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    COUNT(DISTINCT x.kjmo) AS anz,
    SUM(A.distr_gew) / COUNT(DISTINCT x.kjmo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK() OVER (
        PARTITION BY
            A.mandant_id, c.kl_owg_id ORDER BY
            SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto
            ) DESC
    ) AS rang_umsatz_uwg,
    DENSE_RANK()
        OVER (PARTITION BY A.mandant_id, c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS
    rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_2 AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag_2
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_2
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market_2 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.mandant_id > 1
    AND (
        A.mandant_id, A.kjmo) IN (
        SELECT (mandant_id, kjmo)
        FROM dbp_data.art_nielsen_fakten_kjmo_2
        WHERE mandant_id > 1
        GROUP BY
            mandant_id,
            kjmo
        QUALIFY ((DENSE_RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 1
GROUP BY
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_leistung_base1 AS
SELECT
    mandant_id,
    art_nielsen_id,
    art_id,
    kl_owg_id,
    kl_uwg_id,
    0 AS distr_gew,
    NULL AS rang_umsatz_wg,
    NULL AS rang_umsatz_uwg,
    NULL AS rang_absatz_uwg
FROM `_art_leistung_1`
WHERE art_nielsen_id <> -1
GROUP BY
    mandant_id,
    art_nielsen_id,
    art_id,
    kl_owg_id,
    kl_uwg_id,
    distr_gew,
    rang_umsatz_wg;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_wg_ranking AS
SELECT
    mandant_id,
    art_nielsen_id,
    kl_wg_id,
    gtin_id,
    SUM(umsatz_) AS umsatz__,
    DENSE_RANK() OVER (PARTITION BY mandant_id, kl_wg_id ORDER BY SUM(umsatz_) IS NULL DESC, SUM(umsatz_) DESC)
        AS
        rang_umsatz_wg
FROM `_artikel_anteil_uwg_ranking`
GROUP BY
    mandant_id,
    art_nielsen_id,
    kl_wg_id,
    gtin_id;


UPDATE `_artikel_anteil_uwg_leistung_base1` SET
    rang_umsatz_uwg = cast(b.rang_umsatz_uwg AS INT64),
    rang_absatz_uwg = cast(b.rang_absatz_uwg AS INT64),
    distr_gew = cast(b.distr_gew_ AS INT64)
FROM `_artikel_anteil_uwg_ranking` AS b
WHERE
    `_artikel_anteil_uwg_leistung_base1`.art_nielsen_id = b.art_nielsen_id AND `_artikel_anteil_uwg_leistung_base1`.kl_uwg_id
    = b.kl_uwg_id AND `_artikel_anteil_uwg_leistung_base1`.mandant_id = b.mandant_id;


DELETE FROM `_artikel_anteil_wg_ranking`
WHERE (
    mandant_id, art_nielsen_id) IN (SELECT (mandant_id, art_nielsen_id)
FROM `_artikel_anteil_wg_ranking`
GROUP BY
    mandant_id,
    art_nielsen_id
HAVING COUNT(
    *
) > 1) AND (mandant_id, art_nielsen_id, kl_wg_id) NOT IN (
    SELECT (
        mandant_id, art_nielsen_id, MIN(kl_wg_id
        )
    )
    FROM `_artikel_anteil_wg_ranking`
    GROUP BY
        mandant_id,
        art_nielsen_id
    HAVING COUNT(*) > 1
);


UPDATE `_artikel_anteil_uwg_leistung_base1` SET
    rang_umsatz_wg = CAST(b.rang_umsatz_wg AS INT64)
FROM `_artikel_anteil_wg_ranking` AS b
WHERE
    `_artikel_anteil_uwg_leistung_base1`.art_nielsen_id = b.art_nielsen_id AND `_artikel_anteil_uwg_leistung_base1`.mandant_id
    = b.mandant_id;


UPDATE `_artikel_anteil_uwg_ranking` SET
    rang_umsatz_wg = CAST(b.rang_umsatz_wg AS INT64)
FROM `_artikel_anteil_wg_ranking` AS b
WHERE `_artikel_anteil_uwg_ranking`.art_nielsen_id = b.art_nielsen_id AND `_artikel_anteil_uwg_ranking`.mandant_id = b.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_1 AS
SELECT
    b.art_matching_id,
    -- b.umrech_faktor,
    -- b.art_id,
    b.status_2,
    0 AS distr_gew,
    A.mandant_id,
    A.art_id,
    A.kjmo,
    A.wrg_id,
    A.arthiertyp_id,
    A.wg_id,
    A.wug_id,
    A.art_status,
    A.gp_id,
    A.gp_name,
    A.zek_id,
    A.eigenmarke_id,
    A.bio_fg,
    A.vegan_fg,
    A.posten_food,
    A.posten_nonfood,
    A.gluten_fg,
    A.mwst,
    A.disc_pe,
    A.disc_marke,
    A.lactose_fg,
    A.k_listung,
    A.umrech_faktor_best,
    A.umrech_faktor_ausg,
    A.mhd_zeitraum,
    A.mhd_zeitraum_dz,
    A.k1_artbew_menge,
    A.k1_anz_kjwo_wug_absatz,
    A.k2_artbew_menge,
    A.k2_anz_kjwo_wug_absatz,
    A.k3_artbew_menge,
    A.k3_anz_kjwo_wug_absatz,
    A.k4_artbew_menge,
    A.k4_anz_kjwo_wug_absatz,
    A.k5_artbew_menge,
    A.k5_anz_kjwo_wug_absatz,
    A.total_artbew_menge,
    A.total_anz_kjwo_wug_absatz,
    A.total_artbew_menge_vj,
    A.total_artbew_menge_sa,
    A.total_anz_kjwo_wug_absatz_sa,
    A.total_anz_tage_wug_absatz_sa,
    A.total_artbew_menge_af,
    A.total_anz_kjwo_wug_absatz_af,
    A.schnelldreherquote,
    A.prozentual_absatz_sa,
    A.total_rohertrag,
    A.total_rohertrag_vj,
    A.total_rohertrag_af,
    A.total_rohertrag_sa,
    A.rohertrag_einheit,
    A.rohertrag_einheit_af,
    A.rohertrag_einheit_sa,
    A.abschriftbetrag_netto_owerbung,
    A.ek_kb_stamm,
    A.vk_brutto_pk1,
    A.vk_brutto_pk4,
    A.vk_netto_pk1,
    A.vk_netto_pk4,
    A.total_umsatz_netto,
    A.total_umsatz_netto_af,
    A.total_umsatz_netto_sa,
    A.total_anz_markt,
    A.anz_kjwo_wup_listung,
    A.anz_wup_listung,
    A.lager_prozent,
    A.kol_la_bzw,
    A.kol_bst_bzw,
    A.spanne_ek1,
    A.spanne_ek4,
    A.td_update,
    A.td_insert,
    c.sm_id,
    c.ksm_id
FROM dbp_data.sal_kmo_2 AS A
LEFT JOIN (
    SELECT
        mandant_id,
        art_id,
        MIN(CASE
            WHEN CAST(sm_id AS FLOAT64) = -2
                THEN 'R'
            ELSE sm_id
        END) AS sm_id,
        MIN(ksm_id) AS ksm_id
    FROM dbp_etl_process.art_sm_vw_zu_per_2
    WHERE
        mandant_id > 1
        AND dat_bis = DATE '9999-12-31'
    GROUP BY
        mandant_id,
        art_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        CAST(FLOOR(art_id / 10) AS INTEGER) AS kl_art_id,
        art_id,
        status_2
    FROM `_art_leistung_1`
    GROUP BY
        mandant_id,
        art_matching_id,
        kl_art_id,
        art_id,
        status_2
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE (
    A.mandant_id, A.kjmo) IN (
    SELECT (a.mandant_id, MIN(B.kjmo))
    FROM (
        SELECT
            a1.mandant_id,
            COALESCE(a1.kjmo_nielsen, a2.kjmo_tag) AS kjmo
        FROM (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo_nielsen
        FROM dbp_data.art_nielsen_fakten_kjmo_2
        WHERE mandant_id > 1
        GROUP BY mandant_id) AS a1
        INNER JOIN (
            SELECT MAX(kjmo) AS kjmo_tag
            FROM dbp_data.tag_2
            WHERE akt_mo = -1
        ) AS a2
            ON TRUE
    ) AS a
    INNER JOIN dbp_data.tag_2 AS B ON a.kjmo = B.kjmo
    GROUP BY a.mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_2 AS
/* Kennzahlen */ SELECT
    A.mandant_id,
    A.art_matching_id,
    A.status_2,
    0 AS kl_wg_id,
    0 AS kl_owg_id,
    0 AS kl_uwg_id,
    NULL AS rang_umsatz_wg,
    NULL AS rang_umsatz_uwg,
    NULL AS rang_absatz_uwg,
    A.art_id,
    CAST(FLOOR(A.art_id / 10) AS INTEGER) AS kl_art_id,
    A.wug_id,
    B.art_bez,
    A.sm_id,
    A.ksm_id,
    A.art_status,
    A.gp_id,
    -- akt_lieferant,
    -- CAST(SUBSTR(akt_lieferant,1,POSITION(':' IN akt_lieferant)-1) AS INTEGER) AS gp_id,
    A.gp_name,
    A.zek_id AS zek_2,
    A.disc_pe,
    A.disc_marke,
    A.lactose_fg AS lcf,
    A.vegan_fg AS vegan,
    A.gluten_fg AS gluten,
    A.bio_fg AS bio,
    A.eigenmarke_id AS eigenmarke,
    ' ' AS tierwohl,
    A.posten_food,
    A.posten_nonfood,
    A.mwst,
    A.k_listung,
    ' ' AS ost_basis,
    ' ' AS ost_gross,
    ' ' AS sued_ost,
    ' ' AS sued_west,
    ' ' AS west,
    ' ' AS nord,
    /* a.total_anz_markt AS anz_maerkte, */ CAST(A.distr_gew AS NUMERIC) AS gewichtete_distribution,
    /* Index-AF */ 0 AS index_af_id,
    A.total_umsatz_netto_af / IF(
        A.total_anz_kjwo_wug_absatz = 0, NULL, A.total_anz_kjwo_wug_absatz) AS
    umsatz_af_pro_markt_woche,
    CAST(A.total_artbew_menge_af / IF(A.total_anz_kjwo_wug_absatz_af = 0, NULL, A.total_anz_kjwo_wug_absatz_af) AS BIGNUMERIC)
        AS absatz_af_pro_markt_woche,
    A.total_rohertrag_af / IF(
        A.total_anz_kjwo_wug_absatz = 0, NULL, A.total_anz_kjwo_wug_absatz) AS
    ertrag_af_pro_markt_woche,
    0 AS bonreichweite_af,
    IFNULL(A.total_rohertrag_af / IF(
        A.total_anz_kjwo_wug_absatz = 0, NULL, A.total_anz_kjwo_wug_absatz) / IF(
        A.total_umsatz_netto_af
        / IF(A.total_anz_kjwo_wug_absatz = 0, NULL, A.total_anz_kjwo_wug_absatz) = 0, NULL, A.total_umsatz_netto_af / IF(A.total_anz_kjwo_wug_absatz = 0, NULL, A.total_anz_kjwo_wug_absatz)
    ), 0) AS spanne_af,
    /* Index-SA */ 0 AS index_sa_id,
    IFNULL(A.total_umsatz_netto_sa / IF(A.total_anz_tage_wug_absatz_sa = 0, NULL, A.total_anz_tage_wug_absatz_sa), 0) *
    7.00 AS umsatz_sa_pro_markt_woche,
    IFNULL(
        CAST(A.total_artbew_menge_sa AS BIGNUMERIC) / IF(A.total_anz_tage_wug_absatz_sa = 0, NULL, A.total_anz_tage_wug_absatz_sa
        ), 0
    ) * 7.00 AS absatz_sa_pro_markt_woche,
    IFNULL(A.total_rohertrag_sa / IF(A.total_anz_tage_wug_absatz_sa = 0, NULL, A.total_anz_tage_wug_absatz_sa), 0) * 7.00
        AS ertrag_sa_pro_markt_woche,
    0 AS bonreichweite_sa,
    IFNULL(
        IFNULL(A.total_rohertrag_sa / IF(A.total_anz_tage_wug_absatz_sa = 0, NULL, A.total_anz_tage_wug_absatz_sa), 0) *
        7.00 / IF(IFNULL(
            A.total_umsatz_netto_sa / IF(A.total_anz_tage_wug_absatz_sa = 0, NULL, A.total_anz_tage_wug_absatz_sa
            ), 0) * 7.00 = 0, NULL, IFNULL(
            A.total_umsatz_netto_sa / IF(A.total_anz_tage_wug_absatz_sa = 0, NULL, A.total_anz_tage_wug_absatz_sa
            ), 0
        ) * 7.00), 0
    ) AS spanne_sa,
    CAST(ROUND(A.total_artbew_menge_sa / IF(A.total_artbew_menge = 0, NULL, A.total_artbew_menge) * 100, 1) AS BIGNUMERIC)
        AS aktionsanteil_absatz,
    CAST(A.total_artbew_menge AS BIGNUMERIC) AS absatz_total,
    /* Bon */ A.schnelldreherquote,
    0 AS schnelldreherquote_wg,
    0 AS schnelldreherquote_owg,
    CASE
        WHEN A.kol_la_bzw IS NOT NULL
            THEN IFNULL(A.mhd_zeitraum * A.lager_prozent * COALESCE(
                CAST(A.total_artbew_menge_af / IF(A.total_anz_kjwo_wug_absatz_af = 0, NULL, A.total_anz_kjwo_wug_absatz_af) * 1 AS BIGNUMERIC)
                / 7, CAST(IFNULL(A.total_artbew_menge_sa * 1 / IF(A.total_anz_tage_wug_absatz_sa = 0, NULL, A.total_anz_tage_wug_absatz_sa), 0) * 7.00 AS BIGNUMERIC)
            ) / IF(A.kol_la_bzw = 0, NULL, A.kol_la_bzw), 0)
        ELSE IFNULL(A.mhd_zeitraum_dz * COALESCE(
            CAST(A.total_artbew_menge_af / IF(A.total_anz_kjwo_wug_absatz_af = 0, NULL, A.total_anz_kjwo_wug_absatz_af) * 1 AS BIGNUMERIC)
            / 7, CAST(IFNULL(A.total_artbew_menge_sa * 1 / IF(A.total_anz_tage_wug_absatz_sa = 0, NULL, A.total_anz_tage_wug_absatz_sa), 0) * 7.00 AS BIGNUMERIC)
        ) / IF(A.kol_bst_bzw = 0, NULL, A.kol_bst_bzw), 0)
    END AS kolliabverkaufsquote,
    0 AS kolliabverkaufsquote_wg,
    0 AS kolliabverkaufsquote_owg,
    IFNULL(
        A.abschriftbetrag_netto_owerbung / IF(A.total_umsatz_netto = 0, NULL, A.total_umsatz_netto), 0) AS
    abschriftsanteil,
    0 AS abschriftsanteil_wg,
    0 AS abschriftsanteil_owg,
    0 AS cherrypicker_quote,
    0 AS cherrypicker_quote_wg,
    0 AS cherrypicker_quote_owg,
    0 AS restbon,
    0 AS restbon_wg,
    0 AS restbon_owg,
    /* Bewertung */ A.vk_brutto_pk1 AS vk_preis,
    CASE
        WHEN A.total_umsatz_netto_af <> 0
            THEN IFNULL(A.total_umsatz_netto_af / IF(A.total_artbew_menge_af = 0, NULL, A.total_artbew_menge_af), 0)
        ELSE IFNULL(A.total_umsatz_netto_sa / IF(A.total_artbew_menge_sa = 0, NULL, A.total_artbew_menge_sa), 0)
    END AS durchschnittspreis,
    0 AS preislagenverteilung,
    0 AS marktanteilbewertung,
    /* zur Berechnung */ A.total_anz_kjwo_wug_absatz AS anz_wo_mit_absatz,
    A.total_anz_kjwo_wug_absatz_af AS anz_wo_mit_absatz_af,
    ROUND(CAST(A.total_anz_tage_wug_absatz_sa / 7.0000 AS NUMERIC), 4) AS anz_wo_mit_absatz_sa,
    A.anz_kjwo_wup_listung AS anz_wo_listung_2,
    A.kol_la_bzw,
    A.kol_bst_bzw,
    A.mhd_zeitraum_dz AS rlz_dz,
    A.mhd_zeitraum AS rlz,
    A.lager_prozent AS lagerprozent,
    CAST(A.total_artbew_menge_af / IF(A.total_anz_kjwo_wug_absatz_af = 0, NULL, A.total_anz_kjwo_wug_absatz_af) AS NUMERIC)
        AS total_absatz_af_mt_wo,
    CAST(A.total_artbew_menge_sa / IF(A.total_anz_tage_wug_absatz_sa = 0, NULL, A.total_anz_tage_wug_absatz_sa) AS NUMERIC)
        AS total_absatz_sa_mt_tag,
    CAST(A.total_artbew_menge_af AS BIGNUMERIC) AS total_af_absatz,
    CAST(A.total_artbew_menge_sa AS BIGNUMERIC) AS total_sa_absatz,
    A.total_umsatz_netto_af AS af_umsatz_netto,
    A.total_umsatz_netto_sa AS sa_umsatz_netto,
    A.total_anz_tage_wug_absatz_sa AS absatz_sa_markt_tage,
    A.total_anz_kjwo_wug_absatz_af AS absatz_af_markt_wochen,
    CAST(A.abschriftbetrag_netto_owerbung AS FLOAT64) AS abschr_o_werb,
    CAST(A.total_umsatz_netto AS FLOAT64) AS kassenumsatz
FROM `_sal_snap_1` AS A
LEFT JOIN dbp_data.art_spr_zu_2
    AS B ON A.art_id = B.art_id AND A.mandant_id = B.mandant_id AND B.spr_id
NOT IN (22, 24);


UPDATE `_sal_snap_2` SET
    bonreichweite_af = CAST(b.krw_af AS INT64),
    bonreichweite_sa = CAST(b.krw_sa AS INT64)
FROM (
    SELECT
        mandant_id,
        kl_art_id,
        SUM(krw_af) AS krw_af,
        SUM(krw_sa) AS krw_sa,
        SUM(cpq_total) AS cpq_total,
        SUM(rb_total) AS rb_total
    FROM dbp_etl.kpi_aggregat_kmo_2
    WHERE
        mandant_id > 1
        AND kjmo_sort IN (
            SELECT MAX(kjmo_sort) AS a229457457
            FROM dbp_etl.kpi_aggregat_kmo_2
            WHERE mandant_id > 1
        )
    GROUP BY
        mandant_id,
        kl_art_id
) AS b
WHERE `_sal_snap_2`.kl_art_id = b.kl_art_id AND `_sal_snap_2`.mandant_id = b.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _step1 AS
SELECT
    B.mandant_id,
    B.art_id,
    C.wg_id,
    SUM(A.artikel_bons_af) AS art_bons_af,
    SUM(A.artikel_bons_sa) AS art_bons_sa,
    SUM(A.cpq_total) AS cpq_total_artikel,
    SUM(A.cherry_bons_af) AS cp_bons_af,
    SUM(A.cherry_bons_sa) AS cp_bons_sa
FROM dbp_etl.kpi_aggregat_kmo_2 AS A
INNER JOIN dbp_data.art_2 AS B
    ON
        A.mandant_id = B.mandant_id AND A.kl_art_id = B.kl_art_id AND B.dat_bis
        = DATE '9999-12-31'
INNER JOIN dbp_data.art_wg_zu_per_2 AS C
    ON
        A.mandant_id = C.mandant_id AND B.art_id = C.art_id AND C.arthiertyp_id
        = 2 AND C.dat_bis = DATE '9999-12-31'
WHERE
    A.mandant_id > 1
    AND (
        A.mandant_id, A.kjmo_sort) IN (
        SELECT (mandant_id, MAX(kjmo_sort))
        FROM dbp_etl.kpi_aggregat_kmo_2
        WHERE mandant_id > 1
        GROUP BY mandant_id
    )
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
    A.mandant_id,
    A.art_matching_id,
    A.status_2,
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
    A.sm_id,
    A.ksm_id,
    A.art_status,
    A.gp_id,
    A.gp_name,
    A.zek_2,
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
    A.anz_wo_mit_absatz_af,
    A.anz_wo_mit_absatz_sa,
    A.anz_wo_listung_2,
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
INNER JOIN (SELECT
    art_matching_id,
    mandant_id
FROM `_sal_snap_2`
GROUP BY
    mandant_id,
    art_matching_id
HAVING COUNT(*) > 1) AS b ON A.art_matching_id = b.art_matching_id AND A.mandant_id = b.mandant_id;


UPDATE `_sal_snap_2_multis` SET
    wug_id = CAST(b.wug_id AS INT64),
    art_bez = b.art_bez,
    art_status = b.art_status,
    gp_id = CAST(b.gp_id AS INT64),
    gp_name = b.gp_name,
    zek_2 = b.zek_2,
    disc_pe = CAST(b.disc_pe AS INT64),
    disc_marke = CAST(b.disc_marke AS INT64),
    lcf = CAST(b.lcf AS INT64),
    vegan = CAST(b.vegan AS INT64),
    gluten = CAST(b.gluten AS INT64),
    bio = CAST(b.bio AS INT64),
    eigenmarke = b.eigenmarke,
    tierwohl = b.tierwohl,
    posten_food = b.posten_food,
    posten_nonfood = b.posten_nonfood,
    mwst = b.mwst,
    k_listung = b.k_listung,
    ost_basis = b.ost_basis,
    ost_gross = b.ost_gross,
    sued_ost = b.sued_ost,
    sued_west = b.sued_west,
    west = b.west,
    nord = b.nord
FROM (
    SELECT
        Y.mandant_id,
        Y.art_matching_id,
        Y.status_2,
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
        Y.sm_id,
        Y.ksm_id,
        Y.art_status,
        Y.gp_id,
        Y.gp_name,
        Y.zek_2,
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
        Y.anz_wo_mit_absatz_af,
        Y.anz_wo_mit_absatz_sa,
        Y.anz_wo_listung_2,
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
        FROM dbp_data.art_wup_zu_per_2
        WHERE
            mandant_id > 1
            AND listung_id = 1
        GROUP BY art_id) AS y ON X.kl_art_id = CAST(FLOOR(y.art_id / 10) AS INTEGER)
        GROUP BY
            X.art_matching_id,
            X.kl_art_id,
            y.art_id, dat_von
        QUALIFY (ROW_NUMBER() OVER (
            PARTITION BY
                1 ORDER BY
                X.art_matching_id IS NULL DESC, X.art_matching_id DESC, dat_von
                IS NULL DESC, dat_von DESC, X.kl_art_id IS NULL DESC, X.kl_art_id DESC
        )) = 1
    ) AS x1 ON Y.art_matching_id = x1.art_matching_id AND Y.kl_art_id = x1.kl_art_id
) AS b
WHERE `_sal_snap_2_multis`.art_matching_id = b.art_matching_id AND `_sal_snap_2_multis`.mandant_id = b.mandant_id;


DROP TABLE IF EXISTS dbp_etl.bf_artbew_wg_art_wo_sum_kmo_2;


CREATE TABLE IF NOT EXISTS dbp_etl.bf_artbew_wg_art_wo_sum_kmo_2 (
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


INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_kmo_2
(
    SELECT
        A.mandant_id,
        C.kjwo,
        B.wg_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.bewart_id,
        A.menge,
        A.umsatz_netto,
        A.ek_mep
    FROM dbp_data.artbew_wo_sum_2 AS A
    INNER JOIN dbp_data.woche_kj_kl_2 AS C ON A.kjwo_kl = C.kjwo_kl
    INNER JOIN dbp_data.art_wg_zu_per_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    INNER JOIN (
        SELECT
            mandant_id,
            art_id
        FROM dbp_etl.art_matching_nielsen_per_kmo_2
        WHERE art_id <> -1
        GROUP BY
            mandant_id,
            art_id
    ) AS d ON A.art_id = d.art_id AND A.mandant_id = d.mandant_id
    WHERE (
        A.mandant_id, C.kjwo) IN (
        SELECT (b.mandant_id, C0.kjwo)
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 AS A0
        INNER JOIN (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_2
        WHERE mandant_id > 1
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
        INNER JOIN dbp_data.woche_2 AS C0 ON C0.kjwo BETWEEN A0.kjwo_von AND A0.kjwo_bis
        GROUP BY b.mandant_id,
        C0.kjwo
    )
);


INSERT INTO dbp_etl.bf_listung_markt_kw_kmo_2 (
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
    FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_2 AS V01
    INNER JOIN dbp_data.art_wg_zu_per_2 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id

    INNER JOIN dbp_data.wup_2 AS V04
        ON
            V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
            = V04.mandant_id
    WHERE
        V01.mandant_id > 1
        AND V03.arthiertyp_id = 2
        AND V03.dat_bis = DATE '9999-12-31'
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
    A.mandant_id,
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
FROM dbp_etl.bf_listung_markt_kw_kmo_2 AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_2
    WHERE art_id <> -1
    GROUP BY
        mandant_id,
        art_id,
        art_matching_id
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE (
    A.mandant_id, A.kjwo) IN (
    SELECT (b.mandant_id, C.kjwo)
    FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 AS A0
    INNER JOIN (SELECT
        mandant_id,
        MAX(kjmo) AS kjmo
    FROM dbp_data.sortiment_leistung_2
    WHERE mandant_id > 1
    GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
    INNER JOIN dbp_data.woche_2 AS C ON C.kjwo BETWEEN A0.kjwo_von AND A0.kjwo_bis
    GROUP BY b.mandant_id,
    C.kjwo
)
AND b.art_matching_id IN (
    SELECT art_matching_id
    FROM `_sal_snap_2_multis`
)
GROUP BY
    A.kjwo,
    A.mandant_id,
    b.art_matching_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen1 AS
SELECT
    art_matching_id,
    mandant_id,
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
    art_matching_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _woche AS
SELECT
    B.mandant_id,
    A.kjwo
FROM dbp_data.woche_2 AS A
INNER JOIN dbp_data.mandant_2 AS B ON TRUE
WHERE (
    B.mandant_id, A.kjwo) IN (
    SELECT (b.mandant_id, C.kjwo)
    FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 AS A0
    INNER JOIN (SELECT
        mandant_id,
        MAX(kjmo) AS kjmo
    FROM dbp_data.sortiment_leistung_2
    WHERE mandant_id > 1
    GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
    INNER JOIN dbp_data.woche_2 AS C ON C.kjwo BETWEEN A0.kjwo_von AND A0.kjwo_bis
    GROUP BY b.mandant_id,
    C.kjwo
)
GROUP BY
    B.mandant_id,
    A.kjwo;


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
        B.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(CASE
            WHEN SUM(A11.absatz) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz
    FROM dbp_etl.bf_listung_markt_kw_kmo_2 AS A11
    INNER JOIN dbp_etl.art_matching_nielsen_per_2 AS B ON A11.art_id = B.art_id AND A11.mandant_id = B.mandant_id

    WHERE
        A11.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE wg_filter_id = 11
        )
        AND (
            A11.mandant_id, A11.kjwo) IN (
            SELECT (mandant_id, kjwo)
            FROM `_woche`
        )
        AND A11.mandant_id > 1
        AND B.art_matching_id IN (
            SELECT art_matching_id
            FROM `_sal_snap_2_multis`
        )
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
    anz_wo_listung_2 FLOAT64
);


INSERT INTO zzsp08_pre
(
    SELECT
        A11.kjwo,
        B.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(COUNT(DISTINCT A11.kjwo) AS FLOAT64) AS anz_wo_listung_2
    FROM dbp_data.art_wup_listung_kjwo_2 AS A11
    INNER JOIN dbp_etl.art_matching_nielsen_per_kmo_2 AS B
        ON
            A11.mandant_id = B.mandant_id AND A11.art_id =
            B.art_id
    WHERE
        A11.mandant_id > 1
        AND (
            A11.mandant_id, A11.kjwo) IN (
            SELECT (mandant_id, kjwo)
            FROM `_woche`
        )
        AND B.art_matching_id IN (
            SELECT art_matching_id
            FROM `_sal_snap_2_multis`
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
    A.anz_wo_listung_2,
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
    anz_wo_listung_2,
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
    anz_wo_listung_2 FLOAT64
);


INSERT INTO zzsp08
(
    SELECT
        matching_id,
        mandant_id,
        SUM(anz_wo_listung_2) AS anz_wo_listung_2
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
    anz_wo_listung_2 FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    schnelldreherquote FLOAT64
);


INSERT INTO zzmd0a_xxx
(
    SELECT
        PA11.matching_id,
        PA11.mandant_id,
        1.0 AS wjxbfs1,
        PA13.anz_wo_listung_2,
        PA12.anz_wo_mit_absatz,
        ROUND(PA12.anz_wo_mit_absatz / IF(PA13.anz_wo_listung_2 = 0, NULL, PA13.anz_wo_listung_2) * 100, 1) AS schnelldreherquote
    FROM zzoj09 AS PA11
    LEFT JOIN zzsp07 AS PA12 ON PA11.matching_id = PA12.matching_id AND PA11.mandant_id = PA12.mandant_id
    LEFT JOIN zzsp08 AS PA13 ON PA11.matching_id = PA13.matching_id AND PA11.mandant_id = PA13.mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE `_sal_snap_2_multis1`
AS
SELECT
    X.MANDANT_ID,
    X.ART_MATCHING_ID,
    X.STATUS_2,
    max(coalesce(XXX.OWG_ID, X.KL_WG_ID)) AS KL_WG_ID,
    max(coalesce(XXX.WG_ID, X.KL_OWG_ID)) AS KL_OWG_ID,
    max(coalesce(XXX.WUG_ID, X.KL_UWG_ID)) AS KL_UWG_ID,
    max(X.RANG_UMSATZ_WG) AS RANG_UMSATZ_WG,
    max(X.RANG_UMSATZ_UWG) AS RANG_UMSATZ_UWG,
    max(X.RANG_ABSATZ_UWG) AS RANG_ABSATZ_UWG,
    max(coalesce(XXX.ART_ID, X.ART_ID)) AS ART_ID,
    replace(trim(string_agg(lpad(substr(CAST(round(CAST(lpad(CAST(X.KL_ART_ID as STRING), 8, '0') as BIGNUMERIC), 0) as STRING), 1, 8), 8, '0'), ',' ORDER BY if(X.KL_ART_ID IS NULL, 0, 1) DESC, X.KL_ART_ID), ','), ' ', '') AS KL_ART_ID,
    max(coalesce(XXX.WUG_ID, X.WUG_ID)) AS WUG_ID,
    max(X.ART_BEZ) AS ART_BEZ,
    max(X.SM_ID) AS SM_ID,
    max(X.KSM_ID) AS KSM_ID,
    max(X.ART_STATUS) AS ART_STATUS,
    max(X.GP_ID) AS GP_ID,
    max(X.GP_NAME) AS GP_NAME,
    max(X.ZEK_2) AS ZEK_2,
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
    coalesce(sum(X.GEWICHTETE_DISTRIBUTION) / nullif(count(*), NUMERIC '0'), NUMERIC '0') AS GEWICHTETE_DISTRIBUTION,
    /* Index AF */
    max(X.INDEX_AF_ID) AS INDEX_AF_ID,
    coalesce(sum(X.AF_UMSATZ_NETTO) / nullif(max(Y.ANZAHL_WOCHEN_MIT_UMSATZ_AF), NUMERIC '0'), NUMERIC '0') AS UMSATZ_AF_PRO_MARKT_WOCHE_,
    coalesce(sum(X.TOTAL_AF_ABSATZ) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ABSATZ_AF), NUMERIC '0'), NUMERIC '0') AS ABSATZ_AF_PRO_MARKT_WOCHE_,
    coalesce(max(Y.ERTRAG_AF) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ERTRAG_AF), NUMERIC '0'), NUMERIC '0') AS ERTRAG_AF_PRO_MARKT_WOCHE_,
    sum(X.BONREICHWEITE_AF) AS BONREICHWEITE_AF,
    coalesce(coalesce(max(Y.ERTRAG_AF) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ERTRAG_AF), NUMERIC '0'), NUMERIC '0') / nullif(coalesce(sum(X.AF_UMSATZ_NETTO) / nullif(max(Y.ANZAHL_WOCHEN_MIT_UMSATZ_AF), NUMERIC '0'), NUMERIC '0'), NUMERIC '0'), NUMERIC '0') AS SPANNE_AF,
    /* Index SA */
    max(X.INDEX_SA_ID) AS INDEX_SA_ID,
    coalesce(sum(X.SA_UMSATZ_NETTO) / nullif(max(Y.ANZAHL_WOCHEN_MIT_UMSATZ_SA), NUMERIC '0'), NUMERIC '0') AS UMSATZ_SA_PRO_MARKT_WOCHE_,
    coalesce(sum(X.TOTAL_SA_ABSATZ) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ABSATZ_SA), NUMERIC '0'), NUMERIC '0') AS ABSATZ_SA_PRO_MARKT_WOCHE_,
    coalesce(max(Y.ERTRAG_SA) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ERTRAG_SA), NUMERIC '0'), NUMERIC '0') AS ERTRAG_SA_PRO_MARKT_WOCHE_,
    sum(X.BONREICHWEITE_SA) AS BONREICHWEITE_SA,
    coalesce(coalesce(max(Y.ERTRAG_SA) / nullif(max(Y.ANZAHL_WOCHEN_MIT_ERTRAG_SA), NUMERIC '0'), NUMERIC '0') / nullif(coalesce(sum(X.SA_UMSATZ_NETTO) / nullif(max(Y.ANZAHL_WOCHEN_MIT_UMSATZ_SA), NUMERIC '0'), NUMERIC '0'), NUMERIC '0'), NUMERIC '0') AS SPANNE_SA,
    /* Kennzahlen */
    coalesce(sum(TOTAL_SA_ABSATZ) / nullif(sum(X.ABSATZ_TOTAL), NUMERIC '0'), NUMERIC '0') AS AKTIONSANTEIL_ABSATZ,
    sum(X.ABSATZ_TOTAL) AS ABSATZ_TOTAL,
    /* Bon */
    coalesce(sum(CAST(X.ANZ_WO_MIT_ABSATZ as FLOAT64)) / nullif(sum(CAST(X.ANZ_WO_LISTUNG_2 as FLOAT64)), 0.0), 0.0) AS SCHNELLDREHERQUOTE,
    sum(SCHNELLDREHERQUOTE_WG) AS SCHNELLDREHERQUOTE_WG,
    sum(SCHNELLDREHERQUOTE_OWG) AS SCHNELLDREHERQUOTE_OWG,
    CAST(CASE
        WHEN max(KOL_LA_BZW) IS NOT NULL THEN coalesce(max(RLZ) / count(*) * max(LAGERPROZENT) * coalesce(sum(TOTAL_AF_ABSATZ) / sum(ABSATZ_AF_MARKT_WOCHEN) / NUMERIC '6', sum(TOTAL_SA_ABSATZ) / sum(ABSATZ_SA_MARKT_TAGE)) / nullif(max(KOL_LA_BZW), NUMERIC '0'), NUMERIC '0')
        ELSE coalesce(max(RLZ_DZ) / count(*) * coalesce(sum(TOTAL_AF_ABSATZ) / sum(ABSATZ_AF_MARKT_WOCHEN) / NUMERIC '6', sum(TOTAL_SA_ABSATZ) / sum(ABSATZ_SA_MARKT_TAGE)) / nullif(max(KOL_BST_BZW), NUMERIC '0'), NUMERIC '0')
    END AS FLOAT64) AS KOLLIABVERKAUFSQUOTE,
    sum(KOLLIABVERKAUFSQUOTE_WG) AS KOLLIABVERKAUFSQUOTE_WG,
    sum(KOLLIABVERKAUFSQUOTE_OWG) AS KOLLIABVERKAUFSQUOTE_OWG,
    CAST(coalesce(sum(CAST(ABSCHR_O_WERB as FLOAT64)) / nullif(sum(CAST(KASSENUMSATZ as FLOAT64)), 0.0), 0.0) AS NUMERIC) AS ABSCHRIFTSANTEIL,
    sum(ABSCHRIFTSANTEIL_WG) AS ABSCHRIFTSANTEIL_WG,
    sum(ABSCHRIFTSANTEIL_OWG) AS ABSCHRIFTSANTEIL_OWG,
    CAST(sum(CHERRYPICKER_QUOTE) / count(*) AS INT64) AS CHERRYPICKER_QUOTE,
    sum(CHERRYPICKER_QUOTE_WG) AS CHERRYPICKER_QUOTE_WG,
    sum(CHERRYPICKER_QUOTE_OWG) AS CHERRYPICKER_QUOTE_OWG,
    sum(RESTBON) AS RESTBON,
    sum(RESTBON_WG) AS RESTBON_WG,
    sum(RESTBON_OWG) AS RESTBON_OWG,
    /* Bewertung */
    max(VK_PREIS) /*-> muessen wir aendern!*/ AS VK_PREIS,
    CAST(CASE
        WHEN sum(AF_UMSATZ_NETTO) <> NUMERIC '0'
            THEN coalesce(
                (sum(AF_UMSATZ_NETTO) * ((NUMERIC '100' + max(X.MWST)) / NUMERIC '100')) / nullif(sum(TOTAL_AF_ABSATZ), NUMERIC '0'),
                NUMERIC '0'
            )
        ELSE coalesce(
            (sum(SA_UMSATZ_NETTO) * ((NUMERIC '100' + max(X.MWST)) / NUMERIC '100')) / nullif(sum(TOTAL_SA_ABSATZ), NUMERIC '0'),
            NUMERIC '0'
        )
    END AS NUMERIC) AS DURCHSCHNITTSPREIS,
    ----> brutto!
    sum(PREISLAGENVERTEILUNG) AS PREISLAGENVERTEILUNG,
    sum(MARKTANTEILBEWERTUNG) AS MARKTANTEILBEWERTUNG,
    /* Berechnung */
    sum(ANZ_WO_MIT_ABSATZ) AS ANZ_WO_MIT_ABSATZ,
    sum(ANZ_WO_MIT_ABSATZ_AF) AS ANZ_WO_MIT_ABSATZ_AF,
    sum(ANZ_WO_MIT_ABSATZ_SA) AS ANZ_WO_MIT_ABSATZ_SA,
    sum(ANZ_WO_LISTUNG_2) AS ANZ_WO_LISTUNG_2,
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
    `_sal_snap_2_multis` AS X
LEFT OUTER JOIN _track_min_arts AS XXX_2
    ON
        X.MANDANT_ID = XXX.MANDANT_ID
        AND X.ART_MATCHING_ID = XXX.ART_MATCHING_ID
LEFT OUTER JOIN _step1 AS Z
    ON
        X.MANDANT_ID = Z.MANDANT_ID
        AND X.ART_ID = Z.ART_ID
LEFT OUTER JOIN _anz_wochen1 AS Y
    ON
        X.ART_MATCHING_ID = Y.ART_MATCHING_ID
        AND X.MANDANT_ID = Y.MANDANT_ID
WHERE (X.ART_MATCHING_ID, X.MANDANT_ID) NOT IN (
    SELECT AS STRUCT
        X.ART_MATCHING_ID,
        mandant_id AS MANDANT_ID
    FROM
        dbp_etl.art_matching_nielsen_per_2
    CROSS JOIN
        UNNEST(ARRAY[
            MANDANT_ID
        ]) AS mandant_id
    WHERE GTIN_ID IN (
        -NUMERIC '9998', -NUMERIC '9999'
    )
    AND mandant_id > NUMERIC '1'
)
GROUP BY 1, 2, 3;


UPDATE `_sal_snap_2_multis1`
SET SCHNELLDREHERQUOTE = B.SDQ / 100 FROM (
    SELECT
        zzmd0a_xxx.SCHNELLDREHERQUOTE AS SDQ,
        zzmd0a_xxx.MATCHING_ID,
        zzmd0a_xxx.MANDANT_ID
    FROM
        zzmd0a_xxx
    GROUP BY 1, 2, 3
) AS B
WHERE
    `_sal_snap_2_multis1`.ART_MATCHING_ID = B.MATCHING_ID
    AND `_sal_snap_2_multis1`.MANDANT_ID = B.MANDANT_ID;


DELETE FROM _sal_snap_2
WHERE (_sal_snap_2.MANDANT_ID, _sal_snap_2.ART_MATCHING_ID) IN (
    SELECT AS STRUCT
        MANDANT_ID,
        ART_MATCHING_ID
    FROM
        `_sal_snap_2_multis1`
);


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_final AS
SELECT
    A.mandant_id,
    D.kjmo_sort AS kjmo,
    A.art_matching_id /* ,' ' AS status_2
      ,umrech_faktor */,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    A.rang_umsatz_wg,
    A.rang_umsatz_uwg,
    A.rang_absatz_uwg,
    A.art_id,
    CAST(A.kl_art_id AS STRING) AS kl_art_id,
    A.wug_id,
    A.art_bez,
    A.art_status,
    A.sm_id,
    A.ksm_id,
    A.gp_id,
    A.gp_name,
    A.zek_2 AS zek_id,
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
    A.nord /* ,anz_maerkte */,
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
    A.marktanteilbewertung /* zur Berechnung */,
    A.anz_wo_mit_absatz,
    A.anz_wo_listung_2,
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
    SELECT MAX(kjmo) AS max_kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo_2
    WHERE mandant_id > 1
) AS c
    ON TRUE
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 AS D ON c.max_kjmo = D.kjmo_sort;


INSERT INTO _sal_snap_final
SELECT
    A.MANDANT_ID,
    D.KJMO_SORT AS KJMO,
    ART_MATCHING_ID,
    /*,' ' AS status_2
            ,umrech_faktor*/
    KL_WG_ID,
    KL_OWG_ID,
    KL_UWG_ID,
    RANG_UMSATZ_WG,
    RANG_UMSATZ_UWG,
    RANG_ABSATZ_UWG,
    ART_ID,
    substr(substr(KL_ART_ID, 1, 300), 1, 300) AS KL_ART_ID,
    WUG_ID,
    ART_BEZ,
    ART_STATUS,
    SM_ID,
    KSM_ID,
    GP_ID,
    GP_NAME,
    ZEK_2 AS ZEK_ID,
    DISC_PE,
    DISC_MARKE,
    LCF,
    VEGAN,
    GLUTEN,
    BIO,
    EIGENMARKE,
    TIERWOHL,
    POSTEN_FOOD,
    POSTEN_NONFOOD,
    MWST,
    K_LISTUNG,
    OST_BASIS,
    OST_GROSS,
    SUED_OST,
    SUED_WEST,
    WEST,
    NORD,
    /* ,anz_maerkte */
    GEWICHTETE_DISTRIBUTION,
    INDEX_AF_ID,
    UMSATZ_AF_PRO_MARKT_WOCHE_,
    ABSATZ_AF_PRO_MARKT_WOCHE_,
    ERTRAG_AF_PRO_MARKT_WOCHE_,
    BONREICHWEITE_AF,
    SPANNE_AF,
    INDEX_SA_ID,
    UMSATZ_SA_PRO_MARKT_WOCHE_,
    ABSATZ_SA_PRO_MARKT_WOCHE_,
    ERTRAG_SA_PRO_MARKT_WOCHE_,
    BONREICHWEITE_SA,
    SPANNE_SA,
    AKTIONSANTEIL_ABSATZ,
    ABSATZ_TOTAL,
    CAST(SCHNELLDREHERQUOTE AS NUMERIC),
    SCHNELLDREHERQUOTE_WG,
    SCHNELLDREHERQUOTE_OWG,
    CAST(KOLLIABVERKAUFSQUOTE AS BIGNUMERIC),
    KOLLIABVERKAUFSQUOTE_WG,
    KOLLIABVERKAUFSQUOTE_OWG,
    ABSCHRIFTSANTEIL,
    ABSCHRIFTSANTEIL_WG,
    ABSCHRIFTSANTEIL_OWG,
    CHERRYPICKER_QUOTE,
    CHERRYPICKER_QUOTE_WG,
    CHERRYPICKER_QUOTE_OWG,
    RESTBON,
    RESTBON_WG,
    RESTBON_OWG,
    VK_PREIS,
    DURCHSCHNITTSPREIS,
    PREISLAGENVERTEILUNG,
    MARKTANTEILBEWERTUNG,
    /* zur Berechnung */
    ANZ_WO_MIT_ABSATZ,
    ANZ_WO_LISTUNG_2,
    KOL_LA_BZW,
    KOL_BST_BZW,
    RLZ_DZ,
    RLZ,
    LAGERPROZENT,
    TOTAL_ABSATZ_AF_MT_WO,
    TOTAL_ABSATZ_SA_MT_TAG,
    TOTAL_AF_ABSATZ,
    TOTAL_SA_ABSATZ,
    AF_UMSATZ_NETTO,
    SA_UMSATZ_NETTO,
    ABSATZ_SA_MARKT_TAGE,
    ABSATZ_AF_MARKT_WOCHEN,
    ABSCHR_O_WERB,
    KASSENUMSATZ
FROM
    `_sal_snap_2_multis1` AS A
INNER JOIN (
    SELECT max(art_nielsen_fakten_kjmo.KJMO) AS MAX_KJMO
    FROM
        dbp_data.art_nielsen_fakten_kjmo_2
    WHERE art_nielsen_fakten_kjmo.MANDANT_ID > NUMERIC '1'
) AS C ON NUMERIC '1' = NUMERIC '1'
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 AS D ON C.MAX_KJMO = D.KJMO_SORT;


DELETE FROM `_sal_snap_final`
WHERE (
    mandant_id, art_id) IN (SELECT (mandant_id, art_id)
FROM `_sal_snap_final`
GROUP BY
    mandant_id,
    art_id
HAVING COUNT(
    *
) > 1) AND (mandant_id, art_id, art_matching_id) NOT IN (
    SELECT (
        mandant_id, art_id, MIN(art_matching_id
        )
    )
    FROM `_sal_snap_final`
    GROUP BY
        mandant_id,
        art_id
    HAVING COUNT(*) > 1
);


UPDATE `_sal_snap_final` SET
    kl_wg_id = CAST(b.kl_wg_id AS INT64),
    kl_owg_id = CAST(b.kl_owg_id AS INT64),
    kl_uwg_id = CAST(b.kl_uwg_id AS INT64)
FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(kl_wg_id) AS kl_wg_id,
        MAX(kl_owg_id) AS kl_owg_id,
        MAX(kl_uwg_id) AS kl_uwg_id
    FROM `_art_leistung_1`
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE `_sal_snap_final`.art_id = b.art_id AND `_sal_snap_final`.mandant_id = b.mandant_id;


UPDATE `_sal_snap_final` SET
    rang_umsatz_wg = CAST(b.rang_umsatz_wg AS INT64),
    rang_umsatz_uwg = CAST(b.rang_umsatz_uwg AS INT64),
    rang_absatz_uwg = CAST(b.rang_absatz_uwg AS INT64),
    gewichtete_distribution = CAST(b.distr_gew AS INT64)
FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(rang_umsatz_wg) AS rang_umsatz_wg,
        MAX(rang_umsatz_uwg) AS rang_umsatz_uwg,
        MAX(rang_absatz_uwg) AS rang_absatz_uwg,
        SUM(distr_gew) AS distr_gew
    FROM `_artikel_anteil_uwg_leistung_base1`
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE `_sal_snap_final`.art_id = b.art_id AND `_sal_snap_final`.mandant_id = b.mandant_id;


UPDATE `_sal_snap_final` SET
    rang_umsatz_wg = CAST(b.next_rang_ums_wg AS INT64),
    rang_umsatz_uwg = CAST(b.next_rang_ums_uwg AS INT64),
    rang_absatz_uwg = CAST(b.next_rang_abs_uwg AS INT64)
FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        kl_uwg_id,
        MAX(rang_umsatz_wg) AS next_rang_ums_wg,
        MAX(rang_umsatz_uwg) AS next_rang_ums_uwg,
        MAX(rang_absatz_uwg) AS next_rang_abs_uwg
    FROM `_artikel_anteil_uwg_ranking`
    GROUP BY
        mandant_id,
        kl_owg_id,
        kl_uwg_id
) AS b
WHERE
    `_sal_snap_final`.kl_uwg_id = b.kl_uwg_id AND `_sal_snap_final`.kl_owg_id = b.kl_owg_id AND `_sal_snap_final`.rang_umsatz_wg
    IS NULL AND `_sal_snap_final`.rang_umsatz_uwg IS NULL AND `_sal_snap_final`.rang_absatz_uwg IS NULL AND
    `_sal_snap_final`.mandant_id = b.mandant_id;


UPDATE `_sal_snap_final` SET
    rang_umsatz_wg = CAST(b.next_rang_ums_wg AS INT64)
FROM (
    SELECT
        mandant_id,
        kl_wg_id,
        MAX(rang_umsatz_wg) + 1 AS next_rang_ums_wg
    FROM `_artikel_anteil_uwg_ranking`
    GROUP BY
        mandant_id,
        kl_wg_id
) AS b
WHERE
    `_sal_snap_final`.kl_wg_id = b.kl_wg_id AND `_sal_snap_final`.rang_umsatz_wg IS NULL AND `_sal_snap_final`.mandant_id
    = b.mandant_id;


UPDATE `_sal_snap_final` SET
    rang_umsatz_uwg = CAST(b.next_rang_ums_uwg AS INT64),
    rang_absatz_uwg = CAST(b.next_rang_abs_uwg AS INT64)
FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        kl_uwg_id,
        COALESCE(CAST(MAX(rang_umsatz_uwg) AS BIGNUMERIC), 0) + 1 AS next_rang_ums_uwg,
        COALESCE(CAST(MAX(rang_absatz_uwg) AS BIGNUMERIC), 0) + 1 AS next_rang_abs_uwg
    FROM `_sal_snap_final` AS A
    WHERE rang_umsatz_uwg IS NULL
    GROUP BY
        mandant_id,
        kl_owg_id,
        kl_uwg_id
) AS b
WHERE
    `_sal_snap_final`.kl_uwg_id = b.kl_uwg_id AND `_sal_snap_final`.kl_owg_id = b.kl_owg_id AND `_sal_snap_final`.rang_umsatz_uwg
    IS NULL AND `_sal_snap_final`.rang_absatz_uwg IS NULL AND `_sal_snap_final`.mandant_id = b.mandant_id;


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    rang_umsatz_wg = CAST(b.next_rang_ums_wg AS INT64)
FROM (
    SELECT
        mandant_id,
        kl_wg_id,
        MAX(COALESCE(CAST(rang_umsatz_wg AS BIGNUMERIC), 0)) + 1 AS next_rang_ums_wg
    FROM `_sal_snap_final`
    GROUP BY
        mandant_id,
        kl_wg_id
) AS b
WHERE
    `_sal_snap_final0`.kl_wg_id = b.kl_wg_id AND `_sal_snap_final0`.rang_umsatz_wg IS NULL AND `_sal_snap_final0`.mandant_id
    = b.mandant_id;


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    rang_umsatz_uwg = CAST(b.next_rang_ums_uwg AS INT64),
    rang_absatz_uwg = CAST(b.next_rang_abs_uwg AS INT64)
FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        MAX(COALESCE(CAST(rang_umsatz_uwg AS BIGNUMERIC), 0)) + 1 AS next_rang_ums_uwg,
        MAX(COALESCE(CAST(rang_absatz_uwg AS BIGNUMERIC), 0)) + 1 AS next_rang_abs_uwg
    FROM `_sal_snap_final`
    GROUP BY
        mandant_id,
        kl_owg_id
) AS b
WHERE
    `_sal_snap_final0`.kl_owg_id = b.kl_owg_id AND `_sal_snap_final0`.rang_umsatz_uwg IS NULL AND `_sal_snap_final0`.rang_absatz_uwg
    IS NULL AND `_sal_snap_final0`.mandant_id = b.mandant_id;


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    schnelldreherquote_wg = CAST(b.schnelldreherquote_wg AS INT64),
    kolliabverkaufsquote_wg = CAST(b.kolliabverkaufsquote_wg AS INT64),
    abschriftsanteil_wg = CAST(b.abschriftsanteil_wg AS INT64) FROM (
    SELECT
        mandant_id,
        kl_wg_id,
        IFNULL(SUM(
            CAST(anz_wo_mit_absatz AS FLOAT64)) / IF(
            SUM(CAST(anz_wo_listung_2 AS FLOAT64)) = 0, NULL, SUM(CAST(anz_wo_listung_2 AS FLOAT64)
            )
        ), 0) AS schnelldreherquote_wg,
        CASE
            WHEN MAX(kol_la_bzw) IS NOT NULL
                THEN IFNULL(SUM(
                    rlz) / COUNT(*) * MAX(lagerprozent) * COALESCE(
                    SUM(total_af_absatz) / SUM(absatz_af_markt_wochen) /
                    7, SUM(total_sa_absatz) / SUM(absatz_sa_markt_tage)
                ) / IF(MAX(kol_la_bzw) = 0, NULL, MAX(kol_la_bzw)
                ), 0)
            ELSE IFNULL(SUM(
                rlz_dz) / COUNT(*) * COALESCE(
                SUM(total_af_absatz) / SUM(absatz_af_markt_wochen) / 7, SUM(total_sa_absatz
                ) / SUM(absatz_sa_markt_tage)
            ) / IF(MAX(kol_bst_bzw) = 0, NULL, MAX(kol_bst_bzw)
            ), 0)
        END AS kolliabverkaufsquote_wg,
        IFNULL(SUM(abschr_o_werb) / IF(SUM(kassenumsatz) = 0, NULL, SUM(kassenumsatz)), 0) AS abschriftsanteil_wg
    FROM `_sal_snap_final`
    GROUP BY
        mandant_id,
        kl_wg_id
) AS b
WHERE `_sal_snap_final0`.kl_wg_id = b.kl_wg_id AND `_sal_snap_final0`.mandant_id = b.mandant_id;


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    schnelldreherquote_owg = CAST(b.schnelldreherquote_owg AS INT64),
    kolliabverkaufsquote_owg = CAST(b.kolliabverkaufsquote_owg AS INT64),
    abschriftsanteil_owg = CAST(b.abschriftsanteil_owg AS INT64) FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        SUM(CAST(anz_wo_mit_absatz AS FLOAT64)) / SUM(CAST(anz_wo_listung_2 AS FLOAT64)) AS schnelldreherquote_owg,
        CAST(CASE
            WHEN MAX(kol_la_bzw) IS NOT NULL
                THEN IFNULL(SUM(
                    rlz) / COUNT(*) * MAX(lagerprozent) * COALESCE(
                    SUM(total_af_absatz) / SUM(absatz_af_markt_wochen) /
                    7, SUM(total_sa_absatz) / SUM(absatz_sa_markt_tage)
                ) / IF(MAX(kol_la_bzw) = 0, NULL, MAX(kol_la_bzw)
                ), 0)
            ELSE IFNULL(SUM(
                rlz_dz) / COUNT(*) * COALESCE(
                SUM(total_af_absatz) / SUM(absatz_af_markt_wochen) / 7, SUM(total_sa_absatz
                ) / SUM(absatz_sa_markt_tage)
            ) / IF(MAX(kol_bst_bzw) = 0, NULL, MAX(kol_bst_bzw)
            ), 0)
        END AS INT64) AS kolliabverkaufsquote_owg,
        IFNULL(SUM(abschr_o_werb) / IF(SUM(kassenumsatz) = 0, NULL, SUM(kassenumsatz)), 0) AS abschriftsanteil_owg
    FROM `_sal_snap_final`
    GROUP BY
        mandant_id,
        kl_owg_id
) AS b
WHERE `_sal_snap_final0`.kl_owg_id = b.kl_owg_id AND `_sal_snap_final0`.mandant_id = b.mandant_id;


/* Index SA */ /* Index AF */ CREATE OR REPLACE TEMPORARY TABLE _index01 (
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
    CAST(/* Index AF */ umsatz_af_pro_markt_woche AS FLOAT64) AS umsatz_af_pro_markt_woche,
    CAST(absatz_af_pro_markt_woche AS FLOAT64) AS absatz_af_pro_markt_woche,
    CAST(ertrag_af_pro_markt_woche AS FLOAT64) AS ertrag_af_pro_markt_woche,
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
    mandant_id,
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
    mandant_id,
    kl_wg_id;


CREATE OR REPLACE TEMPORARY TABLE _index03 AS
/* Index AF */ /* Index SA */ SELECT
    A.mandant_id,
    A.kl_wg_id,
    MAX(B.anz_art) AS anz_art_,
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
    SQRT(SUM(
        (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche) * (A.umsatz_af_pro_markt_woche - B.avg_umsatz_af_pro_markt_woche
        )
    ) / MAX(B.anz_art
    )) AS std_umsatz_af,
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
    SQRT(SUM(
        (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche) * (A.umsatz_sa_pro_markt_woche - B.avg_umsatz_sa_pro_markt_woche
        )
    ) / MAX(B.anz_art
    )) AS std_umsatz_sa,
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
INNER JOIN `_index02` AS B ON A.kl_wg_id = B.kl_wg_id AND A.mandant_id = B.mandant_id
GROUP BY
    A.mandant_id,
    A.kl_wg_id;


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
INNER JOIN `_index02` AS B ON A.kl_wg_id = B.kl_wg_id AND A.mandant_id = B.mandant_id
INNER JOIN `_index03` AS C ON A.kl_wg_id = C.kl_wg_id AND A.mandant_id = C.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _index05_af AS
SELECT
    mandant_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    MAX(l_af_quartil) AS l_af_quartil,
    MAX(m_af_quartil) AS m_af_quartil,
    MAX(h_af_quartil) AS h_af_quartil
FROM (
    SELECT DISTINCT
        A.mandant_id,
        A.kjmo AS kl_wg_id,
        A.art_matching_id AS kl_owg_id,
        A.kl_wg_id AS kl_uwg_id,
        CAST(PERCENTILE_CONT(A.index_af_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id, A.kl_wg_id) AS BIGNUMERIC)
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
            A.kl_wg_id = b.kl_wg_id AND A.kl_owg_id = b.kl_owg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.mandant_id
            = b.mandant_id AND A.index_af_tmp <= b.med_1
    UNION ALL
    SELECT
        A.mandant_id,
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id,
        MAX(0) AS l_af_quartil,
        MAX(t4.med_1) AS m_af_quartil,
        MAX(0) AS h_af_quartil
    FROM `_index04` AS A
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        kjmo AS kl_wg_id,
        art_matching_id AS kl_owg_id,
        kl_wg_id AS kl_uwg_id,
        PERCENTILE_CONT(index_af_tmp, 0.5) OVER (PARTITION BY mandant_id, kjmo, art_matching_id, kl_wg_id) AS med_1
    FROM `_index04`) AS t4
        ON
            A.kl_wg_id = t4.kl_wg_id AND A.kl_owg_id = t4.kl_owg_id AND A.kl_uwg_id = t4.kl_uwg_id
            AND A.mandant_id = t4.mandant_id AND A.index_af_tmp <= t4.med_1
    GROUP BY
        A.mandant_id,
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id
    UNION ALL
    SELECT DISTINCT
        A.mandant_id,
        A.kjmo AS kl_wg_id,
        A.art_matching_id AS kl_owg_id,
        A.kl_wg_id AS kl_uwg_id,
        0 AS l_af_quartil,
        0 AS m_af_quartil,
        PERCENTILE_CONT(A.index_af_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id, A.kl_wg_id)
            AS
            h_af_quartil
    FROM `_index04` AS A

    INNER JOIN (SELECT DISTINCT
        mandant_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id,
        PERCENTILE_CONT(index_af_tmp, 0.5) OVER (PARTITION BY mandant_id, kl_wg_id, kl_owg_id, kl_uwg_id) AS med_1
    FROM `_index04`) AS b

        ON
            A.kl_wg_id = b.kl_wg_id AND A.kl_owg_id = b.kl_owg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.mandant_id
            = b.mandant_id AND A.index_af_tmp > b.med_1
) AS x
GROUP BY
    mandant_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;


CREATE OR REPLACE TEMPORARY TABLE _index05_sa AS
SELECT
    mandant_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    MAX(l_sa_quartil) AS l_sa_quartil,
    MAX(m_sa_quartil) + 2 AS m_sa_quartil,
    MAX(h_sa_quartil) AS h_sa_quartil
FROM (
    SELECT DISTINCT
        A.mandant_id,
        A.kjmo AS kl_wg_id,
        A.art_matching_id AS kl_owg_id,
        A.kl_wg_id AS kl_uwg_id,
        CAST(PERCENTILE_CONT(A.index_sa_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id, A.kl_wg_id) AS BIGNUMERIC)
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
            A.kl_wg_id = b.kl_wg_id AND A.kl_owg_id = b.kl_owg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.mandant_id
            = b.mandant_id AND A.index_sa_tmp <= b.med_1
    UNION ALL
    SELECT
        A.mandant_id,
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id,
        MAX(0) AS l_sa_quartil,
        MAX(t4.med_1) AS m_sa_quartil,
        MAX(0) AS h_sa_quartil
    FROM `_index04` AS A
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        kjmo AS kl_wg_id,
        art_matching_id AS kl_owg_id,
        kl_wg_id AS kl_uwg_id,
        PERCENTILE_CONT(index_sa_tmp, 0.5) OVER (PARTITION BY mandant_id, kjmo, art_matching_id, kl_wg_id) AS med_1
    FROM `_index04`) AS t4
        ON
            A.kl_wg_id = t4.kl_wg_id AND A.kl_owg_id = t4.kl_owg_id AND A.kl_uwg_id = t4.kl_uwg_id
            AND A.mandant_id = t4.mandant_id AND A.index_sa_tmp <= t4.med_1
    GROUP BY
        A.mandant_id,
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id
    UNION ALL
    SELECT DISTINCT
        A.mandant_id,
        A.kjmo AS kl_wg_id,
        A.art_matching_id AS kl_owg_id,
        A.kl_wg_id AS kl_uwg_id,
        0 AS l_sa_quartil,
        0 AS m_sa_quartil,
        PERCENTILE_CONT(A.index_sa_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id, A.kl_wg_id)
            AS
            h_sa_quartil
    FROM `_index04` AS A
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id,
        PERCENTILE_CONT(index_af_tmp, 0.5) OVER (PARTITION BY mandant_id, kl_wg_id, kl_owg_id, kl_uwg_id) AS med_1
    FROM `_index04`) AS b
        ON
            A.kl_wg_id = b.kl_wg_id AND A.kl_owg_id = b.kl_owg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.mandant_id
            = b.mandant_id AND A.index_sa_tmp > b.med_1
) AS x
GROUP BY
    mandant_id,
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
    `_index04`.kl_wg_id = b.kl_wg_id AND `_index04`.kl_owg_id = b.kl_owg_id AND `_index04`.kl_uwg_id = b.kl_uwg_id AND
    `_index04`.mandant_id = b.mandant_id;


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
    `_index04`.kl_wg_id = b.kl_wg_id AND `_index04`.kl_owg_id = b.kl_owg_id AND `_index04`.kl_uwg_id = b.kl_uwg_id AND
    `_index04`.mandant_id = b.mandant_id;


UPDATE `_sal_snap_final` SET
    index_af_id = CAST(b.index_af AS INT64),
    index_sa_id = CAST(b.index_sa AS INT64) FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(index_af) AS index_af,
        MAX(index_sa) AS index_sa
    FROM `_index04`
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE `_sal_snap_final`.art_id = b.art_id AND `_sal_snap_final`.mandant_id = b.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_kl AS
SELECT
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    COUNT(DISTINCT x.kjmo) AS anz,
    COUNT(DISTINCT A.kjmo) AS anz_wochen,
    SUM(A.distr_gew) / COUNT(DISTINCT A.kjmo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.anz_maerkte) AS anz_maerkte,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK() OVER (
        PARTITION BY
            A.mandant_id, c.kl_owg_id ORDER BY
            SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto
            ) DESC
    ) AS rang_umsatz_uwg,
    DENSE_RANK()
        OVER (PARTITION BY A.mandant_id, c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS
    rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_2 AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag_2
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_2
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market_2 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo_2
        WHERE mandant_id > 1
        GROUP BY kjmo
        QUALIFY ((RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 1
GROUP BY
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_x AS
SELECT
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    COUNT(DISTINCT x.kjmo) AS anz,
    SUM(A.distr_gew) / COUNT(DISTINCT x.kjmo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK() OVER (
        PARTITION BY
            A.mandant_id, c.kl_owg_id ORDER BY
            SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto
            ) DESC
    ) AS rang_umsatz_uwg,
    DENSE_RANK()
        OVER (PARTITION BY A.mandant_id, c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS
    rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_2 AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag_2
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_2
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market_2 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo_2
        WHERE mandant_id > 1
        GROUP BY kjmo
        QUALIFY ((RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
GROUP BY
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _kl_ma_owg_1 AS
SELECT
    a.mandant_id,
    a.kl_owg_id,
    SUM(a.umsatz__) AS umsatz_x,
    SUM(b.umsatz_kl) AS umsatz_kl_x,
    IFNULL(SUM(b.umsatz_kl) / IF(SUM(a.umsatz__) = 0, NULL, SUM(a.umsatz__)), 0) * 100.00 AS marktanteil_owg
FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        SUM(umsatz_) AS umsatz__
    FROM `_artikel_anteil_uwg_ranking_x`
    GROUP BY
        mandant_id,
        kl_owg_id
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        kl_owg_id,
        SUM(umsatz_) AS umsatz_kl
    FROM `_artikel_anteil_uwg_ranking_kl`
    GROUP BY
        mandant_id,
        kl_owg_id
) AS b ON a.kl_owg_id = b.kl_owg_id AND a.mandant_id = b.mandant_id
GROUP BY
    a.mandant_id,
    a.kl_owg_id;


CREATE OR REPLACE TEMPORARY TABLE _kl_ma_uwg_1 AS
SELECT
    a.mandant_id,
    a.kl_owg_id,
    a.kl_uwg_id,
    SUM(a.umsatz__) AS umsatz_x,
    SUM(b.umsatz_kl) AS umsatz_kl_x,
    IFNULL(SUM(b.umsatz_kl) / IF(SUM(a.umsatz__) = 0, NULL, SUM(a.umsatz__)), 0) * 100.00 AS marktanteil_uwg
FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        kl_uwg_id,
        SUM(umsatz_) AS umsatz__
    FROM `_artikel_anteil_uwg_ranking_x`
    GROUP BY
        mandant_id,
        kl_owg_id,
        kl_uwg_id
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        kl_owg_id,
        kl_uwg_id,
        SUM(umsatz_) AS umsatz_kl
    FROM `_artikel_anteil_uwg_ranking_kl`
    GROUP BY
        mandant_id,
        kl_owg_id,
        kl_uwg_id
) AS b ON a.kl_owg_id = b.kl_owg_id AND a.kl_uwg_id = b.kl_uwg_id AND a.mandant_id = b.mandant_id
GROUP BY
    a.mandant_id,
    a.kl_owg_id,
    a.kl_uwg_id;


UPDATE `_sal_snap_final` SET
    marktanteilbewertung = CAST(b.indexpunkt AS INT64) FROM (
    SELECT
        A.mandant_id,
        B.kl_owg_id,
        B.kl_uwg_id,
        A.marktanteil_owg,
        B.marktanteil_uwg,
        IFNULL(B.marktanteil_uwg / IF(A.marktanteil_owg = 0, NULL, A.marktanteil_owg), 0) AS indexpunkt
    FROM `_kl_ma_owg_1` AS A
    INNER JOIN `_kl_ma_uwg_1` AS B ON A.kl_owg_id = B.kl_owg_id AND A.mandant_id = B.mandant_id
    GROUP BY
        A.mandant_id,
        B.kl_owg_id,
        B.kl_uwg_id,
        A.marktanteil_owg,
        B.marktanteil_uwg,
        indexpunkt
) AS b
WHERE
    `_sal_snap_final`.kl_uwg_id = b.kl_uwg_id AND `_sal_snap_final`.kl_owg_id = b.kl_owg_id AND `_sal_snap_final`.mandant_id
    = b.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _preis_wg_kl AS
SELECT
    mandant_id,
    kjmo,
    wg_id AS kl_owg_id,
    wug_id AS kl_uwg_id,
    ROUND(CAST(durchschnitt_preis_kasse AS BIGNUMERIC), 0) + 1 AS preis,
    COUNT(*) AS anz_artikel
FROM dbp_data.art_kl_preislage_zu_per_2 AS A
WHERE
    durchschnitt_preis_kasse IS NOT NULL
    AND kjmo IN (
        SELECT MAX(kjmo) AS kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo_2
        WHERE mandant_id > 1
    )
    AND mandant_id > 1
    AND (
        kjmo, kjwo_update) IN (
        SELECT (MAX(kjmo), MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id > 1
    )
GROUP BY
    mandant_id,
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    preis;


CREATE OR REPLACE TEMPORARY TABLE _preis_wg_nielsen AS
SELECT
    mandant_id,
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    ROUND(CAST(durchschnitt_preis_kasse AS BIGNUMERIC), 0) + 1 AS preis,
    COUNT(*) AS anz_artikel
FROM dbp_data.art_nielsen_preislage_zu_per_2 AS A
WHERE
    durchschnitt_preis_kasse IS NOT NULL
    AND (
        mandant_id, kjmo, art_matching_id) IN (
        SELECT (mandant_id, kjmo, art_matching_id)
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE
            kjmo IN (
                SELECT MAX(kjmo) AS kjmo
                FROM dbp_data.art_nielsen_fakten_kjmo_2
                WHERE mandant_id > 1
            )
            AND mandant_id > 1
            AND (
                kjmo, kjwo_update) IN (
                SELECT (MAX(kjmo), MAX(kjwo_update))
                FROM dbp_data.art_kl_preislage_zu_per_2
                WHERE mandant_id > 1
            )
        GROUP BY mandant_id,
        kjmo,
        art_matching_id
    )
    AND mandant_id > 1
GROUP BY
    mandant_id,
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    preis;


CREATE OR REPLACE TEMPORARY TABLE _preis_wg AS
SELECT
    COALESCE(A.mandant_id, B.mandant_id) AS mandant_id,
    COALESCE(A.kjmo, B.kjmo) AS kjmo,
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
FULL JOIN `_preis_wg_nielsen` AS B ON A.kjmo = B.kjmo AND A.kl_uwg_id = B.kl_uwg_id AND A.kl_owg_id = B.kl_owg_id AND A.preis = B.preis AND A.mandant_id = B.mandant_id;


UPDATE `_sal_snap_final` SET
    preislagenverteilung = CAST(b.preislage_id AS INT64)
FROM `_preis_wg` AS b
WHERE
    `_sal_snap_final`.kl_uwg_id = b.kl_uwg_id AND `_sal_snap_final`.kl_owg_id = b.kl_owg_id AND CAST(`_sal_snap_final`.durchschnittspreis AS BIGNUMERIC)
    = b.preis AND `_sal_snap_final`.mandant_id = b.mandant_id;


UPDATE `_sal_snap_final` SET
    preislagenverteilung = 2
WHERE preislagenverteilung = 0;


DROP TABLE IF EXISTS dbp_etl.sal_snap_final_kmo_2;


CREATE TABLE IF NOT EXISTS dbp_etl.sal_snap_final_kmo_2 AS
SELECT *
FROM `_sal_snap_final`;


DROP TABLE IF EXISTS dbp_etl.sal_snap2_kmo_2;


CREATE TABLE IF NOT EXISTS dbp_etl.sal_snap2_kmo_2 AS
SELECT *
FROM `_sal_snap_2`;


DROP TABLE IF EXISTS dbp_etl.sal_snap2_multis_2;


CREATE OR REPLACE TABLE dbp_etl.SAL_SNAP2_MULTIS_2
AS
SELECT *
FROM
    `_sal_snap_2_multis1`;
