--==============================================================
-- Table: tms_auftrag_verpackung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag_verpackung
   generated from Powerdesigner on Donnerstag, 24. April 2025 11:53:23
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_AUFTRAG_VERPACKUNG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_verpackung_id                   INTEGER     NOT NULL COMMENT 'ID der Verpackung',
   tms_verpackung_lfd_nr               VARCHAR(10)      NOT NULL COMMENT 'Identifier der Verpackung im Quellsystem',
   tms_auftrag_id                      VARCHAR(30)      NOT NULL COMMENT 'ID des Auftrags (Auftragsnummer). Aus plau.au_nr',
   tms_auftrag_unter_id                INTEGER     NOT NULL COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plau.au_unter_nr',
   tms_transportmittel_id              INTEGER     COMMENT 'ID des Transportmittels auf dem die Verpackung verpackt wird.',
   anz_verpackung                      INTEGER     COMMENT 'Anzahl gleichartiger Verpackungen',
   tms_verpackung_bem_txt              VARCHAR(30)      COMMENT 'Freitext für Bemerkungen zur Verpackung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_AUFTRAG_VERPACKUNG PRIMARY KEY (mandant_id, system_id, tms_verpackung_id) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält Verpackunsinformationen zum Auftrag inklusive des genutzen Transportmittels der Verpackung.';
