--==============================================================
-- Table: wup_plan_tag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_plan_tag
   generated from Powerdesigner on Dienstag, 25. März 2025 13:14:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_plan_tag (
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum'),
plan_tag_fg BIGNUMERIC(38,0)
OPTIONS(description='Wenn die Daten bereits in der SST auf der Ebene wup und Tag geliefert wurden: 1, sonst  0'),
umsatz_netto_plan NUMERIC(18,2) OPTIONS(description='geplanter Nettoumsatz'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
umsatz_netto_plan_extern NUMERIC(18,2) OPTIONS(description='umsatz_netto_plan_extern. Upload aus Excel'),
menge_absatz_ohne_pfand_plan BIGNUMERIC(38,3)
OPTIONS(description='Geplante Anzahl der zu verkaufenden Artikel (ohne Pfand-Artikel) auf  Ebene Filiale/Tag.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wup_id, nb_id, mandant_id, dat) NOT ENFORCED
) OPTIONS(description='VIS - Planwerte pro Markt und Tag');