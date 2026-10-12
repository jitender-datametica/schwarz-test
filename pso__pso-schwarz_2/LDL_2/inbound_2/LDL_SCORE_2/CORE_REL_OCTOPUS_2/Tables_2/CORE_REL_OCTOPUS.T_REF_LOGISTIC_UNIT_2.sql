CREATE TABLE CORE_REL_OCTOPUS.T_REF_LOGISTIC_UNIT_2 (
   logistic_unit_cd                    VARCHAR(20)     NOT NULL COMMENT 'A code for type of packaging e.g. PAL, CASE (Kolli) etc.',
   logistic_unit_descr                 VARCHAR(100)    NOT NULL COMMENT 'A textual description for the logistics_unit_cd written out in group language (German).',
   logistic_unit_descr_de              VARCHAR(100)    COMMENT 'A textual description for the logistics_unit_cd written out in German.',
   logistic_unit_descr_en              VARCHAR(100)    COMMENT 'A textual description for the logistics_unit_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_LOGISTIC_UNIT PRIMARY KEY (logistic_unit_cd) NOT ENFORCED 
)  COMMENT = 'Describes in which case size the products are delivered. This can be done piecewise, via palets or colli. ';
