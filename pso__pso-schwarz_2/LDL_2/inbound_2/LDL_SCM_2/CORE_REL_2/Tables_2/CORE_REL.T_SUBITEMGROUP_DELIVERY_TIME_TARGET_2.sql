CREATE TABLE CORE_REL.T_SUBITEMGROUP_DELIVERY_TIME_TARGET_2 (
   subitemgrp_cd                       VARCHAR(20)     NOT NULL COMMENT 'Subitemgroup code (higher level of product hierarchy_2)',
   tgt_delivery_time_week_cnt          NUMBER(38, 0)   COMMENT 'Target delivery time in weeks',
   supplier_name                       VARCHAR(100)    COMMENT 'Supplier_2 name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   CONSTRAINT PK_T_SUBITEMGROUP_DELIVERY_TIME_TARGET PRIMARY KEY (subitemgrp_cd) NOT ENFORCED
 )  COMMENT= 'Target delivery time set for each subitem group by business';
