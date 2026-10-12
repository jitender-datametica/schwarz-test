--==============================================================
-- Table: L_IVN_VERHANDLUNGS_CLUSTER
--==============================================================
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: L_IVN_VERHANDLUNGS_CLUSTER
   GENERATED FROM POWERDESIGNER ON Montag, 25. September 2023 14:25:49
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_IVN_VERHANDLUNGS_CLUSTER (
   MANDANT_ID                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   IVN_VERHANDLUNGS_CLUSTER_ID         NUMBER(38,0)     NOT NULL COMMENT 'Kauflandweite eindeutige IVN Verhandlungs Cluster fasst die in der IVN schon zusammengefassten Artikel/Lieferant/Land Kombinationen 
            innerhalb der IVN zu verschiedenen IVN-Verhandlungs-Clustern (Gruppen) zusammen.
            Alle möglichen IVN-Verhandlungs-Cluster können in allen IVN-Gruppen vorkommen.',
   IVN_VERHANDLUNGS_CLUSTER_BEZ        VARCHAR(100)     COMMENT 'Bezeichnung des Verhandlungs-Clusters. Es gibt momentan 4 Verhandlungscluster ABC für internationale Verhandlungen und D für nationale Verhandlungen ( ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_IVN_VERHANDLUNGS_CLUSTER PRIMARY KEY (IVN_VERHANDLUNGS_CLUSTER_ID, MANDANT_ID) NOT ENFORCED
)  COMMENT = 'Der IVN Verhandlungs Cluster (nur IVN Cluster in Quelle) fasst Artikel/Lieferant pro Land zu Gruppen zusammen, die die Art der Verhandlung einordnen.
             Mandant ist nur aus technischer Notwendigkeit im PK !!!
             z.B. ob Eigenmarke, Markencharakter, gefordert mit JG-Ziel und ob national verhandelt wird oder international.
             Alle möglichen IVN-Verhandlungs-Cluster können in allen IVN-Gruppen vorkommen, müssen aber nicht zu einer IVN Gruppe gehören. 
             Es stellt eine zweite Gruppierung unabhängig vom IVN dar und muss nicht zwingend zu einer IVN gehören.
             Stand 2023-09-20: 7 Gruppen mit Namen A, B, C, D, D-A, D-B, B-R';
