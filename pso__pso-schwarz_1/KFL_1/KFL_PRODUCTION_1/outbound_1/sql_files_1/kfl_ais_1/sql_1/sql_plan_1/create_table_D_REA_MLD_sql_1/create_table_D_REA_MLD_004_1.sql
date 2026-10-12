--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.rea_inlist_1;


CREATE TABLE IF NOT EXISTS dbp_etl.rea_inlist_1 (
    artikelnummer INTEGER NOT NULL,
    td_insert TIMESTAMP
);
