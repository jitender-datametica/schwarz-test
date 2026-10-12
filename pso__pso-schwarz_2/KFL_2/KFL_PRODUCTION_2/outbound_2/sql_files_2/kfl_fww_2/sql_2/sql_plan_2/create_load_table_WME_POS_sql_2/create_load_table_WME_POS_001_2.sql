--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.fww_wme_pos_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.fww_wme_pos_2 (
mandant_2 STRING(3),
aktionsnummer STRING(10) COLLATE 'und:ci',
markt INTEGER,
artikelnummer INTEGER,
aktionspreis NUMERIC(9,3),
waehrung_id STRING(3),
bezugsquelle INTEGER,
sperrkennzeichen STRING(1),
sperrdatum STRING(10),
aktionsthema STRING(4),
aktionsthema_bez STRING(20)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.fww_wme_pos_tmp_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.fww_wme_pos_tmp_2 (
mandant_2 STRING(3),
aktionsthema STRING(4),
aktionsthema_bez STRING(20),
spras STRING(1) COLLATE 'und:ci'
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.aktion_art_wup_zu_fdenorm_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.aktion_art_wup_zu_fdenorm_2 (
mandant_id INTEGER NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
art_id INTEGER NOT NULL,
bewart_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
vk_aktion_brutto NUMERIC(9,3) NOT NULL,
bezugsweg_id INTEGER NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
grund_sperrung STRING(1) COLLATE 'und:ci',
dat_sperrung DATE,
aktion_thema_id STRING(4) NOT NULL
);