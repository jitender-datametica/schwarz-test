--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.d_tanktresor_help_kunden_2;


CREATE TABLE IF NOT EXISTS dbp_etl.d_tanktresor_help_kunden_2 (
    marktnummer STRING(4) COLLATE 'und:ci',
    wg_text STRING(40) COLLATE 'und:ci',
    schluessel2 STRING(20) COLLATE 'und:ci',
    wert STRING(9) COLLATE 'und:ci',
    datum STRING(10) COLLATE 'und:ci'
);
