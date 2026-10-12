CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _sal_1 AS
SELECT
    A.monat,
    A.anz_monate,
    A.wg_id,
    A.wug_id,
    A.art_nr,
    A.art_bez,
    A.art_status,
    A.akt_lieferant,
    A.zek,
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
    A.anz_wo_listung,
    A.anz_listung_as_is,
    A.kol_la_bzw,
    A.kol_bst_bzw,
    A.lagerprozent,
    A.td_update,
    A.td_insert,
    B.art_id,
    COALESCE(1 + IF(C.mwst = 0, NULL, C.mwst) / 100.0000, 1.19) AS multi_mwst
FROM dbp_etl.bf_sort_sal_export AS A
INNER JOIN dbp_data.art AS B
    ON
        CAST(A.art_nr AS STRING) = CAST(B.kl_art_id AS STRING) AND B.mandant_id
        = 1 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.mwst_per AS C
    ON
        C.mandant_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND C.dat_bis
        AND B.mwst_id = C.mwst_id
WHERE
    B.artikeltyp_id <> 12
    AND TRIM(A.art_status) NOT IN ('L', 'R');


CREATE OR REPLACE TEMPORARY TABLE _sal_2 AS
SELECT
    B.art_matching_id,
    A.art_id,
    TRIM(A.k_listung) AS k_listung,
    A.vk_pk_1,
    B.kl_art_kat_id,
    B.kl_wg_id,
    B.kl_owg_id,
    B.kl_uwg_id,
    COALESCE(A.total_umsatz_netto, 0) * A.multi_mwst AS umsatz_brutto,
    COALESCE(A.af_umsatz_netto, 0) * A.multi_mwst AS umsatz_brutto_af,
    COALESCE(A.sa_umsatz_netto, 0) * A.multi_mwst AS umsatz_brutto_sa,
    COALESCE(A.total_absatz, 0) AS menge,
    COALESCE(A.total_af_absatz, 0) AS menge_af,
    COALESCE(A.total_sa_absatz, 0) AS menge_sa,
    COUNT(A.art_id) OVER (
        PARTITION BY B.art_matching_id
        ORDER BY A.art_id IS NULL, A.art_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS anz_artikel
FROM `_sal_1` AS A
INNER JOIN dbp_etl.art_matching_nielsen_per AS B ON A.art_id = B.art_id;


CREATE OR REPLACE TEMPORARY TABLE _sal_3 AS
SELECT
    art_matching_id,
    MAX(kl_art_kat_id) AS kl_art_kat_id,
    MAX(kl_wg_id) AS kl_wg_id,
    MAX(kl_owg_id) AS kl_owg_id,
    MAX(kl_uwg_id) AS kl_uwg_id,
    MAX(CASE
        WHEN k_listung = 'N/A'
            THEN ''
        ELSE k_listung
    END) AS k_listung,
    AVG(vk_pk_1) AS vk_pk_1,
    SUM(umsatz_brutto) AS umsatz_brutto,
    SUM(umsatz_brutto_af) AS umsatz_brutto_af,
    SUM(umsatz_brutto_sa) AS umsatz_brutto_sa,
    SUM(menge) AS menge,
    SUM(menge_af) AS menge_af,
    SUM(menge_sa) AS menge_sa,
    MAX(anz_artikel) AS anz_artikel
FROM `_sal_2`
GROUP BY art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _chk AS
SELECT 1 AS k;


INSERT INTO `_chk` (k)
VALUES (2);


INSERT INTO `_chk` (k)
VALUES (3);


INSERT INTO `_chk` (k)
VALUES (4);


INSERT INTO `_chk` (k)
VALUES (5);


DELETE FROM dbp_data.art_kl_preislage_zu_per
WHERE kjmo IN (
    SELECT MIN(B.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
)
AND mandant_id = 1
AND kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche
    WHERE akt_wo = 1
);


INSERT INTO dbp_data.art_kl_preislage_zu_per (
    mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id,
    sm_id,
    ksm_id,
    owg_id,
    wg_id,
    wug_id,
    vk_brutto_pk_1,
    durchschnitt_preis_kasse,
    umsatz_brutto,
    umsatz_brutto_af,
    umsatz_brutto_sa, menge, menge_af, menge_sa
)
(
    SELECT
        1 AS mandant_id,
        A.art_matching_id,
        x.kjmo,
        Z.kjwo AS kjwo_update,
        'EUR' AS wrg_id,
        CASE
            WHEN A.k_listung = ''
                THEN 'N/A'
            ELSE A.k_listung
        END AS sm_id,
        '' AS ksm_id,
        A.kl_wg_id AS owg_id,
        A.kl_owg_id AS wg_id,
        A.kl_uwg_id AS wug_id,
        CAST(A.vk_pk_1 AS NUMERIC) AS vk_brutto_pk_1,
        CAST(CASE
            WHEN A.umsatz_brutto_af > 0 AND A.menge_af <> 0
                THEN A.umsatz_brutto_af / IF(A.menge_af = 0, NULL, A.menge_af)
            WHEN
                A.umsatz_brutto_af = 0
                AND A.umsatz_brutto_sa > 0
                AND A.menge_sa <> 0
                THEN A.umsatz_brutto_sa / IF(A.menge_sa = 0, NULL, A.menge_sa)
            ELSE IFNULL(A.umsatz_brutto / IF(A.menge = 0, NULL, A.menge), 0)
        END AS NUMERIC) AS durchschnitt_preis_kasse,
        CAST(A.umsatz_brutto AS NUMERIC) AS umsatz_brutto,
        CAST(A.umsatz_brutto_af AS NUMERIC) AS umsatz_brutto_af,
        CAST(A.umsatz_brutto_sa AS NUMERIC) AS umsatz_brutto_sa,
        ROUND(CAST(A.menge AS NUMERIC), 3) AS menge,
        ROUND(CAST(A.menge_af AS NUMERIC), 3) AS menge_af,
        ROUND(CAST(A.menge_sa AS NUMERIC), 3) AS menge_sa
    FROM `_sal_3` AS A
    INNER JOIN (
        SELECT MIN(B.kjmo) AS kjmo
        FROM (
            SELECT MAX(kjwo) AS kjwo
            FROM dbp_data.art_nielsen_fakten_kjwo
            WHERE mandant_id = 1
        ) AS a
        INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
    ) AS x
        ON TRUE
    INNER JOIN dbp_data.woche AS Z ON TRUE
    WHERE
        A.umsatz_brutto > 0
        AND A.menge > 0
        AND Z.akt_wo = 1
);


INSERT INTO dbp_data.art_kl_preislage_zu_per (
    mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id,
    sm_id,
    ksm_id,
    owg_id,
    wg_id,
    wug_id,
    vk_brutto_pk_1,
    durchschnitt_preis_kasse,
    umsatz_brutto,
    umsatz_brutto_af,
    umsatz_brutto_sa, menge, menge_af, menge_sa
)
(
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.kjmo,
        A.kjwo_update,
        'EUR' AS wrg_id,
        CAST(B.k AS STRING) AS sm_id,
        A.ksm_id,
        A.owg_id,
        A.wg_id,
        A.wug_id,
        A.vk_brutto_pk_1,
        A.durchschnitt_preis_kasse,
        A.umsatz_brutto,
        A.umsatz_brutto_af,
        A.umsatz_brutto_sa,
        A.menge,
        A.menge_af,
        A.menge_sa
    FROM dbp_data.art_kl_preislage_zu_per AS A
    INNER JOIN `_chk` AS B ON ROUND(CAST(A.sm_id AS BIGNUMERIC), 0) < B.k
    WHERE
        A.mandant_id = 1
        AND A.sm_id NOT IN ('N/A', '-1')
        AND (
            A.mandant_id,
            A.art_matching_id,
            A.kjmo,
            CAST(B.k AS BIGNUMERIC),
            A.kjwo_update
        ) NOT IN (SELECT (
            mandant_id,
            art_matching_id,
            kjmo,
            ROUND(CAST(sm_id AS BIGNUMERIC), 0),
            kjwo_update
        )
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE sm_id NOT IN ('N/A', '-1'))
);


DELETE FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE kjmo IN (
    SELECT MIN(B.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
)
AND mandant_id = 1
AND kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche
    WHERE akt_wo = 1
);


INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (
    mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id,
    sm_id,
    ksm_id,
    owg_id,
    wg_id,
    wug_id,
    vk_brutto_pk_1,
    durchschnitt_preis_kasse,
    umsatz_brutto,
    umsatz_brutto_af,
    umsatz_brutto_sa, menge, menge_af, menge_sa
)
(SELECT
    mandant_id,
    art_matching_id,
    kjmo,
    kjwo_update,
    wrg_id,
    sm_id,
    ksm_id,
    owg_id,
    wg_id,
    wug_id,
    vk_brutto_pk_1,
    durchschnitt_preis_kasse,
    umsatz_brutto,
    umsatz_brutto_af,
    umsatz_brutto_sa,
    menge,
    menge_af,
    menge_sa
FROM dbp_data.art_kl_preislage_zu_per
WHERE kjmo IN (
    SELECT MIN(B.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
)
AND mandant_id = 1
AND kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche
    WHERE akt_wo = 1
));


CREATE OR REPLACE TEMPORARY TABLE _nielsen_preise_1 AS
SELECT
    C.art_matching_id,
    MAX(C.kl_art_kat_id) AS kl_art_kat_id,
    MAX(C.kl_wg_id) AS kl_wg_id,
    MAX(C.kl_owg_id) AS kl_owg_id,
    MAX(C.kl_uwg_id) AS kl_uwg_id,
    SUM(A.menge) AS menge,
    SUM(A.menge_af) AS menge_af,
    SUM(A.menge_sa) AS menge_sa,
    SUM(A.umsatz_brutto) AS umsatz_brutto,
    SUM(A.umsatz_brutto_af) AS umsatz_brutto_af,
    SUM(A.umsatz_brutto_sa) AS umsatz_brutto_sa
FROM dbp_data.art_nielsen_fakten_kjwo AS A
INNER JOIN
    `_art_nielsen` AS B
    ON A.art_nielsen_id = B.art_nielsen_id AND A.mandant_id = B.mandant_id
INNER JOIN dbp_etl.art_matching_nielsen_per AS C
    ON
        B.art_nielsen_id = C.art_nielsen_id AND B.mandant_id
        = C.mandant_id
INNER JOIN
    dbp_data.nielsen_market AS D
    ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY
            (
                (RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1
            ) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 3
    AND A.mandant_id = 1
GROUP BY C.art_matching_id;


DELETE FROM dbp_data.art_nielsen_preislage_zu_per
WHERE kjmo IN (
    SELECT MIN(B.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
) AND mandant_id = 1;


INSERT INTO dbp_data.art_nielsen_preislage_zu_per (
    mandant_id, art_matching_id, kjmo, wrg_id,
    kl_art_kat_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    hwg_id,
    owg_id,
    wg_id,
    wug_id,
    durchschnitt_preis_kasse,
    umsatz_brutto,
    umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa
)
(
    SELECT
        1 AS mandant_id,
        A.art_matching_id,
        x.kjmo,
        'EUR' AS wrg_id,
        A.kl_art_kat_id,
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id,
        A.kl_art_kat_id AS hwg_id,
        A.kl_wg_id AS owg_id,
        A.kl_owg_id AS wg_id,
        A.kl_uwg_id AS wug_id,
        CAST(CASE
            WHEN A.umsatz_brutto_af > 0
                THEN A.umsatz_brutto_af / IF(A.menge_af = 0, NULL, A.menge_af)
            WHEN A.umsatz_brutto_af = 0 AND A.umsatz_brutto_sa > 0
                THEN A.umsatz_brutto_sa / IF(A.menge_sa = 0, NULL, A.menge_sa)
            ELSE 0
        END AS NUMERIC) AS durchschnitt_preis_kasse,
        A.umsatz_brutto,
        A.umsatz_brutto_af,
        A.umsatz_brutto_sa,
        A.menge,
        A.menge_af,
        A.menge_sa
    FROM `_nielsen_preise_1` AS A
    INNER JOIN (
        SELECT MIN(B.kjmo) AS kjmo
        FROM (
            SELECT MAX(kjwo) AS kjwo
            FROM dbp_data.art_nielsen_fakten_kjwo
            WHERE mandant_id = 1
        ) AS a
        INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
    ) AS x
        ON TRUE
    WHERE
        A.umsatz_brutto > 0
        AND A.menge > 0
);


UPDATE dbp_data.art_kl_preislage_zu_per SET
    sm_id = 'N/A'
WHERE sm_id = '-1';
