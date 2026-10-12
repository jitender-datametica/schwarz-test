CREATE OR REPLACE TABLE szd_production_core_rel.t_broker_report_line (
movement_ref_number STRING(250) NOT NULL
OPTIONS(description='This is a customs identification number that’s created each time a declaration is submitted\n            The movement reference number for importing or exporting goods. The number generated is bespoke, allowing your goods to be uniquely linked to you. As such, it forms an important part of the audit process for your declarations.'),
item_position INTEGER NOT NULL
OPTIONS(description='The number of the Item to which the report line refers. It\'s\"Item Number\" in CDS item.'),
trader_reference STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - This is a reference assigned by the declarant for the goods covered by the declaration.'),
authority_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country of the customs auhtority.'),
customs_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs procedure code.'),
customs_classification_scheme_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the customs classification scheme.'),
customs_tariff_code_cd STRING(250) NOT NULL OPTIONS(description='The standardized customs tariff code number.'),
customs_preference_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs procedure code.'),
non_preferential_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country for goods without a preference.'),
preferential_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country for goods with a preference.'),
customs_product_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the customs product.'),
invoice_number STRING(250) OPTIONS(description='Descriptive Attribute - This is the invoice number given by SAP.'),
gross_mass_meas NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The gross mass of the declared goods in kilograms.'),
net_mass_meas NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The net mass of the declared goods in kilograms.'),
charge_amount_curr_cd STRING(50) NOT NULL
OPTIONS(description='The currency in which the charge amount of an item is specified.'),
charge_amount_val NUMERIC(29,5) NOT NULL OPTIONS(description='Fact - additive - That is the price on the invoice. '),
item_descr STRING(250) NOT NULL OPTIONS(description='Descriptive Attribute - Text description of the declared goods.'),
abv_pct NUMERIC(29,5)
OPTIONS(description='Fact - not additive - If the articel is beer, this is the concentration of alcohol.'),
item_piece_cnt INTEGER NOT NULL OPTIONS(description='Fact - additive - Count of item pieces. (TODO)'),
item_tariff_qty_uom_id INTEGER NOT NULL
OPTIONS(description='Id of the unit (e.g. material unit, production line parameter) for the item tariff quantity.'),
item_tariff_qty NUMERIC(29,5)
OPTIONS(description='Fact - additive - It is additional unit inforamtion for special products, like alcohol. Regarding alcohol it is the amount of the alcohol. For example it is 300 Liter.'),
alcoholic_beverage_tax_rate_cd STRING(50)
OPTIONS(description='The unique code of the tax rate for alcoholic beverages within the country.'),
duty_excise_rate_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - Excise duty rate used to calculate excise (per unit) as a descriptive text.'),
excise_payment_amount_val NUMERIC(29,5) OPTIONS(description='Fact - additive - How much excise was actually paid.'),
value_for_duty_val NUMERIC(29,5)
OPTIONS(description='Fact - additive - It is the value that is used to determine how much customs duties you need to pay for the item.'),
duty_payment_amount_val NUMERIC(29,5) OPTIONS(description='Fact - additive - How much was atucually paid for duty.'),
value_for_vat_val NUMERIC(29,5)
OPTIONS(description='Fact - additive - The total value of each position\'s item for purposes of VAT. This can differ from the\n            Customs Value - for example, it includes any customs duty paid together with\n            freight charges from the EU to the UK boundary. It is\"VAT Value\" in CDS item.'),
vat_payment_amount_val NUMERIC(29,5)
OPTIONS(description='Fact - additive -  It means how much VAT was paid for this position at the moment we submit the declaration.'),
vat_tax_assessed_amount_val NUMERIC(29,5)
OPTIONS(description='Fact - additive -  It means how much VAT should be paid for this position.'),
supplementary_cd STRING(50)
OPTIONS(description='Descriptive Attribute - An additional code of the  commedity code (customs tariff number).'),
documents_txt STRING(1000) OPTIONS(description='Descriptive Attribute - Additional document references.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source.'),
PRIMARY KEY (movement_ref_number, item_position, trader_reference) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional Events - Snapshot - A broker report line is part of a declaration/shipment declared in the broker report. It describes a single item within the declaration. - Source - Excel-Report from Broker (per Mail)');