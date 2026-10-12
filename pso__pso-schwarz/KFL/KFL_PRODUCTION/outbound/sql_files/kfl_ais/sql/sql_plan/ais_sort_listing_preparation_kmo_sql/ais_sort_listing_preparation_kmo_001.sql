CREATE OR REPLACE TEMPORARY TABLE _art_matching_nielsen_per_kmo AS
SELECT *
FROM dbp_etl.art_matching_nielsen_per_kmo
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl.art_matching_nielsen_per_kmo
);


TRUNCATE TABLE dbp_etl_process.art_gtin;


INSERT INTO dbp_etl_process.art_gtin
(SELECT
    art_id,
    mandant_id,
    gtin_id,
    gtin_typ_kz,
    haupt_gtin_fg,
    td_insert,
    td_update
FROM dbp_data.art_gtin_zu);


CREATE OR REPLACE TEMPORARY TABLE _schrott_1 AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    B.gtin_id AS gtin_alt,
    MAX(A.gtin_id) AS gtin_neu
FROM `_art_matching_nielsen_per_kmo` AS A
INNER JOIN dbp_data.art_nielsen AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id

WHERE
    A.gtin_id <> B.gtin_id
    AND B.gtin_id IN (-9999, -9998)
    AND B.dat_bis = DATE '9999-12-31'
GROUP BY
    A.mandant_id,
    A.art_nielsen_id,
    gtin_alt;


UPDATE dbp_data.art_nielsen SET
    gtin_id = b.gtin_neu FROM (
    SELECT DISTINCT *
    FROM `_schrott_1`
) AS b
WHERE
    art_nielsen.mandant_id = b.mandant_id AND art_nielsen.art_nielsen_id = b.art_nielsen_id AND art_nielsen.gtin_id =
    b.gtin_alt AND art_nielsen.dat_bis = DATE '9999-12-31';


--DBP_DATA._gtin_mix_up must be done before update dbp_etl.art_matching_nielsen_per_kmo


CREATE OR REPLACE TEMPORARY TABLE _gtin_mix_up AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    A.gtin_id AS gtin_alt,
    B.gtin_id AS gtin_neu
FROM `_art_matching_nielsen_per_kmo` AS A
INNER JOIN dbp_data.art_nielsen AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id

WHERE
    A.gtin_id <> B.gtin_id
    AND A.mandant_id = B.mandant_id
    AND B.dat_bis = DATE '9999-12-31'
    AND B.gtin_id NOT IN (-9999, -9998);


UPDATE dbp_etl_process.art_art_nielsen_prepare_kmo SET
    gtin_id = b.gtin_neu FROM (
    SELECT *
    FROM `_gtin_mix_up`
    GROUP BY
        mandant_id,
        art_nielsen_id,
        gtin_alt,
        gtin_neu
) AS b
WHERE
    art_art_nielsen_prepare_kmo.mandant_id = b.mandant_id AND art_art_nielsen_prepare_kmo.art_nielsen_id = b.art_nielsen_id
    AND art_art_nielsen_prepare_kmo.gtin_id = b.gtin_alt;


CREATE OR REPLACE TEMPORARY TABLE _schrott_2 AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    A.gtin_id AS gtin_alt,
    B.gtin_id AS gtin_neu
FROM `_art_matching_nielsen_per_kmo` AS A
INNER JOIN dbp_data.art_nielsen AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id

WHERE
    A.gtin_id <> B.gtin_id
    AND B.dat_bis = DATE '9999-12-31'
    AND B.gtin_id NOT IN (-9999, -9998);


UPDATE dbp_etl.art_matching_nielsen_per_kmo SET
    gtin_id = b.gtin_neu FROM (
    SELECT DISTINCT *
    FROM `_schrott_2`
) AS b
WHERE
    art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo.art_nielsen_id = b.art_nielsen_id
    AND art_matching_nielsen_per_kmo.gtin_id = b.gtin_alt AND art_matching_nielsen_per_kmo.kjwo_update = (SELECT
        MAX(kjwo_update
        )
    FROM dbp_etl.art_matching_nielsen_per_kmo);


