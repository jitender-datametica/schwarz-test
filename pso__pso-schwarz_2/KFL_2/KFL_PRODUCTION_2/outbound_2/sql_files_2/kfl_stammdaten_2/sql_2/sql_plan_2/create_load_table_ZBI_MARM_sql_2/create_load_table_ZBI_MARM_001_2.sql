--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_marm_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_marm_2 (
    matnr INTEGER,
    matnr_char STRING(36) COLLATE 'und:ci',
    quellsystem STRING(2) COLLATE 'und:ci',
    meinh STRING(6) COLLATE 'und:ci',
    brgew NUMERIC(29, 3),
    gewei STRING(6) COLLATE 'und:ci',
    umrez NUMERIC(29, 3),
    umren NUMERIC(29, 3),
    laenge NUMERIC(29, 3),
    breite NUMERIC(29, 3),
    hoehe NUMERIC(29, 3),
    bezugsdatum DATE,
    mandant_id INTEGER,
    td_insert TIMESTAMP
);
