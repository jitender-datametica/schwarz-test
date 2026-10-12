CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen_1
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TABLE dbp_etl.not_listed_basis_1 (
    mandant_id INTEGER,
    art_matching_id INTEGER,
    art_id INTEGER,
    gtin_id INTEGER,
    list_kz STRING(2) COLLATE 'und:ci'
);


CREATE OR REPLACE TEMPORARY TABLE _not_listed_basis1 AS
SELECT
    a.mandant_id,
    D.art_matching_id,
    a.art_id,
    C.gtin_id,
    a.list_kz
FROM (SELECT DISTINCT
    mandant_id,
    art_id,
    list_kz
FROM dbp_etl.kl_basis_listung_1) AS a
INNER JOIN
    dbp_etl_process.art_gtin_1 AS B
    ON a.mandant_id = B.mandant_id AND a.art_id = B.art_id
INNER JOIN
    `_art_nielsen` AS C
    ON a.mandant_id = C.mandant_id AND B.gtin_id = C.gtin_id
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS D
    ON
        a.mandant_id = D.mandant_id AND a.art_id = D.art_id
        AND C.gtin_id = D.gtin_id
WHERE a.list_kz IN ('C1', 'C2', 'D1', 'D2', 'X')
GROUP BY
    a.mandant_id,
    D.art_matching_id,
    a.art_id,
    C.gtin_id,
    a.list_kz;


INSERT INTO `_not_listed_basis1`
(
    SELECT
        a.mandant_id,
        D.art_matching_id,
        a.art_id,
        C.gtin_id,
        a.list_kz
    FROM (SELECT DISTINCT
        mandant_id,
        art_id,
        list_kz
    FROM dbp_etl.kl_basis_listung_1) AS a
    INNER JOIN
        dbp_etl_process.art_gtin_1 AS B
        ON a.mandant_id = B.mandant_id AND a.art_id = B.art_id
    INNER JOIN
        `_art_nielsen` AS C
        ON a.mandant_id = C.mandant_id AND B.gtin_id = C.gtin_id
    INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS D
        ON
            a.mandant_id = D.mandant_id AND a.art_id = D.art_id
            AND C.gtin_id = D.gtin_id
    WHERE
        a.list_kz IN ('A', 'B')
        AND D.art_matching_id IN (
            SELECT art_matching_id
            FROM `_not_listed_basis1`
        )
    GROUP BY
        a.mandant_id,
        D.art_matching_id,
        a.art_id,
        C.gtin_id,
        a.list_kz
);


--- check for flagging the article constellations


DELETE FROM `_not_listed_basis1`
WHERE art_matching_id IN (
    SELECT art_matching_id
    FROM `_not_listed_basis1`
    GROUP BY art_matching_id
    HAVING MIN(list_kz) IN ('A', 'B')
);


CREATE OR REPLACE TEMPORARY TABLE _not_listed_basis2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    MAX(A.art_id) AS art_id,
    A.gtin_id,
    A.list_kz
FROM `_not_listed_basis1` AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        gtin_id,
        MIN(list_kz) AS min_list_kz
    FROM `_not_listed_basis1`
    GROUP BY
        mandant_id,
        art_matching_id,
        gtin_id
) AS b
    ON
        A.mandant_id = b.mandant_id
        AND A.art_matching_id = b.art_matching_id
        AND A.gtin_id = b.gtin_id
        AND A.list_kz = b.min_list_kz
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.gtin_id,
    A.list_kz;


INSERT INTO dbp_etl.not_listed_basis_1 (
    mandant_id, art_matching_id, art_id, gtin_id, list_kz
)
(
    SELECT *
    FROM `_not_listed_basis2`
);


-- Maximale Auspraegung fuer OWG --


CREATE OR REPLACE TEMPORARY TABLE _owg_ct AS
SELECT
    B.nielsen_wg_bez AS owg_bez,
    A.kl_wg_id AS owg_id,
    COUNT(*) AS anz
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN
    `_art_nielsen` AS B
    ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
