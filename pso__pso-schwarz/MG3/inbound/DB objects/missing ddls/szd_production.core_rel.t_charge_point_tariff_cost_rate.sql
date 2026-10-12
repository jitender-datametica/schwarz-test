CREATE OR REPLACE TABLE szd_production.core_rel.t_charge_point_tariff_cost_rate (
    charge_point_cost_rate_id NUMBER(38,0) NOT NULL COMMENT 'the unique identifier of the charge point tariff.',
    charge_point_tariff_id NUMBER(38,0) NOT NULL COMMENT 'the unique identifier of the charge point tariff.',
    charge_point_cost_rate_nr VARCHAR(250) NOT NULL COMMENT 'the code of the cost rate for the charge point tariff.',
    dwh_created_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was inserted into the table.',
    dwh_updated_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
    dwh_src_file_name VARCHAR(500) COMMENT 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path',
    dwh_src_1_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the extraction timestamp of the record from the source',
    CONSTRAINT pk_charge_point_tariff_cost_rate PRIMARY KEY (charge_point_cost_rate_id)
) 
COMMENT = 'minor entity - defines the possible cost rates of a charge point tariff. - source - iotcharger';