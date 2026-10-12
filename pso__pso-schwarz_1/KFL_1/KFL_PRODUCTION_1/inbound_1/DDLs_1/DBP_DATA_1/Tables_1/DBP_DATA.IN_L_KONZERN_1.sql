--==============================================================
-- Table: in_l_konzern_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_konzern_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_KONZERN_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   konzern_id                          NUMBER(38,0)     NOT NULL COMMENT 'ID des Konzerns',
   konzern_name                        VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Name des Konzerns',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_KONZERN PRIMARY KEY (mandant_id, konzern_id) NOT ENFORCED
)  COMMENT = 'BIS - der Konzern ist eine_1 Gruppierung über Lieferanten. Quelle ist das SAP - Klassensystem';
