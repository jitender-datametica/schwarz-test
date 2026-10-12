CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_purchase_organisation_type_1 (
prod_purch_org_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the country_1 / Lidl organization which is responsible for the purchasing (negotiation).'),
prod_purch_org_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for  the country_1 / Lidl organization which is responsible for the purchasing in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_purch_org_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the country_1 / Lidl organization which is responsible for the purchasing (negotiation). For NF it is normally “LDI” (former purchasing in LDI) and “INTEGER ” (Stiftung).');