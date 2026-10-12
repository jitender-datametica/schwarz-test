/* --------------------------------------------------------------------------------
   DDL for table: t_logistic_unit_of_measure
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_logistic_unit_of_measure (
logistic_uom_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the logistic unit of measure. (e.g. palettes, boxes, pieces or layers on a palette)'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
logistic_uom_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the logistic unit of measure.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (logistic_uom_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='For logistics, quantities are expressed as numbers of palettes, boxes, pieces or layers on a palette. The logistic unit of measure defines these units.');