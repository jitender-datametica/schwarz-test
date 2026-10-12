CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_dat_1 (
    dat_buch DATE NOT NULL,
    mandant_id INTEGER NOT NULL
);


CREATE TABLE IF NOT EXISTS dbp_etl.mseg_reichweite_1 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_buch DATE NOT NULL
);


INSERT INTO dbp_etl.kmo_mseg_dat_1 (dat_buch, mandant_id)
(
    SELECT
        dat_buch,
        mandant_id
    FROM dbp_etl.de_mseg_delta_1
    WHERE
        mandant_id = 1
        AND (
            dat_buch, mandant_id) NOT IN (
            SELECT (dat_buch, mandant_id)
            FROM dbp_etl.kmo_mseg_dat_1
        )
    GROUP BY
        dat_buch,
        mandant_id
);


INSERT INTO dbp_etl.mseg_reichweite_1 (mandant_id, wup_id, nb_id, dat_buch)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat_buch
    FROM dbp_etl.de_mseg_delta_1
    WHERE
        mandant_id = 1
        AND (
            mandant_id, wup_id, nb_id, dat_buch) NOT IN (
            SELECT (mandant_id, wup_id, nb_id, dat_buch)
            FROM dbp_etl.mseg_reichweite_1
        )
    GROUP BY
        dat_buch,
        mandant_id,
        nb_id,
        wup_id
);
