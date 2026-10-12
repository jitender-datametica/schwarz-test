--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.rea_inlist;


CREATE TABLE IF NOT EXISTS dbp_etl.rea_inlist (
    artikelnummer INTEGER NOT NULL,
    td_insert TIMESTAMP
);
