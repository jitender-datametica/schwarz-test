CREATE OR REPLACE TABLE szd_production_core_rel.t_customs_clearance_report_line_document_rel_1 (
movement_ref_number STRING(250) NOT NULL
OPTIONS(description='The movement reference number is a customs identification number that’s created each time a declaration is submitted.'),
trader_reference STRING(250) NOT NULL
OPTIONS(description='Descriptive attribute - This is a reference assigned by the declarant for the goods covered by the declaration.'),
item_position INTEGER NOT NULL OPTIONS(description='The position of the item_1 (report line) within a declaration.'),
resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the resource item..'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (movement_ref_number, trader_reference, item_position, resource_item_sid) NOT ENFORCED
)
OPTIONS(description='Bridge - Associates a customs clearance report line with all attached documents. - CDS (Customs Declaration Service) - Source - Excel Report from CDS (per Mail)');