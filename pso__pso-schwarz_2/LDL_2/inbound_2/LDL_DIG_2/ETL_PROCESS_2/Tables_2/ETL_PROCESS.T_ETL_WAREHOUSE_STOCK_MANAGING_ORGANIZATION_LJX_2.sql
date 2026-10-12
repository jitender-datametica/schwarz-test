/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_STOCK_MANAGING_ORGANIZATION_LJX_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 28. August 2024 07:43:55
*/ --------------------------------------------------------------------------------


CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_STOCK_MANAGING_ORGANIZATION_LJX_2 (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) of  warehouse',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   STOCK_MANAGING_ORG_CD               VARCHAR(32)      NOT NULL COMMENT 'This is the code of the stock managing organization which is in charge of moving stock within the warehouse, sending it to customers or disposing it. 
            This code is introduced because there is a SAP functionality which allows multiple parties (organizations) to use the same warehouse for storing their stock. 
            Warehouses, used by Lidl E-Commerce (LEC) will always have the value LEC populated in this field as they are used solely by LEC.',
   WH_CD                               VARCHAR(5)      COMMENT 'Warehouse code',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   GENERAL_STOCK_PLACEMENT_CD          VARCHAR(10)     COMMENT 'The code of the area in the warehouse where the stock is stored. 
            The stock items wlll be found in the area specified in this column, unless we have a non-null value in column "specific_stock_placement_cd".',
   SPECIFIC_STOCK_PLACEMENT_CD         VARCHAR(10)     COMMENT 'If the value in this column is not null, this is the code of the storage area where the stock items will be found. 
            If the value of the column is null, then the items will be found in the area specified in column "general_stock_placement_cd"',
   STOCK_REMOVAL_CD                    VARCHAR(10)     COMMENT 'The code for stock removal',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_STOCK_MANAGING_ORGANIZATION_L8V PRIMARY KEY (WH_SID, PROD_VARIANT_SID, STOCK_MANAGING_ORG_CD) NOT ENFORCED 
)  COMMENT = 'An etl table that shows data for Stock (Product Variant), Warehouse and Organization that can manage the stock in the warehouse (move it, send it to customers or dispose it)
             
             The source is /SAPAPO/MATLWH from LJX  sap instance';