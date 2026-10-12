/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for F_DELIVERY_WH_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table Delivery to WH
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-25 Mike Davis      Checks, formatting, FK support (now removed)
#  1.2  2021-10-11 Massimo Morelli eliminate the fields ITEM_STOCK_REAL_QTY and ITEM_DELIVERY_TO_STORE_QTY
#                                  which are not in the specification document
#  1.3  2022-01-24 Andreas Kurz	   Reworked the structure after DM review
#  1.4  2023-02-09 Massimo Morelli eliminate the fields ITEM_RCV_QTY and ITEM_BUYING_PRICE_EFF
#  1.5  2023-03-25 Massimo Morelli Added the 5 fields requested today
#  1.6  2023-04-01 Massimo Morelli Added country price and flag
#  1.7  2023-04-15 Massimo Morelli Added 7 Auditing flags
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_PIT.T_F_DELIVERY_WH_ITEM CLUSTER BY (CLIENT_ID, DAY_DT)(
	CLIENT_ID						INTEGER				NOT NULL	DEFAULT -1										COMMENT 'Client ID e.g AT=1',
	COUNTRY_ISO_CD					VARCHAR(3) 																		COMMENT 'Country ISO Code = WAWI Country',
	COUNTRY_DESCR					VARCHAR 																		COMMENT 'Country Name',
	DAY_DT							DATE				NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Day of Sales',
	STORE_SID						INTEGER				NOT NULL	DEFAULT -1 										COMMENT 'Unique key Region surrogate key',
	ITEM_SID						INTEGER				NOT NULL	DEFAULT -1 										COMMENT 'Item Variant (Case Size)',
	ORIG_ITEM_NR					INTEGER		 																	COMMENT 'Item NaN (National Artikel Nummer) Link to Item History',
	ACTION_TYPE_ID					INTEGER		 																	COMMENT 'Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.',
	ITEM_FA_FG						SMALLINT			NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling Item is FA Food Action',
	ITEM_NF_FG						SMALLINT			NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling that item NF None-Food',
	ITEM_PV_FG						SMALLINT			NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling item is PV (Preisveränderung) ',
	ITEM_NP_FG						SMALLINT			NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling item Normalsortiment (NP Normalpreis) ',
	ORIG_STORE_NR					INTEGER		 																	COMMENT 'Original Store Number / code from Wawi',
	STORE_NAME						VARCHAR 																		COMMENT 'Store Name',
	WAREHOUSE_SID					INTEGER		 																	COMMENT 'Warehouse Surrogate ID  L2',
	WAREHOUSE_NAME					VARCHAR 																		COMMENT 'Warehouse Name',
	ORIG_WH_NR						INTEGER		 																	COMMENT 'Original Wahrehouse Number  / code from Wawi',
	
	-- AKU 2022-01-27 Note only national currency's of the countries are used
	CURR_SID						INTEGER				NOT NULL	DEFAULT -1 										COMMENT '[FK] Unique Currency SID based Local Currency of Lidl Country',
	CURR_CD							VARCHAR 																		COMMENT 'Currency Code',
	
	-- AKU 2022-01-25 join criteria for t_cntl_buying_price_range
	SUB_ITEM_GRP_SRC_CD				VARCHAR 																		COMMENT 'Item sub group Wawi Source Code',
	ITEM_GRP_INT_SRC_CD				VARCHAR 																		COMMENT 'Code for international group from source system.',
	
	-- MM 2022-02-09 only buying price now
	ITEM_BUYING_PRICE				NUMBER(38,5)		NOT NULL	DEFAULT 0 										COMMENT 'Einkaufspreis (EK) Buying Price - Debugging Purpose only',
		
	-- AKU 20220401: When there is no EK-Price or the EK-Price == 0.00 for this WH then we take the country (ctry) level EK-Price for this WH
	-- We flag this accourdingly 
	ITEM_BUYING_PRICE_CALC_FG		SMALLINT						DEFAULT 0 										COMMENT 'Flag indicates is warehouse price was 0 and has been calculated from country price',
	
	-- MM 2022-03-25 requested in the daily 
	LAST_WH_RCV_DAY_DT				DATE 																			COMMENT 'Date of the last warhouse row considered in the calculation of the price',
	ITEM_RCV_QTY					NUMBER(38,5)		NOT NULL	DEFAULT 0 										COMMENT 'Quantity used for the calculation of the price',
	ITEM_RCV_BUYING_VALUE			NUMBER(38,5)		NOT NULL	DEFAULT 0 										COMMENT 'Value used for the calculation of the price',
	INRANGE_FG						SMALLINT			NOT NULL	DEFAULT -1 										COMMENT 'Flag: 1 -> (deliveries) In range, 0 -> (deliveries) out of range, -1 no range or no deliveries at all',
	BUY_PRICE_RANGE_DAYS			INTEGER				NOT NULL	DEFAULT -1 										COMMENT 'Range (in days) we look into the past to find the deliveries used to calculate the price',

	-- AKU 20220401: Country Level KPIs, this wil be always calculated
	-- We use the InRange Values (INRANGE_FG == 1)
	-- if still no price, we usa also the out of range 
	CTRY_ITEM_BUYING_PRICE			NUMBER(38,5)		NOT NULL	DEFAULT 0 										COMMENT 'Buying price (per item) at the level of the country',
	
	-- MaMo 20220415 Add auditing flags to check the algorithm. If a row is touched in a step, the flag is activated
	AUD_01_WH_IN_RANGE_FG			SMALLINT						DEFAULT 0 										COMMENT 'Auditing Flag step 01: row touched in getting in_range wh prices',
	AUD_02_WH_OUT_RANGE_FG			SMALLINT						DEFAULT 0 										COMMENT 'Auditing Flag step 02: row touched in getting out_of range wh prices',
	AUD_03_CLI_IN_RANGE_FG			SMALLINT						DEFAULT 0 										COMMENT 'Auditing Flag step 03: row touched in getting in_range client prices',
	AUD_04_CLI_OUT_RANGE_FG			SMALLINT						DEFAULT 0 										COMMENT 'Auditing Flag step 04: row touched in getting out_of range client prices',
	AUD_05_MDN_WH_TO_CLI_FG			SMALLINT						DEFAULT 0 										COMMENT 'Auditing Flag step 05: row touched in getting median wh prices to client prices where qty cancels out at client level',
	AUD_06_0_CLIENT_TO_WH_FG		SMALLINT						DEFAULT 0 										COMMENT 'Auditing Flag step 06: row touched in getting the missing wh prices equal to client prices',
	AUD_07_MISS_CLI_TO_WH_FG		SMALLINT						DEFAULT 0 										COMMENT 'Auditing Flag step 07: row touched in getting the missing wh/item ombination equal to client prices',
					
	-- Technical fields  				
	REJECT_REASON_ID				INTEGER				NOT NULL	DEFAULT -1 										COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG						SMALLINT			NOT NULL	DEFAULT 0 										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID				INTEGER				NOT NULL	DEFAULT 0 										COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG						SMALLINT			NOT NULL	DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS					TIMESTAMP		 	NOT NULL	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS					TIMESTAMP		 																COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID							INTEGER		 		NOT NULL	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, DELETED_FG)
)	COMMENT='Intermediate Fact Table on WH Delivery (buying price)'
;