CREATE OR REPLACE TABLE dbp_etl.sort_wg_liste AS
SELECT A.wg_id
FROM dbp_data.wg_per AS A
INNER JOIN dbp_data.owg_per AS B ON A.mandant_id = B.mandant_id AND A.owg_id = B.owg_id
INNER JOIN dbp_data.hwg_per AS C ON A.mandant_id = C.mandant_id AND B.hwg_id = C.hwg_id
INNER JOIN dbp_data.abt AS D ON A.mandant_id = D.mandant_id AND C.abt_id = D.abt_id
WHERE
    A.dat_bis = DATE '9999-12-31'
    AND B.dat_bis = DATE '9999-12-31'
    AND C.dat_bis = DATE '9999-12-31'
    AND D.abt_id <> 8
GROUP BY A.wg_id;


CREATE OR REPLACE TABLE dbp_etl.sort_ist_kmo (
    wup_id INTEGER,
    mandant_id INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    kassenumsatz FLOAT64,
    anz_tage INTEGER,
    preis FLOAT64,
    list_kz STRING(2) COLLATE 'und:ci'
);


----


CREATE OR REPLACE TEMPORARY TABLE _art_nielsen_mgtin AS
SELECT DISTINCT
    mandant_id,
    art_nielsen_id,
    gtin_id
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31'
UNION DISTINCT
SELECT DISTINCT
    mandant_id,
    art_nielsen_id,
    gtin_ref_id AS gtin_id
FROM dbp_etl_process.art_nielsen_gtin_zu;


CREATE OR REPLACE TEMPORARY TABLE _distinct_nl_arts AS
SELECT *
FROM `_art_nielsen_mgtin` AS A
WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    mandant_id,
    art_nielsen_id,
    gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _article_matching0 AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    b.art_id,
    A.gtin_id
FROM `_distinct_nl_arts` AS A
INNER JOIN (
    SELECT *
    FROM dbp_etl_process.art_gtin AS A
    WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
) AS b
    ON A.gtin_id = b.gtin_id AND A.mandant_id = b.mandant_id
GROUP BY
    A.mandant_id,
    A.art_nielsen_id,
    b.art_id,
    A.gtin_id;


CREATE OR REPLACE TABLE dbp_etl.kl_basis_listung_kmo (
    mandant_id INTEGER,
    art_id INTEGER,
    art_nielsen_id INTEGER,
    list_kz STRING(10) COLLATE 'und:ci'
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_listung (
    mandant_id INTEGER,
    art_id INTEGER,
    art_nielsen_id INTEGER,
    list_kz STRING(10) COLLATE 'und:ci'
);


--listed


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_alle_gelistet AS
SELECT
    A.mandant_id,
    A.art_id
FROM dbp_data.art_list_wup_zu_per AS A
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = DATE '9999-12-31' AND B.arthiertyp_id = 2
WHERE
    A.mandant_id IN (2, 3, 5, 6, 7, 8)
    AND A.nb_id = 0
    AND A.list_komponente_fg = 0
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_etl.sort_wg_liste
    )
    AND A.art_id > 0
    AND A.list_quelle_id NOT IN ('2')
GROUP BY
    A.mandant_id,
    A.art_id;


--not listed


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_nicht_gelistet AS
SELECT
    A.mandant_id,
    A.art_id
FROM dbp_data.art_wup_zu_per AS A
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = DATE '9999-12-31' AND B.arthiertyp_id = 2
WHERE
    A.mandant_id IN (2, 3, 5, 6, 7, 8)
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_etl.sort_wg_liste
    )
    AND A.art_id > 0
GROUP BY
    A.mandant_id,
    A.art_id
HAVING MAX(A.listung_id) = 0;


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_a AS
SELECT
    A.mandant_id,
    A.art_id,
    'A' AS list_kz
