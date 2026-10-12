CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_kw_kmo (
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
    status,
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
FROM dbp_etl.art_matching_nielsen_per_kmo
WHERE
    art_id <> -1
    AND art_id IN (
        SELECT DISTINCT art_id
        FROM dbp_etl.kl_basis_listung_kmo
        WHERE mandant_id = ${mandant_id}
    )
    AND mandant_id = ${mandant_id};


/*--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied*/


CREATE OR REPLACE TEMPORARY TABLE _art_matching_nielsen_per_kmo AS
SELECT *
FROM dbp_etl.art_matching_nielsen_per_kmo
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl.art_matching_nielsen_per_kmo
)
AND mandant_id = ${mandant_id};


CREATE OR REPLACE TABLE dbp_etl_process.art_matching_nielsen_per_kmo_hierarchy (
    mandant_id INTEGER,
    art_matching_id INTEGER,
    art_id INTEGER,
    list_kz STRING(2),
    kl_wg_id INTEGER,
    kl_owg_id INTEGER,
    kl_uwg_id INTEGER
);


--step1


CREATE OR REPLACE TEMPORARY TABLE _min_list_kz AS
SELECT
    mandant_id,
    art_matching_id,
    MIN(list_kz) AS list_kz
FROM `_art_matching_nielsen_per_kmo`
WHERE
    art_id <> -1
    AND mandant_id = ${mandant_id}
GROUP BY
    mandant_id,
    art_matching_id;


--step2


CREATE OR REPLACE TEMPORARY TABLE _filtered_list_kz AS
SELECT *
FROM `_art_matching_nielsen_per_kmo`
WHERE (
    mandant_id, art_matching_id, list_kz) IN (
    SELECT (mandant_id, art_matching_id, list_kz)
    FROM `_min_list_kz`
);


---list_kz in ('A','B')

--step3


CREATE OR REPLACE TEMPORARY TABLE _kaufland_sales_data AS
SELECT
    A.mandant_id,
    c.art_id,
    SUM(A.umsatz_netto) AS umsatz_netto,
    SUM(A.menge) AS absatz
FROM dbp_data.artbew_mo_sum AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_art_matching_nielsen_per_kmo`
    WHERE art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c ON A.art_id = c.art_id AND A.mandant_id = c.mandant_id
WHERE (A.mandant_id, A.kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM dbp_data.art_nielsen_fakten_kjmo
    WHERE mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        kjmo
    QUALIFY ((RANK() OVER (PARTITION BY mandant_id ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
)
AND A.mandant_id > 1
GROUP BY
    A.mandant_id,
    c.art_id;


CREATE OR REPLACE TEMPORARY TABLE _filtered_umsatz AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    A.art_nielsen_id,
    A.gtin_id,
    A.kl_art_kat_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    A.umrech_faktor,
    A.status,
    A.list_kz,
    A.komponente_fg,
    A.kjwo_update,
    A.td_insert,
    A.td_update,
    B.umsatz_netto
FROM `_filtered_list_kz` AS A
LEFT JOIN `_kaufland_sales_data` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id;


--step4


CREATE OR REPLACE TEMPORARY TABLE _a_b AS
SELECT
    mandant_id,
    art_matching_id,
    MAX(umsatz_netto) AS umsatz_netto
FROM `_filtered_umsatz`
WHERE list_kz IN ('A', 'B')
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _a_b_full AS
SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id,
    list_kz,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_filtered_umsatz`
WHERE (
    mandant_id, art_matching_id, umsatz_netto) IN (
    SELECT (mandant_id, art_matching_id, umsatz_netto)
    FROM `_a_b`
);


INSERT INTO dbp_etl_process.art_matching_nielsen_per_kmo_hierarchy
(
    SELECT *
    FROM `_a_b_full`
    WHERE mandant_id = ${mandant_id}
);


---list_kz in ('C1','D1')


CREATE OR REPLACE TEMPORARY TABLE _nielsen_sales_data AS
SELECT
    A.mandant_id,
    c.art_nielsen_id,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_
FROM dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        art_matching_id
    FROM `_art_matching_nielsen_per_kmo`
    WHERE art_nielsen_id > -1
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_matching_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE (
    A.mandant_id, A.kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM dbp_data.art_nielsen_fakten_kjmo
    WHERE mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        kjmo
    QUALIFY ((
        RANK()
            OVER (PARTITION BY mandant_id ORDER BY mandant_id IS NULL, mandant_id, kjmo IS NULL DESC, kjmo DESC
            )
    ) * -1) BETWEEN -12 AND (-1)
)
AND D.nielsen_market_cluster_id = 1
AND A.mandant_id > 1
GROUP BY
    A.mandant_id,
    c.art_nielsen_id;


CREATE OR REPLACE TEMPORARY TABLE _filtered_umsatz_nielsen AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    A.art_nielsen_id,
    A.gtin_id,
    A.kl_art_kat_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    A.umrech_faktor,
    A.status,
    A.list_kz,
    A.komponente_fg,
    A.kjwo_update,
    A.td_insert,
    A.td_update,
    B.umsatz_ AS umsatz
FROM `_filtered_list_kz` AS A
LEFT JOIN `_nielsen_sales_data` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id;


--step5


CREATE OR REPLACE TEMPORARY TABLE _c1_d1 AS
SELECT
    mandant_id,
    art_matching_id,
    MAX(umsatz) AS umsatz
FROM `_filtered_umsatz_nielsen`
WHERE list_kz IN ('C1', 'D1')
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _c1_d1_full AS
SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id,
    art_nielsen_id,
    list_kz,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_filtered_umsatz_nielsen`
WHERE (
    mandant_id, art_matching_id, umsatz) IN (
    SELECT (mandant_id, art_matching_id, umsatz)
    FROM `_c1_d1`
);


--when 2 or more diffrent art_id has same art_nielsen_id with same sales data


CREATE OR REPLACE TEMPORARY TABLE _c1_d1_full_art AS
SELECT
    mandant_id,
    art_matching_id,
    MIN(art_id) AS art_id,
    art_nielsen_id,
    list_kz,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_c1_d1_full`
GROUP BY
    mandant_id,
    art_matching_id,
    art_nielsen_id,
    list_kz,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;


--when 2 or more diffrent art_nielsen_id has same sales data


CREATE OR REPLACE TEMPORARY TABLE _c1_d1_full_art_niel AS
SELECT
    mandant_id,
    art_matching_id,
    art_id,
    MAX(art_nielsen_id) AS art_nielsen_id,
    list_kz,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_c1_d1_full_art`
GROUP BY
    mandant_id,
    art_matching_id,
    art_id,
    list_kz,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;


INSERT INTO dbp_etl_process.art_matching_nielsen_per_kmo_hierarchy
(SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id,
    list_kz,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_c1_d1_full_art_niel`
WHERE mandant_id = ${mandant_id});


--step6


CREATE OR REPLACE TEMPORARY TABLE _c2_d2 AS
SELECT
    mandant_id,
    art_matching_id,
    MIN(art_id) AS art_id
FROM `_filtered_list_kz`
WHERE list_kz IN ('C2', 'D2')
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _c2_d2_full AS
SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id,
    list_kz,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_filtered_list_kz`
WHERE (
    mandant_id, art_matching_id, art_id) IN (
    SELECT (mandant_id, art_matching_id, art_id)
    FROM `_c2_d2`
);


INSERT INTO dbp_etl_process.art_matching_nielsen_per_kmo_hierarchy
(
    SELECT DISTINCT *
    FROM `_c2_d2_full`
    WHERE mandant_id = ${mandant_id}
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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
        FROM dbp_etl.art_matching_nielsen_per_kmo
        WHERE
            status = 'T'
            AND mandant_id = ${mandant_id}
            AND art_id <> -1
    ) AS a
    INNER JOIN
        dbp_data.art_wg_zu_per
            AS B
        ON
            a.mandant_id = B.mandant_id AND a.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
) AS b
WHERE
    `_art_leistung_1`.mandant_id = b.mandant_id AND `_art_leistung_1`.art_matching_id = b.art_matching_id AND
    `_art_leistung_1`.status = 'T';


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_art_leistung_1` SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND mandant_id = ${mandant_id}
        AND owg_id NOT IN (-1, -3)
) AS b
WHERE `_art_leistung_1`.mandant_id = b.mandant_id AND `_art_leistung_1`.kl_owg_id = b.wg_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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
FROM dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag
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
    FROM dbp_etl.art_matching_nielsen_per_kmo
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.mandant_id = ${mandant_id}
    AND A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id}
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_artikel_anteil_uwg_leistung_base1` SET
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg,
    distr_gew = CAST(b.distr_gew_ as INTEGER)
FROM `_artikel_anteil_uwg_ranking` AS b
WHERE
    `_artikel_anteil_uwg_leistung_base1`.art_nielsen_id = b.art_nielsen_id AND `_artikel_anteil_uwg_leistung_base1`.kl_uwg_id
    = b.kl_uwg_id AND `_artikel_anteil_uwg_leistung_base1`.mandant_id = b.mandant_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_artikel_anteil_uwg_leistung_base1` SET
    rang_umsatz_wg = b.rang_umsatz_wg
