DROP TABLE IF EXISTS dbp_etl.useg_agg_dat_2;


CREATE TABLE IF NOT EXISTS dbp_etl.useg_agg_dat_2 (
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE,
    mandant_id INTEGER NOT NULL
);
