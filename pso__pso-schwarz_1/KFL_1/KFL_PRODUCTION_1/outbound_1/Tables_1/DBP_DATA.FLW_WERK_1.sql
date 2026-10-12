--==============================================================
-- Table: flw_werk_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_werk_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_werk_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
werk_nr STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='aus SAP übertragene ID im Format character für werks'),
werk_name STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='Name des Werks aus werk1'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
flw_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Wird mit 1 gefüllt, wenn das Werk für Fleischwerk relevant ist. Sonst = 0'),
buchungskreis_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werk_id) NOT ENFORCED
) OPTIONS(description='FLW - Stammdaten der Werke aus t001w_1');