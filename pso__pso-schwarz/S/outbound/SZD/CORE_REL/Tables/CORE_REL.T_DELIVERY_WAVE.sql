/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_WAVE
   generated from Powerdesigner on Donnerstag, 28. November 2024 11:30:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_delivery_wave (
distribution_nr STRING(250) NOT NULL OPTIONS(description='The business number of the distribution.'),
distribution_position_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of the position of the delivery.'),
wave_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of the wave of the delivery position.'),
distribution_store_group_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='TODO'),
delivery_dt DATE OPTIONS(description='The deliviery date of this wave.'),
distribution_qty BIGNUMERIC(38,5) OPTIONS(description='The quantity to be delivered in this wave,'),
distribution_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The number identifying the distribution quantity unit of measure.'),
order_qty BIGNUMERIC(38,5) OPTIONS(description='The ordered quantity.'),
order_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The number identifying the order quantity unit of measure.'),
desired_qty BIGNUMERIC(38,5) OPTIONS(description='The desired quantity.'),
order_dt DATE OPTIONS(description='The order date.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (distribution_position_nr, wave_nr, distribution_nr, distribution_store_group_nr) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - A wave of a delivery is a scheduled partial delivery of the goods to the target (e.g. a store) . - Source - Lexis');