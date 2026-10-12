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

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	ITEM_PV_PD_FG				INTEGER NOT NULL	DEFAULT 0												COMMENT 'Item_1 is Promotion Designer PV';	
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	ITEM_PV_LP_FG				INTEGER NOT NULL	DEFAULT 0												COMMENT 'Item_1 is Lidl Plus PV';	
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	ITEM_PV_WAWI_FG				INTEGER NOT NULL	DEFAULT 0												COMMENT 'Item_1 is WaWi PV';	

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD PV_UWG_GROUP_FG INTEGER NOT NULL	DEFAULT 0 COMMENT 'Flag / indicator: item_1 is in special UWG Group relevant for PV';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD SORTIMENT_ARTICLE_FG INTEGER NOT NULL	DEFAULT 0 COMMENT 'Flag which indicates that ITEM_SID regular sortiment article BUYINGLIST_TYPE != (7,8)';

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_LST				ARRAY					COMMENT 'Array of EAN_1 Barcode'; 
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_LST_NR			INTEGER					COMMENT 'Size of Array Elements - Array of EAN_1 Barcode';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_LST_DESCR		STRING					COMMENT 'String representation of Array of EAN_1 Barcode with comma separator';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_ITEM_LST		ARRAY					COMMENT 'Array EAN_1 Description (local Language)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_ITEM_LST_NR		INTEGER					COMMENT 'Size of Array Elements - Array of EAN_1 Description (local Language)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD EAN_ITEM_LST_DESCR	STRING					COMMENT 'String representation of Array of EAN_1 Description (local Language) with comma separator';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ORIG_ITEM_MSTR_NR;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP SUB_ITEM_GRP_MSTR_SID;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ITEM_GRP_INT_MSTR_SID;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD WAWI_PV_TYPE_ID				INTEGER NOT NULL	DEFAULT -1 												COMMENT 'In case SFO (PV) then adding the WaWi-PV Resason. Default -1, 3<Preisgebietsdifferenz>, 2<Bestands PV>,1<Abverkaufsbasierte PV aus LP/PD_1 (NPPS)>';

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	ITEM_PCHANGE_FG				INTEGER NOT NULL	DEFAULT 0 												COMMENT 'Flag / indicator: item_1 is available at Price Change Table';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	ITEM_PRICE_FG				INTEGER NOT NULL	DEFAULT 0 												COMMENT 'Flag / indicator: item_1 is available at WAWI Price Table';

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ITEM_FA_FG;					
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ITEM_NF_FG;					
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ITEM_PV_FG;					
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 DROP ITEM_NP_FG;		

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	NBR_OF_STORES_ITEM_SOLD		NUMBER(38,0)	DEFAULT 0															COMMENT 'Nbr. of Stores where this item_1 was sold. Needed for PV Caclulation';

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD		ITEM_FA_FG					INTEGER DEFAULT 0															COMMENT 'Flag / indicator: item_1 is FA Food Action. iff(ACTION_TYPE_ID=3,1::INTEGER ,0::INTEGER )';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD		ITEM_NF_FG					INTEGER DEFAULT 0															COMMENT 'Flag / indicator: item_1 is NF None-Food. iff(ACTION_TYPE_ID=2,1::INTEGER ,0::INTEGER )';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD		ITEM_PV_FG					INTEGER DEFAULT 0															COMMENT 'Flag / indicator: item_1 is PV. iff(ACTION_TYPE_ID=1,1::INTEGER ,0::INTEGER )';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD		ITEM_NP_FG					INTEGER DEFAULT 0															COMMENT 'Flag / indicator: item_1 is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::INTEGER ,0::INTEGER )';
			
