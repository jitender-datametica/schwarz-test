--==============================================================
-- Table: art_wup_pruefung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_pruefung_1
   generated from Powerdesigner on Mittwoch, 21. Februar 2024 15:26:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_pruefung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
pruef_prozess_typ_kz STRING(10) NOT NULL
OPTIONS(description='Kennzeichen des Prüf-Prozesses. Aktuell nur\'MAX\', in Zukunft weitere Prozesse geplant.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
dat_erstellung DATE NOT NULL OPTIONS(description='Erstelldatum der Prüfnachricht.'),
pruef_id STRING(3) NOT NULL
OPTIONS(description='ID des Prüfgrundes. Beinhalten unterschiedliche Nachrichten die zur Überprüfung an die Filialen gesendet werden können.'),
z_arbeitsgebiet_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Arbeitsgebiete. Ein Arbeits gebiet steht für die Nachrichtenklasse zu der die Nachricht gehört. Aktuell gibt es folgende Arbeitsgebiete: 0 = Z_FRE,  1 = Z_EMON und 4 = EWM. '),
pruef_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Status_1 der Überprüfung des Artikels in der Filiale. Aktuell nur 0 = ungeprüft, 1 = geprüft, weitere Stati in Zukunft möglich.'),
dat_pruefung DATE OPTIONS(description='Datum an dem der Prüfprozess als bestätigt markiert wurde.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, pruef_prozess_typ_kz, wup_id, nb_id, art_id, dat_erstellung) NOT ENFORCED
)
OPTIONS(description='Tabelle beinhaltet Prüfnachrichten für in den Filialen zu überprüfende Artikel. Der Inhalt der Nachricht und Prüfung kann sich je nach Prüfprozess unterscheiden');