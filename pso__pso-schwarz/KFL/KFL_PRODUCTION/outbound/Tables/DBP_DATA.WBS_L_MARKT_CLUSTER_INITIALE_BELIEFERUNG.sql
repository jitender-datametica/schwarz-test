--==============================================================
-- Table: wbs_l_markt_cluster_initiale_belieferung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_markt_cluster_initiale_belieferung
   generated from Powerdesigner on Freitag, 1. März 2024 15:08:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_l_markt_cluster_initiale_belieferung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
init_lief_markt_cluster_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Markt-Cluster für die initiale Belieferung(1-5)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, init_lief_markt_cluster_id) NOT ENFORCED
)
OPTIONS(description='Markt-Cluster für die Einstellungen der Initialbelieferungen (WBS TP2 ).             Die für WBS unterschiedlichen Markt-Cluster werden derzeit über eine Excel-Datei Definiert.');