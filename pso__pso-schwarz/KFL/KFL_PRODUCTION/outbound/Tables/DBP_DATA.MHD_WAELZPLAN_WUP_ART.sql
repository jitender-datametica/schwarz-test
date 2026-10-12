--==============================================================
-- Table: mhd_waelzplan_wup_art
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mhd_waelzplan_wup_art
   generated from Powerdesigner on Donnerstag, 15. Dezember 2022 09:45:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mhd_waelzplan_wup_art (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filialnummer'),
kjwo BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kalenderjahreswoche, in der die Prüfung erfolgen soll. Format JJJJWW'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
waelzplan_pruef_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Prüf-ID für den Wälzplan. Lookuptabelle vorhanden (mhd_waelzplan_pruef_id_spr_zu).'),
wiederholungsrhythmus_wochen BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Wiederholungsrhytmus in Wochen'),
kjwo_wiederholung BIGNUMERIC(38,0)
OPTIONS(description='Kalenderjahreswoche, wann der Auftrag zur Wälzung erneut an den Markt gesendet wird. Format JJJJWW'),
dat_aenderung DATE NOT NULL OPTIONS(description='Änderungsdatum des Datensatzes im Format JJJJ-MM-TT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, kjwo, art_id) NOT ENFORCED
) OPTIONS(description='Tabelle für die individuellen MHD Wälzpläne pro Filiale und Artikel');