/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_TARIFF_TYPE
   generated from Powerdesigner on Mittwoch, 15. November 2023 11:12:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_point_tariff_type (
charge_point_tariff_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charge point tariff type.'),
charge_point_tariff_type_descr STRING(250) NOT NULL OPTIONS(description='A brief description of the tariff type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charge_point_tariff_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The type of tariff determines whether the charging station can be used by your own customers or employees and/or whether the charging station can also be used by third parties (public). - Source - Manual');