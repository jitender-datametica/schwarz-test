--==============================================================
-- Table: l_lagernummer
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagernummer
   generated from Powerdesigner on Donnerstag, 13. Juli 2023 12:29:01
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_LAGERNUMMER (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   lagernummer_id                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   oug_fg                              INTEGER     NOT NULL COMMENT 'Flag zur Kennzeichnung von Obst- und Gemüselägern. Kommt nicht aus SAP. Wird direkt im DWH gepflegt.',
   dummy_tor_id                        INTEGER     COMMENT 'Dummy Tor aus ZLV_BSF_GLOBAL ',
   scu_id                              VARCHAR(20)      COMMENT 'Supply-Chain-Unit',
   scu_guid                            VARCHAR(32)      COMMENT 'GUID für Supply-Chain-Unit',
   sort_id                             VARCHAR(3)       COMMENT 'ID für Gruppierung und Sortierung im Frontend, wird im DWH gepflegt - 1. Stelle=Sortiment, 2. Stelle=Land, 3. Stelle = Lfd. Nr.',
   ewm_fg                              INTEGER     DEFAULT 0 COMMENT 'Indicates if the LGNUM is an SAP EWM-run warehouse',
   pers_teilbereich_id                 VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_LAGERNUMMER PRIMARY KEY (mandant_id, lagernummer_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - Lookuptabelle der Lagernummern aus der SAP Tabelle lagp';