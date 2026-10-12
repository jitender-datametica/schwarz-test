--==============================================================
-- DBMS name:      Snowflake
-- Created on:     04.12.2021 11:01:08
--==============================================================


--==============================================================
-- Table: T_KEY_RESOURCE_ITEM_GROUP_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_KEY_RESOURCE_ITEM_GROUP_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_key_resource_item_group_1 (
src_01_cd STRING(100) NOT NULL OPTIONS(description='Source system key 01'),
src_02_cd STRING(100) NOT NULL OPTIONS(description='Source system key 02'),
src_namespace_cd STRING(100) NOT NULL OPTIONS(description='Name space code for source system key'),
resource_item_group_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Resource item_1 group SID'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (src_01_cd, src_02_cd, src_namespace_cd) NOT ENFORCED
) OPTIONS(description='Key table for resource item_1 groups');