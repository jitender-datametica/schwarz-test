/* --------------------------------------------------------------------------------
   DDL for table: t_order_area_1
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_ORDER_AREA_1 (
   order_area_nr                       VARCHAR(20)     NOT NULL COMMENT 'The number which identifies the order area.',
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   order_area_descr                    VARCHAR(250)    NOT NULL COMMENT 'A textual description for the order area.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_ORDER_AREA PRIMARY KEY (order_area_nr, int_org_sid, lang_cd) NOT ENFORCED
 )  COMMENT= 'The order area groups items that are typically stored in the same storage zone in the warehouse. In different  warehouses, the assignment may be different. An order area is identified by its number and the warehouse. (I.e. the number is local to the warhouse.)';