FROM dbp_data.artbew_mo_sum AS A
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = DATE '9999-12-31' AND B.arthiertyp_id = 2
WHERE
    A.mandant_id IN (2, 3, 5, 6, 7, 8)
    AND (A.mandant_id, A.kjmo) IN (
        SELECT (mandant_id, kjmo)
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
        GROUP BY
            mandant_id,
            kjmo
        QUALIFY ((RANK() OVER (PARTITION BY mandant_id ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_etl.sort_wg_liste
    )
    AND (
        A.mandant_id, A.art_id) IN (
        SELECT (mandant_id, art_id)
        FROM (
            SELECT DISTINCT *
            FROM `_kl_basis_alle_gelistet`
        ) AS t7
    )
GROUP BY
    A.mandant_id,
    A.art_id
HAVING SUM(A.menge) > 0;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_a` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_b AS
SELECT
    A.mandant_id,
    A.art_id,
    'B' AS list_kz
FROM dbp_data.artbew_mo_sum AS A
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = DATE '9999-12-31' AND B.arthiertyp_id = 2
WHERE
    A.mandant_id IN (2, 3, 5, 6, 7, 8)
    AND (A.mandant_id, A.kjmo) IN (
        SELECT (mandant_id, kjmo)
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
        GROUP BY
            mandant_id,
            kjmo
        QUALIFY ((RANK() OVER (PARTITION BY mandant_id ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_etl.sort_wg_liste
    )
    AND (
        A.mandant_id, A.art_id) IN (
        SELECT (mandant_id, art_id)
        FROM (
            SELECT DISTINCT *
            FROM `_kl_basis_nicht_gelistet`
        ) AS t7
    )
    AND (
        A.mandant_id, A.art_id) NOT IN (
        SELECT (mandant_id, art_id)
        FROM `_kl_basis_listung`
    )
GROUP BY
    A.mandant_id,
    A.art_id
HAVING SUM(A.menge) > 0;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_b` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
);


CREATE OR REPLACE TEMPORARY TABLE _artikel_nielsen_agg AS
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
    FROM dbp_etl.art_matching_nielsen_per_kmo
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
    WHERE mandant_id > 1
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


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_c1 AS
SELECT
    mandant_id,
    art_id,
    'C1' AS list_kz
FROM `_kl_basis_alle_gelistet` AS A
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
)
GROUP BY
    mandant_id,
    art_id;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_c1` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN `_artikel_nielsen_agg` AS C ON B.mandant_id = C.mandant_id AND B.art_nielsen_id = C.art_nielsen_id
    WHERE C.umsatz_ > 0
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_c2 AS
SELECT
    mandant_id,
    art_id,
    'C2' AS list_kz
FROM `_kl_basis_alle_gelistet` AS A
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
)
GROUP BY
    mandant_id,
    art_id;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_c2` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN `_artikel_nielsen_agg` AS C ON B.mandant_id = C.mandant_id AND B.art_nielsen_id = C.art_nielsen_id
    WHERE C.umsatz_ IS NULL
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_d1 AS
SELECT
    mandant_id,
    art_id,
    'D1' AS list_kz
FROM `_kl_basis_nicht_gelistet` AS A
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
)
GROUP BY
    mandant_id,
    art_id;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_d1` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN `_artikel_nielsen_agg` AS C ON B.mandant_id = C.mandant_id AND B.art_nielsen_id = C.art_nielsen_id
    WHERE C.umsatz_ > 0
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_d2 AS
SELECT
    mandant_id,
    art_id,
    'D2' AS list_kz
FROM `_kl_basis_nicht_gelistet` AS A
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
)
GROUP BY
    mandant_id,
    art_id;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_d2` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN `_artikel_nielsen_agg` AS C ON B.mandant_id = C.mandant_id AND B.art_nielsen_id = C.art_nielsen_id
    WHERE C.umsatz_ IS NULL
);


--gaps


CREATE OR REPLACE TEMPORARY TABLE _gaps AS
SELECT DISTINCT
    A.mandant_id,
    A.art_nielsen_id,
    A.art_id
FROM `_article_matching0` AS A
INNER JOIN `_artikel_nielsen_agg` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
WHERE B.umsatz_ > 0;


