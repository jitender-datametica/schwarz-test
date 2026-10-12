CREATE OR REPLACE TEMPORARY TABLE _vkset_potentials_kopf AS
SELECT
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_parent_pos_sort_id
FROM dbp_etl.kmo_mseg_delta_1
WHERE
    lagerbew_beleg_parent_pos_sort_id <> 0
    AND lager_bewart_id IN ('317', '319')
GROUP BY
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_parent_pos_sort_id;


CREATE OR REPLACE TEMPORARY TABLE _vkset_potentials AS
SELECT
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_pos_sort_id
FROM dbp_etl.kmo_mseg_delta_1
WHERE
    (mandant_id, lagerbew_beleg_id, dat_buch, lagerbew_beleg_pos_sort_id) IN (
        SELECT (
            mandant_id, lagerbew_beleg_id,
            dat_buch, lagerbew_beleg_parent_pos_sort_id
        )
        FROM `_vkset_potentials_kopf`
    )
GROUP BY
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_pos_sort_id;


CREATE OR REPLACE TEMPORARY TABLE _vkset_updates AS
SELECT
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_pos_sort_id,
    art_id
FROM dbp_etl.kmo_mseg_delta_1
WHERE
    (mandant_id, lagerbew_beleg_id, dat_buch, lagerbew_beleg_pos_sort_id) IN (
        SELECT (
            mandant_id, lagerbew_beleg_id,
            dat_buch, lagerbew_beleg_pos_sort_id
        )
        FROM `_vkset_potentials`
    )
GROUP BY
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_pos_sort_id,
    art_id;


UPDATE dbp_etl.kmo_mseg_delta_1 SET
    display_art_id = -1
WHERE TRUE;


UPDATE dbp_etl.kmo_mseg_delta_1 SET
    display_art_id = b.art_id
FROM `_vkset_updates` AS b
WHERE
    kmo_mseg_delta.mandant_id = b.mandant_id
    AND kmo_mseg_delta.lagerbew_beleg_id = b.lagerbew_beleg_id
    AND kmo_mseg_delta.dat_buch = b.dat_buch AND kmo_mseg_delta.lagerbew_beleg_parent_pos_sort_id = b.lagerbew_beleg_pos_sort_id;


UPDATE dbp_etl.kmo_mseg_delta_1 SET
    display_art_id = b.art_id
FROM `_vkset_updates` AS b
WHERE
    kmo_mseg_delta.mandant_id = b.mandant_id
    AND kmo_mseg_delta.lagerbew_beleg_id = b.lagerbew_beleg_id
    AND kmo_mseg_delta.dat_buch = b.dat_buch AND kmo_mseg_delta.lagerbew_beleg_pos_sort_id = b.lagerbew_beleg_pos_sort_id;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_dat_1 (
    dat_buch DATE NOT NULL,
    mandant_id INTEGER NOT NULL
);


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_dat_wwc_1 (
    dat_buch DATE NOT NULL,
    mandant_id INTEGER NOT NULL,
    kjmo INTEGER,
    kjwo INTEGER
);


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_reichweite_1 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_buch DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS dbp_etl.gld_dat_1 (
    dat DATE
);


INSERT INTO dbp_etl.kmo_mseg_dat_1 (dat_buch, mandant_id)
(
    SELECT
        dat_buch,
        mandant_id
    FROM dbp_etl.kmo_mseg_delta_1
    WHERE
        mandant_id > 1
        AND (
            dat_buch, mandant_id) NOT IN (
            SELECT (dat_buch, mandant_id)
            FROM dbp_etl.kmo_mseg_dat_1
        )
    GROUP BY
        dat_buch,
        mandant_id
);


INSERT INTO dbp_etl.kmo_mseg_dat_wwc_1 (dat_buch, mandant_id, kjmo, kjwo)
(
    SELECT
        T1.dat_buch,
        T1.mandant_id,
        T2.kjmo,
        T2.kjwo
    FROM dbp_etl.kmo_mseg_dat_1 AS T1_1
    INNER JOIN dbp_data.tag_1 AS T2 ON T1.dat_buch = T2.dat
    WHERE
        T1.mandant_id = 1
        AND (
            T1.dat_buch, T1.mandant_id) NOT IN (
            SELECT (dat_buch, mandant_id)
            FROM dbp_etl.kmo_mseg_dat_wwc_1
        )
    GROUP BY
        T1.dat_buch,
        T1.mandant_id,
        T2.kjmo,
        T2.kjwo
);


INSERT INTO dbp_etl.kmo_mseg_dat_wwc_1 (dat_buch, mandant_id, kjmo, kjwo)
(
    SELECT
        T1.dat_buch,
        T1.mandant_id,
        T2.kjmo,
        T2.kjwo
    FROM dbp_etl.kmo_mseg_dat_1 AS T1_1
    INNER JOIN dbp_data.tag_1 AS T2 ON T1.dat_buch = T2.dat
    WHERE
        T1.mandant_id > 1
        AND (
            T1.dat_buch, T1.mandant_id) NOT IN (
            SELECT (dat_buch, mandant_id)
            FROM dbp_etl.kmo_mseg_dat_wwc_1
        )
    GROUP BY
        T1.dat_buch,
        T1.mandant_id,
        T2.kjmo,
        T2.kjwo
);


INSERT INTO dbp_etl.kmo_mseg_reichweite_1 (mandant_id, wup_id, nb_id, dat_buch)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat_buch
    FROM dbp_etl.kmo_mseg_delta_1
    WHERE (
        mandant_id, wup_id, nb_id, dat_buch) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat_buch)
        FROM dbp_etl.kmo_mseg_reichweite_1
    )
    GROUP BY
        dat_buch,
        mandant_id,
        nb_id,
        wup_id
);


INSERT INTO dbp_etl.gld_dat_1 (dat)
(
    SELECT dat_buch
    FROM dbp_etl.kmo_mseg_delta_1
    WHERE
        lager_bewart_id IN ('251', '252')
        AND dat_buch >= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 60 DAY)
        AND dat_buch NOT IN (
            SELECT dat
            FROM dbp_etl.gld_dat_1
        )
    GROUP BY dat_buch
);
