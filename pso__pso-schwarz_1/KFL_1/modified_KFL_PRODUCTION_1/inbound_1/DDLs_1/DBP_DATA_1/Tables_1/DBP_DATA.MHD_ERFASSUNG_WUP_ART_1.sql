--==============================================================
-- Table: mhd_erfassung_wup_art_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mhd_erfassung_wup_art_1
   generated from Powerdesigner on Donnerstag, 15. Dezember 2022 09:44:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MHD_ERFASSUNG_WUP_ART_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER    NOT NULL COMMENT 'Filialnummer',
   dat_erfassung                       DATE            NOT NULL COMMENT 'Datum der zu erfassenden Artikel_1 im Format JJJJ-MM_1-TT',
   dat_mhd                             DATE            NOT NULL COMMENT 'Mindesthaltbarkeits-Datum im Format JJJJ-MM_1-TT',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   art_anz                             INTEGER    NOT NULL COMMENT 'Anzahl der erfassten Artikel_1',
   basismenge_einh_id                  VARCHAR(3)      NOT NULL COMMENT 'Id der Mengeneinheit. Anhand dieser ID wird pro Mandant_1 und Artikel_1 eine_1 Mengeneinheit eindeutig identifiziert.',
   mhd_erfassung_pruef_fg              INTEGER    DEFAULT 0 NOT NULL COMMENT 'Prüfkennzeichen für den Datensatz: 0 = ungeprüft, 1 = geprüft',
   listung_fg                          INTEGER    NOT NULL COMMENT 'Flag, ob Artikel_1 ausgelistet ist: 0 = nicht ausgelistet; 1 = ausgelistet',
   dat_erstellung                      DATE            NOT NULL COMMENT 'Erstelldatum des Datensatzes im Format JJJJ-MM_1-TT',
   dat_aenderung                       DATE            NOT NULL COMMENT 'Änderungsdatum des Datensatzes im Format JJJJ-MM_1-TT',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MHD_ERFASSUNG_WUP_ART PRIMARY KEY (mandant_id, wup_id, dat_erfassung, dat_mhd, art_id) NOT ENFORCED
)  COMMENT = 'Tabelle für MHD-Erfassung durch den Markt.';
