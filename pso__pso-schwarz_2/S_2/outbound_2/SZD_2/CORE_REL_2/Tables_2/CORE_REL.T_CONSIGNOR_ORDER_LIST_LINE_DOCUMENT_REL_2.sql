/* --------------------------------------------------------------------------------
   DDL for table: T_CONSIGNOR_ORDER_LIST_LINE_DOCUMENT_REL_2
   generated from Powerdesigner on Freitag, 2. Februar 2024 10:20:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_consignor_order_list_line_document_rel_2 (
trader_reference_nr STRING(250) NOT NULL
OPTIONS(description='Natural Key/Business Key - This is a reference assigned by the declarant for the goods covered by the declaration.'),
order_dt DATE NOT NULL
OPTIONS(description='Natural Key/Business Key - The date when the goods were ordered by the consignor.'),
item_position_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The position number within the order (truck load)'),
resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item..'),
preference_indicator_fg BOOL NOT NULL
OPTIONS(description='A flag indicating whether this document is used to determine the preference.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source.'),
PRIMARY KEY (trader_reference_nr, order_dt, item_position_seq, resource_item_sid) NOT ENFORCED
)
OPTIONS(description='Bridge - Associates a consignor order list line with all attached documents. - Source - BEI Report');