UPDATE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 trg
SET    
	  -- AKU 2024-03-21 VC 
	  trg.ITEM_FA_FG			= IFF((trg.ACTION_TYPE_ID) = 3, 1, 		0)::INTEGER  
	, trg.ITEM_NF_FG			= IFF((trg.ACTION_TYPE_ID) = 2, 1, 		0)::INTEGER  
	, trg.ITEM_PV_FG			= IFF((trg.ACTION_TYPE_ID) = 1, 1, 		0)::INTEGER  
	, trg.ITEM_NP_FG			= IFF((trg.ACTION_TYPE_ID) = -1, 1, 	0)::INTEGER WHERE TRUE
	
	AND trg.DELETED_FG	= 0::INTEGER AND trg.REJECT_FG	= 0::INTEGER 				

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	REAL_ACTION_TYPE_ID			INTEGER			NOT NULL	DEFAULT -1												COMMENT '[Real] Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	REAL_PROMOTION_FA_FG		INTEGER DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is FA Food Action. iff(ACTION_TYPE_ID=3,1::INTEGER ,0::INTEGER )';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	REAL_PROMOTION_NF_FG		INTEGER DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is NF None-Food. iff(ACTION_TYPE_ID=2,1::INTEGER ,0::INTEGER )';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	REAL_PROMOTION_PV_FG		INTEGER DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is PV. iff(ACTION_TYPE_ID=1,1::INTEGER ,0::INTEGER )';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD	REAL_NP_FG					INTEGER DEFAULT 0															COMMENT '[Real] Flag / indicator: item_1 is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::INTEGER ,0::INTEGER )';
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 ADD		ITEM_LP_FG					INTEGER NOT NULL	DEFAULT 0 												COMMENT 'Flag / indicator: item_1 is available at LP Reference Table';

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_WAWI_FG TO SRC_ITEM_WAWI_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_ADP_FG TO SRC_ITEM_ADP_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_ADV_PERIOD_FG TO SRC_ITEM_ADV_PERIOD_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_WA_VARIANTS_FG TO SRC_ITEM_WA_VARIANTS_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_WA_EXTENDED_FG TO SRC_ITEM_WA_EXTENDED_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_DELIVERIES_FG TO SRC_ITEM_DELIVERIES_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_STOCK_FG TO SRC_ITEM_STOCK_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_DELIVERIES_STOCK_FG TO SRC_ITEM_DELIVERIES_STOCK_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_RECEIVINGS_FG TO SRC_ITEM_RECEIVINGS_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_EJR_FG TO SRC_ITEM_EJR_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_PCHANGE_FG TO SRC_ITEM_PCHANGE_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_PRICE_FG TO SRC_ITEM_PRICE_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_LP_FG TO SRC_ITEM_LP_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ITEM_HIER_1 RENAME COLUMN ITEM_PV_SFO_FG TO SRC_ITEM_PV_SFO_FG;
	
*/


-- SUB_ITEM_GRP_MSTR_SID		INTEGER		 AS (
 -- AKU 2024-02-08
 -- ORIG_ITEM_MSTR_NR			INTEGER		 AS (

-- ITEM_GRP_INT_MSTR_SID		INTEGER		 AS (
 -- )
 -- IFF(ITEM_GRP_INT_SID < 0,
 -- IFF(SUB_ITEM_GRP_SID < 0,

-- AKU 2024-02-01 Enhance View WGI by additionbal condition used in WaWi-PV Detection

-- (ORIG_ITEM_NR * 100) - CLIENT_ID,
 -- ITEM_SID_LST_NR				INTEGER		 AS (
 -- AKU 2024-02-01

-- Sourceview Flags Flag indicates that ITEM_SID is inclided in Source Table

-- AKU 2024-03-19 will be moved to AGG-Framework
 -- Renamed for better readablity and understanding
 -- )

-- ITEM_SID_LST_DESCR			STRING AS (
 -- AKU 2024-07-02

-- )													 				COMMENT 'Size of Array Elements - Array of ItemSids',
 -- IFF(ORIG_ITEM_NR < 0,

-- AKU 20210715 Adding some VC on Action Type ID

-- ) 																	COMMENT 'Technical Field: FE_MSTR CROSS JOIN. SID for sub item_1 group (UWG - Unterwarengruppe) (MSTR formatted) ',

-- (ITEM_GRP_INT_SID * 100) + CLIENT_ID
 -- (SUB_ITEM_GRP_SID * 100) - CLIENT_ID,

-- AKU 20220209 added BuyingPrice Range

-- ) 																	COMMENT '[VC] Special MSTR CROSS JOIN criteria to have surrogate ORIG_ITEM_NR + CLIENT_ID',

-- (SUB_ITEM_GRP_SID * 100) + CLIENT_ID
 -- (ITEM_GRP_INT_SID * 100) - CLIENT_ID,
 -- )

-- AKU 20240322 Changed VC Columns

-- ) 																		COMMENT 'String representation of Array of ItemSids with comma separator',

-- ) 																	COMMENT 'Technical Field: FE_MSTR CROSS JOIN. SID for item_1 group international (WGI - Warengruppe International) (MSTR formatted) ',

