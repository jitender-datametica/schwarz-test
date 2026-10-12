/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_PRODUCT
   generated from Powerdesigner on Dienstag, 19. Dezember 2023 09:34:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_product (
product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the customs product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
customs_product_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs product type.'),
origin_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) for the political country.'),
consignor_stream_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the of the consignor stream.'),
customs_classification_scheme_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the customs classification scheme.'),
customs_tariff_code_cd STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key - The standardized customs tariff code number.'),
product_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant. This only applies when the customs product is a GTS product.'),
parent_product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product. This only applies when the customs product is a WWT product.'),
customs_product_nr STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key - The product number from the GTS report or GS Upload'),
additional_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - An additional customized code from the source which specialized the product.'),
customs_product_name STRING(250) NOT NULL
OPTIONS(description='The name/description of the customs product provided by the GS upload.'),
preferential_origin_fg BOOL
OPTIONS(description='Flag that shows whether the supplier can provide proof of preference or not.'),
allocation_cnt BIGNUMERIC(38,0) OPTIONS(description='The count of pieces in a carton of this product.'),
volume_unit_qty BIGNUMERIC(38,5) OPTIONS(description='The volume of a unit of the product (e.g. size of a bottle).'),
volume_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the unit of measure of the product (WWT only)'),
alcoholic_beverage_tax_rate_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the tax rate for alcoholic beverages within the country.'),
alcoholic_beverage_pct BIGNUMERIC(38,5) OPTIONS(description='The percentage of alcohol within an alcoholic beverage,'),
alcoholic_beverage_adjusted_pct BIGNUMERIC(38,5)
OPTIONS(description='The adjusted percentage of alcohol within an alcoholic beverage,'),
alcoholic_beverage_volume_qty BIGNUMERIC(38,5)
OPTIONS(description='The volume of the bottle/jar of the alcoholic beverage.'),
alcoholic_beverage_volume_lpa_qty BIGNUMERIC(38,5)
OPTIONS(description='The volume of pure alcohol in the bottle/jar of the alcoholic beverage.'),
alcoholic_beverage_uom_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The ID of the unit of measure for the alcoholic beverage.'),
alcoholic_beverage_duty_per_lpa_val BIGNUMERIC(38,5)
OPTIONS(description='The amount of duty per liter of pure alcohol.'),
alcoholic_beverage_duty_per_unit_val BIGNUMERIC(38,8) OPTIONS(description='The amount of duty per unit (bottle/jar).'),
special_excise_rate_val BIGNUMERIC(38,8)
OPTIONS(description='A special excise rate to be used to calculate the excise duty for this product. If NULL, the excise rate provided by the tax code is used.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (product_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - The customs product is a special product definition used in the "Foreign Trade" solution to cover both GTS and WWT products. - Source - GS-Upload, GTS/WWT, Excel Report from CDS, Broker (per Mail)');