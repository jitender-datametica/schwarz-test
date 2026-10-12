CREATE TABLE CORE_OCTOPUS.T_DIM_MISSING_REASON (
   missing_reason_cd                   VARCHAR(20)     NOT NULL COMMENT 'A code defining why a (part of) a dispo order position was declared as being missing',
   missing_reason_descr                VARCHAR(100)    COMMENT 'A textual description for the missing_reason_cd written out in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_MISSING_REASON PRIMARY KEY (missing_reason_cd) NOT ENFORCED 
)  COMMENT = 'Contains the reasons why goods have not arrived as agreed at a certain time. For example, this may be a late delivery or incorrect temperature storage of goods, production problems, etc. ';
