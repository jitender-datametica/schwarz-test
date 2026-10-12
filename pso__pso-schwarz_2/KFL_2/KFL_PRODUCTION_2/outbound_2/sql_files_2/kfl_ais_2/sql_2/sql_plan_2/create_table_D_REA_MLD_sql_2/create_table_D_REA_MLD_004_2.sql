--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.rea_inlist_2;


CREATE TABLE IF NOT EXISTS dbp_etl.rea_inlist_2 (
    artikelnummer INTEGER NOT NULL,
    td_insert TIMESTAMP
);
