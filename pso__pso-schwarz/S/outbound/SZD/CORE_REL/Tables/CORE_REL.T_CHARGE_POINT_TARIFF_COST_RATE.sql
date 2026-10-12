/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_TARIFF_COST_RATE
   generated from Powerdesigner on Donnerstag, 16. November 2023 11:09:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_point_tariff_cost_rate (
charge_point_cost_rate_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the charge point tariff.'),
charge_point_tariff_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the charge point tariff.'),
charge_point_cost_rate_nr STRING(250) NOT NULL
OPTIONS(description='The code of the cost rate for the charge point tariff.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charge_point_cost_rate_id) NOT ENFORCED
) OPTIONS(description='Minor Entity - Defines the possible cost rates of a charge point tariff. - Source - IOTCharger');