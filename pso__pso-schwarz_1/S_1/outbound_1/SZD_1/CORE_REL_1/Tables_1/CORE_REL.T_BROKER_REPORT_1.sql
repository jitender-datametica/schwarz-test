/* --------------------------------------------------------------------------------
   DDL for table: T_BROKER_REPORT_1
   generated from Powerdesigner on Dienstag, 9. Mai 2023 12:59:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_broker_report_1 (
movement_ref_number STRING(250) NOT NULL
OPTIONS(description='This is a customs identification number that’s created each time a declaration is submitted            The movement reference number for importing or exporting goods. The number generated is bespoke, allowing your goods to be uniquely linked to you. As such, it forms an important part of the audit process for your declarations.'),
authority_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1 of the customs auhtority.'),
importer_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the importer.'),
importer_declarant_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the importer who makes the declaration.'),
broker_declarant_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the broker who makes the declaration..'),
customs_declaration_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs declaration type.'),
export_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1 where the goods leave the EU.'),
cds_acceptance_dt DATE NOT NULL
OPTIONS(description='This is the date when the goods have arrived at the import location.'),
cds_acceptance_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - This is the date and time when the goods have arrived at the import location.'),
cds_clearance_dt DATE NOT NULL
OPTIONS(description='This is only the date part of the clearance date and time (see also CDS_CLEARANCE_TMSP).'),
cds_clearance_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - The CDS clearance date is  the clearance date of the supplementary declaration when HRMC considers the declaration finalised and all duties and taxes are accounted for.'),
acceptance_tmsp TIMESTAMP
OPTIONS(description='The Acceptance is the date and time of the frontier declarations clearance.'),
trader_reference STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - This is a reference assigned by the declarant for the goods covered by the declaration.'),
consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
consignor_name STRING(100)
OPTIONS(description='Descriptive Attribute - Textual data  of the consignor\'s name.It is the name stored in the broker system.'),
first_deferment STRING(250)
OPTIONS(description='Descriptive Attribute - The first Deferment Approval Number to identify the deferment account_1 to  which revenue is to be debited.'),
goods_location STRING(250)
OPTIONS(description='Descriptive Attribute - The location_1 where the goods are held at the time of making the declaration.'),
trade_terms STRING(250)
OPTIONS(description='Descriptive Attribute - International Commercial Term;It defines the responsibilities of exporters and importers in the arrangement of shipments and the transfer of liability involved at various stages of the transaction.'),
trade_terms_location STRING(250)
OPTIONS(description='Descriptive Attribute - Location_1 of port where the terms apply to.'),
declaration_ucr STRING(250)
OPTIONS(description='Descriptive Attribute - This is a unique consignment reference for the goods covered by the declaration. The reference can be used to identify the entry for amendment or cancellation and is used for inventory linking. On a declaration the UCR may be a reference allocated by a forwarder or one chosen by the declarant, possibly allocated by the exporter, seller, buyer or importer.'),
total_packages_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - Total count of all packages of a declaration.'),
excise_payment_amount_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - It is the excise payment amount for the whole shipment.'),
value_for_duty_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total value of the shipment for purposes of Duty. When we say one shipment,the MRN will differ between the SFD and the SDI as they are essentially two separate entries in the system, but the trader ref should be the same for both'),
duty_payment_amount_val BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The duty for the whole shipment.'),
duty_tax_assessed_amount_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The assessed duty for the whole shipment. Normally this should be the same as the duty payment amount.'),
value_for_vat_val BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The total value of the whole Shipement.'),
vat_payment_amount_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The broker report contains information of a bunch of customs declarations. The broker report is based on a report from an importer (BEI report from LexI or WWT report from OWIM or Lidl Foundation) and contains informationen that are ideally identical to the report from the customs authority.'),
vat_tax_assessed_amount_val BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive -  It means how much VAT should be paid for the whole shipment.'),
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
OPTIONS(description='Entity - Transactional Events - Snapshot_1 - The broker report contains information of a bunch of customs declarations. The broker report is based on a report from an importer (BEI report from LexI or WWT report from OWIM or Lidl Foundation) and contains informationen that are ideally identical to the report from the customs authority. - Source - Excel-Report from Broker (per Mail)');