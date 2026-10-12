/* --------------------------------------------------------------------------------
   DDL for table: T_CONTAINER_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CONTAINER_1 (
   RESOURCE_ITEM_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the container.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CONTAINER_STATUS_CD                 VARCHAR(50)     NOT NULL COMMENT 'The status_1 code for the lot',
   CONTAINER_ISO_TYPE_CD               VARCHAR(50)     NOT NULL COMMENT 'The type code that define a container like "22G0", "42G0" or "42R1" and others',
   CONTAINER_ID                        VARCHAR(50)     NOT NULL COMMENT 'Natural/Business Key - Oversea Container unique identifier in source system',
   CONTAINER_NR                        VARCHAR(50)     NOT NULL COMMENT 'Descriptive Attribute - Oversea Container serial number, can occur in multiple shippings over time',
   SEAL_NR                             VARCHAR(50)     NOT NULL COMMENT 'Descriptive Attribute - Oversea Container customs seal number',
   SPARE_UNITS_FG                      BOOLEAN         NOT NULL COMMENT 'Descriptive Attribute - Flag indicating if a container only contains spare units ',
   SPARE_PARTS_FG                      BOOLEAN         NOT NULL COMMENT 'Descriptive Attribute - Flag indicating if a container only contains spare parts',
   GAS_FILLED_FG                       BOOLEAN         NOT NULL COMMENT 'Descriptive Attribute - Some containers are filled with gas to avoid insects to damage the goods (for example furniture)',
   TEU_QTY                             NUMBER(38, 5)   COMMENT 'Measure - The size of container in TEU ( 1 TEU = volume representing the loading capacity of a 20 Foot container. Commonly used are containers with 1 or 2 TEU capacity (20” or 40”))',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_CONTAINER PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_TO_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - Can contain different articles, but only from the same supplier_1 (mixed container). - Source - VMT';
