CREATE TABLE CORE_OCTOPUS.T_DIM_DISPO_ORDER_STATUS_1 (
   dispo_order_status_cd               VARCHAR(20)     NOT NULL COMMENT 'The code for the status_1 of the disposition (e.g. initialized, approved, sent)',
   dispo_order_status_descr            VARCHAR(100)    COMMENT 'A textual description for the dispo_order_status_cd wirtten out in group language (German).',
   dispo_order_status_descr_de         VARCHAR(100)    COMMENT 'A textual description for the dispo_order_status_cd wirtten out in German.',
   dispo_order_status_descr_en         VARCHAR(100)    COMMENT 'A textual description for the dispo_order_status_cd wirtten out in English',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_DISPO_ORDER_STATUS PRIMARY KEY (dispo_order_status_cd) NOT ENFORCED 
)  COMMENT = 'Shows the actual state of an order. Whether its initialized, approved, sent. ';
