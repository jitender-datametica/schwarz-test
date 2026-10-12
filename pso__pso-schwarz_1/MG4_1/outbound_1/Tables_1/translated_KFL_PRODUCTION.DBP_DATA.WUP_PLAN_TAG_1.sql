CREATE OR REPLACE TABLE kfl_production_dbp_data.wup_plan_tag_1 (
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum'),
plan_tag_fg INTEGER
OPTIONS(description='Wenn die Daten bereits in der SST auf der Ebene wup_1 und Tag_1 geliefert wurden: 1, sonst  0'),
umsatz_netto_plan NUMERIC(18,2) OPTIONS(description='geplanter Nettoumsatz'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
umsatz_netto_plan_extern NUMERIC(18,2) OPTIONS(description='umsatz_netto_plan_extern. Upload aus Excel'),
menge_absatz_ohne_pfand_plan NUMERIC(29,3)
OPTIONS(description='Geplante Anzahl der zu verkaufenden Artikel_1 (ohne Pfand-Artikel_1) auf  Ebene Filiale/Tag.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wup_id, nb_id, mandant_id, dat) NOT ENFORCED
) OPTIONS(description='VIS - Planwerte pro Markt und Tag_1');