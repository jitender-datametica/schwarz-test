--==============================================================
-- Table: wbs_l_markt_cluster_min_platzierung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_markt_cluster_min_platzierung_2
   generated from Powerdesigner on Freitag, 1. März 2024 15:09:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_L_MARKT_CLUSTER_MIN_PLATZIERUNG_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   min_platzierung_markt_cluster_id    INTEGER     NOT NULL COMMENT 'Markt-Cluster für Mindestplatzierung (1-3)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_L_MARKT_CLUSTER_MIN_PLATZIERUNG PRIMARY KEY (mandant_id, min_platzierung_markt_cluster_id) NOT ENFORCED
)  COMMENT = 'Markt-Cluster für die Mindestplatzierung bei der Berechnung der Wiederauffüllung (WBS TP1)
             Die für WBS unterschiedlichen Markt-Cluster werden derzeit über eine_2 Excel-Datei Definiert.';
