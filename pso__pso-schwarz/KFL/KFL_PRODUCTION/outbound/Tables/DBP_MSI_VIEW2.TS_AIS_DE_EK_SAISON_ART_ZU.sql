--==============================================================
-- Table: ts_ais_de_ek_saison_art_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ais_de_ek_saison_art_zu
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 16:08:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view2.ts_ais_de_ek_saison_art_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
ek_saison_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Cluster ID des zugehörigen Saisonclusters zum Artikel.'),
dat_gueltig_von DATE NOT NULL OPTIONS(description='Beginn Saison-Gültigkeitszeitraum des Artikels.'),
dat_gueltig_bis DATE NOT NULL OPTIONS(description='Ende Saison-Gültigkeitszeitraum des Artikels.'),
kl_art_id_liste_txt STRING(10000) NOT NULL,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, ek_saison_id, dat_gueltig_von) NOT ENFORCED
)
OPTIONS(description='AIS DE - Für eine bestimme Saison und Zeitraum werden Artikelgruppen gepflegt, welche aus dem Einkauf (Fachbereich) vorgegeben werden.             ACHTUNG: Diese Tabelle hier ist als Zischenlösung gedacht, bis der Prozess für den Umgang mit Transaction Service Tabellen, die Notwendigkeit Daten manuell ins DWH zu bringen, oder der Umgang mit nicht standardisierten geklärt ist.');