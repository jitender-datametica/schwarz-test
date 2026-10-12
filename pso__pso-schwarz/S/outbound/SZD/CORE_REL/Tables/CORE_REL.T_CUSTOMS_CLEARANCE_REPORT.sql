/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_CLEARANCE_REPORT
   generated from Powerdesigner on Dienstag, 9. Mai 2023 12:49:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_clearance_report (
movement_ref_number STRING(250) NOT NULL
OPTIONS(description='The movement reference number is a customs identification number that’s created each time a declaration is submitted.'),
trader_reference STRING(250) NOT NULL
OPTIONS(description='Descriptive attribute - This is a reference assigned by the declarant for the goods covered by the declaration.'),
authority_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country of the customs authority that created this clearance report.'),
importer_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the importer who initiated the customs declaration via a broker or directly.'),
importer_declarant_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the importer who made the declaration to the customs authority. If not specified then the declaration was made by a broker.'),
broker_declarant_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the broker who made the declaration to the customs authority. If not specified then the declaration was made by a importer.'),
dispatch_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country that dispatched the good.'),
import_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the transhipment location where the goods are unloaded.'),
transport_type_cd STRING(50) NOT NULL OPTIONS(description='The unique identifier of the transport mode.'),
transport_route_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the transport route type.'),
transport_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country that has made the transport of the goods.'),
customs_declaration_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique identifier of the customs declaration type.'),
entry_dt DATE NOT NULL OPTIONS(description='The date when the data enters the CDS system.'),
entry_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive attribute - The time when the data enters the CDS system.'),
acceptance_dt DATE NOT NULL OPTIONS(description='The time when the goods have arrived at the import location.'),
clearance_dt DATE NOT NULL
OPTIONS(description='The date on which the goods were granted clearance by Customs and any duties/taxes due were paid.'),
clearance_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive attribute - The time on which the goods were granted clearance by Customs and any duties/taxes due were paid.'),
consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
consignor_name STRING(100) OPTIONS(description='Descriptive attribute -The name of the consignor.'),
customs_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total value of the item for the purposes of customs duty. In addition to the actual price of the goods this includes additional elements such as freight charges to the EU boundary. '),
total_duty_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total amount of customs duty actually paid outright for the whole declaration.'),
total_vat_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total value of the item for purposes of VAT. This can differ from the Customs Value - for example, it includes any customs duty paid together with freight charges from the EU to the UK boundary.'),
total_vat_paid_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total amount of VAT paid on the whole declaration.'),
total_cap_val BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The total amount of CAP value.'),
total_excise_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total amount of excise on the whole declaration.'),
invoice_auth_country_curr_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying the currency, according to ISO 4217. This is the currency of the country where the goods are imported in.'),
invoice_auth_country_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The value of the invoice in the currency of the country where the goods are imported in.'),
invoice_trust_curr_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying the currency, according to ISO 4217. This is the currency of the used by the trust.'),
invoice_trust_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The value of the invoice in the currency used by the trust.'),
paying_agent_number STRING(250)
OPTIONS(description='Descriptive attribute - Number of the organization who will  pay taxes and duties.'),
total_packages_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Total count of all packages of a declaration.'),
declaration_ucr STRING(250)
OPTIONS(description='Descriptive attribute - This is a unique consignment reference for the goods covered by the declaration. The reference can be used to identify the entry for amendment or cancellation and is used for inventory linking. On a declaration the UCR may be a reference allocated by a forwarder or one chosen by the declarant, possibly allocated by the exporter, seller, buyer or importer.'),
first_deferment BIGNUMERIC(38,0)
OPTIONS(description='Descriptive attribute - The first deferment approval number to identify the deferment account to which revenue is to be debited.'),
second_deferment BIGNUMERIC(38,0)
OPTIONS(description='Descriptive attribute - The second deferment approval number to identify the deferment account to which revenue is to be debited.'),
air_transport_adjust_cost_curr_cd STRING(50) NOT NULL
OPTIONS(description='The currency code used for specifiying the amount of air transport cost adjustments.'),
air_transport_adjust_cost_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The cost amount for air transport adjustments.'),
vat_adjustment_curr_cd STRING(50) NOT NULL
OPTIONS(description='The currency code used for specifiying the amount of VAT value adjustments.'),
vat_adjustment_val BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The value for the VAT adjustment.'),
transport_adjust_cost_curr_cd STRING(50) NOT NULL
OPTIONS(description='The currency code used for specifiying the amount of transport cost adjustments.'),
transport_adjust_cost_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The amount of the transport cost adjustments.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (movement_ref_number, trader_reference) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional Events - Snapshot - A report from a customs authority containing the results of customs clearance for declared/imported goods. - Source - Excel Report from CDS (per Mail)');