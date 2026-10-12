--==============================================================
-- Table: kl_listung_kmo
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kl_listung_kmo
   generated from Powerdesigner on Donnerstag, 7. Oktober 2021 17:10:30
*/ --------------------------------------------------------------------------------


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.kl_listung_kmo (
kl_listung_kmo_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Automatischer generierter Schluessel'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
listung_art STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Vorschlagswert bezueglich Listung aus Stored Procedure (z.B. Listung erweitern)'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum'),
sm_id_selected BIGNUMERIC(38,0) DEFAULT - 1
OPTIONS(description='Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet'),
ksm_id_selected STRING(4) COLLATE 'und:ci'
OPTIONS(description='Kaufland Sortimentsmodul, das in den KMO Laendern eingefuehrt wurde fuer parallele Listungen zu sm_id.'),
sm_id BIGNUMERIC(38,0) DEFAULT - 1
OPTIONS(description='Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet'),
ksm_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Kaufland Sortimentsmodul, das in den KMO Laendern eingefuehrt wurde fuer parallele Listungen zu sm_id.'),
umsatz_hr NUMERIC(18,4) NOT NULL
OPTIONS(description='Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)'),
absatz_hr NUMERIC(18,4) NOT NULL
OPTIONS(description='Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)'),
rohertrag_hr NUMERIC(18,4) NOT NULL
OPTIONS(description='Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)'),
erweiterung_fg BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='Flag, wenn Listungserweiterung'),
reduktion_fg BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='Flag, wenn Listungsreduktion'),
kjwo_update BIGNUMERIC(38,0) DEFAULT 999912 NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
list_kz STRING(2) COLLATE 'und:ci' OPTIONS(description='Flag, wenn aktuell gelistet'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) CLUSTER BY mandant_id, kjwo_update
OPTIONS(description='EK-SORT -  Sortimentstool - Tabelle fuer KMO fuer Zwischenablage der Hochrechnungsergebnisse KL-Artikel ');