CREATE OR REPLACE TABLE szd_production_core.t_fact_customs_clearance_report_line_per_day_2 (
clearance_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
authority_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country_2 of the customs authority.'),
consignor_party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
declarant_party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the declarant.'),
import_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the transhipment location.'),
customs_declaration_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the type of the customs declaration'),
dispatch_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_2 that dispatched the good.'),
transport_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country_2 that has made the transport of the goods.'),
origin_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country_2 where the product comes from.'),
customs_product_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the customs product.'),
customs_preference_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs procedure code.'),
agreement_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the free trade agreement.'),
curr_cd STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='The currency code for the duty paid amount.'),
product_cnt INTEGER NOT NULL OPTIONS(description='Fact - additive - The count of distinct products.'),
duty_paid_val NUMERIC(29,5) NOT NULL OPTIONS(description='Fact - additive - The amount of duty that was paid.'),
net_weight_meas NUMERIC(29,5) NOT NULL OPTIONS(description='Fact - additive - The net weight measure of the item.'),
customs_val NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The total value of the item_2 for the purposes of customs duty. In addition to the actual price of the goods this includes additional elements such as Freight Charges to the EU boundary. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the fully qualified names of the source tables from the relational model.'),
PRIMARY KEY (clearance_dt, authority_country_location_sid, origin_country_location_sid, customs_product_sid,
 import_location_sid, customs_declaration_type_cd, dispatch_country_location_sid, transport_country_location_sid,
 consignor_party_sid, declarant_party_sid, customs_preference_cd, agreement_sid) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by day & authority country_2 & consignor stream & origin country_2 - Aggregate - Containts item_2 related facts from the item_2 report from the customs authority. - Source - CDS Header Report, CDS Item_2 Report');