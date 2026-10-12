/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_ALLOCATION_ENTITY_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 31. August 2023 14:46:40
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_WAREHOUSE_ALLOCATION_ENTITY_2 (
   WH_ALLOC_ENTITY_CD                  VARCHAR(5)      NOT NULL COMMENT 'A code for warehouse allocation unit_2  (LI_DE , LI_CZ, KFL_DE, KFL_CZ , INT etc)',
   WH_ALLOC_ENTITY_DESCR               VARCHAR(250)    NOT NULL COMMENT 'A description for warehouse allocation unit_2',
   DIST_CHANNEL_CD                     VARCHAR(5)      COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
   WH_ALLOC_ENTITY_COUNTRY_CD          VARCHAR(5)      COMMENT 'The unique code for a country_2 according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   WH_ALLOC_ENTITY_DISPLAY_ORDER_NR    NUMBER          COMMENT 'A display order in which allocation entities appear in reporting',
   WH_ALLOC_ENTITY_GROUP_CD            VARCHAR(5)      COMMENT 'Groups allocation entities to related line of business ( LDI ,  Kaufland , etc)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_WAREHOUSE_ALLOCATION_ENTITY PRIMARY KEY (WH_ALLOC_ENTITY_CD) NOT ENFORCED
 )  COMMENT= 'A unit_2 describing fractions or logical units to which warehouse management system allocates stock ( f.e. stock destinated to Lidl DE webshop , KFL CZ webshop , INT- Lidl global pool)';