FROM `_artikel_anteil_wg_ranking` AS b
WHERE
    `_artikel_anteil_uwg_leistung_base1`.art_nielsen_id = b.art_nielsen_id AND `_artikel_anteil_uwg_leistung_base1`.mandant_id
    = b.mandant_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_artikel_anteil_uwg_ranking` SET
    rang_umsatz_wg = b.rang_umsatz_wg
FROM `_artikel_anteil_wg_ranking` AS b
WHERE `_artikel_anteil_uwg_ranking`.art_nielsen_id = b.art_nielsen_id AND `_artikel_anteil_uwg_ranking`.mandant_id = b.mandant_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_1 AS
SELECT
    b.art_matching_id,
    -- b.umrech_faktor,
    -- b.art_id,
    b.status,
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
FROM dbp_data.sal_kmo AS A
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
    FROM dbp_etl_process.art_sm_vw_zu_per
    WHERE
        mandant_id = ${mandant_id}
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
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
        status
    FROM `_art_leistung_1`
    GROUP BY
        mandant_id,
        art_matching_id,
        kl_art_id,
        art_id,
        status
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE A.kjmo IN (
    SELECT MIN(B.kjmo) AS kjmo
    FROM (
        SELECT COALESCE(a1.kjmo_nielsen, a2.kjmo_tag) AS kjmo
        FROM (
            SELECT MAX(kjmo) AS kjmo_nielsen
            FROM dbp_data.art_nielsen_fakten_kjmo
            WHERE mandant_id = ${mandant_id}
        ) AS a1
        INNER JOIN (
            SELECT MAX(kjmo) AS kjmo_tag
            FROM dbp_data.tag
            WHERE akt_mo = -1
        ) AS a2
            ON TRUE
    ) AS a
    INNER JOIN dbp_data.tag AS B ON a.kjmo = B.kjmo
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_2 AS
/* Kennzahlen */ SELECT
    A.mandant_id,
    A.art_matching_id,
    A.status,
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
    -- CAST(SUBSTR(akt_lieferant,1,INDEX(akt_lieferant,':')-1) AS INTEGER) AS gp_id,
    A.gp_name,
    A.zek_id AS zek,
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
    /* a.total_anz_markt AS anz_maerkte, */ A.distr_gew AS gewichtete_distribution,
    /* Index-AF */ 0 AS index_af_id,
    A.total_umsatz_netto_af / IF(
        A.total_anz_kjwo_wug_absatz = 0, NULL, A.total_anz_kjwo_wug_absatz) AS
    umsatz_af_pro_markt_woche,
    CAST(A.total_artbew_menge_af / IF(A.total_anz_kjwo_wug_absatz_af = 0, NULL, A.total_anz_kjwo_wug_absatz_af) AS NUMERIC)
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
    A.anz_kjwo_wup_listung AS anz_wo_listung,
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
LEFT JOIN dbp_data.art_spr_zu
    AS B ON A.art_id = B.art_id AND A.mandant_id = B.mandant_id AND B.spr_id
NOT IN (22, 24);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_2` SET
    bonreichweite_af = CAST(b.krw_af AS INTEGER),
    bonreichweite_sa = CAST(b.krw_sa AS INTEGER) FROM (
    SELECT
        mandant_id,
        kl_art_id,
        SUM(krw_af) AS krw_af,
        SUM(krw_sa) AS krw_sa,
        SUM(cpq_total) AS cpq_total,
        SUM(rb_total) AS rb_total
    FROM dbp_etl.kpi_aggregat_kmo
    WHERE
        mandant_id = ${mandant_id}
        AND kjmo_sort IN (
            SELECT MAX(kjmo_sort) AS a229457457
            FROM dbp_etl.kpi_aggregat_kmo
            WHERE mandant_id = ${mandant_id}
        )
    GROUP BY
        mandant_id,
        kl_art_id
) AS b
WHERE `_sal_snap_2`.kl_art_id = b.kl_art_id AND `_sal_snap_2`.mandant_id = b.mandant_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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
FROM dbp_etl.kpi_aggregat_kmo AS A
INNER JOIN dbp_data.art AS B
    ON
        A.mandant_id = B.mandant_id AND A.kl_art_id = B.kl_art_id AND B.dat_bis
        = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.art_wg_zu_per AS C
    ON
        A.mandant_id = C.mandant_id AND B.art_id = C.art_id AND C.arthiertyp_id
        = 2 AND C.dat_bis = PARSE_DATE('%F', '9999-12-31')
WHERE
    A.mandant_id = ${mandant_id}
    AND A.kjmo_sort IN (
        SELECT MAX(kjmo_sort) AS a229457457
        FROM dbp_etl.kpi_aggregat_kmo
        WHERE mandant_id = ${mandant_id}
    )
