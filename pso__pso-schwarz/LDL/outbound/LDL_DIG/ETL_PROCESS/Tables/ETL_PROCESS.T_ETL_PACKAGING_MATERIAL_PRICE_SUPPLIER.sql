CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_packaging_material_price_supplier (
condition_number_cd STRING(20) OPTIONS(description='The code for the condition number'),
purch_org_type_cd STRING(8) NOT NULL OPTIONS(description='The code for the purchase organization type'),
supplier_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for supplier'),
pack_material_nr STRING(20) NOT NULL OPTIONS(description='The packaging material number (e..g 420000026,  420000028)'),
price_type_cd STRING(20) NOT NULL
OPTIONS(description='Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc'),
price_group_cd STRING(20) OPTIONS(description='Code of pricing group - internal or customer facing'),
active_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The first date from when this record became valid from a business perspective,'),
active_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The last date up to when this record was valid from a business perspective,'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (purch_org_type_cd, supplier_sid, pack_material_nr, price_type_cd, active_from_tmsp) NOT ENFORCED
)
OPTIONS(description='ETL Support table -  fact for prices on supplier level (Purchase price, Additional freight costs, etc)');