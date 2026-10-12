CREATE OR REPLACE TABLE szd_production_core.t_dim_charger_authentication_method_1 (
authentication_method_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the authentication method.'),
authentication_method_name STRING(100) NOT NULL
OPTIONS(description='The displayable name of the authentication method.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (authentication_method_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - The method used for authenticating on a charging station by a customer. - Source - Manual');