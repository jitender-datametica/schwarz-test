--==============================================================
-- Table: back_wup_cluster_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_wup_cluster_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BACK_WUP_CLUSTER_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wup_cluster_id                      INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Wup_2 Clusters. Wird im DWH erzeugt',
   prio                                INTEGER     NOT NULL DEFAULT -1 COMMENT 'Prio ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BACK_WUP_CLUSTER_ZU PRIMARY KEY (mandant_id, wup_id, nb_id, wup_cluster_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop -Zuordnung wup_2-Cluster zu Markt aus der Quelltabelle zek_bake_marktcl';

