CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_warenbewertung_abschluss_beladung (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
dat_aenderung DATE NOT NULL OPTIONS(description='Das Datum, an dem die Änderungen vorgenommen wurden.'),
job_start_fg INTEGER DEFAULT 0
OPTIONS(description='Flag ob Beladungsjob rueckwirkend für die dat_aenderung gestartet werden sollte. 0 - Job soll nicht gestartet werden , 1 - Job soll gestartet werden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat_aenderung) NOT ENFORCED
)
OPTIONS(description='Die Tabelle dient als Steuerung für die rückwirkende Beladung der Tabelle dbp_data.warenbewertung_abschluss.FB trägt für welches Datum und Land, Änderungen vorgekommen sind, ein und diese sollten in der Tabelle nachbeladen werden (es dreht nicht um die\""normale\"" Beladung ).');