GROUP BY
    B.mandant_id,
    B.art_id,
    C.wg_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_2_multis AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.status,
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
    A.zek,
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
    A.anz_wo_listung,
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
    GROUP BY art_matching_id
    HAVING COUNT(*) > 1
) AS b
    ON A.art_matching_id = b.art_matching_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_2_multis` SET
    wug_id = b.wug_id,
    art_bez = b.art_bez,
    art_status = b.art_status,
    gp_id = b.gp_id,
    gp_name = b.gp_name,
    zek = b.zek,
    disc_pe = b.disc_pe,
    disc_marke = b.disc_marke,
    lcf = b.lcf,
    vegan = b.vegan,
    gluten = b.gluten,
    bio = b.bio,
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
    nord = b.nord FROM (
    SELECT
        Y.mandant_id,
        Y.art_matching_id,
        Y.status,
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
        Y.zek,
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
        Y.anz_wo_listung,
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
            X.kl_art_id,
            dat_von
        FROM `_sal_snap_2_multis` AS X
        INNER JOIN (SELECT
            art_id,
            MAX(dat_von) AS dat_von
        FROM dbp_data.art_wup_zu_per
        WHERE
            mandant_id = ${mandant_id}
            AND listung_id = 1
        GROUP BY art_id) AS y ON X.kl_art_id = CAST(FLOOR(y.art_id / 10) AS INTEGER)
        GROUP BY
            X.art_matching_id,
            X.kl_art_id,
            y.art_id,
            y.dat_von
        QUALIFY (ROW_NUMBER() OVER (
            PARTITION BY
                1 ORDER BY
                X.art_matching_id, y.dat_von IS NULL DESC, X.art_matching_id DESC, dat_von
                IS NULL DESC, dat_von DESC, X.kl_art_id IS NULL DESC, X.kl_art_id DESC
        )) = 1
    ) AS x1 ON Y.art_matching_id = x1.art_matching_id AND Y.kl_art_id = x1.kl_art_id
) AS b
WHERE `_sal_snap_2_multis`.art_matching_id = b.art_matching_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_etl.bf_listung_markt_kw_kmo (
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
    FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo AS V01
    INNER JOIN dbp_data.art_wg_zu_per AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id

    INNER JOIN dbp_data.wup AS V04
        ON
            V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
            = V04.mandant_id
    WHERE
        V01.mandant_id = ${mandant_id}
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen AS
SELECT
    A.kjwo,
    A.mandant_id,
    B.art_matching_id,
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
FROM dbp_etl.bf_listung_markt_kw_kmo AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_kmo AS B ON A.art_id = B.art_id AND A.mandant_id = B.mandant_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.woche
        WHERE akt_wo BETWEEN -52 AND (-1)
    )
    AND B.art_matching_id IN (
        SELECT art_matching_id
        FROM `_sal_snap_2_multis`
    )
GROUP BY
    A.kjwo,
    A.mandant_id,
    B.art_matching_id,
    A.wup_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TEMPORARY TABLE _woche AS
SELECT kjwo
FROM dbp_data.woche
WHERE akt_wo BETWEEN -52 AND (-1);


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre (
    kjwo INTEGER,
    matching_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT64
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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
    FROM dbp_etl.bf_listung_markt_kw_kmo AS A11
    INNER JOIN dbp_etl.art_matching_nielsen_per AS B ON A11.art_id = B.art_id AND A11.mandant_id = B.mandant_id

    WHERE
        A11.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu
            WHERE wg_filter_id = 11
        )
        AND A11.kjwo BETWEEN (
            SELECT MIN(kjwo)
            FROM `_woche`) AND (
            SELECT MAX(kjwo)
            FROM `_woche`
        )
        AND A11.mandant_id = ${mandant_id}
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


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre (
    kjwo INTEGER,
    matching_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_listung FLOAT64
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO zzsp08_pre
(
    SELECT
        A11.kjwo,
        B.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(COUNT(DISTINCT A11.kjwo) AS FLOAT64) AS anz_wo_listung
    FROM dbp_data.art_wup_listung_kjwo AS A11
    INNER JOIN dbp_etl.art_matching_nielsen_per_kmo AS B
        ON
            A11.mandant_id = B.mandant_id AND A11.art_id =
            B.art_id
    WHERE
        A11.mandant_id = ${mandant_id}
        AND A11.kjwo BETWEEN (
            SELECT MIN(kjwo)
            FROM `_woche`) AND (
            SELECT MAX(kjwo)
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _mm AS
SELECT
    A.kjwo,
    A.matching_id,
    A.mandant_id,
    A.wup_id,
    A.anz_wo_listung,
    B.anz_wo_mit_absatz
FROM zzsp08_pre AS A
INNER JOIN zzsp07_pre
    AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.matching_id AND A.wup_id = B.wup_id AND
A.kjwo = B.kjwo;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO `_mm`
(SELECT
    kjwo,
    matching_id,
    mandant_id,
    wup_id,
    anz_wo_listung,
    0
FROM zzsp08_pre
WHERE (
    kjwo, matching_id, mandant_id, wup_id) NOT IN (
    SELECT (kjwo, matching_id, mandant_id, wup_id)
    FROM `_mm`
));


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TEMPORARY TABLE zzsp07 (
    matching_id INTEGER,
    mandant_id INTEGER,
    anz_wo_mit_absatz FLOAT64
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TEMPORARY TABLE zzsp08 (
    matching_id INTEGER,
    mandant_id INTEGER,
    anz_wo_listung FLOAT64
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO zzsp08
(
    SELECT
        matching_id,
        mandant_id,
        SUM(anz_wo_listung) AS anz_wo_listung
    FROM `_mm` AS A11
    GROUP BY
        matching_id,
        mandant_id
);


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TEMPORARY TABLE zzoj09 (
    matching_id INTEGER,
    mandant_id INTEGER
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO zzoj09
(
    SELECT *
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
    ) AS t1
);


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TEMPORARY TABLE zzmd0a_xxx (
    matching_id INTEGER,
    mandant_id INTEGER,
    wjxbfs1 FLOAT64,
    anz_wo_listung FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    schnelldreherquote FLOAT64
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO zzmd0a_xxx
(
    SELECT
        PA11.matching_id,
        PA11.mandant_id,
        1.0 AS wjxbfs1,
        PA13.anz_wo_listung,
        PA12.anz_wo_mit_absatz,
        ROUND(PA12.anz_wo_mit_absatz / IF(PA13.anz_wo_listung = 0, NULL, PA13.anz_wo_listung) * 100, 1) AS schnelldreherquote
    FROM zzoj09 AS PA11
    LEFT JOIN zzsp07 AS PA12 ON PA11.matching_id = PA12.matching_id AND PA11.mandant_id = PA12.mandant_id
    LEFT JOIN zzsp08 AS PA13 ON PA11.matching_id = PA13.matching_id AND PA11.mandant_id = PA13.mandant_id
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_2_multis1 AS
-- REPLACE(TRIM((LISTAGG(LPAD(CAST(x.kl_art_id AS STRING(10)),8,'0'), ',') within group (ORDER BY x.kl_art_id) ), ','),' ', '') AS kl_art_id,

-- > muessen wir aendern!
-- > brutto!
SELECT
    X.mandant_id,
    X.art_matching_id,
    X.status,
    MAX(COALESCE(XXX.kl_wg_id, X.kl_wg_id)) AS kl_wg_id,
    MAX(COALESCE(XXX.kl_owg_id, X.kl_owg_id)) AS kl_owg_id,
    MAX(COALESCE(XXX.kl_uwg_id, X.kl_uwg_id)) AS kl_uwg_id,
    MAX(X.rang_umsatz_wg) AS rang_umsatz_wg,
    MAX(X.rang_umsatz_uwg) AS rang_umsatz_uwg,
    MAX(X.rang_absatz_uwg) AS rang_absatz_uwg,
    MAX(COALESCE(XXX.art_id, X.art_id)) AS art_id,
    -- REPLACE(trim(STRING_AGG(LPAD(SUBSTR(CAST(ROUND(CAST(lpad(CAST( x.kl_art_id as STRING), 8, '0') as BIGNUMERIC), 0) as STRING), 1, 8), 8, '0'), ',' ORDER BY if(x.kl_art_id IS NULL, 0, 1) DESC, x.kl_art_id), ','), ' ', '') AS kl_art_id,

    -- REPLACE(TRIM((LISTAGG(lpad(cast(cast(LPAD(CAST(x.kl_art_id AS STRING(600)),8,'0') as INTEGER) as STRING(8)),8,'0'), ',') within group (ORDER BY x.kl_art_id) ), ','),' ', '') AS kl_art_id,

    -- mfialkiewicz CAST to Varchar12
    REPLACE(trim(STRING_AGG(LPAD(SUBSTR(CAST(ROUND(CAST(lpad(CAST(x.kl_art_id as STRING), 8, '0') as BIGNUMERIC), 0) as STRING), 1, 8), 8, '0'), ',' ORDER BY if(x.kl_art_id IS NULL, 0, 1) DESC, x.kl_art_id), ','), ' ', '') AS kl_art_id,
    MAX(COALESCE(XXX.kl_uwg_id, X.wug_id)) AS wug_id,
    MAX(X.art_bez) AS art_bez,
    MAX(X.sm_id) AS sm_id,
    MAX(X.ksm_id) AS ksm_id,
    MAX(X.art_status) AS art_status,
    MAX(X.gp_id) AS gp_id,
    MAX(X.gp_name) AS gp_name,
    MAX(X.zek) AS zek,
    MAX(X.disc_pe) AS disc_pe,
    MAX(X.disc_marke) AS disc_marke,
    MAX(X.lcf) AS lcf,
    MAX(X.vegan) AS vegan,
    MAX(X.gluten) AS gluten,
    MAX(X.bio) AS bio,
    MAX(X.eigenmarke) AS eigenmarke,
    MAX(X.tierwohl) AS tierwohl,
    MAX(X.posten_food) AS posten_food,
    MAX(X.posten_nonfood) AS posten_nonfood,
    MAX(X.mwst) AS mwst,
    MAX(X.k_listung) AS k_listung,
    MAX(X.ost_basis) AS ost_basis,
    MAX(X.ost_gross) AS ost_gross,
    MAX(X.sued_ost) AS sued_ost,
    MAX(X.sued_west) AS sued_west,
    MAX(X.west) AS west,
    MAX(X.nord) AS nord,
    IFNULL(SUM(X.gewichtete_distribution) / IF(COUNT(*) = 0, NULL, COUNT(*)), 0) AS gewichtete_distribution,
    MAX(X.index_af_id) AS index_af_id,
    IFNULL(SUM(X.af_umsatz_netto) / IF(MAX(Y.anzahl_wochen_mit_umsatz_af) = 0, NULL, MAX(Y.anzahl_wochen_mit_umsatz_af)), 0
    ) AS umsatz_af_pro_markt_woche_,
    IFNULL(SUM(X.total_af_absatz) / IF(MAX(Y.anzahl_wochen_mit_absatz_af) = 0, NULL, MAX(Y.anzahl_wochen_mit_absatz_af)), 0
    ) AS absatz_af_pro_markt_woche_,
    IFNULL(
        MAX(Y.ertrag_af) / IF(MAX(Y.anzahl_wochen_mit_ertrag_af) = 0, NULL, MAX(Y.anzahl_wochen_mit_ertrag_af)), 0) AS
    ertrag_af_pro_markt_woche_,
    SUM(X.bonreichweite_af) AS bonreichweite_af,
    IFNULL(IFNULL(
        MAX(Y.ertrag_af) / IF(MAX(Y.anzahl_wochen_mit_ertrag_af) = 0, NULL, MAX(Y.anzahl_wochen_mit_ertrag_af)),
        0) / IF(
        IFNULL(SUM(
            X.af_umsatz_netto) / IF(MAX(Y.anzahl_wochen_mit_umsatz_af) = 0, NULL, MAX(Y.anzahl_wochen_mit_umsatz_af
        )), 0) = 0, NULL, IFNULL(SUM(X.af_umsatz_netto) / IF(
            MAX(Y.anzahl_wochen_mit_umsatz_af) = 0, NULL, MAX(Y.anzahl_wochen_mit_umsatz_af
            )
        ), 0)
    ), 0) AS spanne_af,
    MAX(X.index_sa_id) AS index_sa_id,
    IFNULL(SUM(X.sa_umsatz_netto) / IF(MAX(Y.anzahl_wochen_mit_umsatz_sa) = 0, NULL, MAX(Y.anzahl_wochen_mit_umsatz_sa)), 0
    ) AS umsatz_sa_pro_markt_woche_,
    IFNULL(SUM(X.total_sa_absatz) / IF(MAX(Y.anzahl_wochen_mit_absatz_sa) = 0, NULL, MAX(Y.anzahl_wochen_mit_absatz_sa)), 0
    ) AS absatz_sa_pro_markt_woche_,
    IFNULL(
        MAX(Y.ertrag_sa) / IF(MAX(Y.anzahl_wochen_mit_ertrag_sa) = 0, NULL, MAX(Y.anzahl_wochen_mit_ertrag_sa)), 0) AS
    ertrag_sa_pro_markt_woche_,
    SUM(X.bonreichweite_sa) AS bonreichweite_sa,
    IFNULL(IFNULL(
        MAX(Y.ertrag_sa) / IF(MAX(Y.anzahl_wochen_mit_ertrag_sa) = 0, NULL, MAX(Y.anzahl_wochen_mit_ertrag_sa)),
        0) / IF(
        IFNULL(SUM(
            X.sa_umsatz_netto) / IF(MAX(Y.anzahl_wochen_mit_umsatz_sa) = 0, NULL, MAX(Y.anzahl_wochen_mit_umsatz_sa
        )), 0) = 0, NULL, IFNULL(SUM(X.sa_umsatz_netto) / IF(
            MAX(Y.anzahl_wochen_mit_umsatz_sa) = 0, NULL, MAX(Y.anzahl_wochen_mit_umsatz_sa
            )
        ), 0)
    ), 0) AS spanne_sa,
    IFNULL(SUM(X.total_sa_absatz) / IF(SUM(X.absatz_total) = 0, NULL, SUM(X.absatz_total)), 0) AS aktionsanteil_absatz,
    SUM(X.absatz_total) AS absatz_total,
    IFNULL(SUM(
        CAST(X.anz_wo_mit_absatz AS FLOAT64)) / IF(
        SUM(CAST(X.anz_wo_listung AS FLOAT64)) = 0, NULL, SUM(CAST(X.anz_wo_listung AS FLOAT64)
        )
    ), 0) AS schnelldreherquote,
    SUM(X.schnelldreherquote_wg) AS schnelldreherquote_wg,
    SUM(X.schnelldreherquote_owg) AS schnelldreherquote_owg,
    CASE
        WHEN MAX(X.kol_la_bzw) IS NOT NULL
            THEN IFNULL(MAX(
                X.rlz) / COUNT(*) * MAX(X.lagerprozent) * COALESCE(SUM(X.total_af_absatz) / SUM(X.absatz_af_markt_wochen
            ) / 6, SUM(X.total_sa_absatz) / SUM(X.absatz_sa_markt_tage)) / IF(
                MAX(X.kol_la_bzw) = 0, NULL, MAX(X.kol_la_bzw
                )
            ), 0)
        ELSE IFNULL(MAX(
            X.rlz_dz) / COUNT(*) * COALESCE(
            SUM(X.total_af_absatz) / SUM(X.absatz_af_markt_wochen) / 6, SUM(X.total_sa_absatz
            ) / SUM(X.absatz_sa_markt_tage)
        ) / IF(MAX(X.kol_bst_bzw) = 0, NULL, MAX(X.kol_bst_bzw)
        ), 0)
    END AS kolliabverkaufsquote,
    SUM(X.kolliabverkaufsquote_wg) AS kolliabverkaufsquote_wg,
    SUM(X.kolliabverkaufsquote_owg) AS kolliabverkaufsquote_owg,
    IFNULL(SUM(X.abschr_o_werb) / IF(SUM(X.kassenumsatz) = 0, NULL, SUM(X.kassenumsatz)), 0) AS abschriftsanteil,
    SUM(X.abschriftsanteil_wg) AS abschriftsanteil_wg,
    SUM(X.abschriftsanteil_owg) AS abschriftsanteil_owg,
    SUM(X.cherrypicker_quote) / COUNT(*) AS cherrypicker_quote,
    SUM(X.cherrypicker_quote_wg) AS cherrypicker_quote_wg,
    SUM(X.cherrypicker_quote_owg) AS cherrypicker_quote_owg,
    SUM(X.restbon) AS restbon,
    SUM(X.restbon_wg) AS restbon_wg,
    SUM(X.restbon_owg) AS restbon_owg,
    MAX(X.vk_preis) AS vk_preis,
    CASE
        WHEN SUM(X.af_umsatz_netto) <> 0
            THEN IFNULL(SUM(
                X.af_umsatz_netto * ((100 + X.mwst) / 100)) / IF(
                SUM(X.total_af_absatz) = 0, NULL, SUM(X.total_af_absatz
                )
            ), 0)
        ELSE IFNULL(SUM(
            X.sa_umsatz_netto * ((100 + X.mwst) / 100)) / IF(
            SUM(X.total_sa_absatz) = 0, NULL, SUM(X.total_sa_absatz
            )
        ), 0)
    END AS durchschnittspreis,
    SUM(X.preislagenverteilung) AS preislagenverteilung,
    SUM(X.marktanteilbewertung) AS marktanteilbewertung,
    SUM(X.anz_wo_mit_absatz) AS anz_wo_mit_absatz,
    SUM(X.anz_wo_listung) AS anz_wo_listung,
    MAX(X.kol_la_bzw) AS kol_la_bzw,
    MAX(X.kol_bst_bzw) AS kol_bst_bzw,
    MAX(X.rlz_dz) AS rlz_dz,
    MAX(X.rlz) AS rlz,
    MAX(X.lagerprozent) AS lagerprozent,
    SUM(X.total_absatz_af_mt_wo) AS total_absatz_af_mt_wo,
    SUM(X.total_absatz_sa_mt_tag) AS total_absatz_sa_mt_tag,
    SUM(X.total_af_absatz) AS total_af_absatz,
    SUM(X.total_sa_absatz) AS total_sa_absatz,
    SUM(X.af_umsatz_netto) AS af_umsatz_netto,
    SUM(X.sa_umsatz_netto) AS sa_umsatz_netto,
    SUM(X.absatz_sa_markt_tage) AS absatz_sa_markt_tage,
    SUM(X.absatz_af_markt_wochen) AS absatz_af_markt_wochen,
    SUM(X.abschr_o_werb) AS abschr_o_werb,
    SUM(X.kassenumsatz) AS kassenumsatz
FROM `_sal_snap_2_multis` AS X
LEFT JOIN dbp_etl_process.art_matching_nielsen_per_kmo_hierarchy AS XXX
    ON
        X.mandant_id = XXX.mandant_id
        AND X.art_matching_id = XXX.art_matching_id
LEFT JOIN `_step1` AS Z ON X.mandant_id = Z.mandant_id AND X.art_id = Z.art_id
LEFT JOIN `_anz_wochen1` AS Y ON X.art_matching_id = Y.art_matching_id AND X.mandant_id = Y.mandant_id
GROUP BY
    X.mandant_id,
    X.art_matching_id,
    X.status;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_2_multis1` SET
    schnelldreherquote = b.sdq / 100 FROM (SELECT
    schnelldreherquote AS sdq,
    matching_id
FROM zzmd0a_xxx) AS b
WHERE `_sal_snap_2_multis1`.art_matching_id = b.matching_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM `_sal_snap_2`
WHERE art_matching_id IN (
    SELECT art_matching_id
    FROM `_sal_snap_2_multis1`
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _sal_snap_final AS
SELECT
    A.mandant_id,
    D.kjmo_sort AS kjmo,
    A.art_matching_id /* ,' ' AS status
      ,umrech_faktor */,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    A.rang_umsatz_wg,
    CAST(A.rang_umsatz_uwg AS INTEGER) as rang_umsatz_uwg,
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
    A.zek AS zek_id,
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
    CAST(A.cherrypicker_quote AS FLOAT64) as cherrypicker_quote,
    A.cherrypicker_quote_wg,
    A.cherrypicker_quote_owg,
    A.restbon,
    A.restbon_wg,
    A.restbon_owg,
    A.vk_preis,
    CAST(A.durchschnittspreis as NUMERIC) as durchschnittspreis,
    A.preislagenverteilung,
    A.marktanteilbewertung /* zur Berechnung */,
    A.anz_wo_mit_absatz,
    A.anz_wo_listung,
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
    FROM dbp_data.art_nielsen_fakten_kjmo
    WHERE mandant_id = ${mandant_id}
) AS c
    ON TRUE
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS D ON c.max_kjmo = D.kjmo_sort;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO `_sal_snap_final`
(
    SELECT
        A.mandant_id,
        D.kjmo_sort AS kjmo,
        A.art_matching_id /* ,' ' AS status
        ,umrech_faktor */,
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id,
        A.rang_umsatz_wg,
        CAST(A.rang_umsatz_uwg AS INTEGER) as rang_umsatz_uwg,
        A.rang_absatz_uwg,
        A.art_id,
        CAST(SUBSTR(A.kl_art_id, 1, 300) AS STRING) AS kl_art_id,
        A.wug_id,
        A.art_bez,
        A.art_status,
        A.sm_id,
        A.ksm_id,
        A.gp_id,
        A.gp_name,
        A.zek AS zek_id,
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
        CAST(A.nord AS STRING) /* ,anz_maerkte */,
        CAST(A.gewichtete_distribution AS INT64),
        A.index_af_id,
        A.umsatz_af_pro_markt_woche_,
        CAST(A.absatz_af_pro_markt_woche_ AS NUMERIC),
        A.ertrag_af_pro_markt_woche_,
        A.bonreichweite_af,
        A.spanne_af,
        A.index_sa_id,
        A.umsatz_sa_pro_markt_woche_,
        A.absatz_sa_pro_markt_woche_,
        A.ertrag_sa_pro_markt_woche_,
        A.bonreichweite_sa,
        A.spanne_sa,
        A.aktionsanteil_absatz,
        A.absatz_total,
        ROUND(CAST(A.schnelldreherquote AS NUMERIC), 5) AS schnelldreherquote,
        A.schnelldreherquote_wg,
        A.schnelldreherquote_owg,
        CAST(A.kolliabverkaufsquote AS NUMERIC),
        A.kolliabverkaufsquote_wg,
        A.kolliabverkaufsquote_owg,
        ROUND(CAST(A.abschriftsanteil AS NUMERIC), 0) AS abschriftsanteil,
        A.abschriftsanteil_wg,
        A.abschriftsanteil_owg,
        A.cherrypicker_quote,
        A.cherrypicker_quote_wg,
        A.cherrypicker_quote_owg,
        A.restbon,
        A.restbon_wg,
        A.restbon_owg,
        A.vk_preis,
        CAST(A.durchschnittspreis AS NUMERIC) as durchschnittspreis,
        A.preislagenverteilung,
        A.marktanteilbewertung /* zur Berechnung */,
        A.anz_wo_mit_absatz,
        A.anz_wo_listung,
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
    FROM `_sal_snap_2_multis1` AS A
    INNER JOIN (
        SELECT MAX(kjmo) AS max_kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id}
    ) AS c
        ON TRUE
    INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS D ON c.max_kjmo = D.kjmo_sort
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id FROM (
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` SET
    rang_umsatz_wg = b.rang_umsatz_wg,
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg,
    gewichtete_distribution = b.distr_gew FROM (
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` SET
    rang_umsatz_wg = b.next_rang_ums_wg,
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg FROM (
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` SET
    rang_umsatz_wg = b.next_rang_ums_wg FROM (
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` SET
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        kl_uwg_id,
        COALESCE(CAST(MAX(rang_umsatz_uwg) AS INTEGER), 0) + 1 AS next_rang_ums_uwg,
        COALESCE(CAST(MAX(rang_absatz_uwg) AS INTEGER), 0) + 1 AS next_rang_abs_uwg
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    rang_umsatz_wg = b.next_rang_ums_wg FROM (
    SELECT
        mandant_id,
        kl_wg_id,
        MAX(COALESCE(CAST(rang_umsatz_wg AS INTEGER), 0)) + 1 AS next_rang_ums_wg
    FROM `_sal_snap_final`
    GROUP BY
        mandant_id,
        kl_wg_id
) AS b
WHERE
    `_sal_snap_final0`.kl_wg_id = b.kl_wg_id AND `_sal_snap_final0`.rang_umsatz_wg IS NULL AND `_sal_snap_final0`.mandant_id
    = b.mandant_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        MAX(COALESCE(CAST(rang_umsatz_uwg AS INTEGER), 0)) + 1 AS next_rang_ums_uwg,
        MAX(COALESCE(CAST(rang_absatz_uwg AS INTEGER), 0)) + 1 AS next_rang_abs_uwg
    FROM `_sal_snap_final`
    GROUP BY
        mandant_id,
        kl_owg_id
) AS b
WHERE
    `_sal_snap_final0`.kl_owg_id = b.kl_owg_id AND `_sal_snap_final0`.rang_umsatz_uwg IS NULL AND `_sal_snap_final0`.rang_absatz_uwg
    IS NULL AND `_sal_snap_final0`.mandant_id = b.mandant_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    schnelldreherquote_wg = CAST(b.schnelldreherquote_wg AS INT64),
    kolliabverkaufsquote_wg = CAST(b.kolliabverkaufsquote_wg AS INT64),
    abschriftsanteil_wg = CAST(b.abschriftsanteil_wg AS INT64) FROM (
    SELECT
        mandant_id,
        kl_wg_id,
        IFNULL(SUM(
            CAST(anz_wo_mit_absatz AS INT64)) / IF(
            SUM(CAST(anz_wo_listung AS INT64)) = 0, NULL, SUM(CAST(anz_wo_listung AS INT64)
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` AS `_sal_snap_final0` SET
    schnelldreherquote_owg = CAST(b.schnelldreherquote_owg AS INT64),
    kolliabverkaufsquote_owg = CAST(b.kolliabverkaufsquote_owg AS INT64),
    abschriftsanteil_owg = CAST(b.abschriftsanteil_owg AS INT64) FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        SUM(CAST(anz_wo_mit_absatz AS FLOAT64)) / SUM(CAST(anz_wo_listung AS FLOAT64)) AS schnelldreherquote_owg,
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
        END AS kolliabverkaufsquote_owg,
        IFNULL(SUM(abschr_o_werb) / IF(SUM(kassenumsatz) = 0, NULL, SUM(kassenumsatz)), 0) AS abschriftsanteil_owg
    FROM `_sal_snap_final`
    GROUP BY
        mandant_id,
        kl_owg_id
) AS b
WHERE `_sal_snap_final0`.kl_owg_id = b.kl_owg_id AND `_sal_snap_final0`.mandant_id = b.mandant_id;


--[OK] statement is translated correctly (syntax and type checks are fine)


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _index02 AS
/* Index AF */ /* Index SA */ SELECT
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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
    INNER JOIN (
        SELECT
            mandant_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            PERCENTILE_CONT(index_af_tmp, 0.5) OVER () AS med_1
        FROM `_index04`
        GROUP BY
            mandant_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            index_af_tmp
    ) AS b
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
    INNER JOIN (
        SELECT
            mandant_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            PERCENTILE_CONT(index_af_tmp, 0.5) OVER () AS med_1
        FROM `_index04`
        GROUP BY
            mandant_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id,
            index_af_tmp
    ) AS b
        ON
            A.kl_wg_id = b.kl_wg_id AND A.kl_owg_id = b.kl_owg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.mandant_id
            = b.mandant_id AND A.index_af_tmp > b.med_1
) AS x
GROUP BY
    mandant_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


-- CREATE OR REPLACE TEMPORARY TABLE _index05_sa AS
-- SELECT mandant_id,
--  kl_wg_id,
--  kl_owg_id,
--  kl_uwg_id,
--  MAX(l_sa_quartil) AS l_sa_quartil,
--   MAX(m_sa_quartil) + 3 AS m_sa_quartil,
--  MAX(h_sa_quartil) AS h_sa_quartil
-- FROM (SELECT DISTINCT A.mandant_id,
--     A.kjmo AS kl_wg_id,
--     A.art_matching_id AS kl_owg_id,
--     A.kl_wg_id AS kl_uwg_id,
--     CAST(PERCENTILE_CONT(A.index_sa_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id, A.kl_wg_id) AS BIGNUMERIC)
--     AS l_sa_quartil,
--     0 AS m_sa_quartil,
--     0 AS h_sa_quartil
--    FROM `_index04` AS A
--     INNER JOIN (SELECT mandant_id,
--       kl_wg_id,
--       kl_owg_id,
--       kl_uwg_id,
--       CAST(PERCENTILE_CONT(A.index_sa_tmp, 0.5)OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id, A.kl_wg_id) AS BIGNUMERIC)AS med_1
--      FROM `_index04`
--      GROUP BY mandant_id,
--       kl_wg_id,
--       kl_owg_id,
--       kjmo,
--       art_matching_id,
--       kl_uwg_id,
--       index_sa_tmp) AS b ON A.kl_wg_id = b.kl_wg_id AND A.kl_owg_id = b.kl_owg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.mandant_id
--         = b.mandant_id AND A.index_sa_tmp <= b.med_1
--    UNION ALL
--    SELECT A.mandant_id,
--     A.kl_wg_id,
--     A.kl_owg_id,
--     A.kl_uwg_id,
--     MAX(0) AS l_sa_quartil,
--     MAX(t4.med_1) AS m_sa_quartil,
--     MAX(0) AS h_sa_quartil
--    FROM `_index04` AS A
--     INNER JOIN (SELECT DISTINCT mandant_id,
--       kjmo AS kl_wg_id,
--       art_matching_id AS kl_owg_id,
--       kl_wg_id AS kl_uwg_id,
--       PERCENTILE_CONT(index_sa_tmp, 0.5) OVER (PARTITION BY mandant_id, kjmo, art_matching_id, kl_wg_id) AS med_1
--      FROM `_index04`) AS t4 ON A.kl_wg_id = t4.kl_wg_id AND A.kl_owg_id = t4.kl_owg_id AND A.kl_uwg_id = t4.kl_uwg_id
--       AND A.mandant_id = t4.mandant_id AND A.index_sa_tmp <= t4.med_1
--    GROUP BY A.mandant_id,
--     A.kl_wg_id,
--     A.kl_owg_id,
--     A.kjmo,
--     A.art_matching_id,
--     A.kl_uwg_id
--    UNION ALL
--    SELECT DISTINCT A.mandant_id,
--     A.kjmo AS kl_wg_id,
--     A.art_matching_id AS kl_owg_id,
--     A.kl_wg_id AS kl_uwg_id,
--     0 AS l_sa_quartil,
--     0 AS m_sa_quartil,
--     PERCENTILE_CONT(A.index_sa_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id, A.kl_wg_id) AS
--     h_sa_quartil
--    FROM `_index04` AS A
--     INNER JOIN (SELECT mandant_id,
--       kl_wg_id,
--       kl_owg_id,
--       kjmo,
--       art_matching_id,
--       kl_uwg_id,
--       PERCENTILE_CONT(A.index_sa_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id, A.kl_wg_id) AS med_1 
--      FROM `_index04` AS A
--      GROUP BY mandant_id,
--       kl_wg_id,
--       kl_owg_id,
--       kjmo,
--       art_matching_id,
--       kl_uwg_id,
--       index_sa_tmp) AS b ON A.kl_wg_id = b.kl_wg_id AND A.kl_owg_id = b.kl_owg_id AND A.kl_uwg_id = b.kl_uwg_id AND A.mandant_id
--         = b.mandant_id AND A.index_sa_tmp > b.med_1) AS x
-- GROUP BY mandant_id,
--  kl_wg_id,
--  kl_owg_id,
-- --  kjmo,
-- --  art_matching_id,
--  kl_uwg_id;


CREATE OR REPLACE TEMPORARY TABLE _index05_sa AS
WITH base_with_median AS (
    SELECT
        *,
        PERCENTILE_CONT(index_sa_tmp, 0.5) OVER (
            PARTITION BY mandant_id, kjmo, art_matching_id, kl_wg_id
        ) AS med_1_group
    FROM `_index04`
),

quartile_union AS (
    SELECT DISTINCT
        A.mandant_id,
        A.kjmo AS kl_wg_id,
        A.art_matching_id AS kl_owg_id,
        A.kl_wg_id AS kl_uwg_id,
        CAST(PERCENTILE_CONT(A.index_sa_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id, A.kl_wg_id) AS BIGNUMERIC) AS l_sa_quartil,
        0 AS m_sa_quartil,
        0 AS h_sa_quartil
    FROM base_with_median AS A
    WHERE A.index_sa_tmp <= A.med_1_group
    UNION ALL
    SELECT DISTINCT
        A.mandant_id,
        A.kjmo AS kl_wg_id,
        A.art_matching_id AS kl_owg_id,
        A.kl_wg_id AS kl_uwg_id,
        0 AS l_sa_quartil,
        A.med_1_group AS m_sa_quartil,
        0 AS h_sa_quartil
    FROM base_with_median AS A

    UNION ALL
    SELECT DISTINCT
        A.mandant_id,
        A.kjmo AS kl_wg_id,
        A.art_matching_id AS kl_owg_id,
        A.kl_wg_id AS kl_uwg_id,
        0 AS l_sa_quartil,
        0 AS m_sa_quartil,
        PERCENTILE_CONT(A.index_sa_tmp, 0.5) OVER (PARTITION BY A.mandant_id, A.kjmo, A.art_matching_id, A.kl_wg_id) AS h_sa_quartil
    FROM base_with_median AS A
    WHERE A.index_sa_tmp > A.med_1_group
)

SELECT
    mandant_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    MAX(l_sa_quartil) AS l_sa_quartil,
    MAX(m_sa_quartil) + 3 AS m_sa_quartil,
    MAX(h_sa_quartil) AS h_sa_quartil
FROM quartile_union
GROUP BY
    mandant_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_index04` SET
    index_sa = CASE
        WHEN `_index04`.index_sa_tmp < b.l_sa_quartil + 2
            THEN 1
        WHEN `_index04`.index_sa_tmp BETWEEN 90 AND 150
            THEN 2
        ELSE 3
    END FROM (SELECT
    kl_owg_id,
    MAX(l_sa_quartil) AS l_sa_quartil,
    MAX(m_sa_quartil) AS m_sa_quartil
FROM `_index05_sa`
GROUP BY kl_owg_id) AS b
WHERE `_index04`.kl_owg_id = b.kl_owg_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` SET
    index_af_id = b.index_af,
    index_sa_id = b.index_sa FROM (
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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
FROM dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag
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
    FROM dbp_etl.art_matching_nielsen_per_kmo
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id}
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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
FROM dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag
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
    FROM dbp_etl.art_matching_nielsen_per_kmo
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id}
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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TEMPORARY TABLE _preis_wg_kl AS
SELECT
    mandant_id,
    kjmo,
    wg_id AS kl_owg_id,
    wug_id AS kl_uwg_id,
    ROUND(CAST(durchschnitt_preis_kasse AS BIGNUMERIC), 0) + 1 AS preis,
    COUNT(*) AS anz_artikel
FROM dbp_data.art_kl_preislage_zu_per AS A
WHERE
    durchschnitt_preis_kasse IS NOT NULL
    AND kjmo IN (
        SELECT MAX(kjmo) AS kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id}
    )
    AND mandant_id = ${mandant_id}
    AND (
        kjmo, kjwo_update) IN (
        SELECT (MAX(kjmo), MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    )
GROUP BY
    mandant_id,
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    preis;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TEMPORARY TABLE _preis_wg_nielsen AS
SELECT
    mandant_id,
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    ROUND(CAST(durchschnitt_preis_kasse AS BIGNUMERIC), 0) + 1 AS preis,
    COUNT(*) AS anz_artikel
FROM dbp_data.art_nielsen_preislage_zu_per AS A
WHERE
    durchschnitt_preis_kasse IS NOT NULL
    AND (
        mandant_id, kjmo, art_matching_id) IN (
        SELECT (mandant_id, kjmo, art_matching_id)
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE
            kjmo IN (
                SELECT MAX(kjmo) AS kjmo
                FROM dbp_data.art_nielsen_fakten_kjmo
                WHERE mandant_id = ${mandant_id}
            )
            AND mandant_id = ${mandant_id}
            AND (
                kjmo, kjwo_update) IN (
                SELECT (MAX(kjmo), MAX(kjwo_update))
                FROM dbp_data.art_kl_preislage_zu_per
                WHERE mandant_id = ${mandant_id}
            )
        GROUP BY mandant_id,
        kjmo,
        art_matching_id
    )
    AND mandant_id = ${mandant_id}
GROUP BY
    mandant_id,
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    preis;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` SET
    preislagenverteilung = CAST(b.preislage_id AS INT64)
FROM `_preis_wg` AS b
WHERE
    `_sal_snap_final`.kl_uwg_id = b.kl_uwg_id AND `_sal_snap_final`.kl_owg_id = b.kl_owg_id AND CAST(`_sal_snap_final`.durchschnittspreis AS BIGNUMERIC)
    = b.preis AND `_sal_snap_final`.mandant_id = b.mandant_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE `_sal_snap_final` SET
    preislagenverteilung = 2
WHERE preislagenverteilung = 0;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.sortiment_leistung
WHERE kjmo IN (
    SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo
    WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id} AND (kjmo, kjwo_update) IN (
    SELECT (MAX(kjmo), MAX(kjwo_update))
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* ,anz_maerkte */ /* ,TRIM(k_listung) AS k_listung */ -- Potenzial --------------------------
INSERT INTO
dbp_data.sortiment_leistung (
    mandant_id, kjmo, matching_id, kjwo_update, wrg_id, kl_wg_id, kl_owg_id,
    kl_uwg_id, owg_id, wg_id, wug_id, rang_umsatz_wg, rang_umsatz_uwg, rang_absatz_uwg, art_id, kl_art_id, art_bez,
    art_status, gp_id, akt_lieferant, zek_id, disc_pe, disc_marke, lcf, vegan, gluten, bio, eigenmarke, tierwohl,
    posten_food, posten_nonfood, mwst, listung_k_sst_mvke, gewichtete_distribution, index_af_id, umsatz_af_pro_markt_woche,
    absatz_af_pro_markt_woche, ertrag_af_pro_markt_woche, bonreichweite_af, spanne_af, index_sa_id,
    umsatz_sa_pro_markt_woche, absatz_sa_pro_markt_woche, ertrag_sa_pro_markt_woche, bonreichweite_sa, spanne_sa,
    aktionsanteil_absatz, absatz_total, schnelldreherquote, schnelldreherquote_wg, schnelldreherquote_owg,
    kolliabverkaufsquote, kolliabverkaufsquote_wg, kolliabverkaufsquote_owg, abschriftsanteil, abschriftsanteil_wg,
    abschriftsanteil_owg, cherrypicker_quote, cherrypicker_quote_wg, cherrypicker_quote_owg, restbon, restbon_wg,
    restbon_owg, vk_preis, durchschnittspreis, preislagenverteilung, marktanteilbewertung, produktwissen_vp,
    lieferantenwissen_vp, produktwissen_pflege, lieferantenwissen_pflege, listung_sst_pflege, ost_basis_pflege,
    ost_gross_pflege, sued_ost_pflege, sued_west_pflege, west_pflege, nord_pflege, vorschlag, stk_re_pflege, umsatz_hr,
    absatz_hr, rohertrag_hr, nielsen_art_bez, gtin, distr_gew, umsatz_anteil_uwg, umsatz_anteil_uwg_kumuliert,
    durchschnitt_anz_maerkte, durchschnitt_preis, kl_markt_anteil_owg, umsatz_artikel, absatz_artikel, anz_monate,
    anz_wochen, eigenmarke_fg, listung_sst_mvke, ost_basis, ost_gross, sued_ost, sued_west, west, nord,
    listung_k_sst_pflege
)
(
    SELECT
        A.mandant_id,
        A.kjmo,
        A.art_matching_id,
        Z.kjwo AS kjwo_update,
        X.default_wrg AS wrg_id,
        CAST(A.kl_wg_id AS INTEGER) AS kl_wg_id,
        CAST(A.kl_owg_id AS INTEGER) AS kl_owg_id,
        CAST(A.kl_uwg_id AS INTEGER) AS kl_uwg_id,
        CAST(A.kl_wg_id AS INTEGER) AS owg_id,
        CAST(A.kl_owg_id AS INTEGER) AS wg_id,
        CAST(A.kl_uwg_id AS INTEGER) AS wug_id,
        CAST(A.rang_umsatz_wg AS INTEGER) AS rang_umsatz_wg,
        CAST(A.rang_umsatz_uwg AS INTEGER) AS rang_umsatz_uwg,
        CAST(A.rang_absatz_uwg AS INTEGER) AS rang_absatz_uwg,
        A.art_id,
        A.kl_art_id,
        A.art_bez,
        A.art_status,
        A.gp_id,
        A.gp_name AS akt_lieferant,
        A.zek_id,
        A.disc_pe,
        A.disc_marke,
        SUBSTR(CAST(A.lcf AS STRING), 1, 4) AS lcf,
        SUBSTR(CAST(A.vegan AS STRING), 1, 4) AS vegan,
        SUBSTR(CAST(A.gluten AS STRING), 1, 4) AS gluten,
        SUBSTR(CAST(A.bio AS STRING), 1, 4) AS bio,
        A.eigenmarke,
        A.tierwohl,
        A.posten_food,
        A.posten_nonfood,
        A.mwst,
        TRIM(A.ksm_id) AS listung_k_sst_mvke,
        A.gewichtete_distribution,
        A.index_af_id,
        A.umsatz_af_pro_markt_woche,
        A.absatz_af_pro_markt_woche,
        A.ertrag_af_pro_markt_woche,
        ROUND(CAST(A.bonreichweite_af AS NUMERIC), 5) AS bonreichweite_af,
        A.spanne_af,
        A.index_sa_id,
        A.umsatz_sa_pro_markt_woche,
        CAST(A.absatz_sa_pro_markt_woche AS NUMERIC) as absatz_sa_pro_markt_woche,
        A.ertrag_sa_pro_markt_woche,
        ROUND(CAST(A.bonreichweite_sa AS NUMERIC), 5) AS bonreichweite_sa,
        A.spanne_sa,
        CAST(A.aktionsanteil_absatz AS NUMERIC) AS aktionsanteil_absatz,
        CAST(A.absatz_total AS NUMERIC) AS absatz_total,
        A.schnelldreherquote / 100,
        ROUND(CAST(A.schnelldreherquote_wg AS NUMERIC), 5) AS schnelldreherquote_wg,
        ROUND(CAST(A.schnelldreherquote_owg AS NUMERIC), 5) AS schnelldreherquote_owg,
        CAST(A.kolliabverkaufsquote AS NUMERIC) as kolliabverkaufsquote,
        ROUND(CAST(A.kolliabverkaufsquote_wg AS NUMERIC), 5) AS kolliabverkaufsquote_wg,
        ROUND(CAST(A.kolliabverkaufsquote_owg AS NUMERIC), 5) AS kolliabverkaufsquote_owg,
        A.abschriftsanteil,
        ROUND(CAST(A.abschriftsanteil_wg AS NUMERIC), 5) AS abschriftsanteil_wg,
        ROUND(CAST(A.abschriftsanteil_owg AS NUMERIC), 5) AS abschriftsanteil_owg,
        ROUND(CAST(A.cherrypicker_quote AS NUMERIC), 5) AS cherrypicker_quote,
        ROUND(CAST(A.cherrypicker_quote_wg AS NUMERIC), 5) AS cherrypicker_quote_wg,
        ROUND(CAST(A.cherrypicker_quote_owg AS NUMERIC), 5) AS cherrypicker_quote_owg,
        A.restbon,
        A.restbon_wg,
        A.restbon_owg,
        A.vk_preis,
        A.durchschnittspreis,
        ROUND(CAST(A.preislagenverteilung AS NUMERIC), 5) AS preislagenverteilung,
        ROUND(CAST(
            A.marktanteilbewertung -- TS --------------------------
            AS NUMERIC
        ), 5) AS marktanteilbewertung,
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
        CAST(NULL AS INTEGER) AS durchschnitt_anz_maerkte,
        NULL AS durchschnitt_preis,
        NULL AS kl_markt_anteil_owg,
        NULL AS umsatz_artikel,
        NULL AS absatz_artikel,
        CAST(NULL AS INTEGER) AS anz_monate,
        CAST(NULL AS INTEGER) AS anz_wochen,
        CAST(NULL AS INTEGER) AS eigenmarke_fg,
        TRIM(A.sm_id) AS listung_sst_mvke,
        A.ost_basis,
        A.ost_gross,
        A.sued_ost,
        A.sued_west,
        A.west,
        A.nord /* ,anz_maerkte */,
        ' ' AS listung_k_sst_pflege
    FROM `_sal_snap_final` AS A
    INNER JOIN dbp_data.mandant AS X ON A.mandant_id = X.mandant_id
    INNER JOIN dbp_data.woche AS Z ON TRUE
    WHERE
        Z.kjwo IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = ${mandant_id}
        )
);


INSERT INTO dbp_data.sortiment_leistung (
    mandant_id, kjmo, matching_id, kjwo_update, wrg_id, kl_wg_id,
    kl_owg_id, kl_uwg_id, owg_id, wg_id, wug_id, rang_umsatz_wg, rang_umsatz_uwg, rang_absatz_uwg, art_id, zek_id,
    nielsen_art_bez, gtin, distr_gew, umsatz_anteil_uwg, umsatz_anteil_uwg_kumuliert, durchschnitt_anz_maerkte,
    durchschnitt_preis, kl_markt_anteil_owg, umsatz_artikel, absatz_artikel, anz_monate, anz_wochen, eigenmarke_fg
)
(
    SELECT
        A.mandant_id,
        A.kjmo,
        A.art_matching_id,
        Z.kjwo AS kjwo_update,
        X.default_wrg AS wrg_id,
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id,
        A.kl_wg_id AS owg_id,
        A.kl_owg_id AS wg_id,
        A.kl_uwg_id AS wug_id,
        A.rang_umsatz_wg,
        A.rang_umsatz_uwg,
        A.rang_absatz_uwg,
        A.art_id,
        '-99' AS zek_id,
        A.art_nielsen_bez,
        A.gtin_id,
        A.distr_gew,
        A.umsatz_anteil_uwg,
        A.umsatz_anteil_uwg_kumuliert,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.kl_markt_anteil_owg,
        A.umsatz_artikel,
        A.absatz_artikel,
        A.anz_monate,
        A.anz_wochen,
        A.eigenmarke_fg
    FROM dbp_etl.sortiment_potenziale_kmo AS A
    INNER JOIN dbp_data.mandant AS X ON A.mandant_id = X.mandant_id
    INNER JOIN dbp_data.woche AS Z ON TRUE
    WHERE
        Z.kjwo IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = ${mandant_id}
        )
);


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.sortiment_leistung SET
    art_id = NULL
WHERE art_id = -1;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--mfialkie add as STRING(14) instead of STRING(14)


UPDATE dbp_data.sortiment_leistung SET
    kl_art_id = CAST(CAST(FLOOR(sortiment_leistung.art_id / 10) AS INTEGER) AS STRING),
    wug_id = b.wug_id,
    art_bez = b.art_bez,
    art_status = b.art_status,
    gp_id = b.gp_id,
    akt_lieferant = b.gp_name,
    zek_id = b.zek_id,
    disc_pe = b.disc_pe,
    disc_marke = b.disc_marke,
    lcf = SUBSTR(CAST(b.lactose_fg AS STRING), 1, 4),
    vegan = SUBSTR(CAST(b.vegan_fg AS STRING), 1, 4),
    gluten = SUBSTR(CAST(b.gluten_fg AS STRING), 1, 4),
    bio = SUBSTR(CAST(b.bio_fg AS STRING), 1, 4),
    eigenmarke = b.eigenmarke_id,
    tierwohl = '',
    posten_food = b.posten_food,
    posten_nonfood = b.posten_nonfood,
    mwst = b.mwst,
    listung_sst_mvke = TRIM(b.sm_id),
    listung_k_sst_mvke = TRIM(b.ksm_id),
    durchschnittspreis = b.rohertrag_einheit FROM (
    SELECT
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
        B.art_bez,
        c.sm_id,
        c.ksm_id
    FROM dbp_data.sal_kmo AS A
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
        FROM dbp_etl_process.art_sm_vw_zu_per
        WHERE
            mandant_id = ${mandant_id}
            AND dat_bis = PARSE_DATE('%F', '9999-12-31')
        GROUP BY
            mandant_id,
            art_id
    ) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id
    LEFT JOIN dbp_data.art_spr_zu AS B ON A.art_id = B.art_id AND A.mandant_id = B.mandant_id AND B.spr_id NOT IN (22, 24)
    WHERE
        A.mandant_id = ${mandant_id}
        AND A.kjmo IN (
            SELECT MIN(B0.kjmo) AS kjmo
            FROM (
                SELECT COALESCE(a1.kjmo_nielsen, a2.kjmo_tag) AS kjmo
                FROM (
                    SELECT MAX(kjmo) AS kjmo_nielsen
                    FROM dbp_data.art_nielsen_fakten_kjmo
                    WHERE mandant_id = ${mandant_id}
                ) AS a1
                INNER JOIN (
                    SELECT MAX(kjmo) AS kjmo_tag
                    FROM dbp_data.tag
                    WHERE akt_mo = -1
                ) AS a2
                    ON TRUE
            ) AS a
            INNER JOIN dbp_data.tag AS B0 ON a.kjmo = B0.kjmo
        )
) AS b
WHERE sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.vk_preis IS NULL AND sortiment_leistung.art_id = b.art_id AND sortiment_leistung.kjmo IN (
    SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo
    WHERE mandant_id = ${mandant_id}) AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}
) AND sortiment_leistung.gtin IS NOT NULL;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.sortiment_leistung SET
    art_id = NULL
WHERE art_id = -1 AND kjmo IN (
    SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo
    WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id} AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}
);


