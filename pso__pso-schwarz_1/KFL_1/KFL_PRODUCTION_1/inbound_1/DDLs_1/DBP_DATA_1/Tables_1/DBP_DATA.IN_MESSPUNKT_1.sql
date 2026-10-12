--==============================================================
-- Table: in_messpunkt_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_messpunkt_1
   generated from Powerdesigner on Freitag, 2. Dezember 2022 01:34:40
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_MESSPUNKT_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH.',
   messpunkt_id                        NUMBER(38,0)    NOT NULL COMMENT 'Messpunkt/Measuring point. In Plant Maintenance, measuring points are located on technical objects, in other words, on pieces of equipment or functional locations.',
   tp_objekt_id                        NUMBER(38,0)    NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1',
   tp_objekt_nr                        VARCHAR(30)     NOT NULL COMMENT 'Objektnummer',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_MESSPUNKT PRIMARY KEY (mandant_id, messpunkt_id) NOT ENFORCED
)  COMMENT = 'Table for Measuring Points (Messpunkt). 
             In Plant Maintenance, measuring points are located on technical objects, in other words, on pieces of equipment or functional locations.';
