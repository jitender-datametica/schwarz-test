/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_WAVE_1
   generated from Powerdesigner on Donnerstag, 28. November 2024 11:30:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_DELIVERY_WAVE_1 (
   DISTRIBUTION_NR                     VARCHAR(250)    NOT NULL COMMENT 'The business number of the distribution.',
   DISTRIBUTION_POSITION_NR            NUMBER(38, 0)   NOT NULL COMMENT 'The number of the position of the delivery.',
   WAVE_NR                             NUMBER(38, 0)   NOT NULL COMMENT 'The number of the wave of the delivery position.',
   DISTRIBUTION_STORE_GROUP_NR         NUMBER(38, 0)   NOT NULL COMMENT 'TODO',
   DELIVERY_DT                         DATE            COMMENT 'The deliviery date of this wave.',
   DISTRIBUTION_QTY                    NUMBER(38, 5)   COMMENT 'The quantity to be delivered in this wave,',
   DISTRIBUTION_UNIT_ID                NUMBER(38,0)    NOT NULL COMMENT 'The number identifying the distribution quantity unit_1 of measure.',
   ORDER_QTY                           NUMBER(38, 5)   COMMENT 'The ordered quantity.',
   ORDER_UNIT_ID                       NUMBER(38,0)    NOT NULL COMMENT 'The number identifying the order quantity unit_1 of measure.',
   DESIRED_QTY                         NUMBER(38, 5)   COMMENT 'The desired quantity.',
   ORDER_DT                            DATE            COMMENT 'The order date.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_T_DELIVERY_WAVE PRIMARY KEY (DISTRIBUTION_POSITION_NR, WAVE_NR, DISTRIBUTION_NR, DISTRIBUTION_STORE_GROUP_NR) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - A wave of a delivery is a scheduled partial delivery of the goods to the target (e.g. a store) . - Source - Lexis';
