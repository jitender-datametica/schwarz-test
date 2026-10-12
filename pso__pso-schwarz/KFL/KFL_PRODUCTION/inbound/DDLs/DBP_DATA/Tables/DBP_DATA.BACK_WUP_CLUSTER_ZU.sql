--==============================================================
-- Table: back_wup_cluster_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_wup_cluster_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BACK_WUP_CLUSTER_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wup_cluster_id                      NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Wup Clusters. Wird im DWH erzeugt',
   prio                                NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Prio ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BACK_WUP_CLUSTER_ZU PRIMARY KEY (mandant_id, wup_id, nb_id, wup_cluster_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop -Zuordnung wup-Cluster zu Markt aus der Quelltabelle zek_bake_marktcl';

