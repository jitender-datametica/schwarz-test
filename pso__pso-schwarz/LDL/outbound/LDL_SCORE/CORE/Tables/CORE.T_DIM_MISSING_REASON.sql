--==============================================================
-- Table: t_dim_missing_reason
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_missing_reason
   generated from Powerdesigner on Donnerstag, 8. August 2024 10:13:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_missing_reason (
missing_reason_cd STRING(20) NOT NULL
OPTIONS(description='A code defining why a (part of) a dispo order position was declared as being missing'),
missing_reason_descr STRING(100)
OPTIONS(description='A textual description for the missing_reason_cd written out in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (missing_reason_cd) NOT ENFORCED
)
OPTIONS(description='Contains the reasons why goods have not arrived as agreed at a certain time. For example, this may be a late delivery or incorrect temperature storage of goods, production problems, etc. ');