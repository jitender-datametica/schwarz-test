--==============================================================
-- Table: wbs_l_markt_cluster_initiale_belieferung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_markt_cluster_initiale_belieferung_2
   generated from Powerdesigner on Freitag, 1. März 2024 15:08:52
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_L_MARKT_CLUSTER_INITIALE_BELIEFERUNG_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   init_lief_markt_cluster_id          INTEGER     NOT NULL COMMENT 'Markt-Cluster für die initiale Belieferung(1-5)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_L_MARKT_CLUSTER_INITIALE_BELIEFERUNG PRIMARY KEY (mandant_id, init_lief_markt_cluster_id) NOT ENFORCED
)  COMMENT = 'Markt-Cluster für die Einstellungen der Initialbelieferungen (WBS TP2 ).
             Die für WBS unterschiedlichen Markt-Cluster werden derzeit über eine_2 Excel-Datei Definiert.';
