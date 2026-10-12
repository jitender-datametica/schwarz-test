--==============================================================
-- Table: ts_mercareon_mapping_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_mercareon_mapping_1
   generated from Powerdesigner on Tuesday, March 22, 2022 8:57:57 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TS_MERCAREON_MAPPING_1 (
   mercareon_standort                  VARCHAR(255)    NOT NULL COMMENT 'Standortbezeichnung Mercareon',
   mercareon_entladestelle             VARCHAR(255)    NOT NULL COMMENT 'Entladestellenbezeichnung Mercareon',
   mandant_id                          NUMBER(38,0)    COMMENT 'Mandant_1 DWH',
   wup_id                              NUMBER(38,0)    COMMENT 'Verteilzentrum',
   nb_id                               NUMBER(38,0)    COMMENT 'Nebenbetrieb',
   lagernummer_ewm_id                  VARCHAR(4)      COMMENT 'Lagernummer EWM',
   lagernummer_les_id                  VARCHAR(4)      COMMENT 'Lagernummer LES',
   entladestelle_id                    NUMBER(38,0)    COMMENT 'Entladestelle',
   artikelsortiment_id                 VARCHAR(1)      COMMENT 'Artikelsortiment',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_MERCAREON_MAPPING PRIMARY KEY (mercareon_standort, mercareon_entladestelle) NOT ENFORCED
)  COMMENT = 'Mapping Mercareon Standort + Entladestelle auf VZ/Lagernummer/Entladestelle etc.';
