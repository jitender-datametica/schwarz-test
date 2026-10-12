/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_CLEARANCE_REPORT_LINE_1
   generated from Powerdesigner on Freitag, 18. August 2023 09:35:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_clearance_report_line_1 (
movement_ref_number STRING(250) NOT NULL
OPTIONS(description='The movement reference number is a customs identification number that’s created each time a declaration is submitted.'),
trader_reference STRING(250) NOT NULL
OPTIONS(description='Descriptive attribute - This is a reference assigned by the declarant for the goods covered by the declaration.'),
item_position BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The position of the item_1 (report line) within a declaration.'),
clearance_dt DATE NOT NULL
OPTIONS(description='The date on which the goods were granted clearance by Customs and any duties/taxes due were paid.'),
origin_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country_1 where the goods are manufactured.'),
customs_preference_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs procedure code.'),
customs_valuation_method_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique code of the customs valuation method.'),
customs_product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the customs product.'),
customs_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs procedure code.'),
additional_special_cpc_codes STRING(1000)
OPTIONS(description='Descriptive attribute - Additional special customs procedure codes.'),
customs_classification_scheme_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the customs classification scheme.'),
customs_tariff_code_cd STRING(250) NOT NULL OPTIONS(description='The standardized customs tariff code number.'),
first_supplementary_cd STRING(50) OPTIONS(description='The first supplementary code to the customs tariff code.'),
second_supplementary_cd STRING(50) OPTIONS(description='The second supplementary code to the customs tariff code.'),
inventory_ucr STRING(250)
OPTIONS(description='Descriptive attribute - This field contains any inventory consignment reference that has been declared.'),
declaration_part_number STRING(50)
OPTIONS(description='Descriptive attribute - Optionally completed when more than one declaration is made to cover the goods identified by the same Decln UCR. '),
item_price BIGNUMERIC(38,5)
OPTIONS(description='Descriptive attribute - Item_1 price in the same currency as the one used for the invoice total amount.'),
customs_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total value of the item_1 for the purposes of customs duty. In addition to the actual price of the goods this includes additional elements such as Freight Charges to the EU boundary. '),
duty_paid_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total amount of customs duty actually paid outright for the item. This does not include any potential duty calculated but not charged, for example, for IPR. '),
vat_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total value of the item_1 for purposes of VAT. This can differ from the Customs Value - for example, it includes any customs duty paid together with freight charges from the EU to the UK boundary.'),
vat_paid_val BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The total amount of VAT paid on the item.'),
duty_suspended_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total amount of customs duty suspended for the item.'),
duty_secured_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total amount of customs duty secured for the item. This records any amount declared with a security method of payment indicating that the final amount payable has not been determined.'),
net_mass_qty BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The net mass in kilograms of the goods declared.'),
supplementary_units_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The commodity code may require a second declaration quantity. If so it appears here in whatever form the Tariff requires – it can be pairs, items, litres, dozens'),
goods_descr STRING(250) OPTIONS(description='Descriptive attribute - Description of the declared goods.'),
document_references STRING(1000)
OPTIONS(description='Descriptive attribute - A list of document references provided by the customs authority.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (movement_ref_number, trader_reference, item_position) NOT ENFORCED
)
OPTIONS(description='Entity -Tranactional Events - Transaction - The report line as part of a customs clearance report contains detailed information about the customs clearance of an item_1 within the declaration. - - Source - Excel Report from CDS (per Mail)');