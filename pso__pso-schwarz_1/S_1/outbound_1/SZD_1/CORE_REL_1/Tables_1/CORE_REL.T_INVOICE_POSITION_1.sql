/* --------------------------------------------------------------------------------
   DDL for table: T_INVOICE_POSITION_1
   generated from Powerdesigner on Montag, 12. Februar 2024 09:21:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_invoice_position_1 (
finance_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the invoice position.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
invoice_finance_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the invoice that contains this position.'),
product_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
origin_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country.'),
export_warehouse_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the export warehouse.'),
carrier_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the carrier/hauler company.'),
reference_invoice_position_finance_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the referenced invoice position.'),
invoice_position_seq BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The position number within the invoice.'),
additional_product_cd STRING(250) NOT NULL OPTIONS(description='An additional product code (can be empty, only WWT).'),
product_name STRING(100) NOT NULL OPTIONS(description='The name of the product defined in this invoice position.'),
business_transaction_type_cd STRING(250)
OPTIONS(description='The code of the business transaction type (as it comes from WWT)'),
unit_gross_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Gross weight of a unit_1 of the product in kilogram.'),
unit_net_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Net weight of a unit_1 of the product in kilogram.'),
item_net_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Net weight of a item_1 of the product in kilogram.'),
non_food_fg BOOL OPTIONS(description='Flag indicating whether this product is categorized as "Non Food".'),
amount_val BIGNUMERIC(38,5) OPTIONS(description='The amount value of this invoice position.'),
price_val BIGNUMERIC(38,5) OPTIONS(description='The price amount of the invoice position.'),
package_content_cnt BIGNUMERIC(38,0) OPTIONS(description='The count of single items within a package.'),
package_qty BIGNUMERIC(38,5) OPTIONS(description='The quantity of packages.'),
loading_dt DATE OPTIONS(description='The date of the loading of the goods to the transport vehicle.'),
batch_nr STRING(250) OPTIONS(description='The number of the batch the product is part of.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (finance_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - The invoice position is part of an invoice and contains information about a specific product sold/bought. - Source - WWT');