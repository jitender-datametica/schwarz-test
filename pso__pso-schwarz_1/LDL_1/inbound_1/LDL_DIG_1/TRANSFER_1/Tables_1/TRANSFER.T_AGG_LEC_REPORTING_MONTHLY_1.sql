CREATE TABLE TRANSFER.T_AGG_LEC_REPORTING_MONTHLY_1 (
	BUS_YEAR 				        NUMBER(38,0)       NOT NULL    COMMENT 'The business year (starting in March, ending in February of the following calendar_1 year)',
	MONTH_OF_BUS_YEAR 	        	NUMBER(38,0)       NOT NULL    COMMENT 'The month of business year, indicated by a number (1 = March, 2 = April, ... 12 = February)',
	WSHOP_CD 				        VARCHAR(5)         NOT NULL    COMMENT 'The unique code for the Lidl webshop',
	GMV_GROSS_EUR_VAL 	        	NUMBER(38,5)                   COMMENT 'Gross Margin Value = gross revenue (including shipping fees and additional services) before cancellations and returns',
    SALES_REVENUE_GROSS_EUR_VAL   	NUMBER(38,5)                   COMMENT 'Gross Sales_1 Revenue before cancellations and before returns',
    ORDER_CNT                     	NUMBER(38,5)                   COMMENT 'Number of unique sale orders',
	AVG_BASKET_GROSS_EUR_VAL		NUMBER(38,5)				   COMMENT 'Average order basket gross euro value, before cancellations and before returns',
	CUST_CNT						NUMBER(38,5)			   	   COMMENT 'Number of unique customers who ordered on the online shop during the period',
	GMV_PER_CUSTOMER_GROSS_EUR_VAL  NUMBER(38,5)				   COMMENT 'The Gross Margin Value generated per unique customer during the period',
	TOTAL_ACTIVE_CUST_CNT			NUMBER(38,5)			   	   COMMENT 'Number of active customers: unique customers who ordered on the online shop in the past 12 months',
	DWH_CREATED_TMSP 		        TIMESTAMP_LTZ(9)   NOT NULL    COMMENT 'The point in time when this record was created in the data warehouse',
	DWH_UPDATED_TMSP 		        TIMESTAMP_LTZ(9)   NOT NULL    COMMENT 'The point in time when this record was last updated',
	DWH_SRC_FILE_NAME 	        	VARCHAR(255)       NOT NULL    COMMENT 'The path and the name of the file(s) from which this record was loaded',
	CONSTRAINT PK_T_AGG_LEC_REPORTING_MONTHLY PRIMARY KEY ( BUS_YEAR, MONTH_OF_BUS_YEAR, WSHOP_CD )
) COMMENT = 'This table is used for the monthly reporting of aggregated sales_1 KPIs (before cancellations and before returns) from LEC business operations'
;