--==============================================================
-- Table: ginfo_betr_t_platz_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_betr_t_platz_zu_per_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ginfo_betr_t_platz_zu_per_1 (
ginfo_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Vom Ginfo-System verwaltete eindeutige ID des technischen Platzes. Die techn_platz_id ist nicht immer eindeutig. Vorläufig wird die ginfo_id nur in dieser Tabelle verwendet'),
betreiberart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID einer Betreiberart. Wird im DWH generiert'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
techn_platz_id STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der technische Platz ist eine_1 von Kaufland Facility Management verwaltete Einheit'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ginfo_id, dat_von) NOT ENFORCED
) OPTIONS(description='IOS - Zuordnungstabelle der Betreiberarten zu technischen Plätzen');