-- AKU 2024-03-19 will be moved to AGG-Framework
 -- (ORIG_ITEM_NR * 100) + CLIENT_ID
 -- Technical Fields

-- Business key
 -- AKU 20210716 Added new column
 -- ARRAY_SIZE(ITEM_SID_LST)

-- AKU 20220209 Added FG to identify mainitem --> from Source View
 -- ARRAY_TO_STRING(ITEM_SID_LST, ',')

-- AKU 2024-03-19
 -- AKU 2024-02-08
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_item_hier_1 (
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Calendar_1 Day of the daily sliced flattened item_1 hierarchy_1'),
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1::=AT'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
item_sid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Unique system ID, sid, for the item_1 variant that is active (may include main item_1 sids also).'),
item_fam_grp_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='Sid for item_1 family group.'),
sub_item_grp_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='Sid for item_1 sub group. (UWG)'),
item_grp_int_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='Sid for item_1 international group. (WGI)'),
brand_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Sid for brand_1 of item.'),
orig_item_nr INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Item_1 business identifier. NaN := National Article NUMBER. CORE_AC.v_item_1: TRYCAST(Coalesce(itm.src_orig_item_nr, itm.config_item_cd, itm.src_matnr) AS INTEGER )'),
src_dat_valid_from DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Original Item_1 Source DATE from.'),
case_size BIGNUMERIC(38,5) OPTIONS(description='Business variant information.'),
item_name STRING(16777216) OPTIONS(description='(short) item_1 name in local LANGUAGE'),
item_descr STRING(16777216) OPTIONS(description='(long) item_1 description in local LANGUAGE'),
item_int_descr STRING(16777216)
OPTIONS(description='(long) item_1 description in international LANGUAGE of centre (Deutsch)'),
item_fam_grp_src_id INTEGER OPTIONS(description='ID for family group from source system.'),
item_fam_grp_src_cd STRING(16777216) OPTIONS(description='Wawi Code for Article family group'),
item_fam_grp_name STRING(16777216) OPTIONS(description='Family group name.'),
item_fam_grp_descr STRING(16777216) OPTIONS(description='Family group description (local).'),
item_fam_grp_int_descr STRING(16777216) OPTIONS(description='Family group description (international).'),
sub_item_grp_name STRING(16777216) OPTIONS(description='Item_1 sub group name. UWG'),
sub_item_grp_src_cd STRING(16777216) OPTIONS(description='Item_1 sub group Wawi Source Code. Business Key'),
sub_item_grp_descr STRING(16777216) OPTIONS(description='Item_1 sub group description (local).'),
sub_item_grp_int_descr STRING(16777216) OPTIONS(description='Item_1 sub group description (international).'),
pv_uwg_group_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: item_1 is in special UWG Group relevant for PV'),
item_grp_int_src_cd STRING(16777216) OPTIONS(description='Code for international group from source system.'),
item_grp_int_name STRING(16777216) OPTIONS(description='International group name.'),
item_grp_int_descr STRING(16777216) OPTIONS(description='International group description (local).'),
item_grp_int_int_descr STRING(16777216) OPTIONS(description='International group description (international).'),
buying_list_type_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='ID for buying list type. Only on Country_1 Level – no regionalization.'),
buying_list_type_descr STRING(16777216) OPTIONS(description='Buying list type description (local).'),
buying_list_type_int_descr STRING(16777216) OPTIONS(description='Buying list type description (international).'),
sortiment_article_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag which indicates that ITEM_SID regular sortiment article BUYINGLIST_TYPE != (7,8)'),
brand_name STRING(16777216) OPTIONS(description='Brand_1 name.'),
brand_type_cd STRING(16777216) OPTIONS(description='Brand_1 type.'),
item_action_type_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.'),
mainitem_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag which indicates that ITEM_SID is a MainItem, which is driving the ORIG_ITEM_NR'),
buy_price_range_days INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Buying Price Range in days – defined by controlling'),
item_sid_lst ARRAY < STRING >OPTIONS(description='Array of ItemSids (Variants) which are grouped together bei NAN'),
item_fa_fg INTEGER DEFAULT 0
OPTIONS(description='Flag / indicator: item_1 is FA Food Action. iff(ACTION_TYPE_ID=3,1::INTEGER ,0::INTEGER )'),
item_nf_fg INTEGER DEFAULT 0
OPTIONS(description='Flag / indicator: item_1 is NF None-Food. iff(ACTION_TYPE_ID=2,1::INTEGER ,0::INTEGER )'),
item_np_fg INTEGER DEFAULT 0
OPTIONS(description='Flag / indicator: item_1 is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::INTEGER ,0::INTEGER )'),
item_pv_npps_fg INTEGER DEFAULT 0 OPTIONS(description='Item_1 is Promotion Designer PV'),
item_pv_lp_fg INTEGER DEFAULT 0 OPTIONS(description='Item_1 is Lidl Plus PV'),
item_pv_wawi_fg INTEGER DEFAULT 0 OPTIONS(description='Item_1 is WaWi PV'),
action_type_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Real] Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.'),
real_promotion_fa_fg INTEGER DEFAULT 0
OPTIONS(description='[Real] Flag / indicator: item_1 is FA Food Action. iff(ACTION_TYPE_ID=3,1::INTEGER ,0::INTEGER )'),
real_promotion_nf_fg INTEGER DEFAULT 0
OPTIONS(description='[Real] Flag / indicator: item_1 is NF None-Food. iff(ACTION_TYPE_ID=2,1::INTEGER ,0::INTEGER )'),
real_promotion_pv_lp_fg INTEGER DEFAULT 0 OPTIONS(description='[Real] Flag / indicator: item_1 is PV_LP'),
real_promotion_pv_wawi_fg INTEGER DEFAULT 0 OPTIONS(description='[Real] Flag / indicator: item_1 is PV_WAWI'),
real_promotion_pv_npps_fg INTEGER DEFAULT 0 OPTIONS(description='[Real] Flag / indicator: item_1 is PV_NPPS'),
real_np_fg INTEGER DEFAULT 0
OPTIONS(description='[Real] Flag / indicator: item_1 is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::INTEGER ,0::INTEGER )'),
nbr_of_stores_item_sold BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Nbr. of Stores where this item_1 was sold. Needed for PV Caclulation'),
supplier_list_descr STRING(16777216)
OPTIONS(description='Future use: Comma separated list of suppliers / Vendors of this article. Descriptive Information only.'),
src_item_wawi_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator: item_1 is available at WAWI Source'),
src_item_adp_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator: that item_1 is available at ADP source'),
src_item_adv_period_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: that item_1 is available in the processed extended periods determined by T_P_F_STORE_DAY_ADV_PERIOD_ITEM_1'),
src_item_wa_variants_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: that item_1 is included when we take all the variants of all the items from ADP and WAWI'),
src_item_wa_extended_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: that item_1 is included when we do the above and extend the			DATEs to cover the extended deliveries, stock and	DEFAULT period intervals'),
src_item_deliveries_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: item_1 exists in deliveries to store within a time range of DAY_DT - ${START_DT_DELIV_QTY} and DAY_DT + ${END_DT_DELIV_QTY}'),
src_item_stock_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: item_1 exists in the stock record within a time range of DAY_DT - ${START_DT_STC_REAL_QTY} and DAY_DT'),
src_item_deliveries_stock_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Combined flag: the item_1-day the combination of the DAY_DTs from the delivery and stock calculations expanded by the relevant time ranges'),
src_item_receivings_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: item_1 is available to be received by supplier_1 to a warehouse'),
src_item_ejr_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: item_1 is available at EJR (Kassa / POS) source'),
src_item_pv_sfo_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator: item_1 is available at SFO PV Table'),
src_item_pchange_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: item_1 is available at Price Change Table'),
src_item_price_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: item_1 is available at WAWI Price Table'),
src_item_lp_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator: item_1 is available at LP Reference Table'),
wawi_pv_type_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='In case SFO (PV) then adding the WaWi-PV Resason. Default -1, 3<Preisgebietsdifferenz>, 2<Bestands PV>,1<Abverkaufsbasierte PV aus LP/NPPS>'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, day_dt, item_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Dimension table flattend item_1 hierarchy_1');