CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_logistic_unit_1 (
logistic_unit_cd STRING(20) NOT NULL OPTIONS(description='A code for type of packaging e.g. PAL, CASE (Kolli) etc.'),
logistic_unit_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the logistics_unit_cd written out in group language (German).'),
logistic_unit_descr_de STRING(100)
OPTIONS(description='A textual description for the logistics_unit_cd written out in German.'),
logistic_unit_descr_en STRING(100)
OPTIONS(description='A textual description for the logistics_unit_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (logistic_unit_cd) NOT ENFORCED
)
OPTIONS(description='Describes in which case size the products are delivered. This can be done piecewise, via palets or colli. ');