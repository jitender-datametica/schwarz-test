CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_dat (
    dat_buch DATE NOT NULL,
    mandant_id INTEGER NOT NULL
);


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_dat_wwc (
    dat_buch DATE NOT NULL,
    mandant_id INTEGER NOT NULL,
    kjmo INTEGER,
    kjwo INTEGER
);


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_reichweite (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_buch DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS dbp_etl.gld_dat (
    dat DATE
);


INSERT INTO dbp_etl.kmo_mseg_dat (dat_buch, mandant_id)
(
    SELECT
        dat_buch,
        mandant_id
    FROM dbp_etl.kmo_mseg_delta
    WHERE
        mandant_id > 1
        AND (
            dat_buch, mandant_id) NOT IN (
            SELECT (dat_buch, mandant_id)
            FROM dbp_etl.kmo_mseg_dat
        )
    GROUP BY
        dat_buch,
        mandant_id
);


INSERT INTO dbp_etl.kmo_mseg_dat_wwc (dat_buch, mandant_id, kjmo, kjwo)
(
    SELECT
        T1.dat_buch,
        T1.mandant_id,
        T2.kjmo,
        T2.kjwo
    FROM dbp_etl.kmo_mseg_dat AS T1
    INNER JOIN dbp_data.tag AS T2 ON T1.dat_buch = T2.dat
    WHERE
        T1.mandant_id = 1
        AND (
            T1.dat_buch, T1.mandant_id) NOT IN (
            SELECT (dat_buch, mandant_id)
            FROM dbp_etl.kmo_mseg_dat_wwc
        )
    GROUP BY
        T1.dat_buch,
        T1.mandant_id,
        T2.kjmo,
        T2.kjwo
);


INSERT INTO dbp_etl.kmo_mseg_dat_wwc (dat_buch, mandant_id, kjmo, kjwo)
(
    SELECT
        T1.dat_buch,
        T1.mandant_id,
        T2.kjmo,
        T2.kjwo
    FROM dbp_etl.kmo_mseg_dat AS T1
    INNER JOIN dbp_data.tag AS T2 ON T1.dat_buch = T2.dat
    WHERE
        T1.mandant_id > 1
        AND (
            T1.dat_buch, T1.mandant_id) NOT IN (
            SELECT (dat_buch, mandant_id)
            FROM dbp_etl.kmo_mseg_dat_wwc
        )
    GROUP BY
        T1.dat_buch,
        T1.mandant_id,
        T2.kjmo,
        T2.kjwo
);


INSERT INTO dbp_etl.kmo_mseg_reichweite (mandant_id, wup_id, nb_id, dat_buch)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat_buch
    FROM dbp_etl.kmo_mseg_delta
    WHERE (
        mandant_id, wup_id, nb_id, dat_buch) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat_buch)
        FROM dbp_etl.kmo_mseg_reichweite
    )
    GROUP BY
        dat_buch,
        mandant_id,
        nb_id,
        wup_id
);


INSERT INTO dbp_etl.gld_dat (dat)
(
    SELECT dat_buch
    FROM dbp_etl.kmo_mseg_delta
    WHERE
        lager_bewart_id IN ('251', '252')
        AND dat_buch >= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 60 DAY)
        AND dat_buch NOT IN (
            SELECT dat
            FROM dbp_etl.gld_dat
        )
    GROUP BY dat_buch
);
