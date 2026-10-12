--==============================================================
-- Table: TS_SCM_CLUSTER_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: TS_SCM_CLUSTER_2
   generated from Powerdesigner on Mittwoch, 9. November 2022 09:15:39
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_SCM_CLUSTER_2 (
   cluster_id                          INTEGER    NOT NULL COMMENT 'Cluster ID, laufende Nummer',
   cluster_bez                         VARCHAR(255)    COMMENT 'Cluster Name, z. B. Zeitcluster nach Schicht',
   cluster_typ_id                      INTEGER    COMMENT 'Cluster Typ ID, laufende Nummer',
   cluster_typ_bez                     VARCHAR(255)    COMMENT 'Cluster Typ Name, z. B. Dauer, Uhrzeit oder Wert',
   cluster_element_id                  INTEGER    NOT NULL COMMENT 'Cluster Element ID, laufende Nummer, nur eindeutig innerhalb eines Clusters',
   cluster_element_bez                 VARCHAR(255)    COMMENT 'Cluster Element Name, z. B. Frühschicht/Spätschicht usw.',
   zeit_von                            TIME(0)         COMMENT 'Cluster nach Zeit_2 oder Dauer, Intervall Beginn',
   zeit_bis                            TIME(0)         COMMENT 'Cluster nach Zeit_2 oder Dauer, Intervall Ende',
   wert_von                            NUMBER(38,16)   COMMENT 'Cluster nach Wert, Intervall min',
   wert_bis                            NUMBER(38,16)   COMMENT 'Cluster nach Wert, Intervall max',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_SCM_CLUSTER PRIMARY KEY (cluster_id, cluster_element_id) NOT ENFORCED
)  COMMENT = 'Enthält Cluster und ihre Elemente zur Gruppierung von Kennzahlen und Attributen im Frontend (z. B. Zeitcluster). Befüllung über TS-Bericht.';