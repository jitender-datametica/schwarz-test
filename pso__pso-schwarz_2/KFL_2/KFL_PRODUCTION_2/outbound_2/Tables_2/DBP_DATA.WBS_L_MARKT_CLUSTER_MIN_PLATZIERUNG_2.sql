--==============================================================
-- Table: wbs_l_markt_cluster_min_platzierung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_markt_cluster_min_platzierung_2
   generated from Powerdesigner on Freitag, 1. März 2024 15:09:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_l_markt_cluster_min_platzierung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
min_platzierung_markt_cluster_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Markt-Cluster für Mindestplatzierung (1-3)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, min_platzierung_markt_cluster_id) NOT ENFORCED
)
OPTIONS(description='Markt-Cluster für die Mindestplatzierung bei der Berechnung der Wiederauffüllung (WBS TP1)             Die für WBS unterschiedlichen Markt-Cluster werden derzeit über eine_2 Excel-Datei Definiert.');