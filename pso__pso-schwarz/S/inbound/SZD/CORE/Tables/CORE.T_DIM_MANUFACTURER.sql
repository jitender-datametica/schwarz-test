/* --------------------------------------------------------------------------------
   DDL for table: t_dim_manufacturer
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:31:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MANUFACTURER (
   manufacturer_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a company which produces deposit machines.',
   manufacturer_group_cd               VARCHAR(50)     NOT NULL COMMENT 'the type of machines, products..a manufacturer produces',
   manufacturer_name                   VARCHAR(100)    NOT NULL COMMENT 'The name of a company which produces deposit machines.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_DIM_MANUFACTURER PRIMARY KEY (manufacturer_sid) NOT ENFORCED
 )  COMMENT= 'A company that produces machines, products e.g..Tomra, Sielaff';
