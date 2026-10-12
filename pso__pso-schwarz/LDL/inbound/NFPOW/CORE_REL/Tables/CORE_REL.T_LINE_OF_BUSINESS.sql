/* --------------------------------------------------------------------------------
   DDL for table: t_line_of_business
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LINE_OF_BUSINESS DATA_RETENTION_TIME_IN_DAYS = 2 (
   lob_cd                              VARCHAR(100)     NOT NULL COMMENT 'Code of the line of business, so far LDL and KFL are used for Lidl and Kaufland.',
   lob_name                            VARCHAR(100)     NOT NULL COMMENT 'Name of the line of business.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LINE_OF_BUSINESS PRIMARY KEY (lob_cd) NOT ENFORCED 
)  COMMENT = 'Line of business.
             distinguishes between Lidl and Kaufland related clients';

