CREATE TABLE IF NOT EXISTS ldl_score_meta.t_party_key_1 (
party_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the Party.'),
party_type_cd STRING(100) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the Party.'),
dwh_valid_from_tmsp TIMESTAMP DEFAULT CAST('1900-01-01 00:00:00' AS TIMESTAMP)
NOT NULL OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP DEFAULT CAST('9999-12-31 23:59:59' AS TIMESTAMP)
NOT NULL OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL DEFAULT TRUE NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
nat_key_comp_1_nr STRING(100) DEFAULT '@' NOT NULL
OPTIONS(description='The natural key which identifies the Party.In case the natural key consist of several columns, all components get concatenated.'),
nat_key_comp_2_nr STRING(100) DEFAULT '@' NOT NULL
OPTIONS(description='The natural key which identifies the Party.In case the natural key consist of several columns, all components get concatenated.'),
nat_key_comp_3_nr STRING(100) DEFAULT '@' NOT NULL
OPTIONS(description='The natural key which identifies the Party.In case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP DEFAULT CURRENT_TIMESTAMP() NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP DEFAULT CURRENT_TIMESTAMP() NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (party_type_cd, dwh_valid_from_tmsp, nat_key_comp_1_nr, nat_key_comp_2_nr, nat_key_comp_3_nr) NOT ENFORCED
)
OPTIONS(description='Key table for the Party key space. A surrogate key is identified by one or several natural keys. The kind of natural key is defined by the key type code. In case the natural key consists of several columns, all components get concatenated using a separator character. The association between a natural key and its surrogate key can change over time, e.g. because of a re_1-numbering in the source. That is why the key table is historized.');