--==============================================================
-- Table: ssm_wup_cluster_prozess_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ssm_wup_cluster_prozess_zu
   generated from Powerdesigner on Montag, 30. Januar 2023 15:35:57
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SSM_WUP_CLUSTER_PROZESS_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   ssm_cluster_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID des Sollstundenmodell-Cluster für die jeweilige Abteilung eines ',
   ssm_prozess_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID des Prozesses',
   dat_von                             DATE             NOT NULL DEFAULT CAST ('1900-01-01' AS DATE) COMMENT 'Datum im Format JJJJ-MM-TT',
   dat_bis                             DATE             NOT NULL DEFAULT CAST ('9999-12-31' AS DATE) COMMENT 'Datum im Format JJJJ-MM-TT',
   wup_bereich_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID für die Bereiche innerhalb eines Markt für das Sollstundenmodell',
   wup_abt_id                          NUMBER(38,0)     NOT NULL COMMENT 'ID der Abteilung innerhalb eines Marktes',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SSM_WUP_CLUSTER_PROZESS_ZU PRIMARY KEY (mandant_id, wup_id, nb_id, ssm_cluster_id, ssm_prozess_id, dat_von) NOT ENFORCED
)  COMMENT = 'VIS - Sollstundenmodell - Pflegetabelle der landesindividuellen Cluster pro Filiale und Prozess';
