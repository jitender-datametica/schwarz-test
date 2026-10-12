--==============================================================
-- Table: ts_scm_tor_gruppe_map
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_tor_gruppe_map
   generated from Powerdesigner on Monday, May 30, 2022 9:49:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TS_SCM_TOR_GRUPPE_MAP (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   lagernummer_id                      VARCHAR(4)      NOT NULL COMMENT 'Lagernummer / Lagerkomplex',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   tor_id_zugeordnet                   VARCHAR(3)      NOT NULL COMMENT 'Tor ID zugeordnet',
   tor_gruppe                          VARCHAR(20)     COMMENT 'SCM Tor Gruppe',
   hallenseite_bez                     VARCHAR(10)     COMMENT 'Hallenseite (WE/WA/Sonstiges)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_SCM_TOR_GRUPPE_MAP PRIMARY KEY (mandant_id, lagernummer_id, wup_id, nb_id, tor_id_zugeordnet) NOT ENFORCED
)  COMMENT = 'Mapping SCM Tor Gruppe';