INSERT INTO `_kl_basis_listung`
(SELECT DISTINCT
    mandant_id,
    art_id,
    art_nielsen_id,
    'D1' AS list_kz
FROM `_gaps`
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
));


INSERT INTO `_kl_basis_listung`
(SELECT DISTINCT
    mandant_id,
    art_id,
    art_nielsen_id,
    'D2' AS list_kz
FROM `_article_matching0`
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
));


INSERT INTO dbp_etl.kl_basis_listung_kmo (mandant_id, art_id, art_nielsen_id, list_kz)
(
    SELECT *
    FROM `_kl_basis_listung`
    GROUP BY
        mandant_id,
        art_id,
        art_nielsen_id,
        list_kz
);


/*
_------------------------------------------------------------------------------
_ 3.) Die Kalkulation und Differenzierung fuer Artikel, die ueber Nielsen-CURRENT_DATE("Europe/Berlin")n
_     abgebildet werden muessen, erfolgt in den naechsten Schritten.
_------------------------------------------------------------------------------
*/


CREATE OR REPLACE TEMPORARY TABLE _sort_ist1 (
    wup_id INTEGER,
    mandant_id INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    kassenumsatz FLOAT64,
    anz_tage INTEGER,
    preis FLOAT64,
    list_kz STRING(2)
);


-- (1) Kz. A (alle Artikel aus Historie uebernehmen)


INSERT INTO `_sort_ist1` (wup_id, mandant_id, wg_id, art_id, kassenumsatz, anz_tage, preis, list_kz)
(
    SELECT
        A11.wup_id,
        A11.mandant_id,
        A12.wg_id,
        A11.art_id,
        CAST(SUM(A11.umsatz_netto + A11.umsatz_mwst_betrag) AS FLOAT64) AS kassenumsatz,
        COUNT(DISTINCT A11.dat) AS anz_tage,
        CAST(IFNULL(SUM(A11.umsatz_netto + A11.umsatz_mwst_betrag) / IF(SUM(A11.menge) = 0, NULL, SUM(A11.menge)), 0) AS FLOAT64)
            AS preis,
        X.list_kz
    FROM dbp_data.artbew AS A11
    INNER JOIN dbp_data.tag AS Y ON A11.dat = Y.dat
    INNER JOIN `_kl_basis_listung` AS X ON A11.mandant_id = X.mandant_id AND A11.art_id = X.art_id AND X.list_kz = 'A'
    INNER JOIN dbp_data.art_wg_zu_per AS A12
        ON
            A11.mandant_id = A12.mandant_id AND A11.art_id = A12.art_id
            AND A12.dat_bis = DATE '9999-12-31' AND A12.arthiertyp_id = 2
    INNER JOIN dbp_data.wup AS C ON A11.wup_id = C.wup_id AND A11.mandant_id = C.mandant_id
    WHERE
        A11.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 366 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        AND A11.mandant_id IN (2, 3, 5, 6, 7, 8)
        AND A11.bewart_id IN (1001, 1002)
        AND A12.wg_id IN (
            SELECT wg_id
            FROM dbp_etl.sort_wg_liste
        )
    GROUP BY
        A11.wup_id,
        A11.mandant_id,
        A12.wg_id,
        A11.art_id,
        X.list_kz
);


-- (2) Kz. B (alle Artikel aus Historie uebernehmen)


