CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_packaging_material_price_supplier (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
supplier_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for supplier'),
pack_material_nr STRING(20) NOT NULL OPTIONS(description='The packaging material number (e..g 420000026,  420000028)'),
price_type_cd STRING(20) NOT NULL
OPTIONS(description='Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc'),
price_group_cd STRING(20) OPTIONS(description='Code of pricing group - internal or customer facing'),
active_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The first date from when this record became valid from a business perspective,'),
active_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The last date up to when this record was valid from a business perspective,'),
curr_cd STRING(5) OPTIONS(description='Currency in which price is set'),
price_val BIGNUMERIC(38,5) OPTIONS(description='Valid price in given currency'),
prod_qty BIGNUMERIC(38,0)
OPTIONS(description='Quantity of products defined in the pricing condition ( fe price is defined per 1000 boxes or 100 boxes in other cases)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
supplier_nr STRING(20) OPTIONS(description='Account number of supplier/vendor from the sorce system'),
PRIMARY KEY (wshop_cd, supplier_sid, pack_material_nr, price_type_cd, active_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A fact for packaging material prices on supplier level (Purchase price, Additional freight costs, etc)');