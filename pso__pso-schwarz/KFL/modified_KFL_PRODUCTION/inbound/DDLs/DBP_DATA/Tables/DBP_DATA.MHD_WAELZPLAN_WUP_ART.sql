--==============================================================
-- Table: mhd_waelzplan_wup_art
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mhd_waelzplan_wup_art
   generated from Powerdesigner on Donnerstag, 15. Dezember 2022 09:45:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MHD_WAELZPLAN_WUP_ART (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER    NOT NULL COMMENT 'Filialnummer',
   kjwo                                INTEGER    NOT NULL COMMENT 'Kalenderjahreswoche, in der die Prüfung erfolgen soll. Format JJJJWW',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   waelzplan_pruef_id                  INTEGER    DEFAULT 0 NOT NULL COMMENT 'Prüf-ID für den Wälzplan. Lookuptabelle vorhanden (mhd_waelzplan_pruef_id_spr_zu).',
   wiederholungsrhythmus_wochen        INTEGER    DEFAULT 0 NOT NULL COMMENT 'Wiederholungsrhytmus in Wochen',
   kjwo_wiederholung                   INTEGER    COMMENT 'Kalenderjahreswoche, wann der Auftrag zur Wälzung erneut an den Markt gesendet wird. Format JJJJWW',
   dat_aenderung                       DATE            NOT NULL COMMENT 'Änderungsdatum des Datensatzes im Format JJJJ-MM-TT',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MHD_WAELZPLAN_WUP_ART PRIMARY KEY (mandant_id, wup_id, kjwo, art_id) NOT ENFORCED
)  COMMENT = 'Tabelle für die individuellen MHD Wälzpläne pro Filiale und Artikel';
