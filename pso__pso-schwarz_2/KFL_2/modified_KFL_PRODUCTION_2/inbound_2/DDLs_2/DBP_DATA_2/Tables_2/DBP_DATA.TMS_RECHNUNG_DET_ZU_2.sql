--==============================================================
-- Table: tms_rechnung_det_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_rechnung_det_zu_2
   generated from Powerdesigner on Donnerstag, 24. April 2025 16:36:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_RECHNUNG_DET_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_rech_beleg_id                   INTEGER     NOT NULL COMMENT 'ID der Rechnung (Rechnungsnummer). Aus plrpos.beleg_nr',
   tms_rech_beleg_pos_id               VARCHAR(8)       NOT NULL COMMENT 'Rechnungspositionsnummer. Aus plrpos.beleg_posnr',
   tms_rech_bezug_lfd_nr               INTEGER     NOT NULL COMMENT 'ID der Zuordnung / Referenz im Quellsystem.',
   bezugsart_id                        INTEGER     COMMENT 'ID der Art_2 des Belegbezugs: 0 = undefiniert; 1 = Tour_2; 2 = Tourposition; 3 = Auftrag; 4 = Auftragsposition; 5 = HAU / Gesamtauftrag; 6 = Tag_2; 7 = E_Bordero; 8 = Teil transport; 9 = Gesamtrechnung; 10 = Teil Transport E Bordero; 100 = TRM',
   bezug_schluessel_nr                 VARCHAR(30)      COMMENT 'Gesamter Schluessel des Bezugsbelegs.',
   tms_ref_nr                          VARCHAR(30)      COMMENT 'Erster Teil des Bezugsbelegs, bspw. Auftrag',
   tms_ref_unter_nr                    VARCHAR(30)      COMMENT 'Zweiter Teil des Bezugsbelegs, bspw. Unterauftrag',
   tms_ref_pos_nr                      VARCHAR(30)      COMMENT 'Dritter Teil des Bezugsbelegs, bspw. Auftragsposition',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_RECHNUNG_DET_ZU PRIMARY KEY (mandant_id, system_id, tms_rech_beleg_id, tms_rech_beleg_pos_id, tms_rech_bezug_lfd_nr) NOT ENFORCED
)  COMMENT = 'TMS - Zuordnungstabelle zwischen den Rechnungspositionen und je nach Bezugsart anderen Belegen wie bspw. Auftragspositionen, Tourenpositionen, Gesamtrechnungen, etc.';
