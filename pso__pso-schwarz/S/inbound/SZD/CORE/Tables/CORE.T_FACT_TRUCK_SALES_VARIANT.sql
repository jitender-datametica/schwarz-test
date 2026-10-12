/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_TRUCK_SALES_VARIANT
   generated from Powerdesigner on Mittwoch, 30. Juli 2025 14:18:27
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_TRUCK_SALES_VARIANT (
   DELIVERY_NR                         VARCHAR(250)    NOT NULL COMMENT 'Business/Natural key - The business identifier of the delivery.',
   DISTRIBUTION_NR                     VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - The business number of the distribution.',
   SALES_VARIANT_PRODUCT_SID           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   HAULER_PARTY_SID                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the hauler (carrier )',
   RECEIPT_PARTY_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the recipient.',
   DELIVERY_NOTE_NR                    VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - External delivery identification note number.',
   ACTUAL_DELIVERY_DT                  DATE            COMMENT 'Descriptive Attribute - The date when the goods are delivered.',
   PLANNED_GOODS_MOVEMENT_DT           DATE            COMMENT 'Descriptive Attribute - The planned date of the movement of the goods.',
   PROMOTION_DT                        DATE            COMMENT 'Descriptive Attribute - The date of promotion.',
   CHARGEBACK_MIN_DT                   DATE            COMMENT 'Descriptive Attribute - Minimum date of charge back.',
   MIN_WAVE_DELIVERY_DT                DATE            COMMENT 'Descriptive Attribute - The minimum delivery date of the of the delivery wave.',
   DECOMMISSIONING_MONTH               NUMBER(38, 0)   COMMENT 'Descriptive Attribute - The month of decommisioning in the format of YYMM (e.g. 1707 for July 2017).',
   LIDL_DELIVERY_WEEK_FIXED_FG         BOOLEAN         COMMENT 'Descriptive Attribute - Flag indicating if the delivery week is fixed.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.',   
   CONSTRAINT PK_FACT_TRUCK_SALES_VARIANT PRIMARY KEY (DELIVERY_NR, DISTRIBUTION_NR) NOT ENFORCED 
)  COMMENT = 'Fact table - Transactional Events - This table contains detailed informationen of transactions of materials delivered by trucks  - Source - LExIS';
