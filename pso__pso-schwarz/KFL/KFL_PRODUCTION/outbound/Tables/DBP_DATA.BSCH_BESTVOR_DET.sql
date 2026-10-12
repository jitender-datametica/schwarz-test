--==============================================================
-- Table: bsch_bestvor_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bsch_bestvor_det
   generated from Powerdesigner on Donnerstag, 25. Januar 2024 08:04:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bsch_bestvor_det (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
best_vor_nr INTEGER NOT NULL
OPTIONS(description='Bestellvorschlagsnummer, bei Bestellungen ohne Vorschlag die Bestellnummer aus der Tabelle besch_best'),
best_vor_pos BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bestellvorschlagsposition'),
dat_plan DATE NOT NULL OPTIONS(description='Planungsdatum'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige Artikelnummer'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
menge_best_vor NUMERIC(18,4) NOT NULL OPTIONS(description='Vorgeschlagene Menge'),
menge_best NUMERIC(18,4) NOT NULL OPTIONS(description='Bestellte Menge'),
status STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Status der Position:             "VB"  unveränderte Übernahme Vorschlag in Bestellung            "V0"  Vorschlag ohne Bestellung            "0B" Bestellung ohne Vorschlag            "V+" Bestellvorschlag erhöht            "V-" Bestellvorschlag reduziert            '),
best_vor_einh BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Faktor zur vorgeschlagenen Menge, umgerechnet über art_umrechnung_fakor_per'),
best_einh BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Faktor zur bestellten Menge, umgerechnet über art_umrechnung_fakor_per'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
bestellart_id STRING(4) COLLATE 'und:ci' DEFAULT '    ' NOT NULL
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
dat_lief_soll DATE OPTIONS(description='Soll-Lieferdatum aus ZFRE_BV (fur_best_vor)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (best_vor_nr, best_vor_pos, mandant_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat_plan
OPTIONS(description='AIS -  F&R - Aggregat der Bestellvorschläge - MULTISET  ab KW 19/12 entfällt die bisherige SST - wird jetzt aus der Tabelle fur_best_vor befüllt');