--[OK] statement is translated correctly (syntax and type checks are fine)
-- mfialkiewicz


UPDATE dbp_data.sortiment_leistung SET
    kl_art_id = CAST(CAST(FLOOR(sortiment_leistung.art_id / 10) AS INTEGER) AS STRING),
    wug_id = b.wug_id,
    art_bez = b.art_bez,
    art_status = b.art_status,
    gp_id = CAST(ROUND(CAST(SUBSTR(b.akt_lieferant, 1, STRPOS(b.akt_lieferant, ':') - 1) AS BIGNUMERIC), 0) AS INTEGER),
    akt_lieferant = b.akt_lieferant,
    zek_id = b.zek,
    disc_pe = b.disc_pe,
    disc_marke = b.disc_marke,
    lcf = SUBSTR(CAST(b.lcf AS STRING), 1, 4),
    vegan = SUBSTR(CAST(b.vegan AS STRING), 1, 4),
    gluten = SUBSTR(CAST(b.gluten AS STRING), 1, 4),
    bio = SUBSTR(CAST(b.bio AS STRING), 1, 4),
    eigenmarke = b.eigenmarke FROM (
    SELECT DISTINCT
        A.mandant_id,
        A.kjmo,
        A.art_id,
        B.kl_art_id,
        A132.wug_id,
        A133.art_bez,
        B.loesch_id AS art_status,
        B.zek_id AS zek,
        B.aldi_id AS disc_pe,
        B.discount_id AS disc_marke,
        B.lactose_fg AS lcf,
        B.vegan_fg AS vegan,
        B.gluten_fg AS gluten,
        B.bio_fg AS bio,
        B.eigenmarke_id AS eigenmarke,
        B.tierwohl_kz AS tierwohl,
        COALESCE(X.mwst, 0) AS mwst,
        'N/A' AS k_listung,
        CASE
            WHEN B.posten_id = 'PF'
                THEN 'X'
            ELSE ' '
        END AS posten_food,
        CASE
            WHEN B.posten_id = 'PN'
                THEN 'X'
            ELSE ' '
        END AS posten_nonfood,
        CAST(a126.gp_id AS STRING) || ':' || a126.gp_name AS akt_lieferant
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN dbp_data.art AS B ON A.art_id = B.art_id AND A.mandant_id = B.mandant_id
    INNER JOIN dbp_data.art_wg_zu_per AS A132 ON A.art_id = A132.art_id AND A.mandant_id = A132.mandant_id AND A132.arthiertyp_id = 2 AND A132.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.art_spr_zu AS A133 ON A.art_id = A133.art_id AND A.mandant_id = A133.mandant_id AND A133.spr_id NOT IN (22, 24)
    LEFT JOIN dbp_data.mwst_per AS X ON A.mandant_id = X.mandant_id AND B.mwst_id = X.mwst_id AND X.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN (
        SELECT
            V01.mandant_id,
            V01.art_id,
            V01.gp_id,
            V02.gp_name,
            COUNT(*) AS anz_lief
        FROM dbp_data.art_gp_nm_zu_per AS V01
        INNER JOIN dbp_data.gp AS V02 ON V01.mandant_id = V02.mandant_id AND V01.gp_id = V02.gp_id
        WHERE
            V01.dat_bis = PARSE_DATE('%F', '9999-12-31')
            AND V01.gp_id <> -1
            AND V01.mandant_id <> 1
        GROUP BY
            V01.mandant_id,
            V01.art_id,
            V01.gp_id,
            V02.gp_name
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY V01.mandant_id, V01.art_id ORDER BY anz_lief IS NULL DESC, anz_lief DESC)) = 1
    ) AS a126 ON A.art_id = a126.art_id AND B.mandant_id = a126.mandant_id
    WHERE
        A.kl_art_id IS NULL
        AND A.vk_preis IS NULL
        AND A.kjmo IN (
            SELECT MAX(kjmo) AS kjmo
            FROM dbp_data.art_nielsen_fakten_kjmo
            WHERE mandant_id = ${mandant_id}
        )
        AND A.mandant_id = ${mandant_id}
        AND A.art_id IS NOT NULL
        AND A.gtin IS NOT NULL
) AS b
WHERE sortiment_leistung.art_id = b.art_id AND sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.kjmo IN (
    SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo
    WHERE mandant_id = ${mandant_id}) AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}
);


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.sortiment_leistung SET
    akt_lieferant = t1.hersteller_bez FROM (
    SELECT
        mandant_id,
        gtin_id,
        art_nielsen_bez,
        MAX(hersteller_bez) AS hersteller_bez
    FROM `_art_nielsen`
    WHERE mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        art_nielsen_bez,
        gtin_id
) AS t1
WHERE
    ROUND(CAST(sortiment_leistung.gtin AS BIGNUMERIC), 0) = t1.gtin_id AND sortiment_leistung.nielsen_art_bez = t1.art_nielsen_bez
    AND sortiment_leistung.mandant_id = t1.mandant_id;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.sortiment_leistung SET
    eigenmarke = '0'
