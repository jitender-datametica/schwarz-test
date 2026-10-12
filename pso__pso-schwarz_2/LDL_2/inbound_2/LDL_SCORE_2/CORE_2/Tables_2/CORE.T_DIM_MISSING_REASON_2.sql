--==============================================================
-- Table: t_dim_missing_reason_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_missing_reason_2
   generated from Powerdesigner on Donnerstag, 8. August 2024 10:13:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MISSING_REASON_2 (
   missing_reason_cd                   VARCHAR(20)     NOT NULL COMMENT 'A code defining why a (part of) a dispo order position was declared as being missing',
   missing_reason_descr                VARCHAR(100)    COMMENT 'A textual description for the missing_reason_cd written out in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_MISSING_REASON PRIMARY KEY (missing_reason_cd) NOT ENFORCED 
)  COMMENT = 'Contains the reasons why goods have not arrived as agreed at a certain time. For example, this may be a late delivery or incorrect temperature storage of goods, production problems, etc. ';