WHERE
    A.mandant_id = 1
    AND B.nielsen_wg_bez <> '-1'
    AND A.kl_owg_id BETWEEN 120 AND 665
    AND A.kl_wg_id NOT IN (-1, -3)
    AND A.kl_owg_id NOT IN (-1, -3)
    AND A.kl_uwg_id NOT IN (-1, -3)
GROUP BY
    owg_bez,
    owg_id;


CREATE OR REPLACE TEMPORARY TABLE _owg_ct_max AS
SELECT
    A.owg_bez,
    MAX(A.owg_id) AS owg_id
FROM `_owg_ct` AS A
INNER JOIN (SELECT
    owg_bez,
    MAX(anz) AS max_anz
FROM `_owg_ct`
GROUP BY owg_bez) AS b ON A.owg_bez = b.owg_bez AND A.anz = b.max_anz
GROUP BY A.owg_bez;


-- Maximale Auspraegung fuer WG --


CREATE OR REPLACE TEMPORARY TABLE _wg_ct AS
SELECT
    X.owg_bez,
    B.nielsen_uwg1_bez AS wg_bez,
    A.kl_owg_id AS wg_id,
    COUNT(*) AS anz
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN
    `_art_nielsen` AS B
    ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN `_owg_ct_max` AS X ON B.nielsen_wg_bez = X.owg_bez
WHERE
    A.mandant_id = 1
    AND A.kl_owg_id BETWEEN 120 AND 665
    AND A.kl_wg_id NOT IN (-1, -3)
    AND A.kl_owg_id NOT IN (-1, -3)
    AND A.kl_uwg_id NOT IN (-1, -3)
GROUP BY
    X.owg_bez,
    wg_bez,
    wg_id;


CREATE OR REPLACE TEMPORARY TABLE _wg_ct_max AS
SELECT
    A.owg_bez,
    A.wg_bez,
    MAX(A.wg_id) AS wg_id
FROM `_wg_ct` AS A
INNER JOIN (
    SELECT
        owg_bez,
        wg_bez,
        MAX(anz) AS max_anz
    FROM `_wg_ct`
    GROUP BY
        owg_bez,
        wg_bez
) AS b ON A.owg_bez = b.owg_bez AND A.wg_bez = b.wg_bez AND A.anz = b.max_anz
GROUP BY
    A.owg_bez,
    A.wg_bez;


-- Maximale Auspraegung fuer WGI --


CREATE OR REPLACE TEMPORARY TABLE _wgi_ct AS
SELECT
    X.owg_bez,
    B.nielsen_uwg1_bez AS wg_bez,
    B.nielsen_uwg2_bez AS wug_bez,
    A.kl_uwg_id AS wug_id,
    COUNT(*) AS anz
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN
    `_art_nielsen` AS B
    ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN
    `_wg_ct_max` AS X
    ON B.nielsen_wg_bez = X.owg_bez AND B.nielsen_uwg1_bez = X.wg_bez
WHERE
    A.mandant_id = 1
    AND A.kl_owg_id BETWEEN 120 AND 665
    AND A.kl_wg_id NOT IN (-1, -3)
    AND A.kl_owg_id NOT IN (-1, -3)
    AND A.kl_uwg_id NOT IN (-1, -3)
GROUP BY
    X.owg_bez,
    wg_bez,
    wug_bez,
    wug_id;


CREATE OR REPLACE TEMPORARY TABLE _wgi_ct_max AS
SELECT
    A.owg_bez,
    A.wg_bez,
    A.wug_bez,
    MAX(A.wug_id) AS wug_id
FROM `_wgi_ct` AS A
INNER JOIN (
    SELECT
        owg_bez,
        wg_bez,
        wug_bez,
        MAX(anz) AS max_anz
    FROM `_wgi_ct`
    GROUP BY
        owg_bez,
        wg_bez,
        wug_bez
) AS b
    ON
        A.owg_bez = b.owg_bez
        AND A.wg_bez = b.wg_bez
        AND A.wug_bez = b.wug_bez
        AND A.anz = b.max_anz
GROUP BY
    A.owg_bez,
    A.wg_bez,
    A.wug_bez;