WHERE kjmo IN (
    SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo
    WHERE mandant_id = ${mandant_id}
) AND gtin IN ('-9999', '-9998'
) AND mandant_id = ${mandant_id} AND gtin IS NOT NULL;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TEMPORARY TABLE IF NOT EXISTS _step1_absatz_vj AS
SELECT
    A.mandant_id,
    C.kjmo_sort AS kjmo,
    b.art_id,
    SUM(A.menge) AS absatz_vj
FROM dbp_data.artbew AS A
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS C
    ON A.dat BETWEEN DATE_SUB(
        C.dat_von,
        INTERVAL 365 DAY
    ) AND (DATE_SUB(C.dat_bis, INTERVAL 365 DAY)
    )
INNER JOIN (
    SELECT
        mandant_id,
        art_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        art_id
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE
    A.mandant_id = ${mandant_id}
    AND C.kjmo_sort IN (
        SELECT MAX(kjmo) AS a1886105636
        FROM dbp_data.sortiment_leistung
        WHERE mandant_id = ${mandant_id}
    )
GROUP BY
    A.mandant_id,
    kjmo,
    b.art_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TEMPORARY TABLE IF NOT EXISTS _step2_absatz_vj AS
SELECT
    A.mandant_id,
    A.kjmo,
    b.art_matching_id,
    b.art_id,
    A.absatz_vj
FROM `_step1_absatz_vj` AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        art_id,
        art_matching_id
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
GROUP BY
    A.mandant_id,
    A.kjmo,
    b.art_matching_id,
    b.art_id,
    A.absatz_vj;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.sortiment_leistung SET
    absatz_total_vj = b.absatz_vj FROM (
    SELECT
        mandant_id,
        kjmo,
        art_matching_id,
        SUM(absatz_vj) AS absatz_vj
    FROM `_step2_absatz_vj`
    GROUP BY
        mandant_id,
        kjmo,
        art_matching_id
) AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.kjmo = b.kjmo AND sortiment_leistung.mandant_id
    = b.mandant_id AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    );


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.sortiment_leistung SET
    wug_id = sortiment_leistung.kl_uwg_id
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}
) AND mandant_id = ${mandant_id} AND kl_uwg_id <> wug_id;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.sortiment_leistung SET
    kassenumsatz_kl_absolut_brutto = 0,
    kassenumsatz_kl_absolut_netto = 0,
    abschriften_wert_netto_absolut = 0
