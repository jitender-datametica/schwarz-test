--==============================================================
-- Table: tms_auftrag_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag_det
   generated from Powerdesigner on Freitag, 25. April 2025 14:06:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_AUFTRAG_DET (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_auftrag_id                      VARCHAR(30)      NOT NULL COMMENT 'ID des Auftrags (Auftragsnummer). Aus plps.au_nr',
   tms_auftrag_unter_id                INTEGER     NOT NULL COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plps.au_unter_nr',
   tms_auftrag_pos_id                  VARCHAR(5)       NOT NULL COMMENT 'Laufende Nummer zur Identifizierung einer Auftragsposition innerhalb eines Auftrages. Aus plps.au_lfnr',
   tms_auftrag_det_lfd_nr              INTEGER     NOT NULL COMMENT 'SKey für die Tabelle tms_auftrag_det im Quellsystem. Aus plps.au_lfnr',
   art_id                              INTEGER     COMMENT 'Artikelnummer der Auftragsposition',
   orig_art_nr                         VARCHAR(30)      COMMENT 'Artikelnummer der Auftragsposition inklusive aller Zeichen (alphanumerisch und Sonderzeichen), falls vorhanden.',
   menge_kommissioniert                NUMBER(29,2)     COMMENT 'Fertig kommissionierte Menge',
   status_fertig_cd                    VARCHAR(3)       COMMENT 'Fertig Kennzeichen: F = Kommissionierung abgeschlossen weil entweder ausreichende Menge kommissioniert wurde oder weil der Rest zur Fehlmenge erklärt wurde.',
   tms_transportmittel_id              INTEGER     COMMENT 'ID des Transportmittels.',
   anz_transportmittel                 INTEGER     COMMENT 'Anzahl des Transportmittels.',
   wareneingang_beleg_id               VARCHAR(30)      COMMENT 'Belegnummer des Wareneingangs, auf T = EBELN.',
   dat_wareneingang                    DATE             COMMENT 'Datum des Wareneingangs',
   tms_auftrag_orig_id                 VARCHAR(30)      COMMENT 'Originale Auftragsnummer der Auftragsposition, bezieht sich auf SAP Aufträge.',
   tms_auftrag_orig_unter_id           INTEGER     COMMENT 'Originale Positionsnummer der Auftragsposition, bezieht sich auf SAP Aufträge.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_AUFTRAG_DET PRIMARY KEY (mandant_id, system_id, tms_auftrag_id, tms_auftrag_unter_id, tms_auftrag_pos_id) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält die relevanten Informationen zu einem Distributionsauftrag auf Positionsebene.';
