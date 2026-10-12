
CREATE TABLE CORE_REL.T_ITEM_2 (
   client_id                           NUMBER(38, 0)   NOT NULL,
   country_iso_cd                      VARCHAR(3)      NOT NULL,
   orig_item_nr                        NUMBER(38, 0)   NOT NULL,
   orig_item_nr_int                    NUMBER(9, 0),
   case_size                           NUMBER(38, 4)   NOT NULL,
   package_qty                         NUMBER(38, 4),
   item_name                           VARCHAR(100)    NOT NULL,
   item_descr                          VARCHAR(250)    NOT NULL,
   src_orig_item_nr_int                NUMBER(9, 0)    COMMENT 'An IAN number that was mapped in data warehouse',
   familygrp_cd                        VARCHAR(20)     COMMENT 'Family group code (lower level of product hierarchy_2)',
   subitemgrp_cd                       VARCHAR(20)     COMMENT 'Subitemgroup code (higher level of product hierarchy_2)',
   dwh_created_tmsp                    TIMESTAMP_NTZ(6) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_NTZ(6) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   CONSTRAINT PK_T_ITEM PRIMARY KEY (client_id, country_iso_cd, orig_item_nr, case_size, item_name, item_descr) NOT ENFORCED
 )  COMMENT= 'Product Data';



