/* --------------------------------------------------------------------------------
   DDL for table: t_dim_line_of_business_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LINE_OF_BUSINESS_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   lob_cd                              VARCHAR(100)     NOT NULL COMMENT 'code of the line of business, so far LDL and KFL are used for Lidl and Kaufland
            CORE_REL: t_line_of_business.lob_cd',
   lob_name                            VARCHAR(100)     COMMENT 'name of the line of business
            CORE_REL: t_line_of_business.lob_name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_LINE_OF_BUSINESS PRIMARY KEY (lob_cd) NOT ENFORCED 
)  COMMENT = 'Line of business.
             Distinguishes between Lidl and Kaufland related clients.
             CORE_REL: T_LINE_OF_BUSINESS_1';

