/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CHARGE_POINT_POWER_TYPE_1
   generated from Powerdesigner on Donnerstag, 8. Mai 2025 13:38:16
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_charge_point_power_type_1 (
charge_point_power_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charging power type.'),
charge_point_power_type_name STRING(100) NOT NULL
OPTIONS(description='The displayable name of the charging power type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charge_point_power_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - The type of the power of a charge point on a charger station. - Source - Manual');