INSERT INTO `_sort_ist1` (wup_id, mandant_id, wg_id, art_id, kassenumsatz, anz_tage, preis, list_kz)
(
    SELECT
        A11.wup_id,
        A11.mandant_id,
        A12.wg_id,
        A11.art_id,
        CAST(SUM(A11.umsatz_netto + A11.umsatz_mwst_betrag) AS FLOAT64) AS kassenumsatz,
        COUNT(DISTINCT A11.dat) AS anz_tage,
        CAST(IFNULL(SUM(A11.umsatz_netto + A11.umsatz_mwst_betrag) / IF(SUM(A11.menge) = 0, NULL, SUM(A11.menge)), 0) AS FLOAT64)
            AS preis,
        X.list_kz
    FROM dbp_data.artbew AS A11
    INNER JOIN dbp_data.tag AS Y ON A11.dat = Y.dat
    INNER JOIN `_kl_basis_listung` AS X ON A11.mandant_id = X.mandant_id AND A11.art_id = X.art_id AND X.list_kz = 'B'
    INNER JOIN dbp_data.art_wg_zu_per AS A12
        ON
            A11.mandant_id = A12.mandant_id AND A11.art_id = A12.art_id
            AND A12.dat_bis = DATE '9999-12-31' AND A12.arthiertyp_id = 2
    INNER JOIN dbp_data.wup AS C ON A11.wup_id = C.wup_id AND A11.mandant_id = C.mandant_id
    WHERE
        A11.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 366 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        AND A11.mandant_id IN (2, 3, 5, 6, 7, 8)
        AND A11.bewart_id IN (1001, 1002)
        AND A12.wg_id IN (
            SELECT wg_id
            FROM dbp_etl.sort_wg_liste
        )
    GROUP BY
        A11.wup_id,
        A11.mandant_id,
        A12.wg_id,
        A11.art_id,
        X.list_kz
);


/*
_------------------------------------------------------------------------------
_ 4.) Ueberfuehrung der Artikel fuer Folgeprozesse.
_------------------------------------------------------------------------------
*/


INSERT INTO dbp_etl.sort_ist_kmo (
    wup_id, mandant_id, wg_id, art_id, kassenumsatz, anz_tage, preis,
    list_kz
)
(
    SELECT *
    FROM `_sort_ist1`
);


-- 16.03.2019, -dbay-
--
-- Ausgewaehlte OWGs, die von den ZEKs zum Zeitpunkt der Erstellung des MATs
-- in Verwendung sind, werden ueber die Pflegetabelle angezogen und hier die
-- Artikel, die nicht in der originaeren Listungstabelle drin sind, mit abge-
-- bildet, um selbige spaeter in die Kreuztabelle ueberfuehren zu koennen.
-- Wichtig fuer die Marktzaehlungen!


INSERT INTO dbp_etl.sort_ist_kmo (
    wup_id, mandant_id, wg_id, art_id, kassenumsatz, anz_tage, preis,
    list_kz
)
(
    SELECT
        A.wup_id,
        A.mandant_id,
        C.wg_id,
        A.art_id,
        CAST(0 AS FLOAT64) AS kassenumsatz,
        0 AS anz_tage,
        CAST(0 AS FLOAT64) AS preis,
        B.list_kz
    FROM dbp_data.art_list_wup_zu_per AS A
    INNER JOIN `_kl_basis_listung` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    INNER JOIN dbp_data.art_wg_zu_per AS C
        ON
            A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND C.arthiertyp_id
            = 2 AND C.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_data.wg_per AS E
        ON
            A.mandant_id = E.mandant_id AND C.wg_id = E.wg_id AND E.arthiertyp_id
            = 2 AND E.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_etl_process.sort_tool_owg_de AS F ON E.owg_id = F.owg_id
    INNER JOIN dbp_data.wup AS D
        ON
            A.wup_id = D.wup_id AND A.mandant_id = D.mandant_id AND CURRENT_DATE("Europe/Berlin")
            BETWEEN D.dat_von AND D.dat_bis AND D.nb_id = 0 AND D.wup_id >= 1000
    WHERE
        A.nb_id = 0
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
        AND A.list_komponente_fg = 0
        AND A.mandant_id IN (2, 3, 5, 6, 7, 8)
        AND (
            A.mandant_id, A.art_id, A.wup_id) NOT IN (
            SELECT (mandant_id, art_id, wup_id)
            FROM `_sort_ist1`
        )
        AND A.list_quelle_id NOT IN ('2')
    GROUP BY
        A.wup_id,
        A.mandant_id,
        C.wg_id,
        A.art_id,
        kassenumsatz,
        anz_tage,
        preis,
        B.list_kz
);
