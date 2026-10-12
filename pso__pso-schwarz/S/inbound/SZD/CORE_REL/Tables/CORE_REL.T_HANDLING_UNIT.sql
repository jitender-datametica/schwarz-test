/* --------------------------------------------------------------------------------
   DDL for table: T_HANDLING_UNIT
   generated from Powerdesigner on Mittwoch, 21. Mai 2025 14:12:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_HANDLING_UNIT (
   INTERNAL_HANDLING_UNIT_NR           VARCHAR(250)    NOT NULL COMMENT 'Business / Natural Key - The unique identification number of the handling unit.',
   EVENT_DT                            DATE            NOT NULL COMMENT 'The date of a change event.',
   DELIVERY_NR                         VARCHAR(250)    NOT NULL COMMENT 'Business/Natural key - The business identifier of the delivery.',
   PACKAGING_MATERIAL_CD               VARCHAR(50)     NOT NULL COMMENT 'The unique code of the packaging material as used in the source system.',
   PACKAGING_MATERIAL_TYPE_TXT         VARCHAR(1000)   COMMENT 'Descriptive Attribute - A description text of the specific type of the packaging material.',
   FIRST_EXTERNAL_HANDLING_UNIT_NR     VARCHAR(250)    COMMENT 'Descriptive Attribute - The first external identification number of the handling unit.',
   SECOND_EXTERNAL_HANDLING_UNIT_NR    VARCHAR(250)    COMMENT 'Descriptive Attribute - The second external identification number of the handling unit.',
   SHIPPING_POINT_CD                   VARCHAR(50)     COMMENT 'Descriptive Attribute - The code of the shipping point. This is the location from which the goods are dispatched.',
   CREATED_TMSP                        TIMESTAMP_TZ(9) NOT NULL COMMENT 'The timestamp when the handling unit was created in the business system.',
   UPDATED_TMSP                        TIMESTAMP_TZ(9) COMMENT 'The timestamp when the handling unit was updated in the business system.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_HANDLING_UNIT PRIMARY KEY (INTERNAL_HANDLING_UNIT_NR, EVENT_DT) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - A handling unit is a physical unit consisting of packaging materials and the goods contained within. It combines product and packaging information under a unique identification number for easier tracking. - Source - LExIS';
