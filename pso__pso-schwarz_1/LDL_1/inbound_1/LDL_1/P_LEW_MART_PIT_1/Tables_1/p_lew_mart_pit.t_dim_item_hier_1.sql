/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ITEM_HIER
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Flattened daily sliced item_1 hierarchy_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#   1.0  2021-07-01 Andreas Kurz     Initial version
#   1.1  2021-07-15 Andreas Kurz     Added further columns and conduct some changes on the VC
#                                    Columns
#   1.2  2021-07-16 Andreas Kurz     Added Column SRC_DAT_VALID_FROM part of the logical business key of an item_1
#                                    to identify item_1 variants
#   1.3  2021-07-19 Andreas Kurz     Changed Column SRC_DAT_VALID_FROM to NUllable
#                                    Added missing SOURCE_SYSTEM_ID
#   1.4  2021-08-23 Mike Davis       Checks, formatting, FK support (now removed)
#   1.5  2021-10-12 Mike Davis       Added ::DATETIME to CURRENT_TIMESTAMP()
#                                    Simple PRIMARY KEY (not as constraint statement)
#   1.6  2021-10-14 Mike Davis       Swap order of buying_list_type and brand_1 data
#   1.7  2021-10-18 Mike Davis       Clarify deliveries_fg and receivings_fg
#   1.8  2022-01-24 Andreas Kurz     Reworked the structure after DM review
#   1.9  2022-02-09 Andreas Kurz     Adding MAINITEM_FG
#   1.10 2022-02-09 Andreas Kurz     DAY_ID --> DAY_DT in cluster
#                                    move MAINITEM_FG so after item_name
#   1.11 2022-07-06 Mike Davis       Add ITEM_ADV_PERIOD_FG and ITEM_STOCK_FG
#   1.12 2022-07-08 Mike Davis       Add ITEM_WA_VARIANTS_FG and changed meanings in some COMMENTs
#   1.13 2022-07-11 Mike Davis       Change	DEFAULTs and virtuals and tidy up.
#   2.00 2022-07-13 Nikolai Toknov   Changing the script for DevOps
#	2.01 2024-02-01 Andreas Kurz	 Enhance View WGI by additionbal condition used in WaWi-PV Detection
#									   	PV_UWG_GROUP_FG
#										SORTIMENT_ARTICLE_FG
#   2.02 2024-02-08 Andreas Kurz	 Adding EAN_1 and EAN_DESCR as List of EAN_1, and List of EANs , csv
#   2.03 2024-03-19 Andreas Kurz	 Changed based on VC Task and adding a further column WAWI_PV_TYPE_ID
#   2.04 2024-03-22 Andreas Kurz 	 Changed VC ITEM_FA_FG will be updated by load_dim_item_hier and also by 
#										load_t_f_receipt_item
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
ORIG_ITEM_MSTR_NR
SUB_ITEM_GRP_MSTR_SID
ITEM_GRP_INT_MSTR_SID
ITEM_FA_FG			
ITEM_NF_FG				
ITEM_PV_FG				
ITEM_NP_FG
ITEM_SID_LST_NR
ITEM_SID_LST_DESCR
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_2XL;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_1;

ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	ITEM_PV_PD_FG				SMALLINT		NOT NULL	DEFAULT 0												COMMENT 'Item_1 is Promotion Designer PV';	
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	ITEM_PV_LP_FG				SMALLINT		NOT NULL	DEFAULT 0												COMMENT 'Item_1 is Lidl Plus PV';	
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	ITEM_PV_WAWI_FG				SMALLINT		NOT NULL	DEFAULT 0												COMMENT 'Item_1 is WaWi PV';	

ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD PV_UWG_GROUP_FG SMALLINT		NOT NULL	DEFAULT 0 COMMENT 'Flag / indicator: item_1 is in special UWG Group relevant for PV';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD SORTIMENT_ARTICLE_FG SMALLINT		NOT NULL	DEFAULT 0 COMMENT 'Flag which indicates that ITEM_SID regular sortiment article BUYINGLIST_TYPE != (7,8)';

ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_LST				ARRAY					COMMENT 'Array of EAN_1 Barcode'; 
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_LST_NR			INTEGER					COMMENT 'Size of Array Elements - Array of EAN_1 Barcode';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_LST_DESCR		VARCHAR					COMMENT 'String representation of Array of EAN_1 Barcode with comma separator';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_ITEM_LST		ARRAY					COMMENT 'Array EAN_1 Description (local Language)';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_ITEM_LST_NR		INTEGER					COMMENT 'Size of Array Elements - Array of EAN_1 Description (local Language)';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_ITEM_LST_DESCR	VARCHAR					COMMENT 'String representation of Array of EAN_1 Description (local Language) with comma separator';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ORIG_ITEM_MSTR_NR;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP SUB_ITEM_GRP_MSTR_SID;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ITEM_GRP_INT_MSTR_SID;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD WAWI_PV_TYPE_ID				SMALLINT		NOT NULL	DEFAULT -1 												COMMENT 'In case SFO (PV) then adding the WaWi-PV Resason. Default -1, 3<Preisgebietsdifferenz>, 2<Bestands PV>,1<Abverkaufsbasierte PV aus LP/PD_1 (NPPS)>';

ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	ITEM_PCHANGE_FG				SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag / indicator: item_1 is available at Price Change Table';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	ITEM_PRICE_FG				SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag / indicator: item_1 is available at WAWI Price Table';

ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ITEM_FA_FG;					
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ITEM_NF_FG;					
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ITEM_PV_FG;					
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ITEM_NP_FG;		

ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	NBR_OF_STORES_ITEM_SOLD		NUMBER(38,0)	DEFAULT 0															COMMENT 'Nbr. of Stores where this item_1 was sold. Needed for PV Caclulation';

ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD		ITEM_FA_FG					SMALLINT	 	DEFAULT 0															COMMENT 'Flag / indicator: item_1 is FA Food Action. iff(ACTION_TYPE_ID=3,1::SMALLINT,0::SMALLINT)';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD		ITEM_NF_FG					SMALLINT	 	DEFAULT 0															COMMENT 'Flag / indicator: item_1 is NF None-Food. iff(ACTION_TYPE_ID=2,1::SMALLINT,0::SMALLINT)';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD		ITEM_PV_FG					SMALLINT	 	DEFAULT 0															COMMENT 'Flag / indicator: item_1 is PV. iff(ACTION_TYPE_ID=1,1::SMALLINT,0::SMALLINT)';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD		ITEM_NP_FG					SMALLINT	 	DEFAULT 0															COMMENT 'Flag / indicator: item_1 is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::SMALLINT,0::SMALLINT)';
			
