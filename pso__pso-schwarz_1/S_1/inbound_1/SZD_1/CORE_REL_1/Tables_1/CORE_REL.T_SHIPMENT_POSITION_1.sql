/* --------------------------------------------------------------------------------
   DDL for table: T_SHIPMENT_POSITION_1
   generated from Powerdesigner on Montag, 19. Mai 2025 09:10:24
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_SHIPMENT_POSITION_1 (
   DELIVERY_NR                         VARCHAR(250)    NOT NULL COMMENT 'Business/Natural key - The business identifier of the delivery.',
   SHIPMENT_NR                         VARCHAR(250)    NOT NULL COMMENT 'The unique identifier of the shipment.',
   SHIPMENT_POSITION_NR                NUMBER(38, 0)   NOT NULL COMMENT 'The unique position number of the shipment.',
   CREATED_TMSP                        TIMESTAMP_TZ(9) NOT NULL COMMENT 'The timestamp when the shipping order position was created in the source system.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_SHIPMENT_POSITION PRIMARY KEY (DELIVERY_NR, SHIPMENT_NR) NOT ENFORCED 
)  COMMENT = 'Bridge Table - Contains shipping order positions. A shipping order positiion is delivery that is part of the shipping order.';