WHERE mandant_id = ${mandant_id} AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TEMPORARY TABLE IF NOT EXISTS _step1_umsatz_brutto_kmo AS
SELECT
    C.kjmo_sort AS kjmo,
    A.mandant_id,
    b.art_id,
    SUM(A.umsatz_netto) AS umsatz_netto,
    SUM(A.umsatz_netto + A.umsatz_mwst_betrag) AS umsatz_brutto
FROM dbp_data.artbew AS A
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS C ON A.dat BETWEEN C.dat_von AND C.dat_bis
INNER JOIN (
    SELECT
        mandant_id,
        art_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        art_id
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE
    A.mandant_id = ${mandant_id}
    AND C.kjmo_sort IN (
        SELECT MAX(kjmo) AS a1886105636
        FROM dbp_data.sortiment_leistung
        WHERE mandant_id = ${mandant_id}
    )
GROUP BY
    kjmo,
    A.mandant_id,
    b.art_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TEMPORARY TABLE IF NOT EXISTS _step2_umsatz_brutto_kmo AS
SELECT
    A.kjmo,
    A.mandant_id,
    b.art_matching_id,
    b.art_id,
    A.umsatz_netto,
    A.umsatz_brutto
FROM `_step1_umsatz_brutto_kmo` AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        art_id,
        art_matching_id
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
GROUP BY
    A.kjmo,
    A.mandant_id,
    b.art_matching_id,
    b.art_id,
    A.umsatz_netto,
    A.umsatz_brutto;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.sortiment_leistung SET
    kassenumsatz_kl_absolut_brutto = b.umsatz_brutto,
    kassenumsatz_kl_absolut_netto = b.umsatz_netto FROM (
    SELECT
        kjmo,
        mandant_id,
        art_matching_id,
        SUM(umsatz_netto) AS umsatz_netto,
        SUM(umsatz_brutto) AS umsatz_brutto
    FROM `_step2_umsatz_brutto_kmo`
    GROUP BY
        kjmo,
        mandant_id,
        art_matching_id
) AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.kjmo = b.kjmo AND sortiment_leistung.mandant_id
    = b.mandant_id AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    ) AND sortiment_leistung.art_id IS NOT NULL;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TEMPORARY TABLE IF NOT EXISTS _step1_abschr_kmo AS
