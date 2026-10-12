CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_transshipment_point_type_2 (
transpoint_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.'),
transpoint_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the transpoint_type_cd written out in group language (German).'),
transpoint_type_descr_de STRING(100)
OPTIONS(description='A textual description for the transpoint_type_cd written out in German.'),
transpoint_type_descr_en STRING(100)
OPTIONS(description='A textual description for the transpoint_type_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (transpoint_type_cd) NOT ENFORCED
) OPTIONS(description='This entity defines  type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.');