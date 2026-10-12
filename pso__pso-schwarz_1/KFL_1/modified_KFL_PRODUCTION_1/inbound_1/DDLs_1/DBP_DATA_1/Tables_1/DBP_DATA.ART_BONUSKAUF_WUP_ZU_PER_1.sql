--==============================================================
-- Table: art_bonuskauf_wup_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_bonuskauf_wup_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BONUSKAUF_WUP_ZU_PER_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER     NOT NULL COMMENT 'DWH Artikel_1 ID',
   bonuskauf_id                        VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr',
   dat_von                             DATE             NOT NULL COMMENT 'Beginndatum der Gültigkeit einer Promotion aus datab',
   dat_bis                             DATE             NOT NULL COMMENT 'Endedatum der Gültigkeit einer Promotion aus datbi',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BONUSKAUF_WUP_ZU_PER PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, bonuskauf_id, dat_von) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Zuordnungstabelle der Bonuskaufaktionen zu Artikeln und Märkten';

