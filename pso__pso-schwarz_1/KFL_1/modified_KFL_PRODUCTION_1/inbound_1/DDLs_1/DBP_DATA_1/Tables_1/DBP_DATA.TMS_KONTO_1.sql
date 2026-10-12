--==============================================================
-- Table: tms_konto_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_konto_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_KONTO_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_konto_id                        INTEGER     NOT NULL COMMENT 'ID des Kontos (Kontonummer). Aus plkto.konto_nr',
   tms_konto_lfd_nr                    INTEGER     NOT NULL COMMENT 'SKey für die Tabelle tms_konto_1 im Quellsystem. Aus plkto.kto_id',
   tms_konto_bez                       VARCHAR(50)      NOT NULL COMMENT 'Bezeichnung zum Konto_1',
   tms_konto_txt                       VARCHAR(300)     COMMENT 'Beschreibung des Kontos',
   tms_fibu_konto_cd                   VARCHAR(20)      COMMENT 'FIBU Konto_1 (aktuell 3-Letter-Code)',
   tms_kostenstelle_id                 INTEGER     COMMENT 'Kostenstelle',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_KONTO PRIMARY KEY (mandant_id, system_id, tms_konto_id) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält die Informationen über die Konten, einschließlich FIBU Konto_1 Code und Kostenstelle. Sie dient zur Differenzierung der Rechnungspositionen nach Kostenart. Aus der Quelle plkto (WANKO)';
