--==============================================================
-- Table: l_markt_verraeumung_prio_grund_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_markt_verraeumung_prio_grund_1
   generated from Powerdesigner on Freitag, 28. März 2025 10:02:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_markt_verraeumung_prio_grund_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
verraeumung_prio_grund_id STRING(2) NOT NULL
OPTIONS(description='ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, verraeumung_prio_grund_id) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für die Verräumungs-Prioritätsgründe in der Filiale. Diese Tabelle listet die verschiedenen Gründe auf, die einen Artikel_1 im Lager als "kritisch" für die Verräumung auf die Verkaufsfläche einstufen.             z.B. das Erreichen eines Nullbestands im Regal. Quelle: ZRS_LGBPRF_CUST (SAP)');