--==============================================================
-- Table: ts_warenbewertung_abschluss_beladung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_warenbewertung_abschluss_beladung_2
   generated from Powerdesigner on Montag, 22. September 2025 11:38:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_warenbewertung_abschluss_beladung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
dat_aenderung DATE NOT NULL OPTIONS(description='Das Datum, an dem die Änderungen vorgenommen wurden.'),
job_start_fg BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Flag ob Beladungsjob rueckwirkend für die dat_aenderung gestartet werden sollte. 0 - Job soll nicht gestartet werden , 1 - Job soll gestartet werden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat_aenderung) NOT ENFORCED
)
OPTIONS(description='Die Tabelle dient als Steuerung für die rückwirkende Beladung der Tabelle dbp_data.warenbewertung_abschluss.FB trägt für welches Datum und Land_2, Änderungen vorgekommen sind, ein und diese sollten in der Tabelle nachbeladen werden (es dreht nicht um die "normale" Beladung ).');