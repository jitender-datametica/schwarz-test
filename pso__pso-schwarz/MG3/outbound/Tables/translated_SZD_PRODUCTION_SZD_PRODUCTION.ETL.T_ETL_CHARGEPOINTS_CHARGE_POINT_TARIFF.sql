CREATE OR REPLACE TABLE szd_production_etl.t_etl_chargepoints_charge_point_tariff (
charge_point_tariff_id INTEGER NOT NULL OPTIONS(description='The unique identifier of the charge point tariff.'),
charge_point_tariff_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charge point tariff type.'),
charge_point_tariff_name STRING(100) NOT NULL
OPTIONS(description='Natural/Business Key - The unique name of the charge point tariff.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charge_point_tariff_id) NOT ENFORCED
);