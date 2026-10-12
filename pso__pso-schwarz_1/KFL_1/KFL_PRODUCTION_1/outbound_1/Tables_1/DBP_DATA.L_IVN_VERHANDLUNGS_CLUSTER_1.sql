--==============================================================
-- Table: L_IVN_VERHANDLUNGS_CLUSTER_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: L_IVN_VERHANDLUNGS_CLUSTER_1
   GENERATED FROM POWERDESIGNER ON Montag, 25. September 2023 14:25:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ivn_verhandlungs_cluster_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ivn_verhandlungs_cluster_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kauflandweite eindeutige IVN Verhandlungs Cluster fasst die in der IVN schon zusammengefassten Artikel_1/Lieferant/Land_1 Kombinationen             innerhalb der IVN zu verschiedenen IVN-Verhandlungs-Clustern (Gruppen) zusammen.            Alle möglichen IVN-Verhandlungs-Cluster können in allen IVN-Gruppen vorkommen.'),
ivn_verhandlungs_cluster_bez STRING(100)
OPTIONS(description='Bezeichnung des Verhandlungs-Clusters. Es gibt momentan 4 Verhandlungscluster ABC für internationale Verhandlungen und D für nationale Verhandlungen ( '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ivn_verhandlungs_cluster_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='Der IVN Verhandlungs Cluster (nur IVN Cluster in Quelle) fasst Artikel_1/Lieferant pro Land_1 zu Gruppen zusammen, die die Art_1 der Verhandlung einordnen.             Mandant_1 ist nur aus technischer Notwendigkeit im PK !!!             z.B. ob Eigenmarke, Markencharakter, gefordert mit JG-Ziel und ob national verhandelt wird oder international.             Alle möglichen IVN-Verhandlungs-Cluster können in allen IVN-Gruppen vorkommen, müssen aber nicht zu einer IVN Gruppe_1 gehören.              Es stellt eine_1 zweite Gruppierung unabhängig vom IVN dar und muss nicht zwingend zu einer IVN gehören.             Stand 2023-09-20: 7 Gruppen mit Namen A, B, C, D, D-A, D-B, B-R');