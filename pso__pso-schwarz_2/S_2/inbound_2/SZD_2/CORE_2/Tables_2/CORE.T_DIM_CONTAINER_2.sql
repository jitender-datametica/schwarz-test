/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CONTAINER_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CONTAINER_2 (
   RESOURCE_ITEM_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the container.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CONTAINER_STATUS_CD                 VARCHAR(50)     NOT NULL COMMENT 'The status_2 code for the lot',
   CONTAINER_ISO_TYPE_CD               VARCHAR(50)     NOT NULL COMMENT 'Container Iso Size Type (22G0, 45G0RF etc)',
   CONTAINER_ID                        VARCHAR(50)     NOT NULL COMMENT 'Descriptive Attribute - Oversea Container unique identifier in source system',
   CONTAINER_NR                        VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - Oversea Container serial number',
   SEAL_NR                             VARCHAR(50)     NOT NULL COMMENT 'Descriptive Attribute - Oversea Container customs seal number',
   SPARE_UNITS_FG                      BOOLEAN         NOT NULL COMMENT 'Flag indicating if a container only contains spare units ',
   SPARE_PARTS_FG                      BOOLEAN         NOT NULL COMMENT 'Flag indicating if a container only contains spare parts',
   GAS_FILLED_FG                       BOOLEAN         NOT NULL COMMENT 'Some containers are filled with gas to avoid insects to damage the goods (for example furniture)',
   TEU_QTY                             NUMBER(38, 5)   COMMENT 'Fact - additive - The size of container in TEU ( 1 TEU = volume representing the loading capacity of a 20 Foot container. Commonly used are containers with 1 or 2 TEU capacity (20” or 40))',
   LOT_NUMBERS_IN_CONTAINER_TXT        VARCHAR(1000)   NOT NULL COMMENT 'Derived attribute - Possibly empty list of consolidated lot numbers',
   LOT_NUMBERS_IN_CONTAINER_CNT        NUMBER(38,0)    NOT NULL COMMENT 'Derived attribute - Number of consolidated lots in a container',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_CONTAINER PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_TO_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - Can contain different articles, but only from the same supplier_2 (mixed container). - Source - VMT';
