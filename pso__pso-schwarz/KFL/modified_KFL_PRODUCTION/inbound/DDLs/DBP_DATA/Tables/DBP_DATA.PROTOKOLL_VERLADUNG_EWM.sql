--==============================================================
-- Table: protokoll_verladung_ewm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: protokoll_verladung_ewm
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:36:41
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PROTOKOLL_VERLADUNG_EWM (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   transportation_unit_id              INTEGER     NOT NULL COMMENT 'Nummer eines Transportes im EWM-System. Ein Transport / eine Tour ist eine Fahrt einer Transporters mit Start- und Zielverteilzentrum inklusive Zwischenstopps bei anderen VZs. Das Feld hat die gleiche Bedeutung wie tour_id, wurde aber von SAP abgeaendert.',
   kj_transportation_unit              INTEGER     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   transportation_unit_sr_act_id       INTEGER     NOT NULL COMMENT 'Warenannahme- und Versandaktivitaetsnummer der Transporteinheit.',
   handling_unit_id_ext                VARCHAR(20)      NOT NULL COMMENT 'Externe Handling-Unit-Identifikation. Nummer der Palette.',
   datzeit_scan                        TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Datum- und Zeitstempel der Bearbeitung. UTC-Zeitstempel in Langform (JJJJMMTThhmmssmmmuuun).',
   lagernummer_id                      VARCHAR(4)       NOT NULL COMMENT 'ID der Lagernummer - hoechste Ebene der Lagerhierarchie.',
   lagersortiment_id                   VARCHAR(1)       COMMENT 'Lagersortiment ID.',
   kunde_id                            INTEGER     COMMENT 'Warenempfaenger (wup_id_markt, Marktnummer).',
   dat_scan                            DATE             COMMENT 'Scandatum.',
   zeit_scan                           TIME(6)          COMMENT 'Scanuhrzeit.',
   versandeinheit_id_ext               VARCHAR(20)      COMMENT 'Handling-Unit-ID bei Sammelpalette, wenn Paletten vereinigt werden. Enthaelt 18-stellige Nummer, wenn Teil einer Palette, -1 wenn Palette, 1 wenn Sammelpalette.',
   lief_beleg_id                       INTEGER     COMMENT 'Das Feld enthaelt die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.',
   dat_lief_soll                       DATE             COMMENT 'Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann fuer den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschaetzungen errechnen.',
   z_arbeitsgebiet_id                  INTEGER     COMMENT 'Nachrichtentyp einer Pruefung bei einer Verladung. Ordnet die Pruef ID einem Typ/Arbeitsgebiet zu, in dem die Pruefung stattfindet. Ohne diese ID ist die pruef_id nicht eindeutig.',
   pruef_id                            INTEGER     COMMENT 'Nachrichtennummer die den Prueffall beschreibt.',
   gesamtgewicht_hu                    NUMBER(29,3)     COMMENT 'Gesamtgewicht der Palette / Handling-Unit.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PROTOKOLL_VERLADUNG_EWM PRIMARY KEY (mandant_id, transportation_unit_id, transportation_unit_sr_act_id, kj_transportation_unit, handling_unit_id_ext, datzeit_scan, lagernummer_id) NOT ENFORCED
)  COMMENT = 'ZGI_LOAD_RECORD ''Protokolltabelle Verladung'', Quelle SAP-EWM. Die Tabelle protokoll_verladung aus Quelle SAP-LES bildet den gleichen Sachverhalt ab, nur in etwas anderer Form / anderer Granularitaet. SAP hat ihr Datenmodell veraendert, weshalbt sich Feldnamen und z.T. auch Bedeutung unterscheiden. Auch werden hier einige Fehler der anderen Tabelle behoben.';
