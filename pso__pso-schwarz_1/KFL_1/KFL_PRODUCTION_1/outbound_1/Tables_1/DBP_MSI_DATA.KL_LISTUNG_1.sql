--==============================================================
-- Table: kl_listung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kl_listung_1
   generated from Powerdesigner on Donnerstag, 7. Oktober 2021 16:56:46
*/ --------------------------------------------------------------------------------


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.kl_listung_1 (
kl_listung_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Automatischer generierter Schluessel'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
listung_art STRING(100) NOT NULL
OPTIONS(description='Vorschlagswert bezueglich Listung aus Stored Procedure (z.B. Listung erweitern)'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum'),
sm_id_selected BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet'),
sm_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet'),
ost_basis STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
ost_gross STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
sued_ost STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
sued_west STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
west STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
nord STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
umsatz_hr NUMERIC(18,4) OPTIONS(description='Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)'),
absatz_hr NUMERIC(18,4) OPTIONS(description='Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)'),
rohertrag_hr NUMERIC(18,4) OPTIONS(description='Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)'),
kjwo_update BIGNUMERIC(38,0) DEFAULT 999912 NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
erweiterung_fg BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='Flag, wenn Listungserweiterung'),
reduktion_fg BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='Flag, wenn Listungsreduktion'),
list_kz STRING(2) COLLATE 'und:ci' DEFAULT '' OPTIONS(description='Flag, wenn aktuell gelistet'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) CLUSTER BY kjwo_update, art_id
OPTIONS(description='EK-INTEGER  -  Sortimentstool - Tabelle fuer Zwischenablage der Hochrechnungsergebnisse KL-Artikel_1');