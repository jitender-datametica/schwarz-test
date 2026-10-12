CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_missing_reason_2 (
missing_reason_cd STRING(20) NOT NULL
OPTIONS(description='A code defining why a (part of) a dispo order position was declared as being missing'),
missing_reason_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the missing_reason_cd written out in group language (German).'),
missing_reason_descr_de STRING(100)
OPTIONS(description='A textual description for the missing_reason_cd written out in German.'),
missing_reason_descr_en STRING(100)
OPTIONS(description='A textual description for the missing_reason_cd written out in English.'),
elm_missing_reason_id BIGNUMERIC OPTIONS(description='ELM reasonid'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (missing_reason_cd) NOT ENFORCED
)
OPTIONS(description='Contains the reasons why goods have not arrived as agreed at a certain time. For example, this may be a late delivery or incorrect temperature storage of goods, production problems, etc. ');