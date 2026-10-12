--==============================================================
-- Table: t_dim_supplier_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_supplier_2
   generated from Powerdesigner on Donnerstag, 8. August 2024 10:57:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_supplier_2 (
supplier_sid BIGNUMERIC NOT NULL OPTIONS(description='Unique identifier for the supplier_2'),
supplier_nr STRING(20) OPTIONS(description='The number which identifies the supplier_2 in '),
supplier_name STRING(100) OPTIONS(description='The name of the supplier_2'),
supplier_short_name STRING(100) OPTIONS(description='The short name of the supplier_2 (Cago: Kurzbezeichnung).'),
supplier_abbr_name STRING(100) OPTIONS(description='The abbreviated supplier_2 name'),
int_negot_fg BOOL
OPTIONS(description='An indicator showing whether the company is internationally negotiated or country_2 specific.'),
vat_nr STRING(20) OPTIONS(description='The vat number (Umsatzsteuer ID). '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (supplier_sid) NOT ENFORCED
)
OPTIONS(description='A company which delivers products to Lidl. The supplier_2 is not necessarily identical with the manufacturer.              It could also be a wholesaler who also sources the products from somewhere. Lidl dictates to the supplier_2 which items he needs');