CREATE OR REPLACE TEMPORARY TABLE _pflege01 AS
SELECT *
FROM `_art_nielsen`
WHERE
    mandant_id = 1
    AND (
        mandant_id, art_nielsen_id) IN (
        SELECT (mandant_id, art_nielsen_id)
        FROM dbp_etl.art_matching_nielsen_per_1
        WHERE
            art_id = -1
            AND mandant_id = 1
    )
    AND (
        mandant_id, art_nielsen_id) NOT IN (
        SELECT (mandant_id, art_nielsen_id)
        FROM dbp_data.art_nielsen_wug_zu_pflege_1
        WHERE mandant_id = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _pflege02 AS
SELECT
    mandant_id,
    art_nielsen_id,
    CAST(-1 AS INTEGER) AS kl_wg_id,
    CAST(-1 AS INTEGER) AS kl_owg_id,
    CAST(-1 AS INTEGER) AS kl_uwg_id,
    nielsen_wg_bez,
    nielsen_uwg1_bez,
    nielsen_uwg2_bez
FROM `_pflege01` AS A
GROUP BY
    mandant_id,
    art_nielsen_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    nielsen_wg_bez,
    nielsen_uwg1_bez,
    nielsen_uwg2_bez;


UPDATE `_pflege02` SET
    kl_wg_id = b.owg_id FROM (SELECT
    owg_bez,
    MAX(owg_id) AS owg_id
FROM `_owg_ct_max`
GROUP BY owg_bez) AS b
WHERE `_pflege02`.nielsen_wg_bez = b.owg_bez;


UPDATE `_pflege02` SET
    kl_owg_id = b.wg_id FROM (SELECT
    wg_bez,
    MAX(wg_id) AS wg_id
FROM `_wg_ct_max`
GROUP BY wg_bez) AS b
WHERE `_pflege02`.nielsen_uwg1_bez = b.wg_bez;


UPDATE `_pflege02` SET
    kl_uwg_id = b.wug_id FROM (SELECT
    wug_bez,
    MAX(wug_id) AS wug_id
FROM `_wgi_ct_max`
GROUP BY wug_bez) AS b
WHERE `_pflege02`.nielsen_uwg2_bez = b.wug_bez;


INSERT INTO dbp_data.art_nielsen_wug_zu_pflege_1
(
    SELECT
        A.mandant_id,
        A.art_nielsen_id,
        B.art_nielsen_bez,
        -1 AS fb_pflege_wg_id,
        -1 AS fb_pflege_wug_id,
        B.nielsen_abteilung_bez,
        B.nielsen_wg_bez,
        B.nielsen_uwg1_bez,
        B.nielsen_uwg2_bez,
        A.kl_owg_id AS kalk_vorschl_wg_id,
        A.kl_uwg_id AS kalk_vorschl_wug_id,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM `_pflege02` AS A
    INNER JOIN
        `_art_nielsen` AS B
        ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
    WHERE
        A.kl_wg_id NOT IN (0, -1, -3)
        AND A.kl_owg_id NOT IN (0, -1, -3)
        AND (
            A.mandant_id, A.art_nielsen_id) NOT IN (
            SELECT (mandant_id, art_nielsen_id)
            FROM dbp_data.art_nielsen_wug_zu_pflege_1
        )
);


UPDATE dbp_data.art_nielsen_wug_zu_pflege_1 SET
    kalk_vorschl_wug_id = b.wug_id FROM (
    SELECT
        mandant_id,
        wg_id,
        MIN(wug_id) AS wug_id
    FROM dbp_data.art_wg_zu_per_1
    WHERE
        arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
        AND wug_id >= 0
    GROUP BY
        mandant_id,
        wg_id
) AS b
WHERE
    art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id
    AND art_nielsen_wug_zu_pflege.kalk_vorschl_wg_id = b.wg_id
    AND (art_nielsen_wug_zu_pflege.mandant_id, art_nielsen_wug_zu_pflege.kalk_vorschl_wg_id, art_nielsen_wug_zu_pflege.kalk_vorschl_wug_id
    ) NOT IN (
        SELECT (mandant_id, wg_id, wug_id)
        FROM dbp_data.art_wg_zu_per_1
        WHERE
            arthiertyp_id = 2
            AND dat_bis = DATE '9999-12-31'
    );
