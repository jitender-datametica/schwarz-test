CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen_1
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _step1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.art_nielsen_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    B.nielsen_wg_bez,
    B.nielsen_uwg1_bez,
    B.nielsen_uwg2_bez
FROM dbp_etl.art_matching_nielsen_per_kmo_1 AS A
INNER JOIN
    `_art_nielsen` AS B
    ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
WHERE
    A.mandant_id > 1
    AND A.art_id <> -1
    AND A.art_nielsen_id <> -1
GROUP BY
    A.mandant_id,
    A.art_id,
    A.art_nielsen_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    B.nielsen_wg_bez,
    B.nielsen_uwg1_bez,
    B.nielsen_uwg2_bez;


CREATE OR REPLACE TEMPORARY TABLE _step2 AS
SELECT
    nielsen_uwg2_bez,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    COUNT(*) AS anz
FROM `_step1`
GROUP BY
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    nielsen_uwg2_bez;


CREATE OR REPLACE TEMPORARY TABLE _step3 AS
SELECT
    A.nielsen_uwg2_bez,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    A.anz
FROM `_step2` AS A
INNER JOIN (SELECT
    nielsen_uwg2_bez,
    MAX(anz) AS max_anz
FROM `_step2`
GROUP BY nielsen_uwg2_bez) AS b
    ON A.nielsen_uwg2_bez = b.nielsen_uwg2_bez AND A.anz = b.max_anz;


CREATE OR REPLACE TEMPORARY TABLE _step4 AS
SELECT
    A.nielsen_uwg2_bez,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    A.anz
FROM `_step3` AS A
INNER JOIN (SELECT
    nielsen_uwg2_bez,
    kl_wg_id
FROM (SELECT
    nielsen_uwg2_bez,
    MAX(kl_wg_id) AS kl_wg_id,
    COUNT(*) AS a0
FROM `_step3`
GROUP BY nielsen_uwg2_bez
HAVING a0 > 1) AS t0) AS b
    ON A.nielsen_uwg2_bez = b.nielsen_uwg2_bez AND A.kl_wg_id = b.kl_wg_id
INNER JOIN (
    SELECT
        nielsen_uwg2_bez,
        kl_wg_id,
        MAX(kl_owg_id) AS kl_owg_id
    FROM `_step3`
    GROUP BY
        nielsen_uwg2_bez,
        kl_wg_id
) AS c
    ON
        A.nielsen_uwg2_bez = c.nielsen_uwg2_bez
        AND A.kl_wg_id = c.kl_wg_id
        AND A.kl_owg_id = c.kl_owg_id
INNER JOIN (
    SELECT
        nielsen_uwg2_bez,
        kl_wg_id,
        kl_owg_id,
        MAX(kl_uwg_id) AS kl_uwg_id
    FROM `_step3`
    GROUP BY
        nielsen_uwg2_bez,
        kl_wg_id,
        kl_owg_id
) AS d
    ON
        A.nielsen_uwg2_bez = d.nielsen_uwg2_bez
        AND A.kl_wg_id = d.kl_wg_id
        AND A.kl_owg_id = d.kl_owg_id
        AND A.kl_uwg_id = d.kl_uwg_id;


DELETE FROM `_step3`
WHERE nielsen_uwg2_bez IN (
    SELECT nielsen_uwg2_bez
    FROM `_step4`
);


INSERT INTO `_step3`
(
    SELECT *
    FROM `_step4`
);


CREATE OR REPLACE TEMPORARY TABLE _pflege01 AS
SELECT *
FROM `_art_nielsen`
WHERE
    mandant_id > 1
    AND (
        mandant_id, art_nielsen_id) IN (
        SELECT (mandant_id, art_nielsen_id)
        FROM dbp_etl.art_matching_nielsen_per_kmo_1
        WHERE
            art_id = -1
            AND mandant_id > 1
    )
    AND (
        mandant_id, art_nielsen_id) NOT IN (
        SELECT (mandant_id, art_nielsen_id)
        FROM dbp_data.art_nielsen_wug_zu_pflege_1
        WHERE mandant_id > 1
    );


CREATE OR REPLACE TEMPORARY TABLE _pflege02 AS
SELECT
    mandant_id,
    art_nielsen_id,
    CAST(-1 AS INTEGER) AS kl_wg_id,
    CAST(-1 AS INTEGER) AS kl_owg_id,
    CAST(-1 AS INTEGER) AS kl_uwg_id,
    nielsen_uwg2_bez
FROM `_pflege01` AS A
GROUP BY
    mandant_id,
    art_nielsen_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    nielsen_uwg2_bez;


UPDATE `_pflege02` SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
FROM `_step3` AS b
WHERE `_pflege02`.nielsen_uwg2_bez = b.nielsen_uwg2_bez;


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
        B.mandant_id > 1
        AND A.kl_wg_id NOT IN (0, -1, -3)
        AND A.kl_owg_id NOT IN (0, -1, -3)
        AND (
            A.mandant_id, A.art_nielsen_id) NOT IN (
            SELECT (mandant_id, art_nielsen_id)
            FROM dbp_data.art_nielsen_wug_zu_pflege_1
            WHERE mandant_id > 1
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
