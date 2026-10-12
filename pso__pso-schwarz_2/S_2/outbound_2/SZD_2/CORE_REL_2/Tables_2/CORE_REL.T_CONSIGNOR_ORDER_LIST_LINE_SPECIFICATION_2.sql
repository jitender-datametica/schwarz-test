/* --------------------------------------------------------------------------------
   DDL for table: T_CONSIGNOR_ORDER_LIST_LINE_SPECIFICATION_2
   generated from Powerdesigner on Montag, 17. Juli 2023 13:58:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_consignor_order_list_line_specification_2 (
trader_reference_nr STRING(250) NOT NULL
OPTIONS(description='Natural Key/Business Key - This is a reference assigned by the declarant for the goods covered by the declaration.'),
order_dt DATE NOT NULL
OPTIONS(description='Natural Key/Business Key - The date when the goods were ordered by the consignor.'),
item_position_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The position number within the order (truck load)'),
specification_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The number of the specification.'),
spec_uom_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the unit_2 (e.g. material unit_2, production line parameter)'),
spec_meas BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The measurement value of this specification.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (trader_reference_nr, order_dt, item_position_seq, specification_seq) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - Describes a specific value consisting of a numeric value and a unit_2 of measurement for a specific position within an order. - Source - BEI Report');