/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_STOCK_MANAGING_ORGANIZATION
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:51:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_warehouse_stock_managing_organization (
stock_managing_org_cd STRING(32) NOT NULL
OPTIONS(description='This is the code of the stock managing organization which is in charge of moving stock within the warehouse, sending it to customers or disposing it.             This code is introduced because there is a SAP functionality which allows multiple parties (organizations) to use the same warehouse for storing their stock.             Warehouses, used by Lidl E-Commerce (LEC) will always have the value LEC populated in this field as they are used solely by LEC.'),
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
general_stock_placement_cd STRING(10)
OPTIONS(description='The code of the area in the warehouse where the stock is stored.             The stock items wlll be found in the area specified in this column, unless we have a non-null value in column "specific_stock_placement_cd".'),
specific_stock_placement_cd STRING(10)
OPTIONS(description='If the value in this column is not null, this is the code of the storage area where the stock items will be found.             If the value of the column is null, then the items will be found in the area specified in column "general_stock_placement_cd"'),
stock_removal_cd STRING(10) OPTIONS(description='The code for stock removal'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, prod_variant_sid, stock_managing_org_cd) NOT ENFORCED
)
OPTIONS(description='This dimensional table contains data about organizations that are in charge of managing the stock within the warehouse (they decide whether to move it, send it to customers or dispose it)');