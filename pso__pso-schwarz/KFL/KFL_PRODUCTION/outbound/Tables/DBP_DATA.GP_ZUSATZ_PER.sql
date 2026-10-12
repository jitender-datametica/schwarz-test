--==============================================================
-- Table: gp_zusatz_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_zusatz_per
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp_zusatz_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.'),
dat_von DATE NOT NULL OPTIONS(description='Gueltigkeitbeginn des Datensatzes;'),
dat_bis DATE OPTIONS(description='Gueltigkeitsende des Datensatzes.'),
entgelt_mind_kz STRING(1)
OPTIONS(description='Kennzeichen Entgeltminderungsvereinbarung (1 entspricht Entgeltminderung vereinbart).'),
ret_sperrprofil_id STRING(3) OPTIONS(description='Modus fuer Retourenabrechnung (z. B. GS fuer Gutschriftsabwicklung);'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_id, einkaufsorganisation_id, dat_von) NOT ENFORCED
)
OPTIONS(description='RPW - Zeitabhängige Informationen zu den Retouren eines Lieferanten aus den SAP Tabellen ZRP_RT_CONTR sowie ZRP_FEE_REDUCT.');