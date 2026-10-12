--==============================================================
-- Table: markt_verraeumung_prio_grund_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: markt_verraeumung_prio_grund_spr_zu_2
   generated from Powerdesigner on Freitag, 28. März 2025 10:02:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.markt_verraeumung_prio_grund_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
verraeumung_prio_grund_id STRING(2) NOT NULL
OPTIONS(description='ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'),
verraeumung_prio_grund_bez STRING(200) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung des Verräumungs Prio Grund.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, verraeumung_prio_grund_id, spr_id) NOT ENFORCED
)
OPTIONS(description='Sprachabhängige Bezeichnung der Verräumungs Prio Gründen in der Filiale. Quelle: SAP ZRS_LGBPRF_CUST');