SELECT
    C.kjmo_sort AS kjmo,
    A.mandant_id,
    A.art_id,
    SUM(A.abschriftbetrag_netto) AS abschriftenbetrag_netto
FROM dbp_data.marktabschriften AS A
INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS C ON A.dat BETWEEN C.dat_von AND C.dat_bis
INNER JOIN (
    SELECT
        mandant_id,
        art_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        art_id
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE
    A.abschriftart_id BETWEEN 905 AND 994
    AND A.mandant_id = ${mandant_id}
    AND (A.abschriftart_id <> 955 OR A.mandant_id <> 2)
GROUP BY
    kjmo,
    A.mandant_id,
    A.art_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TEMPORARY TABLE IF NOT EXISTS _step2_abschr_kmo AS
SELECT
    A.kjmo,
    A.mandant_id,
    b.art_matching_id,
    b.art_id,
    A.abschriftenbetrag_netto
FROM `_step1_abschr_kmo` AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        art_id,
        art_matching_id
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
GROUP BY
    A.kjmo,
    A.mandant_id,
    b.art_matching_id,
    b.art_id,
    A.abschriftenbetrag_netto;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.sortiment_leistung SET
    abschriften_wert_netto_absolut = t0.abschriftenbetrag_netto FROM (
    SELECT
        mandant_id,
        kjmo,
        art_matching_id,
        SUM(abschriftenbetrag_netto) AS abschriftenbetrag_netto
    FROM `_step2_abschr_kmo`
    GROUP BY
        kjmo,
        mandant_id,
        art_matching_id
) AS t0
WHERE
    sortiment_leistung.matching_id = t0.art_matching_id AND sortiment_leistung.kjmo = t0.kjmo AND sortiment_leistung.mandant_id
    = t0.mandant_id AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    ) AND sortiment_leistung.art_id IS NOT NULL;


