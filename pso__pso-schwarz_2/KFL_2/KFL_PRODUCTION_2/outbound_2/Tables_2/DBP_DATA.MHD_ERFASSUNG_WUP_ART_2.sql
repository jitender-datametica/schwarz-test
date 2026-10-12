--==============================================================
-- Table: mhd_erfassung_wup_art_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mhd_erfassung_wup_art_2
   generated from Powerdesigner on Donnerstag, 15. Dezember 2022 09:44:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mhd_erfassung_wup_art_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filialnummer'),
dat_erfassung DATE NOT NULL OPTIONS(description='Datum der zu erfassenden Artikel_2 im Format JJJJ-MM_2-TT'),
dat_mhd DATE NOT NULL OPTIONS(description='Mindesthaltbarkeits-Datum im Format JJJJ-MM_2-TT'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
art_anz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl der erfassten Artikel_2'),
basismenge_einh_id STRING(3) NOT NULL
OPTIONS(description='Id der Mengeneinheit. Anhand dieser ID wird pro Mandant_2 und Artikel_2 eine_2 Mengeneinheit eindeutig identifiziert.'),
mhd_erfassung_pruef_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Prüfkennzeichen für den Datensatz: 0 = ungeprüft, 1 = geprüft'),
listung_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag, ob Artikel_2 ausgelistet ist: 0 = nicht ausgelistet; 1 = ausgelistet'),
dat_erstellung DATE NOT NULL OPTIONS(description='Erstelldatum des Datensatzes im Format JJJJ-MM_2-TT'),
dat_aenderung DATE NOT NULL OPTIONS(description='Änderungsdatum des Datensatzes im Format JJJJ-MM_2-TT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, dat_erfassung, dat_mhd, art_id) NOT ENFORCED
) OPTIONS(description='Tabelle für MHD-Erfassung durch den Markt.');