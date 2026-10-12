--==============================================================
-- Table: ausnahme_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausnahme_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ausnahme_2 (
ausnahme_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID einer Ausnahme_2 aus msghdl'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig);            Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)            Regel: Neuer Artikel_2 -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warenumschlagsplatz - Hier die Ziel-Lokation der Ausnahme_2'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_plan DATE NOT NULL OPTIONS(description='Planungsdatum'),
pruef_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Prüfungsgrund ID'),
z_arbeitsgebiet_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In FuR gibt es die Arbeitsgebeite FRE_EMON für Märkte und Z_FRE für VZs. Wird im DWH in 1 und 0 umgesetzt. Offen für weitere Arbeitsgebiete'),
gp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID) - Hier die Quell-Lokation Lager oder Lieferant'),
ausnahme_mutter_id STRING(32) COLLATE 'und:ci'
OPTIONS(description='Hier ist bei zusammengehörigen Ausnahmen die übergeordnete ausnahme_id gespeichert, aus high_level_ref'),
ausnahme_menge_bme NUMERIC(9,3)
OPTIONS(description='Menge in Basismengeneinheiten. Nur gefüllt bei Prüfgrund 210 und Arbeitsgebiet ZFRE'),
ausnahme_menge_kolli NUMERIC(9,3)
OPTIONS(description='Menge in Kolli. Nur gefüllt bei Prüfgrund 210 und Arbeitsgebiet ZFRE'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat_plan
OPTIONS(description='AIS - Die Ausnahmen von den Bestellvorschlaegen F&R ');