UPDATE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 trg
SET    
	  -- AKU 2024-03-21 VC 
	  trg.ITEM_FA_FG			= IFF((trg.ACTION_TYPE_ID) = 3, 1, 		0)::SMALLINT 
	, trg.ITEM_NF_FG			= IFF((trg.ACTION_TYPE_ID) = 2, 1, 		0)::SMALLINT 
	, trg.ITEM_PV_FG			= IFF((trg.ACTION_TYPE_ID) = 1, 1, 		0)::SMALLINT 
	, trg.ITEM_NP_FG			= IFF((trg.ACTION_TYPE_ID) = -1, 1, 	0)::SMALLINT
WHERE TRUE
	
	AND trg.DELETED_FG	= 0::SMALLINT
	AND trg.REJECT_FG	= 0::SMALLINT				
;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	REAL_ACTION_TYPE_ID			INTEGER			NOT NULL	DEFAULT -1												COMMENT '[Real] Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	REAL_PROMOTION_FA_FG		SMALLINT	 	DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is FA Food Action. iff(ACTION_TYPE_ID=3,1::SMALLINT,0::SMALLINT)';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	REAL_PROMOTION_NF_FG		SMALLINT	 	DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is NF None-Food. iff(ACTION_TYPE_ID=2,1::SMALLINT,0::SMALLINT)';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	REAL_PROMOTION_PV_FG		SMALLINT	 	DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is PV. iff(ACTION_TYPE_ID=1,1::SMALLINT,0::SMALLINT)';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	REAL_NP_FG					SMALLINT	 	DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::SMALLINT,0::SMALLINT)';
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD		ITEM_LP_FG					SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag / indicator: item_1 is available at LP Reference Table';

ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_WAWI_FG TO SRC_ITEM_WAWI_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_ADP_FG TO SRC_ITEM_ADP_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_ADV_PERIOD_FG TO SRC_ITEM_ADV_PERIOD_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_WA_VARIANTS_FG TO SRC_ITEM_WA_VARIANTS_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_WA_EXTENDED_FG TO SRC_ITEM_WA_EXTENDED_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_DELIVERIES_FG TO SRC_ITEM_DELIVERIES_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_STOCK_FG TO SRC_ITEM_STOCK_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_DELIVERIES_STOCK_FG TO SRC_ITEM_DELIVERIES_STOCK_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_RECEIVINGS_FG TO SRC_ITEM_RECEIVINGS_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_EJR_FG TO SRC_ITEM_EJR_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_PCHANGE_FG TO SRC_ITEM_PCHANGE_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_PRICE_FG TO SRC_ITEM_PRICE_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_LP_FG TO SRC_ITEM_LP_FG;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_PV_SFO_FG TO SRC_ITEM_PV_SFO_FG;
	
