--==============================================================
-- Table: fur_art_wup_frp_ltz_lauf
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fur_art_wup_frp_ltz_lauf
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fur_art_wup_frp_ltz_lauf (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
standardabweichung NUMERIC(18,6) DEFAULT 0 NOT NULL
OPTIONS(description='Standardabweichung in Rückschauhorizont für Verbrauch'),
klassifikationsmittelwert NUMERIC(19,6) DEFAULT 0 NOT NULL OPTIONS(description='Klassifikationsmittelwert (classmean)'),
drehklasse_kz STRING(1) COLLATE 'und:ci' DEFAULT '0' NOT NULL
OPTIONS(description='Drehklasse auf Artikel-/ Markt-Kombination(z.B. A, B oder C (Schnell-, Mittel- und Langsamdreher )-wird im ETL-Prozess auf Basis der F&R-Daten ermittelt: Schwellwerte: A=80% des Absatz (Stückbedarf an Gesamtmenge), B= 15% des Absatz, C= 5% des Absatz)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id) NOT ENFORCED
) OPTIONS(description='SCM - F&R - Lokationsprduktdaten für / aus ltzt. FRP-Lauf - SAP F&R - /FRE/MATLOC_FRP');