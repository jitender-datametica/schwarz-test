--==============================================================
-- Table: ts_warenbewertung_abschluss_beladung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_warenbewertung_abschluss_beladung_1
   generated from Powerdesigner on Montag, 22. September 2025 11:38:02
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WARENBEWERTUNG_ABSCHLUSS_BELADUNG_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   dat_aenderung                       DATE             NOT NULL COMMENT 'Das Datum, an dem die Änderungen vorgenommen wurden.',
   job_start_fg                        INTEGER     DEFAULT 0 COMMENT 'Flag ob Beladungsjob rueckwirkend für die dat_aenderung gestartet werden sollte. 0 - Job soll nicht gestartet werden , 1 - Job soll gestartet werden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WARENBEWERTUNG_ABSCHLUSS_BELADUNG PRIMARY KEY (mandant_id, dat_aenderung) NOT ENFORCED
)  COMMENT = 'Die Tabelle dient als Steuerung für die rückwirkende Beladung der Tabelle dbp_data.warenbewertung_abschluss.FB trägt für welches Datum und Land_1, Änderungen vorgekommen sind, ein und diese sollten in der Tabelle nachbeladen werden (es dreht nicht um die "normale" Beladung ).';
