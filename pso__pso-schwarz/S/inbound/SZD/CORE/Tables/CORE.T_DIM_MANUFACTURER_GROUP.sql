/* --------------------------------------------------------------------------------
   DDL for table: t_dim_manufacturer_group
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:30:25
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MANUFACTURER_GROUP (
   manufacturer_group_cd               VARCHAR(50)     NOT NULL COMMENT 'the type of machines, products..a manufacturer produces',
   manufacturer_group_name             VARCHAR(100)    NOT NULL COMMENT 'The group name of manufacturers Productions',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_DIM_MANUFACTURER_GROUP PRIMARY KEY (manufacturer_group_cd) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines Manufactrurer groups for which they produce machines e.g. RVM, HGA';
