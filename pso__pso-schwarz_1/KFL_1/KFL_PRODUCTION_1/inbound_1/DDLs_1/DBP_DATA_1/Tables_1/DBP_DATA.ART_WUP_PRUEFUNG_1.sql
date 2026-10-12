--==============================================================
-- Table: art_wup_pruefung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_pruefung_1
   generated from Powerdesigner on Mittwoch, 21. Februar 2024 15:26:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_PRUEFUNG_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   pruef_prozess_typ_kz                VARCHAR(10)      NOT NULL COMMENT 'Kennzeichen des Prüf-Prozesses. Aktuell nur ''MAX'', in Zukunft weitere Prozesse geplant.',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
   dat_erstellung                      DATE             NOT NULL COMMENT 'Erstelldatum der Prüfnachricht.',
   pruef_id                            VARCHAR(3)       NOT NULL COMMENT 'ID des Prüfgrundes. Beinhalten unterschiedliche Nachrichten die zur Überprüfung an die Filialen gesendet werden können.',
   z_arbeitsgebiet_id                  NUMBER(38,0)     NOT NULL COMMENT 'ID der Arbeitsgebiete. Ein Arbeits gebiet steht für die Nachrichtenklasse zu der die Nachricht gehört. Aktuell gibt es folgende Arbeitsgebiete: 0 = Z_FRE,  1 = Z_EMON und 4 = EWM. ',
   pruef_status_id                     NUMBER(38,0)     NOT NULL COMMENT 'ID des Status_1 der Überprüfung des Artikels in der Filiale. Aktuell nur 0 = ungeprüft, 1 = geprüft, weitere Stati in Zukunft möglich.',
   dat_pruefung                        DATE             COMMENT 'Datum an dem der Prüfprozess als bestätigt markiert wurde.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_PRUEFUNG PRIMARY KEY (mandant_id, pruef_prozess_typ_kz, wup_id, nb_id, art_id, dat_erstellung) NOT ENFORCED
)  COMMENT = 'Tabelle beinhaltet Prüfnachrichten für in den Filialen zu überprüfende Artikel. Der Inhalt der Nachricht und Prüfung kann sich je nach Prüfprozess unterscheiden';
