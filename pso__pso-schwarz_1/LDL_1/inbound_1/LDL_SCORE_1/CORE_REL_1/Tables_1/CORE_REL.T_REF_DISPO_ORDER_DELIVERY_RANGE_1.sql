--==============================================================
-- Table: t_ref_dispo_order_delivery_range_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_dispo_order_delivery_range_1
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 08:57:05
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_DISPO_ORDER_DELIVERY_RANGE_1 (
   dispo_order_delivery_range_cd       VARCHAR(20)      NOT NULL COMMENT 'The code for the delivery range, i.e. whether it is a day based or week based disposition.',
   dispo_order_delivery_range_descr    VARCHAR(100)     NOT NULL COMMENT 'A textual description for the dispo_order_delivery_range_cd written out in group language (German).',
   dispo_order_delivery_range_descr_de VARCHAR(100)     COMMENT 'A textual description for the dispo_order_delivery_range_cd written out in German.',
   dispo_order_delivery_range_descr_en VARCHAR(100)     COMMENT 'A textual description for the dispo_order_delivery_range_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_DISPO_ORDER_DELIVERY_RANGE       PRIMARY KEY (dispo_order_delivery_range_cd) NOT ENFORCED 
)  COMMENT = 'Describes the delivery range, i.e. whether it is a day based or week based disposition. ';
