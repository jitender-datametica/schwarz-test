/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUPPLIER_ORDER_HEADER_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 15. Dezember 2022 11:34:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_supplier_order_header_2 (
supplier_order_nr STRING(20) NOT NULL OPTIONS(description='Supplier_2 Order Number present in the Purchase Order'),
supplier_order_type_cd STRING(5) OPTIONS(description='The unique code for the purchase order document  '),
supplier_order_dt DATE
OPTIONS(description='The order date of the purchase document. It can be different from the creation date in SAP.'),
supplier_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for supplier_2 account_2 number present in the purchaseorder'),
supplier_nr STRING(20) OPTIONS(description='Account_2 number of supplier_2/vendor from the sorce system'),
curr_cd STRING(5) OPTIONS(description='Currency code'),
tax_country_cd STRING(5)
OPTIONS(description='The unique code for a country_2 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (supplier_order_nr) NOT ENFORCED
) OPTIONS(description='The ETL support table for supplier_2 order header detail');