--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.wsoh;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.wsoh (
    mandt INTEGER NOT NULL,
    sart STRING(1) COLLATE 'und:ci',
    skopf INTEGER NOT NULL,
    vtext STRING(40) COLLATE 'und:ci',
    datab DATE,
    datub DATE,
    lvorm STRING(1) COLLATE 'und:ci'
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.wsof;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.wsof (
    mandt INTEGER NOT NULL,
    sart STRING(1) COLLATE 'und:ci',
    skopf INTEGER NOT NULL,
    filiale INTEGER NOT NULL,
    datuv DATE,
    datub DATE NOT NULL,
    lvorm STRING(1) COLLATE 'und:ci'
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.wsop;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.wsop (
    mandt INTEGER NOT NULL,
    sart STRING(1) COLLATE 'und:ci',
    skopf INTEGER NOT NULL,
    sposi INTEGER NOT NULL,
    datuv DATE,
    datub DATE NOT NULL,
    akz STRING(1) COLLATE 'und:ci',
    stcklst INTEGER NOT NULL,
    lvorm STRING(1) COLLATE 'und:ci'
);
