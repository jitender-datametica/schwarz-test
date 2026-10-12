--==============================================================
-- Table: t_logistics_tariff_key_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_logistics_tariff_key_2
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:50:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_meta.t_logistics_tariff_key_2 (
logistics_tariff_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the LOGISTICS TARIFF.'),
logistics_tariff_key_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the LOGISTICS TARIFF.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
nat_key_comp_nr STRING(100) NOT NULL
OPTIONS(description='The natural key which identifies the Agreement.In case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (logistics_tariff_key_type_cd, dwh_valid_from_tmsp, nat_key_comp_nr) NOT ENFORCED
)
OPTIONS(description='Key table for the LOGISTICS TARIFF key space. A surrogate key is identified by one or several natural keys. The kind of natural key is defined by the key type code. In case the natural key consists of several columns, all components get concatenated using a separator character. The association between a natural key and its surrogate key can change over time, e.g. because of a re_2-numbering in the source. That is why the key table is historized.');