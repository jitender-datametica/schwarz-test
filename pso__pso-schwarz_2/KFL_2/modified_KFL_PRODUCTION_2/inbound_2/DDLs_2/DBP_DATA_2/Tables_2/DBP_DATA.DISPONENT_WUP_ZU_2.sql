--==============================================================
-- Table: disponent_wup_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: disponent_wup_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DISPONENT_WUP_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   disponent_id                        VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Disponent ID',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   disponent_name                      VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Der Name des Disponenten ist von wup_2 abhängig. Das Feld wird daher aus der Tabelle l_disponent_2 in diese Tabelle verschoben.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DISPONENT_WUP_ZU PRIMARY KEY (mandant_id, disponent_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'TP408 LVS - Zuordnung Disponent zum Markt - MULTISET';