*/

CREATE TABLE P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 CLUSTER BY (CLIENT_ID, DAY_DT)(
	DAY_DT						DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'Calendar_1 Day of the daily sliced flattened item_1 hierarchy_1',

	CLIENT_ID					INTEGER			NOT NULL	DEFAULT -1												COMMENT 'Client ID e.g. 1::=AT',
	COUNTRY_ISO_CD				VARCHAR(3) 																			COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR				VARCHAR 																			COMMENT 'Country_1 Name',

	ITEM_SID					INTEGER			NOT NULL	DEFAULT -1000											COMMENT 'Unique system ID, sid, for the item_1 variant that is active (may include main item_1 sids also).',
	ITEM_FAM_GRP_SID			INTEGER			NOT NULL	DEFAULT -1000											COMMENT 'Sid for item_1 family group.',
	SUB_ITEM_GRP_SID			INTEGER			NOT NULL	DEFAULT -1000											COMMENT 'Sid for item_1 sub group. (UWG)',
	ITEM_GRP_INT_SID			INTEGER			NOT NULL	DEFAULT -1000											COMMENT 'Sid for item_1 international group. (WGI)',

	BRAND_SID					INTEGER			NOT NULL	DEFAULT -1												COMMENT 'Sid for brand_1 of item.',

	ORIG_ITEM_NR				INTEGER			NOT NULL	DEFAULT -1000											COMMENT 'Item_1 business identifier. NaN := National Article NUMBER. CORE_AC.v_item_1: TRYCAST(Coalesce(itm.src_orig_item_nr, itm.config_item_cd, itm.src_matnr) AS DECIMAL(18,0))',
		
	--AKU 2024-03-19 will be moved to AGG-Framework
	--ORIG_ITEM_MSTR_NR			INTEGER		 AS (
	--											IFF(ORIG_ITEM_NR < 0, 
	--												(ORIG_ITEM_NR * 100) - CLIENT_ID,
	--												(ORIG_ITEM_NR * 100) + CLIENT_ID
	--												)
	--											) 																	COMMENT '[VC] Special MSTR Join criteria to have surrogate ORIG_ITEM_NR + CLIENT_ID',
	-- AKU 20210716 Added new column
	SRC_DAT_VALID_FROM			DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'Original Item_1 Source DATE from.',
	CASE_SIZE					NUMBER(38,5) 																		COMMENT 'Business variant information.',

	ITEM_NAME					VARCHAR 																			COMMENT '(short) item_1 name in local LANGUAGE',
	ITEM_DESCR					VARCHAR 																			COMMENT '(long) item_1 description in local LANGUAGE',
	ITEM_INT_DESCR				VARCHAR 																			COMMENT '(long) item_1 description in international LANGUAGE of centre (Deutsch)',
	ITEM_FAM_GRP_SRC_ID			INTEGER		 																		COMMENT 'ID for family group from source system.',

	-- Business key																
	ITEM_FAM_GRP_SRC_CD			VARCHAR 																			COMMENT 'Wawi Code for Article family group',
	ITEM_FAM_GRP_NAME			VARCHAR 																			COMMENT 'Family group name.',
	ITEM_FAM_GRP_DESCR			VARCHAR 																			COMMENT 'Family group description (local).',
	ITEM_FAM_GRP_INT_DESCR		VARCHAR 																			COMMENT 'Family group description (international).',

	SUB_ITEM_GRP_NAME			VARCHAR 																			COMMENT 'Item_1 sub group name. UWG',
	SUB_ITEM_GRP_SRC_CD			VARCHAR 																			COMMENT 'Item_1 sub group Wawi Source Code. Business Key',
	SUB_ITEM_GRP_DESCR			VARCHAR 																			COMMENT 'Item_1 sub group description (local).',
	SUB_ITEM_GRP_INT_DESCR		VARCHAR 																			COMMENT 'Item_1 sub group description (international).',
	-- AKU 2024-02-01 Enhance View WGI by additionbal condition used in WaWi-PV Detection
	PV_UWG_GROUP_FG				SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag / indicator: item_1 is in special UWG Group relevant for PV',
	

	ITEM_GRP_INT_SRC_CD			VARCHAR 																			COMMENT 'Code for international group from source system.',
	ITEM_GRP_INT_NAME			VARCHAR 																			COMMENT 'International group name.',
	ITEM_GRP_INT_DESCR			VARCHAR 																			COMMENT 'International group description (local).',
	ITEM_GRP_INT_INT_DESCR		VARCHAR 																			COMMENT 'International group description (international).',

	BUYING_LIST_TYPE_ID			INTEGER			NOT NULL	DEFAULT -1												COMMENT 'ID for buying list type. Only on Country_1 Level – no regionalization.',
	BUYING_LIST_TYPE_DESCR		VARCHAR 																			COMMENT 'Buying list type description (local).',
	BUYING_LIST_TYPE_INT_DESCR	VARCHAR 																			COMMENT 'Buying list type description (international).',

	-- AKU 2024-02-01 
	SORTIMENT_ARTICLE_FG		SMALLINT		NOT NULL	DEFAULT -1												COMMENT 'Flag which indicates that ITEM_SID regular sortiment article BUYINGLIST_TYPE != (7,8)',
	
	BRAND_NAME					VARCHAR 																			COMMENT 'Brand_1 name.',
	BRAND_TYPE_CD				VARCHAR 																			COMMENT 'Brand_1 type.',

	ITEM_ACTION_TYPE_ID			INTEGER			NOT NULL	DEFAULT -1											COMMENT 'Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.',

	 -- AKU 20220209 Added FG to identify mainitem --> from Source View
	MAINITEM_FG					SMALLINT		NOT NULL	DEFAULT -1												COMMENT 'Flag which indicates that ITEM_SID is a MainItem, which is driving the ORIG_ITEM_NR',

	-- AKU 20220209 added BuyingPrice Range
	BUY_PRICE_RANGE_DAYS		INTEGER			NOT NULL	DEFAULT -1												COMMENT 'Buying Price Range in days – defined by controlling',
	ITEM_SID_LST				ARRAY 																				COMMENT 'Array of ItemSids (Variants) which are grouped together bei NAN',
--	ITEM_SID_LST_NR				INTEGER		 AS (
--												ARRAY_SIZE(ITEM_SID_LST)
--												)													 				COMMENT 'Size of Array Elements - Array of ItemSids',
-- ITEM_SID_LST_DESCR			VARCHAR AS (
--											ARRAY_TO_STRING(ITEM_SID_LST, ',')
--											) 																		COMMENT 'String representation of Array of ItemSids with comma separator',
	-- AKU 20210715 Adding some VC on Action Type ID
	-- AKU 20240322 Changed VC Columns
	ITEM_FA_FG					SMALLINT	 	DEFAULT 0															COMMENT 'Flag / indicator: item_1 is FA Food Action. iff(ACTION_TYPE_ID=3,1::SMALLINT,0::SMALLINT)',
	ITEM_NF_FG					SMALLINT	 	DEFAULT 0															COMMENT 'Flag / indicator: item_1 is NF None-Food. iff(ACTION_TYPE_ID=2,1::SMALLINT,0::SMALLINT)',
	ITEM_NP_FG					SMALLINT	 	DEFAULT 0															COMMENT 'Flag / indicator: item_1 is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::SMALLINT,0::SMALLINT)',

	ITEM_PV_NPPS_FG				SMALLINT		DEFAULT 0															COMMENT 'Item_1 is Promotion Designer PV',	
	ITEM_PV_LP_FG				SMALLINT		DEFAULT 0															COMMENT 'Item_1 is Lidl Plus PV',	
	ITEM_PV_WAWI_FG				SMALLINT		DEFAULT 0															COMMENT 'Item_1 is WaWi PV',	

	-- AKU 2024-07-02
	ACTION_TYPE_ID				INTEGER			NOT NULL	DEFAULT -1												COMMENT '[Real] Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.',
	REAL_PROMOTION_FA_FG		SMALLINT	 	DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is FA Food Action. iff(ACTION_TYPE_ID=3,1::SMALLINT,0::SMALLINT)',
	REAL_PROMOTION_NF_FG		SMALLINT	 	DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is NF None-Food. iff(ACTION_TYPE_ID=2,1::SMALLINT,0::SMALLINT)',
	REAL_PROMOTION_PV_LP_FG		SMALLINT	 	DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is PV_LP',
	REAL_PROMOTION_PV_WAWI_FG	SMALLINT	 	DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is PV_WAWI',
	REAL_PROMOTION_PV_NPPS_FG	SMALLINT	 	DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is PV_NPPS',
	REAL_NP_FG					SMALLINT	 	DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::SMALLINT,0::SMALLINT)',

	-- AKU 2024-03-19
	NBR_OF_STORES_ITEM_SOLD		NUMBER(38,0)	DEFAULT 0															COMMENT 'Nbr. of Stores where this item_1 was sold. Needed for PV Caclulation',
	
	SUPPLIER_LIST_DESCR			VARCHAR 																			COMMENT 'Future use: Comma separated list of suppliers / Vendors of this article. Descriptive Information only.',
	
	--AKU 2024-03-19 will be moved to AGG-Framework
	--SUB_ITEM_GRP_MSTR_SID		INTEGER		 AS (
	--											IFF(SUB_ITEM_GRP_SID < 0,
	--												(SUB_ITEM_GRP_SID * 100) - CLIENT_ID,
	--												(SUB_ITEM_GRP_SID * 100) + CLIENT_ID
	--												)
	--											) 																	COMMENT 'Technical Field: FE_MSTR Join. SID for sub item_1 group (UWG - Unterwarengruppe) (MSTR formatted) ',
	--ITEM_GRP_INT_MSTR_SID		INTEGER		 AS (
	--											IFF(ITEM_GRP_INT_SID < 0,
	--												(ITEM_GRP_INT_SID * 100) - CLIENT_ID,
	--												(ITEM_GRP_INT_SID * 100) + CLIENT_ID
	--												)
	--											) 																	COMMENT 'Technical Field: FE_MSTR Join. SID for item_1 group international (WGI - Warengruppe International) (MSTR formatted) ',

	-- Sourceview Flags Flag indicates that ITEM_SID is inclided in Source Table
	--Renamed for better readablity and understanding
	SRC_ITEM_WAWI_FG				SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: item_1 is available at WAWI Source',
	SRC_ITEM_ADP_FG					SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: that item_1 is available at ADP source',
	SRC_ITEM_ADV_PERIOD_FG			SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: that item_1 is available in the processed extended periods determined by T_P_F_STORE_DAY_ADV_PERIOD_ITEM_1',
	SRC_ITEM_WA_VARIANTS_FG			SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: that item_1 is included when we take all the variants of all the items from ADP and WAWI',
	SRC_ITEM_WA_EXTENDED_FG			SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: that item_1 is included when we do the above and extend the			DATEs to cover the extended deliveries, stock and	DEFAULT period intervals',
	SRC_ITEM_DELIVERIES_FG			SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: item_1 exists in deliveries to store within a time range of DAY_DT - ${START_DT_DELIV_QTY} and DAY_DT + ${END_DT_DELIV_QTY}',
	SRC_ITEM_STOCK_FG				SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: item_1 exists in the stock record within a time range of DAY_DT - ${START_DT_STC_REAL_QTY} and DAY_DT',
	SRC_ITEM_DELIVERIES_STOCK_FG	SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Combined flag: the item_1-day the combination of the DAY_DTs from the delivery and stock calculations expanded by the relevant time ranges',
	SRC_ITEM_RECEIVINGS_FG			SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: item_1 is available to be received by supplier_1 to a warehouse',
	SRC_ITEM_EJR_FG					SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: item_1 is available at EJR (Kassa / POS) source',
	SRC_ITEM_PV_SFO_FG				SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: item_1 is available at SFO PV Table',	
	-- AKU 2024-02-08
	SRC_ITEM_PCHANGE_FG				SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: item_1 is available at Price Change Table',
	SRC_ITEM_PRICE_FG				SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: item_1 is available at WAWI Price Table',
	SRC_ITEM_LP_FG					SMALLINT		NOT NULL	DEFAULT 0 											COMMENT 'Flag / indicator: item_1 is available at LP Reference Table',	
	
	-- AKU 2024-02-08
	WAWI_PV_TYPE_ID				SMALLINT		NOT NULL	DEFAULT -1 												COMMENT 'In case SFO (PV) then adding the WaWi-PV Resason. Default -1, 3<Preisgebietsdifferenz>, 2<Bestands PV>,1<Abverkaufsbasierte PV aus LP/NPPS>',
	


    -- Technical Fields								
	REJECT_FG					SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID			INTEGER			NOT NULL	DEFAULT -1												COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID			INTEGER			NOT NULL	DEFAULT -1												COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG					SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 				TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP()							 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 				TIMESTAMP		 																	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID						INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, ITEM_SID, DELETED_FG)
)	COMMENT='Dimension table flattend item_1 hierarchy_1'
;