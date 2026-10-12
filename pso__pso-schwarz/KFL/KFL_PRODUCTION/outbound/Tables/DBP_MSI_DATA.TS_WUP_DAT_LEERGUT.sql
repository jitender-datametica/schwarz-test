--==============================================================
-- Table: ts_wup_dat_leergut
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wup_dat_leergut
   generated from Powerdesigner on Dienstag, 25. März 2025 12:42:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_wup_dat_leergut (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetriebs ID, bei Märkten immer = 0'),
dat DATE NOT NULL OPTIONS(description='Datum der Zählung des Leerguts.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
betrag_leergut_zaehlung BIGNUMERIC(38,5)
OPTIONS(description='Hausleiter zählt regelmäßig das Leergut und trägt dann den Wert in Landeswährung ein. Wird von Frontend (Transaction) per update/insert gepflegt.'),
betrag_leergut_inventur BIGNUMERIC(38,5)
OPTIONS(description='Inventurwert von Leergut. Wird DWH intern aus Inventuren befüllt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat) NOT ENFORCED
)
OPTIONS(description='Der Betrag des Leerguts in einer Filiale. Diese Information wird entweder durch eine jährliche Inventur oder eine monatliche Zählung,die vom Hausleiter durchgeführt wird,bekannt. Wird per Transaction und per AbInitio befüllt.');