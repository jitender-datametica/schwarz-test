CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_supplier_1 (
supplier_sid BIGNUMERIC NOT NULL OPTIONS(description='Unique identifier for the supplier_1'),
supplier_nr STRING(20) OPTIONS(description='The number which identifies the supplier_1 in '),
supplier_name STRING(100) OPTIONS(description='The name of the supplier_1'),
supplier_short_name STRING(100) OPTIONS(description='The short name of the supplier_1 (Cago: Kurzbezeichnung).'),
supplier_abbr_name STRING(100) OPTIONS(description='The abbreviated supplier_1 name'),
int_negot_fg BOOL
OPTIONS(description='An indicator showing whether the company is internationally negotiated or country_1 specific.'),
vat_nr STRING(20) OPTIONS(description='The vat number (Umsatzsteuer ID). '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (supplier_sid) NOT ENFORCED
)
OPTIONS(description='A company which delivers products to Lidl. The supplier_1 is not necessarily identical with the manufacturer.              It could also be a wholesaler who also sources the products from somewhere. Lidl dictates to the supplier_1 which items he needs');