--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.gastro_finanz;


CREATE TABLE IF NOT EXISTS dbp_etl.gastro_finanz (
    marktnummer INTEGER,
    creationtime DATETIME,
    buchzeit DATETIME,
    neukz STRING(1),
    schluessel STRING(3),
    zm STRING(3),
    betrag NUMERIC(29, 2),
    info1 STRING(20),
    td_insert TIMESTAMP,
    td_update TIMESTAMP
);
