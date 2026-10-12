--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.fww_wme_kopf;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.fww_wme_kopf (
    mandant STRING(3),
    aktionsnummer STRING(10) COLLATE 'und:ci',
    aktionsart STRING(4),
    werbekategorie STRING(18),
    gueltig_ab STRING(10),
    gueltig_bis STRING(10),
    status STRING(1),
    werbekategorie_bez STRING(60),
    aktionsart_bez STRING(20),
    spras STRING(1)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.fww_wme_kopf_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.fww_wme_kopf_tmp (
    mandant_id INTEGER,
    sap_werbe_kat_id STRING(4),
    werbe_kat_id INTEGER,
    werbekategorie_bez STRING(40),
    spras STRING(1) COLLATE 'und:ci'
);
