--==============================================================
-- Table: L_IVN_VERHANDLUNGS_CLUSTER
--==============================================================
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: L_IVN_VERHANDLUNGS_CLUSTER
   GENERATED FROM POWERDESIGNER ON Montag, 25. September 2023 14:25:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ivn_verhandlungs_cluster (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ivn_verhandlungs_cluster_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kauflandweite eindeutige IVN Verhandlungs Cluster fasst die in der IVN schon zusammengefassten Artikel/Lieferant/Land Kombinationen             innerhalb der IVN zu verschiedenen IVN-Verhandlungs-Clustern (Gruppen) zusammen.            Alle möglichen IVN-Verhandlungs-Cluster können in allen IVN-Gruppen vorkommen.'),
ivn_verhandlungs_cluster_bez STRING(100)
OPTIONS(description='Bezeichnung des Verhandlungs-Clusters. Es gibt momentan 4 Verhandlungscluster ABC für internationale Verhandlungen und D für nationale Verhandlungen ( '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ivn_verhandlungs_cluster_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='Der IVN Verhandlungs Cluster (nur IVN Cluster in Quelle) fasst Artikel/Lieferant pro Land zu Gruppen zusammen, die die Art der Verhandlung einordnen.             Mandant ist nur aus technischer Notwendigkeit im PK !!!             z.B. ob Eigenmarke, Markencharakter, gefordert mit JG-Ziel und ob national verhandelt wird oder international.             Alle möglichen IVN-Verhandlungs-Cluster können in allen IVN-Gruppen vorkommen, müssen aber nicht zu einer IVN Gruppe gehören.              Es stellt eine zweite Gruppierung unabhängig vom IVN dar und muss nicht zwingend zu einer IVN gehören.             Stand 2023-09-20: 7 Gruppen mit Namen A, B, C, D, D-A, D-B, B-R');