-- 18.01.2022, -dbay-
--
-- proper handling of duplicates


INSERT INTO dbp_etl_process.matching_art_nielsen_zu
(
    SELECT
        mandant_id,
        kjwo_update,
        art_matching_id,
        art_nielsen_id,
        gtin_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE (
        mandant_id, art_matching_id) IN (
        SELECT (mandant_id, matching_id)
        FROM dbp_data.sortiment_leistung
        WHERE
            mandant_id = ${mandant_id}
            AND kjwo_update IN (
                SELECT MAX(kjwo_update) AS kjwo_update
                FROM dbp_data.sortiment_leistung
                WHERE mandant_id = ${mandant_id}
            )
        GROUP BY
            mandant_id,
            matching_id
        HAVING COUNT(*) > 1
    )
    AND art_nielsen_id <> -1
    AND (mandant_id, art_matching_id, art_nielsen_id, kjwo_update) NOT IN (SELECT (
        mandant_id, art_matching_id,
        art_nielsen_id, kjwo_update
    )
    FROM dbp_etl_process.matching_art_nielsen_zu)
    GROUP BY
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        gtin_id,
        kjwo_update
);


CREATE OR REPLACE TEMPORARY TABLE _sorti_agg AS
SELECT
    mandant_id,
    kjmo,
    matching_id,
    kjwo_update,
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
    MAX(CURRENT_TIMESTAMP()) AS td_update,
    MAX(zek_id) AS zek_id,
    MAX(wrg_id) AS wrg_id
FROM dbp_data.sortiment_leistung
WHERE (
    mandant_id, matching_id, kjwo_update) IN (
    SELECT (mandant_id, art_matching_id, kjwo_update)
    FROM dbp_etl_process.matching_art_nielsen_zu
    WHERE
        mandant_id = ${mandant_id}
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
)
GROUP BY
    mandant_id,
    kjmo,
    matching_id,
    kjwo_update;


DELETE FROM dbp_data.sortiment_leistung
WHERE (
    mandant_id, kjwo_update, matching_id) IN (
    SELECT (mandant_id, kjwo_update, matching_id)
    FROM `_sorti_agg`
);


INSERT INTO dbp_data.sortiment_leistung
(SELECT
    mandant_id,
    kjmo,
    matching_id,
    kjwo_update,
    CAST(kl_wg_id AS INT64) AS kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    owg_id,
    wg_id,
    wug_id,
    rang_umsatz_wg,
    rang_umsatz_uwg,
    rang_absatz_uwg,
    art_id,
    CAST(kl_art_id AS STRING) AS kl_art_id,
    art_bez,
    art_status,
    CAST(gp_id AS INT64) AS gp_id,
    CAST(akt_lieferant AS STRING) AS akt_lieferant,
    CAST(disc_pe AS INTEGER) AS disc_pe,
    CAST(disc_marke AS INTEGER) AS disc_marke,
    CAST(lcf AS STRING) AS lcf,
    CAST(vegan AS STRING) AS vegan,
    gluten,
    bio,
    eigenmarke,
    tierwohl,
    posten_food,
    posten_nonfood,
    CAST(mwst AS NUMERIC) AS mwst,
    listung_k_sst_mvke,
    gewichtete_distribution,
    CAST(index_af_id AS INT64) AS index_af_id,
    umsatz_af_pro_markt_woche,
    CAST(absatz_af_pro_markt_woche AS INTEGER) AS absatz_af_pro_markt_woche,
    ertrag_af_pro_markt_woche,
    bonreichweite_af,
    spanne_af,
    index_sa_id,
    umsatz_sa_pro_markt_woche,
    CAST(absatz_sa_pro_markt_woche AS INTEGER) AS absatz_sa_pro_markt_woche,
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
    CAST(umsatz_hr AS NUMERIC) AS umsatz_hr,
    CAST(absatz_hr AS NUMERIC) AS absatz_hr,
    rohertrag_hr,
    nielsen_art_bez,
    gtin,
    CAST(distr_gew AS NUMERIC) AS distr_gew,
    CAST(umsatz_anteil_uwg AS NUMERIC) AS umsatz_anteil_uwg,
    umsatz_anteil_uwg_kumuliert,
    durchschnitt_anz_maerkte,
    durchschnitt_preis,
    CAST(kl_markt_anteil_owg AS INTEGER) AS kl_markt_anteil_owg,
    umsatz_artikel,
    absatz_artikel,
    anz_monate,
    anz_wochen,
    eigenmarke_fg,
    CAST(listung_sst_mvke AS STRING) AS listung_sst_mvke,
    CAST(ost_basis AS STRING) AS ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    nord,
    CAST(anz_maerkte_sst AS INTEGER) AS anz_maerkte_sst,
    CAST(anz_maerkte_baustein_sonstige AS INTEGER) AS anz_maerkte_baustein_sonstige,
    anz_maerkte_listung_einzel,
    anz_maerkte_listung_gesamt,
    CAST(listungsaktion AS STRING) AS listungsaktion,
    anz_maerkte_k_sst,
    listung_k_sst_pflege,
    CAST(muki_wb_kz AS STRING) AS muki_wb_kz,
    muki_wb_kl_art_id_verkettung,
    muki_vk_kz,
    muki_vk_kl_art_id_verkettung,
    muki_ek_kz,
    muki_ek_kl_art_id_verkettung,
    CAST(absatz_total_vj AS NUMERIC) AS absatz_total_vj,
    CAST(max_anz_maerkte_sst AS INTEGER) AS max_anz_maerkte_sst,
    max_anz_maerkte_k_sst,
    CAST(kassenumsatz_kl_absolut_brutto AS INTEGER) AS kassenumsatz_kl_absolut_brutto,
    CAST(kassenumsatz_kl_absolut_netto AS INTEGER) AS kassenumsatz_kl_absolut_netto,
    abschriften_wert_netto_absolut,
    td_insert,
    td_update,
    CAST(zek_id AS STRING) AS zek_id,
    CAST(wrg_id AS STRING) AS wrg_id
FROM `_sorti_agg` AS A);


--kl_old


CREATE OR REPLACE TEMPORARY TABLE _upd1 AS
SELECT DISTINCT
    kjwo_update,
    mandant_id,
    art_matching_id,
    art_nielsen_id,
    gtin_id
FROM dbp_etl.art_matching_nielsen_per_kmo
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl.art_matching_nielsen_per_kmo
)
AND (
    mandant_id, art_matching_id, art_nielsen_id) IN (
    SELECT (mandant_id, art_matching_id, MAX(art_nielsen_id))
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl.art_matching_nielsen_per_kmo
        )
    GROUP BY mandant_id,
    art_matching_id
)
AND gtin_id NOT IN (-9999, -9998);


CREATE OR REPLACE TEMPORARY TABLE _upd2 AS
SELECT DISTINCT
    kjwo_update,
    mandant_id,
    art_id,
    gtin_id
FROM dbp_etl.art_matching_nielsen_per_kmo
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl.art_matching_nielsen_per_kmo
)
AND art_nielsen_id <> -1
AND art_id <> -1
AND gtin_id NOT IN (-9999, -9998);


--kmo


UPDATE dbp_data.sortiment_leistung SET
    gtin = CAST(b.gtin_id AS STRING) FROM (
    SELECT
        kjwo_update,
        mandant_id,
        art_matching_id,
        MAX(gtin_id) AS gtin_id
    FROM `_upd1`
    WHERE art_nielsen_id <> -1
    GROUP BY
        kjwo_update,
        mandant_id,
        art_matching_id
) AS b
WHERE
    sortiment_leistung.kjwo_update = b.kjwo_update AND sortiment_leistung.mandant_id = b.mandant_id AND
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.gtin IS NULL AND sortiment_leistung.art_id
    IS NOT NULL;


UPDATE dbp_data.sortiment_leistung SET
    gtin = CAST(b.gtin_id AS STRING) FROM (
    SELECT
        kjwo_update,
        mandant_id,
        art_id,
        MAX(gtin_id) AS gtin_id
    FROM `_upd2`
    GROUP BY
        kjwo_update,
        mandant_id,
        art_id
) AS b
WHERE
    sortiment_leistung.kjwo_update = b.kjwo_update AND sortiment_leistung.mandant_id = b.mandant_id AND
    sortiment_leistung.art_id = b.art_id AND sortiment_leistung.gtin IS NULL;
