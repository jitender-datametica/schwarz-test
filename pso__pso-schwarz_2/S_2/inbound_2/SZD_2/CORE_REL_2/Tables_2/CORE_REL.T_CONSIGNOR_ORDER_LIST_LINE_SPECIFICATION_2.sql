/* --------------------------------------------------------------------------------
   DDL for table: T_CONSIGNOR_ORDER_LIST_LINE_SPECIFICATION_2
   generated from Powerdesigner on Montag, 17. Juli 2023 13:58:51
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CONSIGNOR_ORDER_LIST_LINE_SPECIFICATION_2 (
   TRADER_REFERENCE_NR                 VARCHAR(250)    NOT NULL COMMENT 'Natural Key/Business Key - This is a reference assigned by the declarant for the goods covered by the declaration.',
   ORDER_DT                            DATE            NOT NULL COMMENT 'Natural Key/Business Key - The date when the goods were ordered by the consignor.',
   ITEM_POSITION_SEQ                   NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The position number within the order (truck load)',
   SPECIFICATION_SEQ                   NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The number of the specification.',
   SPEC_UOM_ID                         NUMBER(38, 0)   NOT NULL COMMENT 'Id of the unit_2 (e.g. material unit_2, production line parameter)',
   SPEC_MEAS                           NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The measurement value of this specification.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CONSIGNOR_ORDER_LIST_LINE_SPECIFICATION PRIMARY KEY (TRADER_REFERENCE_NR, ORDER_DT, ITEM_POSITION_SEQ, SPECIFICATION_SEQ) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - Describes a specific value consisting of a numeric value and a unit_2 of measurement for a specific position within an order. - Source - BEI Report';
