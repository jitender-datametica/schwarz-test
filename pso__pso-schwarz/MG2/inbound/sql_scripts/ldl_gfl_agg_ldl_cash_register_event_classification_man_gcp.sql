/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_cash_register_event_classification_man.sql
#----------------------------------------------------------------------------
# History:
# 1.0  18.10.2024  Mihail Ivanov, Kamil Roszczyk    - intial version
# 1.1  22.10.2024  Andrzej Wandtke                  - extend delete section to statistics table
# 1.2  29.10.2024  Kamil Roszczyk                   - adding code for new scenarios:
#                                                       1. https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/51387
#                                                       2. https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/51388
# 1.3  19.11.2024  Mihail Ivanov                   - adding code for new scenarios:
#                                                       US:	https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/57599/
#                                                       	for SCENARIO_IDs 41 and 42
#
#													Changed Logic - scenario for returns without original receipts now evaluates only prod_retail_line_type_cd = 'R'
#														Deposits (type 'RD) are excluded
#
# 1.4  21.11.2024  Mihail Ivanov                   - adding filter "re.TURNOVER_RELEVANT_FG = TRUE" for T_RETAIL_EVENT to all appropriate sceanrios
#														 (aborted and suspeded receipts have this flag FALSE, so for their scenario filter is not ADDED intentionally)
#
# 1.5  22.11.2024  Mihail Ivanov                   - columns CUST_SID and CUST_IDENT_TYPE_CD added to T_CASH_REGISTER_EVENT_CLASSIFICATION and all scripts populate them
#
#												   -  adding code for new scenario (as it turns our scenario 40 is needed for this story)
#                                                       US:	https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/57599/
#                                                       for SCENARIO_IDs 40
#
#
# 1.5  29.11.2024  Mihail Ivanov                   - table etl.T_STORES_QUALIFIED is now moved to separate initial script, so it can be reused by other scripts too.
#															it is now a transient table
#
# 1.6  02.12.2024  Mihail Ivanov                   - Set default values for CUST_SID and CUST_IDENT_TYPE_CD
#
# 1.7  07.01.2025  Kamil Roszczyk                  - applied ranking filtering/store selection wildcard for most of manual scenarios (scenario IDs from 21 to 39 - for 40, 41 and 42 currently there is no ranking threshold set up in thresholds table)
#                                                       US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/61727
#                                                       Change log:
#                                                       	- step 2.8: added sales_company_sid and newly added column to ETL.T_STORES_QUALIFIED transient table - store_selected_fg
#															- step 2.11: created separate temp table with enhanced source query copied from SELECT clause in former 3.2 step as this statement can be used twice
#															- step 2.12: created cashier's ranking table used for filtering during the load into classification table
#															- step 3.1: added filtering by cashier ranking/store selection wildcard for subqueries for scenarios with threshold data available (from 21 to 39)
#															- step 3.2: removed the logic in SELECT statement (moved to aforementioned step 2.11) - replaced by simple SELECT from step 2.11 temp table


# 1.8  21.01.2025  Mihail Ivanov                   - Bugfix - Calculating DISCOUNT_NET_VAL correctly
														We had this: SUM(abs( dl.discount_val/(1+prl.tax_pct) ))
														Should be this: SUM(abs( dl.discount_val/(1+prl.tax_pct/100) )) -- because we store "5% tax" as 5, not as 0.05
														Reported here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63231/

# 1.9  23.01.2025  Mihail Ivanov                   - Bugfix - Exclude Fruit/Vegetables/Flowers/Bakery from storno scenarios (step 2.2)
														https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63203/
														In some previous (recent version) it is fixed how T_STATISTICS_BY_STORE_DAY_CASHIER.EVENT_CNT is populated, which was also causing the problems reported in the bug

# 1.10 24.01.2025  Kamil Roszczyk					- Changed logic
														US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/55157
															- EVENT_END_HR attribute has been added to T_CASH_REGISTER_EVENT_CLASSIFICATION - no impact on granularity
															- EVENT_END_HR attribute has been added to T_STATISTICS_BY_STORE_DAY_CASHIER - it changed the table's PK and granularity so the table has been renamed to T_STATISTICS_BY_STORE_HOUR_CASHIER to reflect the granularity change
															- added the logic for extracting EVENT_END_HR data to most of CTEs in most of temp tables
															- changed the anchor logic for etl.T_TMP_STORE_CASHIER_BY_DAY_STATISTICS to adjust to the new attribute - temp table renamed to T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS

# 1.11 29.01.2025  Kamil Roszczyk                  - Bugfix - change in T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS temp table: replaced the source for SALES_COMPANY_SID and STORE_SELECTED_FG from tech_events_agg to working_hours CTE

# 1.12 30.01.2025  Kamil Roszczyk				   - removed SUSPEND_FG and CANCEL_FG filters for continuation receipts in T_TMP_SUSPEND_SCENARIOS temp table
														US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/62636

# 1.13 05.02.2025  Kamil Roszczyk				   - added the filter in T_TMP_ABORT_SCENARIOS temp table logic to exclude aborted receipts that do not have any lines
														Task: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/55436

# 1.14 12.02.2025  Kamil Roszczyk				   - bugfix - changed the logic of calculating retail, sales and return net values within sales_returns_agg CTE in T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS temp table
														All these three metrics are now calculated based on txn_net_val taken from receipt header information (`CORE_REL.T_RETAIL_EVENT`). Before they were calculated using receipt lines but it led to slightly different values than expected by checking the old system reports
														https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64236


# 1.15  13.02.2025  Mihail Ivanov                   - Changes - filters for ranking cashiers and loading "Top 5" into classification table removed.
														Data for all cashiers is loaded in classification table
														Additional table created T_CASHIER_RANKING_BY_FRAUD_SCENARIO ( 1 row per Cashier+Scenario) - cashiers's ranks for each scenario are stored there
														This will fix bugs like:
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63844
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63924


# 1.16  16.02.2025  Mihail Ivanov                   - Changes(bugfix) - Excluding self-checkout cashiers from T_STATISTICS_BY_STORE_HOUR_CASHIER table
														however all "human" cashiers are included regardless of number of days they worked and numbers of events they made
														Discussed here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63231

# 1.17  19.02.2025  Mihail Ivanov                   - Changes(bugfix) - Added column t_cash_register_event_classification.CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
														the column is used only for scenario 22 "Wert manuelle Pfandauszahlung"
														only there we need to work with GROSS val instead of NET val
														Requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63840

# 1.18  20.02.2025  Mihail Ivanov                   - Changes(bugfix) - column t_cash_register_event_classification.CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL is populated also for:
														scenario 21 "Wert reine Pfandauszahlung"
														scenario 23 "Pfandquote"
														Requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63840

# 1.19  21.02.2025  Mihail Ivanov                   - REMOVE CHANGES FROM VERSION 1.16 - the filter should have been applied for CASH_REGISTER_NR, not CASHIER_NR
														We remove this filter now, to go to previous state. In later versions the correct fitler will be applied

# 1.20  24.02.2025  Mihail Ivanov                   - Bugfix: Filter events for "T_STATISTICS_BY_STORE_HOUR_CASHIER" and exclude self-checkout cash registers


# 1.21  28.02.2025  Mihail Ivanov                   - Change: Remove filter that loads only "QUALIFIED" cashiers in T_CASH_REGISTER_EVENT_CLASSIFICATION
														Now we are loading evets for EVERY cashier, but we are still excluding events that happened at self-checkout Registers
																* (except for "return" and "deposit" scenarios. For them we include self-checkout as in old world)
														Filtering for Manual KPI reports will be done by joining with T_CASHIER_RANKING_BY_FRAUD_SCENARIO and using flag RELEVANT_FOR_MANUAL_REPORT_FG
														Discussed here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63844/

														This change also affects Tech and Price Info events.
														Before this change, tables T_TMP_TECH_EVENTS  and T_TMP_PRICE_CHECK_SCENARIOS had flag IS_QUALIFIED_CASHIER
														The flag was set incorrectly to FALSE in days without retail events even for qualified cashiers.
														So events were incorrectly eliminated

# 1.22	03.03.2025	Kamil Roszczyk					- Bugfixing: added threshold for minimal receipt value in T_TMP_ABORT_SCENARIOS temp table Logic
														https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64825

# 1.23	05.03.2025	Kamil Roszczyk					- Bugfixing:
														added filter for excluding cancellation lines in T_TMP_RETURN_SCENARIOS temp table: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64462
														modified logic for aborted scenarios so the threshold for minimal receipt gross value is applied only to Gesamtwert Bonabbruch and not to Gesamtanzahl Bonabbruch: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64825
														removed filter on self checkout registers for Gesamtwert Bonabbruch scenario

# 1.24	10.03.2025	Kamil Roszczyk					- performance optimization for T_TMP_ABORT_SCENARIOS temp table
														during Ab Initio runs Snowflake usually picked very suboptimal execution plan for that table, specifically for join to t_product_retail_line
														-> this was fixed by packing the core logic into separate CTE and adding dummy QUALIFY clause to it forcing Snowflake to execute this whole logic prior to the join with huge t_product_retail_line table

# 1.25  13.03.2025  Mihail Ivanov                   - Refactoring: Created temp tables T_TMP_RETAIL_EVENT and T_TMP_PRODUCT_RETAIL_LINE which are later reused in almost every other query.
														this way even if snowflake acts crazy and reads all "retail lines" first - it will rean only limited amount and not  320B+ rows.

# 1.26  14.03.2025  Mihail Ivanov                   - Bugfix: Added filter TURNOVER_RELEVANT_FG=TRUE to deposit lines (2.9 - T_TMP_DEPOSIT_SCENARIOS)
														https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66702/

# 1.27	25.03.2025	Kamil Roszczyk					- bugfixing and changes:
														- changed the filter conditions on self-checkout cash registers from "cash_register_nr <= 80" comparison to "cash_register_cd = 'TIL'"
														- modified the scope of scenarios that should be affected by this filter according to the requirements
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66853
														- changed the way how the anchor CTE is calculated in T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS load script to mitigate the impact of potential data quality issues we can have with POS source data
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66695
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66702

# 1.28	02.04.2025	Kamil Roszczyk					- bugfixing: modified the logic in T_TMP_CASHIERS_QUALIFIED (changes in sync with MIS logic)
														- total transaction count is now based on all transactions (retail, technical, price check), not only retail ones
														- total workday count is now based on days when at least one unaborted and unsuspended sales transaction was done (previously there was no filter on unaborted and unsuspended transactions)
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/68108
														- created temp tables T_TMP_PRICE_INFORMATION_EVENT and T_TMP_TECHNICAL_CASH_REGISTER_EVENT to avoid multiple table scanning
														- small refactoring of T_TMP_RETAIL_EVENT and T_TMP_PRODUCT_RETAIL_LINE, removed redundant joins to these tables in T_TMP_CASHIER_QUALIFIED logic

# 1.29	02.04.2025	Mihail Ivanov					- changes: Excluding events from countries where given scenario is disabled (inactive/hidden)
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803/

# 1.30	14.04.2025	Kamil Roszczyk					- changes: added the logic for excluding outlier days from Geldrückgabenquote KPI calculations
														added is_outlier_day_return_fg to T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS and `CORE_APP_FRAUD_DETECTION.T_STATISTICS_BY_STORE_HOUR_CASHIER`
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66184


# 1.31	16.04.2025	Mihail Ivanov					- changes: Added additional scenarios to the classification table
														- 4 new "Returns" scenarios (IDs 43,44,45,46) requsted here: 			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803/
														- 6 new "PriceInfo" scenarios (IDs 47,48,49,50,51,52) requested here:	https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63792
														- 3 new "Discount" scenarios (IDs 53,54,55) requested here: 			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63794
														- 2 new "Deposit" scenarios (IDs 56,57) requested here: 				https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63791


# 1.32	24.04.2025	Mihail Ivanov					- changes: Changed filter for storno scenarios
															an Event(receipt) is qualified only if it has a cancelled line with "important product" (excluding Flowers/Bakery/Fruits/Veggies)
															but once an event is qualified, we count the number and amount of ALL its cancelled lines (including Flowers/Bakery/Fruits/Veggies)
															requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63789

# 1.33  29.04.2025  Kamil Roszczyk					- changes: changed 'TIL' filter for non selfcheckout cash registers
														- filter: "cash_register_type_cd = 'TIL'"; replaced with: "cash_register_type_cd = 'TIL' OR cash_register_type_cd IS NULL"
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/69257



# 1.34	13.05.2025	Mihail Ivanov					- bugfix: for Return scenarios when taking original receipts we now do a LEFT JOIN with cashier encryption
																this keeps old original receipts for which the cashier_hash has been set to "@"
																fixes bug reported here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63788

# 1.35	14.05.2025	Mihail Ivanov					- bugfix: for Discount scenarios
														threshold values are now compared to amount/line_cnt of MANUALLY discounted lines (before the comparison was with all discounted lines)
														reported here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63794

													- change: for scenario "Gesamtanzahl Preisanzeigen" ( id 36) set value in CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
														the value comes from column T_PRICE_INFORMATION_EVENT.PROD_PRICE
														requested by Front-End developers

# 1.36  15.05.2025  Kamil Roszczyk					- bugfix: for scenario Wert Pfandauszahlungen (id 56) added filter to qualify only these receipt where any deposit return is available
														Previously the scenario allowed for receipts either with deposit return OR deposit sales lines
														In MIS system the corresponding metric contains only these receipts where any deposit return line exists and such logic was also applied
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63791

# 1.37  16.05.2025  Kamil Roszczyk					- bugfix: for scenario Reine und manuelle Pfandauszahlung (id 57) added filter to qualify only these receipts where all lines are only manual deposit return lines
														Previously the scenario allowed for receipts with non manual deposit return lines
														In MIS system the corresponding metric contains only these receipts all lines in a receipt are only manual deposit return lines
															https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63791



TODO: because of change 1.21 we can calculate from "classification" table many of the Store/Company-level calculations that are now produced from T_STATISTICS_BY_STORE_HOUR_CASHIER
		Many columns from T_STATISTICS_BY_STORE_HOUR_CASHIER will become obsolete and after validating that results from both table are equal we will drop them (example CANCELLED_LINE_CNT, CANCELLED_NET_VAL ...)
		This is planned for next few weeks .. maybe change 1.23/1.24 ... (well if you wanna make god laugh, tell him about your plans)
*/



/*
Script content:

	1.1		CREATE temp tables:	T_TMP_RETAIL_EVENT, T_TMP_PRODUCT_RETAIL_LINE, T_TMP_PRICE_INFORMATION_EVENT and T_TMP_TECHNICAL_CASH_REGISTER_EVENT
	1.2		CREATE temp table:	T_TMP_CASHIERS_QUALIFIED

	2.1		CREATE temp table:	T_TMP_DISCOUNT_SCENARIOS 		(SCENARIO_IDs: 38, 39)
	2.2		CREATE temp table:	T_TMP_STORNO_SCENARIOS			(SCENARIO_IDs: 34, 35)
	2.3		CREATE temp table:	etl.T_TMP_PRICE_CHECK_SCENARIOS		(SCENARIO_IDs: 36)
	2.4		CREATE temp table:	T_TMP_SUSPEND_SCENARIOS			(SCENARIO_IDs: 31, 42)
	2.5		CREATE temp table:	T_TMP_ABORT_SCENARIOS			(SCENARIO_IDs: 32, 33)
	2.6		CREATE temp table:	T_TMP_RETURN_SCENARIOS			(SCENARIO_IDs: 26, 28, 29, 30)
	2.7		CREATE temp table:	T_TMP_SMALL_SALE_SCENARIOS		(SCENARIO_IDs: 25)
	2.8		CREATE temp table:	T_TMP_TECH_EVENTS				(SCENARIO_IDs: 24)
	2.9		CREATE temp table:	T_TMP_DEPOSIT_SCENARIOS			(SCENARIO_IDs: 23, 22, 21)
	2.10	CREATE temp table:	T_TMP_LIDL_PLUS_SCENARIOS		(SCENARIO_IDs: 40)
	2.11	CREATE temp table:	T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS
	2.12	CREATE temp table:	T_TMP_CASHIER_RANKINGS_BY_WAREHOUSE

	3.0		DELETE old data from  T_CASH_REGISTER_EVENT_CLASSIFICATION  &  T_STATISTICS_BY_STORE_HOUR_CASHIER & T_CASHIER_RANKING_BY_FRAUD_SCENARIO
	3.1		INSERT INTO `CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION`
	3.2		INSERT INTO `CORE_APP_FRAUD_DETECTION.T_STATISTICS_BY_STORE_HOUR_CASHIER`
	3.3		INSERT INTO `CORE_APP_FRAUD_DETECTION.T_CASHIER_RANKING_BY_FRAUD_SCENARIO`

*/




--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--	Common/Reusable Objects (views or temp tables)
--
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

DECLARE SV_MIN_WORK_DAYS INT64 DEFAULT 7; -- Cashiers qualify for audit only if they have worked at least this number of days
DECLARE SV_MIN_RECEIPTS INT64 DEFAULT 200;	-- Cashiers qualify for audit only if they have made at least this number of receipts
DECLARE SV_SELF_CASH_REGISTER_NR INT64 DEFAULT 80; -- Cash Registers with higher number are self-checkout, and should be excluded

-- setting session variable for performance optimization (T_STORES_QUALIFIED is transient table populated before this script is invoked)
DECLARE SV_MIN_DT DATE;
DECLARE SV_MAX_DT DATE;
SET (SV_MIN_DT, SV_MAX_DT) = (SELECT AS STRUCT min(bus_dt), max(bus_dt) FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED`);




--------------------------------------------------------------------------------
-- 1.1 Make temp tables will all relavant RetailEvents (T_RETAIL_EVENT) and all relevant line (T_PRODUCT_RETAIL_LINE)
--	these temp tables will be used 8-9 later so we save a lot of time that could be wasted querying these big tables
--
--	especially considering the fetish snowflake has for T_PRODUCT_RETAIL_LINE and how often it just decides to read it fist -
--		the full table, with no filers (instead of reading T_STORES_QUALIFIED first and using it as filter for T_PRODUCT_RETAIL_LINE)
--
--	we also take only necessary cols
CREATE OR REPLACE TEMP TABLE T_TMP_RETAIL_EVENT AS
SELECT
	re.RETAIL_EVENT_SID
	,re.CASH_REGISTER_EVENT_NR
	,re.EVENT_END_TMSP
	,re.BUS_DT
	,re.STORE_SID
	,re.COUNTRY_ORG_CD
	,re.CASH_REGISTER_SID
	,re.CASH_REGISTER_TYPE_CD
	,re.CASHIER_HASH
	,re.CUST_SID
	,re.CUST_IDENT_TYPE_CD
	,re.RETAIL_EVENT_TYPE_CD
	,re.RETAIL_EVENT_SCENARIO_ID
	,re.CANCEL_FG
	,re.SUSPEND_FG
	,re.SUSP_RETAIL_EVENT_SID
	,re.TXN_GROSS_VAL
	,re.TXN_NET_VAL
	,re.TXN_VAT_VAL
	,re.TURNOVER_RELEVANT_FG

	,cr.CASH_REGISTER_NR
	,ce.CASHIER_NR
	,s.SALES_COMPANY_SID
	,s.STORE_SELECTED_FG
	,s.IS_DIRECTLY_ORDERED
FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` s

	INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` re
			ON  re.COUNTRY_ORG_CD = s.COUNTRY_ORG_CD
			AND re.STORE_SID = s.STORE_SID
			AND re.BUS_DT = s.BUS_DT

	INNER JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ce
			ON re.CASHIER_HASH = ce.CASHIER_HASH
			AND re.BUS_DT = ce.BUS_DT

	INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_CASH_REGISTER` cr
			ON cr.CASH_REGISTER_SID = re.CASH_REGISTER_SID
			AND cr.DWH_VALID_FG = TRUE
;


-- temp table with Retail Lines events
CREATE OR REPLACE TEMP TABLE T_TMP_PRODUCT_RETAIL_LINE AS
SELECT
	prl.RETAIL_EVENT_SID
	,prl.RETAIL_EVENT_LINE_SEQ
	,prl.EVENT_END_TMSP
	,prl.BUS_DT
	,prl.STORE_SID
	,prl.COUNTRY_ORG_CD
	,prl.CASH_REGISTER_SID
	,prl.CASHIER_HASH
	,prl.PROD_RETAIL_LINE_TYPE_CD
	,prl.RETAIL_EVENT_LINE_SCENARIO_ID
	,prl.PROD_VARIANT_SID
	,prl.LOCAL_PROD_NR
	,prl.PROD_VARIANT_INPUT_NR
	,prl.PROD_VARIANT_CNT
	,prl.PROD_VARIANT_QTY
	,prl.RETAIL_LINE_GROSS_VAL
	,prl.RETAIL_LINE_NET_VAL
	,prl.RETAIL_LINE_VAT_VAL
	,prl.TAX_PCT
	,prl.TURNOVER_RELEVANT_FG
	,prl.PROD_ENTRY_METHOD_CD
	,prl.ORIG_SALES_EVENT_SID
	,prl.CANCEL_LINE_SEQ
FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` s
	INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` prl
			ON  prl.COUNTRY_ORG_CD = s.COUNTRY_ORG_CD
			AND prl.STORE_SID = s.STORE_SID
			AND prl.BUS_DT = s.BUS_DT
;


CREATE OR REPLACE TEMP TABLE T_TMP_PRICE_INFORMATION_EVENT AS
SELECT
	tpie.PRICE_INFO_EVENT_SID
	, tpie.CASH_REGISTER_EVENT_NR
	, tpie.COUNTRY_ORG_CD
	, tpie.STORE_SID
	, tpie.BUS_DT
	, tpie.EVENT_TMSP
	, tpie.CASH_REGISTER_TYPE_CD
	, tpie.CASHIER_HASH
	, tpie.PROD_PRICE
	, tpie.CURR_CD
	, tpie.CASH_REGISTER_SID
	, tpie.PROD_VARIANT_SID

	, ce.CASHIER_NR
	, cr.CASH_REGISTER_NR
	, sq.SALES_COMPANY_SID
	, sq.STORE_SELECTED_FG
	, sq.IS_DIRECTLY_ORDERED
FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq

	INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRICE_INFORMATION_EVENT` tpie
			ON tpie.STORE_SID = sq.STORE_SID
			and tpie.BUS_DT = sq.BUS_DT
			and tpie.COUNTRY_ORG_CD = sq.COUNTRY_ORG_CD

	INNER JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ce
			ON ce.cashier_hash = tpie.cashier_hash

	INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_CASH_REGISTER` cr
			ON cr.CASH_REGISTER_SID = tpie.CASH_REGISTER_SID
			AND cr.DWH_VALID_FG = TRUE
;


CREATE OR REPLACE TEMP TABLE T_TMP_TECHNICAL_CASH_REGISTER_EVENT AS
SELECT
	ttcre.TECH_CASH_REGISTER_EVENT_SID
	,ttcre.CASH_REGISTER_EVENT_NR
	,ttcre.COUNTRY_ORG_CD
	,ttcre.STORE_SID
	,ttcre.BUS_DT
	,ttcre.EVENT_TMSP
	,ttcre.CASH_REGISTER_TYPE_CD
	,ttcre.TECH_CASH_REGISTER_EVENT_TYPE_CD
	,ttcre.CASHIER_HASH
	,ttcre.CASH_REGISTER_SID

	,tce.CASHIER_NR
	,cr.CASH_REGISTER_NR
	,sq.SALES_COMPANY_SID
	,sq.STORE_SELECTED_FG
	,sq.IS_DIRECTLY_ORDERED
FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq

	INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT` ttcre
			ON ttcre.STORE_SID = sq.STORE_SID
			and ttcre.BUS_DT = sq.BUS_DT
			and ttcre.COUNTRY_ORG_CD = sq.COUNTRY_ORG_CD

	INNER JOIN	`${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` tce
			ON ttcre.cashier_hash = tce.cashier_hash

	INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_CASH_REGISTER` cr
			ON cr.CASH_REGISTER_SID = ttcre.CASH_REGISTER_SID
			AND cr.DWH_VALID_FG = TRUE
;

--------------------------------------------------------------------------------






--------------------------------------------------------------------------------
--	1.2
-- 	Granularity: STORE_SID, CASHIER_HASH (alternatively STORE_SID + CASHIER_NR + BUS_DT0, as we have new Hash each day)
-- 		We will use this view to filter cashiers only for classification table
--		this is why we have the filter and s.IS_DIRECTLY_ORDERED = 1
CREATE OR REPLACE TEMP TABLE T_TMP_CASHIERS_QUALIFIED 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- )
AS
WITH
all_events as
(
	SELECT
		CASHIER_HASH
		,STORE_SID
		,CASHIER_NR
		,BUS_DT
		,COUNTRY_ORG_CD

		--In MIS system only sales receipts with transaction code 100 were qualified for workdays count filter
		--100 means sales receipts that were not suspended or aborted so both conditions in a CASE statement below should correspond to that logic
		,CASE
				WHEN RETAIL_EVENT_TYPE_CD = 'S'
					AND TURNOVER_RELEVANT_FG = True THEN 1
				ELSE 0
			END AS WORKDAYS_CNT_RELEVANT_FG
	FROM T_TMP_RETAIL_EVENT

	-- IS_DIRECTLY_ORDERED=1 means store is explicitly ordered for investigation or belongs to company that is ordered for investigation
	-- IS_DIRECTLY_ORDERED=0 (sibling store) means store is NOT ordered, but is included because another store from same company is explicitly ordered (while the whole company is NOT ordered)
	-- also field STORE_SELECTED_FG exists. It is 1 only for stores that are explicitly ordered while their company is NOT ordered
	WHERE
		IS_DIRECTLY_ORDERED = 1  -- excluding siblings

	UNION ALL

	SELECT
		CASHIER_HASH
		,STORE_SID
		,CASHIER_NR
		,BUS_DT
		,COUNTRY_ORG_CD

		--No workdays count relevant events within technical events set so setting the flag to 0
		,0 AS WORKDAYS_CNT_RELEVANT_FG
	FROM T_TMP_TECHNICAL_CASH_REGISTER_EVENT

	WHERE
		IS_DIRECTLY_ORDERED = 1  -- excluding siblings

	UNION ALL

	SELECT
		CASHIER_HASH
		,STORE_SID
		,CASHIER_NR
		,BUS_DT
		,COUNTRY_ORG_CD

		--No workdays count relevant events within price check events set so setting the flag to 0
		,0 AS WORKDAYS_CNT_RELEVANT_FG
	FROM T_TMP_PRICE_INFORMATION_EVENT

	WHERE
		IS_DIRECTLY_ORDERED = 1  -- excluding siblings
)
,cashier_daily_stats as
(

	SELECT
		CASHIER_HASH
		,STORE_SID
		,CASHIER_NR
		,BUS_DT
		,COUNTRY_ORG_CD

		,sum(WORKDAYS_CNT_RELEVANT_FG) AS cashier_daily_sales_cnt
		,count(*) AS cashier_daily_retail_events_cnt

		,SUM(IF(sum(WORKDAYS_CNT_RELEVANT_FG) = 0, 0, 1)) OVER(PARTITION BY store_sid, cashier_nr) 	AS cashier_workdays_cnt
		,SUM(count(*)) OVER(PARTITION BY store_sid, cashier_nr) 				AS cashier_retail_events_cnt

	FROM all_events
	GROUP by
		CASHIER_HASH
		,STORE_SID
		,CASHIER_NR
		,BUS_DT
		,COUNTRY_ORG_CD
)
SELECT
	STORE_SID
	,COUNTRY_ORG_CD
	,CASHIER_NR
	,CASHIER_HASH
	,BUS_DT
FROM cashier_daily_stats
WHERE 1=1
	and cashier_workdays_cnt > SV_MIN_WORK_DAYS
	and cashier_retail_events_cnt > SV_MIN_RECEIPTS
;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------






--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Get stats on EVENT LEVEL for all stores and days, and calculate flag is a cashier is qualified
--		All rows will go into the statistic table
--		Only rows for qualified cashiers will go into CLASSIFICATION table
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--	2.1
CREATE OR REPLACE TEMP TABLE T_TMP_DISCOUNT_SCENARIOS 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- ) 
AS
WITH
materialize_param_view as
(
	SELECT *
	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE`
	WHERE scenario_id in (
			54	-- "Anzahl Bons mit >=X rabattierten Artikeln pro Bon"
			,55 -- "Anzahl Bons mit Rabattwert >=X pro Bon"
		)
)
,discount_lines_eval as -- calculate a flag which line is "manual" discount
(
	SELECT
		re.RETAIL_EVENT_SID
		,re.CASH_REGISTER_EVENT_NR
		,re.COUNTRY_ORG_CD
		,re.STORE_SID
		,re.BUS_DT
		,re.EVENT_END_TMSP
		,re.CUST_SID
		,re.CUST_IDENT_TYPE_CD
		,re.CASHIER_NR
		,re.CASH_REGISTER_NR
		,re.CASH_REGISTER_TYPE_CD

		,prl.RETAIL_EVENT_LINE_SEQ
		,prl.TAX_PCT
		,dl.DISCOUNT_VAL


		,CASE
				WHEN dl.RETAIL_EVENT_LINE_SCENARIO_ID BETWEEN 400 AND 599
					and not (length(prl.prod_variant_input_nr) BETWEEN 15 AND 17
							and (prl.prod_variant_input_nr LIKE '55%' OR prl.prod_variant_input_nr LIKE '56%')
						)
				THEN 1
				ELSE 0
			END as IS_MANUAL_DISCOUNT_LINE_FG

	FROM T_TMP_RETAIL_EVENT re
		join `${BQ_PROJECT_ID}.CORE_REL.T_DISCOUNT_LINE` dl
			ON  dl.RETAIL_EVENT_SID = re.RETAIL_EVENT_SID
			AND dl.COUNTRY_ORG_CD = re.COUNTRY_ORG_CD
			AND dl.BUS_DT = re.BUS_DT
		join T_TMP_PRODUCT_RETAIL_LINE prl
				ON prl.RETAIL_EVENT_SID = dl.RETAIL_EVENT_SID
				AND prl.RETAIL_EVENT_LINE_SEQ = dl.DISCOUNTED_LINE_SEQ
	WHERE 1=1
		and re.TURNOVER_RELEVANT_FG = TRUE -- this eliminates cancelled (aborted) and suspended receipts too
		AND Abs(dl.discount_val) > 0.01
		and dl.bus_dt between SV_MIN_DT and SV_MAX_DT
)
,discounts_eval as
(
	SELECT
		dle.RETAIL_EVENT_SID 						as CASH_REGISTER_EVENT_SID

		,any_value(dle.CASH_REGISTER_EVENT_NR)		as CASH_REGISTER_EVENT_NR
		,any_value(dle.COUNTRY_ORG_CD)				as COUNTRY_ORG_CD
		,any_value(dle.STORE_SID)					as STORE_SID
		,any_value(dle.BUS_DT)						as BUS_DT
		,any_value(EXTRACT(HOUR FROM dle.EVENT_END_TMSP))			as EVENT_END_HR
		,any_value(dle.CUST_SID)						as CUST_SID
		,any_value(dle.CUST_IDENT_TYPE_CD)			as CUST_IDENT_TYPE_CD
		,any_value(dle.CASHIER_NR)					as CASHIER_NR
		,any_value(dle.CASH_REGISTER_NR)				as CASH_REGISTER_NR
		,any_value(dle.CASH_REGISTER_TYPE_CD)		as CASH_REGISTER_TYPE_CD

		-- it is possible that 1 retail line has 2 discounts ( 2 discount lines)
		-- so the next two columns could have different numbers
		,count(*) 									as DISCOUNT_LINE_CNT
		,count(distinct dle.RETAIL_EVENT_LINE_SEQ) 	as DISCOUNTED_LINES_CNT

		,SUM(abs( dle.discount_val)) 						as DISCOUNT_GROSS_VAL
		,SUM(abs( dle.discount_val/(1+dle.tax_pct/100) )) 	as DISCOUNT_NET_VAL

		-- same as 4 cols above but only manual lines are considered
		,sum(IS_MANUAL_DISCOUNT_LINE_FG) 					as MANUAL_DISCOUNT_LINE_CNT
		,count(distinct IF(IS_MANUAL_DISCOUNT_LINE_FG = 1, dle.RETAIL_EVENT_LINE_SEQ, NULL)) 	as MANUAL_DISCOUNTED_LINES_CNT

		,SUM(abs( dle.discount_val*IS_MANUAL_DISCOUNT_LINE_FG))						as MANUAL_DISCOUNT_GROSS_VAL
		,SUM(abs( dle.discount_val*IS_MANUAL_DISCOUNT_LINE_FG/(1+dle.tax_pct/100) )) as MANUAL_DISCOUNT_NET_VAL

	FROM discount_lines_eval dle
	GROUP BY
		dle.RETAIL_EVENT_SID
)
SELECT
	de.CASH_REGISTER_EVENT_SID
	,de.CASH_REGISTER_EVENT_NR
	,de.COUNTRY_ORG_CD
	,de.STORE_SID
	,de.BUS_DT
	,de.EVENT_END_HR
	,de.CUST_SID
	,de.CUST_IDENT_TYPE_CD
	,de.CASHIER_NR
	,de.CASH_REGISTER_NR
	,de.CASH_REGISTER_TYPE_CD

	,de.DISCOUNT_LINE_CNT
	,de.DISCOUNTED_LINES_CNT
	,de.DISCOUNT_NET_VAL
	,de.DISCOUNT_GROSS_VAL

	,de.MANUAL_DISCOUNT_LINE_CNT
	,de.MANUAL_DISCOUNTED_LINES_CNT
	,de.MANUAL_DISCOUNT_NET_VAL
	,de.MANUAL_DISCOUNT_GROSS_VAL

	,IF(de.MANUAL_DISCOUNTED_LINES_CNT > 0, 1, 0) as HAS_MANUAL_DISCOUNT_FG

	,CASE
			WHEN p_mdl.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
				and de.MANUAL_DISCOUNTED_LINES_CNT >= p_mdl.PARAM_VAL_QTY THEN 1
			ELSE 0
		END as HAS_MANY_DISCOUNTED_LINES_FG

	,CASE
			WHEN p_mdv.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
				and de.MANUAL_DISCOUNT_GROSS_VAL >= p_mdv.PARAM_VAL_QTY THEN 1
			ELSE 0
		END as HAS_HIGH_VALUE_DISCOUNT_FG
FROM discounts_eval de

	left join materialize_param_view p_mdl -- parameter "minimum discounted lines" (Anzahl Bons mit >=X rabattierten Artikeln pro Bon)
				on p_mdl.COUNTRY_ORG_CD = de.COUNTRY_ORG_CD
				and p_mdl.SCENARIO_ID = 54
				and p_mdl.PARAM_ID = 131

	left join materialize_param_view p_mdv -- parameter "minimum discount value" (Anzahl Bons mit Rabattwert >=X LW pro Bon)
				on p_mdv.COUNTRY_ORG_CD = de.COUNTRY_ORG_CD
				and p_mdv.SCENARIO_ID = 55
				and p_mdv.PARAM_ID = 132
;



-- 	2.2
CREATE OR REPLACE TEMP TABLE T_TMP_STORNO_SCENARIOS
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- ) 
AS
WITH
-- for every cancelled line we will produce a flag "is_prod_important_fg" that will be reused in many other columns
-- some poducts are NOT important for cancelled lines (such as Bakery/Fruits/Vegetables/Flowers) - the other products are "important"
-- "important" products are relevant for all "storno" scenarios, while "not important" products need to be counted only in one scenario
important_prod_flag as
(
	SELECT
		re.retail_event_sid 					AS cash_register_event_sid
		, re.cash_register_event_nr
		, re.country_org_cd
		, re.store_sid
		, re.bus_dt
		, EXTRACT(HOUR FROM re.EVENT_END_TMSP)				AS EVENT_END_HR
		, re.CUST_SID
		, re.CUST_IDENT_TYPE_CD
		, re.cashier_nr
		, re.CASH_REGISTER_NR
		, re.CASH_REGISTER_TYPE_CD

		, prl.retail_line_gross_val
		, prl.retail_line_gross_val - prl.retail_line_vat_val 	as cancelled_net_val
		, CASE
				WHEN p.int_item_grp_nr is not NULL
					and p.int_item_grp_nr not in ('10', '20') -- exclude Fruit/Vegetables and Flowers

					and p.sub_item_grp_nr is not NULL
					and p.sub_item_grp_nr != '74' -- exclude bakery
				THEN 1
				ELSE 0
			END 												as is_prod_important_fg

	FROM T_TMP_RETAIL_EVENT re
		INNER JOIN T_TMP_PRODUCT_RETAIL_LINE prl
				ON re.RETAIL_EVENT_SID = prl.RETAIL_EVENT_SID

		INNER JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_SALES_VARIANT` p
				ON prl.prod_variant_sid = p.sales_variant_sid
				AND p.dwh_valid_fg = TRUE

	WHERE 1=1
		and re.RETAIL_EVENT_TYPE_CD = 'S'
		and prl.CANCEL_LINE_SEQ IS NOT NULL
		and re.TURNOVER_RELEVANT_FG = TRUE -- this eliminates cancelled (aborted) and suspended receipts too
)
SELECT
	ipf.CASH_REGISTER_EVENT_SID
	, any_value(ipf.cash_register_event_nr) 		AS cash_register_event_nr
	, any_value(ipf.country_org_cd) 				AS country_org_cd
    , any_value(ipf.store_sid) 						AS store_sid
    , any_value(ipf.bus_dt) 						AS bus_dt
	, any_value(ipf.EVENT_END_HR)					AS EVENT_END_HR
	, any_value(ipf.CUST_SID)						as CUST_SID
	, any_value(ipf.CUST_IDENT_TYPE_CD)				as CUST_IDENT_TYPE_CD
    , any_value(ipf.cashier_nr) 					AS cashier_nr
	, any_value(ipf.CASH_REGISTER_NR)				as CASH_REGISTER_NR
	, any_value(ipf.CASH_REGISTER_TYPE_CD)			as CASH_REGISTER_TYPE_CD

    , count(*) 										AS total_cancelled_line_cnt
    , SUM(ipf.cancelled_net_val) 					AS total_cancelled_net_val
	, SUM(ipf.retail_line_gross_val)				AS total_cancelled_gross_val

    , SUM(is_prod_important_fg) 								AS important_prod_cancelled_line_cnt
    , SUM(is_prod_important_fg * ipf.cancelled_net_val) 		AS important_prod_cancelled_net_val
	, SUM(is_prod_important_fg * ipf.retail_line_gross_val )	AS important_prod_cancelled_gross_val


FROM important_prod_flag ipf
GROUP BY
    ipf.cash_register_event_sid
;




-- 	2.3
CREATE OR REPLACE TEMP TABLE T_TMP_PRICE_CHECK_SCENARIOS 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- )
 AS
WITH
materialize_param_view as
(
	SELECT *
	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE`
	WHERE scenario_id in (
			47	-- "Anzahl Preisanzeigen mit Non-Food Artikeln >= X LW"
			,50 -- "Anzahl Vorgänge > X Preisanzeigen in Folge"
			,52	-- "Anzahl Preisanzeigen direkt vor Kleinstbon"
		)
)
,all_events AS
(
	SELECT
		RETAIL_EVENT_SID 				AS CASH_REGISTER_EVENT_SID
		, CASH_REGISTER_EVENT_NR
		, COUNTRY_ORG_CD
		, STORE_SID
		, BUS_DT
		, EVENT_END_TMSP 				AS EVENT_TMSP
		, RETAIL_EVENT_SCENARIO_ID 		AS CASH_REGISTER_EVENT_TYPE_CD
		, CASH_REGISTER_SID
		, CASH_REGISTER_TYPE_CD
		, CASH_REGISTER_NR
		, CASHIER_NR
		, NULL as PROD_VARIANT_SID

		, TXN_GROSS_VAL

		, SALES_COMPANY_SID
		, STORE_SELECTED_FG
		, IS_DIRECTLY_ORDERED
	FROM T_TMP_RETAIL_EVENT
	UNION ALL
	SELECT
		TECH_CASH_REGISTER_EVENT_SID 		AS CASH_REGISTER_EVENT_SID
		, CASH_REGISTER_EVENT_NR
		, COUNTRY_ORG_CD
		, STORE_SID
		, BUS_DT
		, EVENT_TMSP
		, CAST(TECH_CASH_REGISTER_EVENT_TYPE_CD AS BIGNUMERIC ) 	AS CASH_REGISTER_EVENT_TYPE_CD
		, CASH_REGISTER_SID
		, CASH_REGISTER_TYPE_CD
		, CASH_REGISTER_NR
		, CASHIER_NR
		, NULL as PROD_VARIANT_SID

		, 0 		AS TXN_GROSS_VAL

		, SALES_COMPANY_SID
		, STORE_SELECTED_FG
		, IS_DIRECTLY_ORDERED
	FROM T_TMP_TECHNICAL_CASH_REGISTER_EVENT
	UNION ALL
	SELECT
		PRICE_INFO_EVENT_SID		AS CASH_REGISTER_EVENT_SID
		, CASH_REGISTER_EVENT_NR
		, COUNTRY_ORG_CD
		, STORE_SID
		, BUS_DT
		, EVENT_TMSP
		, 480 						AS CASH_REGISTER_EVENT_TYPE_CD
		, CASH_REGISTER_SID
		, CASH_REGISTER_TYPE_CD
		, CASH_REGISTER_NR
		, CASHIER_NR
		, PROD_VARIANT_SID

		, PROD_PRICE 		AS TXN_GROSS_VAL

		, SALES_COMPANY_SID
		, STORE_SELECTED_FG
		, IS_DIRECTLY_ORDERED
	FROM T_TMP_PRICE_INFORMATION_EVENT
)
,all_events_with_change_flag as
(

	SELECT
		ae.*
		, CASE
				WHEN cash_register_event_type_cd <> LAG(cash_register_event_type_cd) OVER(PARTITION BY bus_dt, cash_register_sid ORDER BY cash_register_event_nr) THEN 1
				ELSE 0
			END AS event_type_change_fg
		, ROW_NUMBER() OVER(PARTITION BY bus_dt, cash_register_sid ORDER BY event_tmsp, cash_register_event_nr) AS rnk
	FROM all_events ae
)
-- consecutive events in the same CASH_REGISTER_SID, of same type have the same GROUP_ID
,all_events_with_groups as
(
	SELECT
		ae1.*
		,SUM(event_type_change_fg) OVER(PARTITION BY cash_register_sid, bus_dt ORDER BY rnk ROWS UNBOUNDED PRECEDING) AS group_id
	FROM all_events_with_change_flag ae1
)
,small_sale_events as
(
	SELECT
		RETAIL_EVENT_SID
	FROM T_TMP_PRODUCT_RETAIL_LINE prl
		join materialize_param_view p_ssma -- parameter "small sale max amount"
				on p_ssma.COUNTRY_ORG_CD = prl.COUNTRY_ORG_CD
				and p_ssma.SCENARIO_ID = 52
				and p_ssma.PARAM_ID = 130
				and p_ssma.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
	WHERE 1=1
		and prl.TURNOVER_RELEVANT_FG = TRUE
	GROUP BY prl.RETAIL_EVENT_SID
	HAVING 1=1
		-- only one retail line
		AND SUM(IF(retail_event_line_scenario_id IN (101, 102, 120, 122, 201, 202, 220, 222), 1, 0)) = 1
		-- and 0 cancelled lines
		AND SUM(IF(cancel_line_seq IS NOT NULL AND retail_line_gross_val > 0, 1, 0)) = 0
		-- and amount of the receipt is below threshold
		AND SUM(IF(retail_event_line_scenario_id IN (101, 102, 120, 122, 201, 202, 220, 222), retail_line_gross_val, 0)) < any_value(p_ssma.PARAM_VAL_QTY) -- param has same value for all receips in given country
)
-- ,price_info_events_with_next_event as
-- (
--   SELECT * FROM (
--     SELECT
--       pie.CASH_REGISTER_EVENT_SID
--       , pie.CASH_REGISTER_EVENT_NR
--       , pie.COUNTRY_ORG_CD
--       , pie.STORE_SID
--       , pie.BUS_DT
--       , pie.EVENT_TMSP
--       , pie.CASH_REGISTER_TYPE_CD
--       , pie.CASH_REGISTER_NR
--       , pie.CASHIER_NR
--       , pie.TXN_GROSS_VAL
--       , pie.CASH_REGISTER_SID
--       , pie.PROD_VARIANT_SID

--       , pie.GROUP_ID
--       , pie.SALES_COMPANY_SID
--       , pie.STORE_SELECTED_FG
--       , pie.IS_DIRECTLY_ORDERED

--       , anpe.CASH_REGISTER_EVENT_SID 			AS NEXT_EVENT_SID
--       , anpe.CASH_REGISTER_EVENT_TYPE_CD 		AS NEXT_EVENT_TYPE_CD
--       , anpe.TXN_GROSS_VAL 					AS NEXT_TXN_GROSS_VAL,
--       ROW_NUMBER() OVER(PARTITION BY pie.CASH_REGISTER_EVENT_SID ORDER BY anpe.CASH_REGISTER_EVENT_NR) as rn
--     FROM all_events_with_groups pie -- we will take only PriceInfo events here (see the WHERE)

--       LEFT JOIN all_events anpe -- we need only non-PriceInfo events here. Also some types of technical events are excluded
--           on anpe.BUS_DT = pie.BUS_DT
--           AND anpe.CASH_REGISTER_SID = pie.CASH_REGISTER_SID
--           AND anpe.CASH_REGISTER_EVENT_TYPE_CD not in (480, 400, 405, 420, 425, 430)
--           AND anpe.CASH_REGISTER_EVENT_NR > pie.CASH_REGISTER_EVENT_NR

--     WHERE pie.CASH_REGISTER_EVENT_TYPE_CD = 480
--   ) WHERE rn = 1
-- ), events_with_flags as(
-- 	COUNT(*) OVER(PARTITION BY pie.BUS_DT, pie.CASH_REGISTER_SID, pie.GROUP_ID) as consecutive_pie_in_group_cnt
-- 	, row_number() over (partition by pie.BUS_DT, pie.CASH_REGISTER_SID, pie.GROUP_ID order by pie.CASH_REGISTER_EVENT_NR asc) as rn_in_group


-- 	FROM price_info_events_with_next_event pie
-- 	left join CORE_DIM.T_DIM_SALES_VARIANT pv
-- 		on pv.SALES_VARIANT_SID = pie.PROD_VARIANT_SID
-- 		and pv.DWH_VALID_FG = TRUE

-- 	left join materialize_param_view p_nfama -- parameter "non-food article min amount"
-- 				on p_nfama.COUNTRY_ORG_CD = pie.COUNTRY_ORG_CD
-- 				and p_nfama.SCENARIO_ID = 47
-- 				and p_nfama.PARAM_ID = 129

-- 	left join materialize_param_view p_cpc -- parameter "consecutive price checks"
-- 				on p_cpc.COUNTRY_ORG_CD = pie.COUNTRY_ORG_CD
-- 				and p_cpc.SCENARIO_ID = 50
-- 				and p_cpc.PARAM_ID = 128

-- 	left join small_sale_events sse
-- 		on sse.RETAIL_EVENT_SID = pie.NEXT_EVENT_SID
-- )
-- SELECT
-- 	pie.CASH_REGISTER_EVENT_SID
-- 	, pie.CASH_REGISTER_EVENT_NR
-- 	, pie.COUNTRY_ORG_CD
-- 	, pie.STORE_SID
-- 	, pie.BUS_DT
-- 	, EXTRACT(HOUR FROM pie.EVENT_TMSP)				AS EVENT_END_HR
-- 	, CAST(NULL AS INT64) 	AS CUST_SID
-- 	, CAST(NULL AS STRING)		AS CUST_IDENT_TYPE_CD
-- 	, pie.CASHIER_NR
-- 	, pie.CASH_REGISTER_NR
-- 	, pie.CASH_REGISTER_TYPE_CD
-- 	, pie.SALES_COMPANY_SID
-- 	, pie.STORE_SELECTED_FG
-- 	, pie.TXN_GROSS_VAL

-- 	, COUNT(*) OVER(PARTITION BY pie.BUS_DT, pie.CASH_REGISTER_SID, pie.GROUP_ID) as consecutive_pie_in_group_cnt
-- 	, row_number() over (partition by pie.BUS_DT, pie.CASH_REGISTER_SID, pie.GROUP_ID order by pie.CASH_REGISTER_EVENT_NR asc) as rn_in_group

-- 	-- for scenario 47
-- 	, CASE
-- 			WHEN p_nfama.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
-- 				and pie.TXN_GROSS_VAL >= p_nfama.PARAM_VAL_QTY
-- 				and SAFE_CAST(pv.INT_ITEM_GRP_NR AS INT64) = 70	THEN 1
-- 			ELSE 0
-- 		END 										as IS_NON_FOOD_FG

-- 	-- for scenario 48
-- 	, IF(SAFE_CAST(pv.SUB_ITEM_GRP_NR AS INT64) = 80, 1, 0)			as IS_TOBACCO_FG

-- 	-- for scenario 49
-- 	, IF(SAFE_CAST(pv.SUB_ITEM_GRP_NR AS INT64) in (60,61,63), 1, 0)	as IS_ALCOHOL_FG

-- 	-- for scenario 50
-- 	, CASE
-- 			WHEN p_cpc.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
-- 				-- many "price checks" in same group (meaning they are consecutive)
-- 				and consecutive_pie_in_group_cnt >= p_cpc.PARAM_VAL_QTY
-- 				-- we mark only one (the first) per group
-- 				and rn_in_group = 1
-- 				THEN 1
-- 			ELSE 0
-- 		END 										as IS_MULTI_PIE_FG

-- 	-- for scenario 51
-- 	, IF(pie.NEXT_EVENT_TYPE_CD = 410, 1, 0)		as IS_NEXT_LOGOFF_FG

-- 	-- for scenario 52
-- 	, IF(pie.NEXT_EVENT_TYPE_CD = 100 and sse.RETAIL_EVENT_SID is NOT NULL, 1, 0)	as IS_NEXT_SMALL_SALE_FG


-- FROM price_info_events_with_next_event pie
-- 	left join CORE_DIM.T_DIM_SALES_VARIANT pv
-- 		on pv.SALES_VARIANT_SID = pie.PROD_VARIANT_SID
-- 		and pv.DWH_VALID_FG = TRUE

-- 	left join materialize_param_view p_nfama -- parameter "non-food article min amount"
-- 				on p_nfama.COUNTRY_ORG_CD = pie.COUNTRY_ORG_CD
-- 				and p_nfama.SCENARIO_ID = 47
-- 				and p_nfama.PARAM_ID = 129

-- 	left join materialize_param_view p_cpc -- parameter "consecutive price checks"
-- 				on p_cpc.COUNTRY_ORG_CD = pie.COUNTRY_ORG_CD
-- 				and p_cpc.SCENARIO_ID = 50
-- 				and p_cpc.PARAM_ID = 128

-- 	left join small_sale_events sse
-- 		on sse.RETAIL_EVENT_SID = pie.NEXT_EVENT_SID
-- ;
,price_info_events_with_next_event AS (
  SELECT * FROM (
    SELECT
      pie.CASH_REGISTER_EVENT_SID,
      pie.CASH_REGISTER_EVENT_NR,
      pie.COUNTRY_ORG_CD,
      pie.STORE_SID,
      pie.BUS_DT,
      pie.EVENT_TMSP,
      pie.CASH_REGISTER_TYPE_CD,
      pie.CASH_REGISTER_NR,
      pie.CASHIER_NR,
      pie.TXN_GROSS_VAL,
      pie.CASH_REGISTER_SID,
      pie.PROD_VARIANT_SID,
      pie.GROUP_ID,
      pie.SALES_COMPANY_SID,
      pie.STORE_SELECTED_FG,
      pie.IS_DIRECTLY_ORDERED,
      anpe.CASH_REGISTER_EVENT_SID AS NEXT_EVENT_SID,
      anpe.CASH_REGISTER_EVENT_TYPE_CD AS NEXT_EVENT_TYPE_CD,
      anpe.TXN_GROSS_VAL AS NEXT_TXN_GROSS_VAL,
      ROW_NUMBER() OVER (PARTITION BY pie.CASH_REGISTER_EVENT_SID ORDER BY anpe.CASH_REGISTER_EVENT_NR) AS rn
    FROM all_events_with_groups pie  -- we will take only PriceInfo events here (see the WHERE)

    LEFT JOIN all_events anpe -- we need only non-PriceInfo events here. Also some types of technical events are excluded
      ON anpe.BUS_DT = pie.BUS_DT
      AND anpe.CASH_REGISTER_SID = pie.CASH_REGISTER_SID
      AND anpe.CASH_REGISTER_EVENT_TYPE_CD NOT IN (480, 400, 405, 420, 425, 430)
      AND anpe.CASH_REGISTER_EVENT_NR > pie.CASH_REGISTER_EVENT_NR
    WHERE pie.CASH_REGISTER_EVENT_TYPE_CD = 480
  )
  WHERE rn = 1
),

pie_with_counts AS (
  SELECT
      pie.CASH_REGISTER_EVENT_SID,
      pie.CASH_REGISTER_EVENT_NR,
      pie.COUNTRY_ORG_CD,
      pie.STORE_SID,
      pie.BUS_DT,
      pie.EVENT_TMSP,
      pie.CASH_REGISTER_TYPE_CD,
      pie.CASH_REGISTER_NR,
      pie.CASHIER_NR,
      pie.TXN_GROSS_VAL,
      pie.CASH_REGISTER_SID,
      pie.PROD_VARIANT_SID,
      pie.GROUP_ID,
      pie.SALES_COMPANY_SID,
      pie.STORE_SELECTED_FG,
      pie.IS_DIRECTLY_ORDERED,
      pie.NEXT_EVENT_SID,
      pie.NEXT_EVENT_TYPE_CD,
      pie.NEXT_TXN_GROSS_VAL,
    COUNT(*) OVER (PARTITION BY pie.BUS_DT, pie.CASH_REGISTER_SID, pie.GROUP_ID) AS consecutive_pie_in_group_cnt,
    ROW_NUMBER() OVER (PARTITION BY pie.BUS_DT, pie.CASH_REGISTER_SID, pie.GROUP_ID ORDER BY pie.CASH_REGISTER_EVENT_NR ASC) AS rn_in_group
  FROM price_info_events_with_next_event pie
)

SELECT
  pie.CASH_REGISTER_EVENT_SID,
  pie.CASH_REGISTER_EVENT_NR,
  pie.COUNTRY_ORG_CD,
  pie.STORE_SID,
  pie.BUS_DT,
  EXTRACT(HOUR FROM pie.EVENT_TMSP) AS EVENT_END_HR,
  CAST(NULL AS INT64) AS CUST_SID,
  CAST(NULL AS STRING) AS CUST_IDENT_TYPE_CD,
  pie.CASHIER_NR,
  pie.CASH_REGISTER_NR,
  pie.CASH_REGISTER_TYPE_CD,
  pie.SALES_COMPANY_SID,
  pie.STORE_SELECTED_FG,
  pie.TXN_GROSS_VAL,

  pie.consecutive_pie_in_group_cnt,
  pie.rn_in_group,

  -- scenario 47: Non-food flag
  CASE
    WHEN p_nfama.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
      AND pie.TXN_GROSS_VAL >= p_nfama.PARAM_VAL_QTY
      AND SAFE_CAST(pv.INT_ITEM_GRP_NR AS INT64) = 70 THEN 1
    ELSE 0
  END AS IS_NON_FOOD_FG,

  -- scenario 48: Tobacco flag
  IF(SAFE_CAST(pv.SUB_ITEM_GRP_NR AS INT64) = 80, 1, 0) AS IS_TOBACCO_FG,

  -- scenario 49: Alcohol flag
  IF(SAFE_CAST(pv.SUB_ITEM_GRP_NR AS INT64) IN (60,61,63), 1, 0) AS IS_ALCOHOL_FG,

  -- scenario 50: Multiple PIE flag
  CASE
    WHEN p_cpc.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
      AND pie.consecutive_pie_in_group_cnt >= p_cpc.PARAM_VAL_QTY
      AND pie.rn_in_group = 1 THEN 1
    ELSE 0
  END AS IS_MULTI_PIE_FG,

  -- scenario 51: Next event is logoff
  IF(pie.NEXT_EVENT_TYPE_CD = 410, 1, 0) AS IS_NEXT_LOGOFF_FG,

  -- scenario 52: Next event is small sale
  IF(pie.NEXT_EVENT_TYPE_CD = 100 AND sse.RETAIL_EVENT_SID IS NOT NULL, 1, 0) AS IS_NEXT_SMALL_SALE_FG

FROM pie_with_counts pie
LEFT JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_SALES_VARIANT` pv
  ON pv.SALES_VARIANT_SID = pie.PROD_VARIANT_SID
  AND pv.DWH_VALID_FG = TRUE

LEFT JOIN materialize_param_view p_nfama
  ON p_nfama.COUNTRY_ORG_CD = pie.COUNTRY_ORG_CD
  AND p_nfama.SCENARIO_ID = 47
  AND p_nfama.PARAM_ID = 129

LEFT JOIN materialize_param_view p_cpc
  ON p_cpc.COUNTRY_ORG_CD = pie.COUNTRY_ORG_CD
  AND p_cpc.SCENARIO_ID = 50
  AND p_cpc.PARAM_ID = 128

LEFT JOIN small_sale_events sse
  ON sse.RETAIL_EVENT_SID = pie.NEXT_EVENT_SID
;







-- 	2.4
CREATE OR REPLACE TEMP TABLE T_TMP_SUSPEND_SCENARIOS 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- ) 
AS
-- Sales events that COULD be the events completing the suspended receipts
WITH cont_sales_event as
(
	SELECT
        DISTINCT -- incorrect data sometimes exists and 1 suspended receipt is resumed with two different receipts
	    c_re.SUSP_RETAIL_EVENT_SID
	FROM T_TMP_RETAIL_EVENT c_re

	WHERE 1=1
		and c_re.SUSP_RETAIL_EVENT_SID is not null
		and c_re.RETAIL_EVENT_TYPE_CD = 'S'
		--Removed both conditions. Doesn't matter for continuation receipt if it's a normal sales, cancellation or another suspended receipt - any continuation for a suspended receipt means that this suspended receipt is resolved
		--and c_re.SUSPEND_FG = FALSE
		--and c_re.CANCEL_FG = FALSE
)
SELECT
	re.RETAIL_EVENT_SID 					as CASH_REGISTER_EVENT_SID

	,re.CASH_REGISTER_EVENT_NR
	,re.COUNTRY_ORG_CD
	,re.STORE_SID
	,re.BUS_DT
	,EXTRACT(HOUR FROM re.EVENT_END_TMSP)				as EVENT_END_HR
	,re.CUST_SID
	,re.CUST_IDENT_TYPE_CD
	,re.CASHIER_NR
	,re.CASH_REGISTER_NR
	,re.CASH_REGISTER_TYPE_CD

	,IF(cse.SUSP_RETAIL_EVENT_SID IS NULL, 0, 1)   as IS_RECEIPT_RESOLVED_FG

	,1										as SUSPENDED_CNT
	,ABS(re.TXN_NET_VAL)					as SUSPENDED_NET_VAL -- SUSPENDED_UNRESOLVED_NET_VAL

FROM T_TMP_RETAIL_EVENT re
	left join cont_sales_event cse
			on cse.SUSP_RETAIL_EVENT_SID = re.RETAIL_EVENT_SID
WHERE  1=1
	and re.RETAIL_EVENT_TYPE_CD = 'S'
	and re.SUSPEND_FG = TRUE  -- suspended
	and re.CANCEL_FG = FALSE  -- not cancelled (aborted)
;



-- 	2.5
CREATE OR REPLACE TEMP TABLE T_TMP_ABORT_SCENARIOS 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- ) 
AS
WITH
materialize_param_view AS
(
	SELECT *
	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE`
	WHERE scenario_id = 32
)

SELECT
	re.RETAIL_EVENT_SID 					as CASH_REGISTER_EVENT_SID

	,re.CASH_REGISTER_EVENT_NR
	,re.COUNTRY_ORG_CD
	,re.STORE_SID
	,re.BUS_DT
	,EXTRACT(HOUR FROM re.EVENT_END_TMSP)				as EVENT_END_HR
	,re.CUST_SID
	,re.CUST_IDENT_TYPE_CD
	,re.CASHIER_NR
	,re.CASH_REGISTER_NR
	,re.CASH_REGISTER_TYPE_CD

	,1										as CASH_REGISTER_ABORT_CNT
	,ABS(re.TXN_NET_VAL)					as ABORT_NET_VAL

	--Calculating if the gross value satisfies the threshold as flag
	--Receipts for Gesamtwert Bonabbruch scenario have to satisfy the threshold but for Gesamtanzahl Bonabbruch all receipts are qualified
	,IF(re.TXN_GROSS_VAL >= mpv.PARAM_VAL_QTY, 1, 0) as IS_VALUE_ABOVE_THRESHOLD_FG

FROM T_TMP_RETAIL_EVENT re
	INNER JOIN materialize_param_view mpv
			ON re.country_org_cd = mpv.country_org_cd
			AND mpv.param_id = 97

WHERE 1=1
	AND re.RETAIL_EVENT_TYPE_CD = 'S'
	AND re.CANCEL_FG = TRUE  -- Aborted
	-- aborted receipts without any retail lines are not correct data and not relevant for the scenario
	and EXISTS
	(
		SELECT 1
		FROM T_TMP_PRODUCT_RETAIL_LINE prl
		WHERE prl.RETAIL_EVENT_SID = re.RETAIL_EVENT_SID
	)

;





-- 	2.6
CREATE OR REPLACE TEMP TABLE T_TMP_RETURN_SCENARIOS 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- ) 
AS
WITH
orig_re as
(
    SELECT
        orig_re.RETAIL_EVENT_SID
        , orig_re.BUS_DT
		, orig_re.STORE_SID
        , orig_ce.CASHIER_NR

    FROM `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` orig_re
        left join `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` orig_ce
				ON orig_ce.cashier_hash = orig_re.cashier_hash
    WHERE orig_re.COUNTRY_ORG_CD in (SELECT DISTINCT COUNTRY_ORG_CD FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED`)
        and orig_re.BUS_DT >= DATE_SUB(SV_MIN_DT, INTERVAL 365 DAY) -- we assume there is no way an item is returned more than a year after purchase
)
, agg_return_lines as
(
    SELECT
        tprl.retail_event_sid

		, COUNT(*) AS return_line_cnt -- includes return deposit lines (type RD)
		, SUM(IF(tprl.prod_entry_method_cd IN ('SC'), 1, 0)) AS return_scanned_line_cnt
		, SUM(IF(tprl.prod_entry_method_cd IN ('KE'), 1, 0)) AS return_manual_no_dv_line_cnt
		, SUM(IF(tprl.prod_entry_method_cd IN ('DV'), 1, 0)) AS return_manual_dv_line_cnt

		, SUM(IF(tprl.prod_entry_method_cd IN ('KE'), 1, 0)) + SUM(IF(tprl.prod_entry_method_cd IN ('DV'), 1, 0)) AS return_manual_line_cnt
		, SUM(IF(orig_re.retail_event_sid is NULL and prod_retail_line_type_cd = 'R', 1, 0)) AS return_no_orig_line_cnt


		, SUM(IF(tprl.prod_entry_method_cd IN ('SC'), ABS(tprl.retail_line_gross_val - tprl.retail_line_vat_val), 0)) AS return_scanned_net_val
		, SUM(IF(tprl.prod_entry_method_cd IN ('KE'), ABS(tprl.retail_line_gross_val - tprl.retail_line_vat_val), 0)) AS return_manual_no_dv_net_val
		, SUM(IF(tprl.prod_entry_method_cd IN ('DV'), ABS(tprl.retail_line_gross_val - tprl.retail_line_vat_val), 0)) AS return_manual_dv_net_val

		, SUM(IF(tprl.prod_entry_method_cd IN ('KE'), ABS(tprl.retail_line_gross_val - tprl.retail_line_vat_val), 0)) + SUM(IF(tprl.prod_entry_method_cd IN ('DV'), ABS(tprl.retail_line_gross_val - tprl.retail_line_vat_val), 0)) AS return_manual_net_val

		, SUM(IF(orig_re.retail_event_sid is NULL and prod_retail_line_type_cd = 'R'
					, ABS(tprl.retail_line_gross_val - tprl.retail_line_vat_val)
					, 0
				)) AS return_no_orig_net_val

		, SUM(IF(tprl.prod_retail_line_type_cd = 'R'
					, COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty)
					, 0
				)) AS return_items_qty

	    -- for return events, lines of type R have reference to original event, but lines of type 'RD' does not have it, and ORIG_ values will be NULL
        -- so we must apply MAX to make sure we get the real values of the original event
        , MAX(orig_re.BUS_DT) 				as O_BUS_DT
		, MAX(orig_re.STORE_SID) 			as O_STORE_SID
        , MAX(orig_re.CASHIER_NR)			as O_CASHIER_NR
    FROM T_TMP_PRODUCT_RETAIL_LINE tprl
        left join orig_re
                on orig_re.RETAIL_EVENT_SID = tprl.orig_sales_event_sid
	--Exclude cancellation lines
	WHERE
		tprl.cancel_line_seq IS NULL
    GROUP BY
        tprl.retail_event_sid
)
SELECT
	re.RETAIL_EVENT_SID as cash_register_event_sid
	, re.cash_register_event_nr
	, re.country_org_cd
	, re.store_sid
	, re.bus_dt
	, extract(hour from re.event_end_tmsp) as event_end_hr
	, re.CUST_SID
	, re.CUST_IDENT_TYPE_CD
	, re.cashier_nr
	, re.CASH_REGISTER_NR
	, re.CASH_REGISTER_TYPE_CD
    , IF(re.cashier_nr = o_cashier_nr and re.STORE_SID = O_STORE_SID, 1, 0) 	as is_same_cashier_fg
    , IF(IF(re.cashier_nr = o_cashier_nr and re.STORE_SID = O_STORE_SID, 1, 0) = 1 and re.bus_dt = o_bus_dt , 1, 0) 				as is_same_cashier_day_fg

	, 1 AS cash_register_event_cnt

	, arl.return_line_cnt
	, arl.return_scanned_line_cnt
	, arl.return_manual_no_dv_line_cnt
	, arl.return_manual_dv_line_cnt
	, arl.return_manual_line_cnt
	, arl.return_no_orig_line_cnt

	, ABS(re.txn_net_val) AS return_net_val
	, arl.return_scanned_net_val
	, arl.return_manual_no_dv_net_val
	, arl.return_manual_dv_net_val
	, arl.return_manual_net_val
	, arl.return_no_orig_net_val

	, ABS(arl.return_items_qty) AS return_items_qty

FROM T_TMP_RETAIL_EVENT re
	INNER JOIN agg_return_lines arl
			ON re.retail_event_sid = arl.retail_event_sid
WHERE 1=1
	AND re.RETAIL_EVENT_TYPE_CD = 'R'
	AND re.TURNOVER_RELEVANT_FG = True
;





-- 	2.7
CREATE OR REPLACE TEMP TABLE T_TMP_SMALL_SALE_SCENARIOS 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- ) 
AS
WITH
materialize_param_view AS
(
	SELECT *
	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE`
	WHERE scenario_id = 25
)
SELECT
	re.retail_event_sid 					AS cash_register_event_sid
	, ANY_VALUE(re.cash_register_event_nr) 	AS cash_register_event_nr
	, ANY_VALUE(re.country_org_cd) 			AS country_org_cd
	, ANY_VALUE(re.store_sid) 				AS store_sid
	, ANY_VALUE(re.bus_dt) 					AS bus_dt
	, ANY_VALUE(EXTRACT(HOUR FROM re.event_end_tmsp)) 	AS event_end_hr
	, ANY_VALUE(re.cust_sid) 				AS CUST_SID
	, ANY_VALUE(re.cust_ident_type_cd) 		AS CUST_IDENT_TYPE_CD
	, ANY_VALUE(re.cashier_nr)				AS cashier_nr
	, ANY_VALUE(re.CASH_REGISTER_NR)		AS CASH_REGISTER_NR
	, ANY_VALUE(re.CASH_REGISTER_TYPE_CD)	AS CASH_REGISTER_TYPE_CD

	, 1 AS cash_register_event_cnt

	, COUNT(prl.retail_event_line_seq) 		AS small_sale_line_cnt		--small sale is, by definition, a sale where there is only one sales line with no deposits returned or cancelled lines, however there can be additional line for a deposit sold, e.g. one bottle of soda + deposit, and it's still qualified as a small sale but in fact it gives 2 actual receipt lines
	, ANY_VALUE(re.txn_net_val) 			AS small_sale_net_val

FROM T_TMP_RETAIL_EVENT re
	inner join T_TMP_PRODUCT_RETAIL_LINE prl
		on re.RETAIL_EVENT_SID = prl.RETAIL_EVENT_SID
	inner join materialize_param_view mpv
			ON re.country_org_cd = mpv.country_org_cd
			AND mpv.param_id = 77
WHERE 1=1
	and re.retail_event_type_cd = 'S'
	and re.txn_gross_val < mpv.param_val_qty			--receipt's total gross value higher than value in parameter - Kleinstbon qualification
	and re.TURNOVER_RELEVANT_FG = TRUE -- this eliminates cancelled (aborted) and suspended receipts too

GROUP BY
	re.retail_event_sid
HAVING
	SUM(IF(prl.prod_retail_line_type_cd = 'S', 1, 0)) = 1		--only one sales line in receipt
	AND SUM(IF(prl.prod_retail_line_type_cd = 'D', 1, 0)) = 0	--no deposit return lines in receipt
	AND SUM(CASE WHEN prl.cancel_line_seq IS NOT NULL AND prl.retail_line_gross_val > 0 THEN 1 ELSE 0 END) = 0 --no cancel lines in receipt
;






-- 	2.8
--Creating a temp table for all technical events
--This will be used as a source for classification table load (logon, logoff events) and as a base for the anchor CTE in cashier by store day load
CREATE OR REPLACE TEMP TABLE T_TMP_TECH_EVENTS 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- )
 AS
SELECT
	TECH_CASH_REGISTER_EVENT_SID 		as CASH_REGISTER_EVENT_SID

	,CASH_REGISTER_EVENT_NR
	,COUNTRY_ORG_CD
	,STORE_SID
	,BUS_DT
	,EXTRACT(HOUR FROM EVENT_TMSP)					as EVENT_END_HR
	,cast(NULL as INT64) 		as CUST_SID
	,cast(null as STRING)			as CUST_IDENT_TYPE_CD
	,CASHIER_NR
	,CASH_REGISTER_NR
	,CASH_REGISTER_TYPE_CD
	,SALES_COMPANY_SID
	,STORE_SELECTED_FG

	,1									as CASH_REGISTER_EVENT_CNT
	,0									as LOGON_LOGOFF_LINE_CNT
	,0									as LOGON_LOGOFF_NET_VAL
	,TECH_CASH_REGISTER_EVENT_TYPE_CD

FROM T_TMP_TECHNICAL_CASH_REGISTER_EVENT
;






-- 	2.9
CREATE OR REPLACE TEMP TABLE T_TMP_DEPOSIT_SCENARIOS 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- ) 
AS
SELECT
	re.retail_event_sid 					AS cash_register_event_sid
	, ANY_VALUE(re.cash_register_event_nr) 	AS cash_register_event_nr
	, ANY_VALUE(re.country_org_cd) 			AS country_org_cd
	, ANY_VALUE(re.store_sid) 				AS store_sid
	, ANY_VALUE(re.bus_dt) 					AS bus_dt
	, ANY_VALUE(EXTRACT(HOUR FROM re.event_end_tmsp)) 	AS event_end_hr
	, ANY_VALUE(re.cust_sid) 				AS CUST_SID
	, ANY_VALUE(re.cust_ident_type_cd) 		AS CUST_IDENT_TYPE_CD
	, ANY_VALUE(re.cashier_nr)				AS cashier_nr
	, ANY_VALUE(re.CASH_REGISTER_NR)		AS CASH_REGISTER_NR
	, ANY_VALUE(re.CASH_REGISTER_TYPE_CD)	AS CASH_REGISTER_TYPE_CD

	, 1 AS cash_register_event_cnt

	-- line counts
	, SUM(IF(prl.prod_retail_line_type_cd = 'SD', 1, 0)) AS sold_deposit_line_cnt
	, SUM(IF(prl.prod_retail_line_type_cd = 'D', 1, 0)) AS returned_deposit_line_cnt
	, SUM(CASE WHEN prl.prod_retail_line_type_cd IN ('D', 'SD') THEN 0 ELSE 1 END) AS non_deposit_lines_cnt
	, SUM(CASE WHEN prl.prod_retail_line_type_cd = 'D' AND prl.prod_entry_method_cd IN ('KE', 'DV') AND LENGTH(prl.prod_variant_input_nr) < 19 THEN 1 ELSE 0 END) AS deposit_return_manual_input_lines_cnt

	-- NET Amounts
	, SUM(IF(prl.prod_retail_line_type_cd = 'SD', prl.retail_line_gross_val - prl.retail_line_vat_val, 0)) AS deposit_sales_net_val
	, ABS(SUM(IF(prl.prod_retail_line_type_cd = 'D', prl.retail_line_gross_val - prl.retail_line_vat_val, 0))) AS deposit_return_net_val
	, ABS(SUM(CASE WHEN prl.prod_retail_line_type_cd = 'D' AND prl.prod_entry_method_cd IN ('KE', 'DV') AND LENGTH(prl.prod_variant_input_nr) < 19 THEN prl.retail_line_gross_val - prl.retail_line_vat_val ELSE 0 END)) AS deposit_return_manual_input_net_val

	-- GROSS Amounts
	, SUM(IF(prl.prod_retail_line_type_cd = 'SD', prl.retail_line_gross_val, 0)) AS deposit_sales_gross_val
	, ABS(SUM(IF(prl.prod_retail_line_type_cd = 'D', prl.retail_line_gross_val, 0))) AS deposit_return_gross_val
	, ABS(SUM(CASE WHEN prl.prod_retail_line_type_cd = 'D' AND prl.prod_entry_method_cd IN ('KE', 'DV') AND LENGTH(prl.prod_variant_input_nr) < 19 THEN prl.retail_line_gross_val ELSE 0 END)) AS deposit_return_manual_input_gross_val

FROM T_TMP_RETAIL_EVENT re
	join T_TMP_PRODUCT_RETAIL_LINE prl
		on re.RETAIL_EVENT_SID = prl.RETAIL_EVENT_SID
WHERE 1=1
	and re.retail_event_type_cd = 'S'
	and re.TURNOVER_RELEVANT_FG = TRUE -- this eliminates cancelled (aborted) and suspended receipts too
	and prl.TURNOVER_RELEVANT_FG = TRUE
GROUP BY
	re.RETAIL_EVENT_SID
HAVING
	returned_deposit_line_cnt + sold_deposit_line_cnt > 0
;



-- 	2.10
CREATE OR REPLACE TEMP TABLE T_TMP_LIDL_PLUS_SCENARIOS 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- ) 
AS
SELECT
	re.RETAIL_EVENT_SID 					as CASH_REGISTER_EVENT_SID

	, ANY_VALUE(re.cash_register_event_nr) 	AS cash_register_event_nr
	, ANY_VALUE(re.country_org_cd) 			AS country_org_cd
	, ANY_VALUE(re.store_sid) 				AS store_sid
	, ANY_VALUE(re.bus_dt) 					AS bus_dt
	, ANY_VALUE(EXTRACT(HOUR FROM re.event_end_tmsp))	AS event_end_hr
	, ANY_VALUE(re.cust_sid) 				AS CUST_SID
	, ANY_VALUE(re.cust_ident_type_cd) 		AS CUST_IDENT_TYPE_CD
	, ANY_VALUE(re.cashier_nr) 				AS cashier_nr
	, ANY_VALUE(re.CASH_REGISTER_NR) 		AS CASH_REGISTER_NR
	, ANY_VALUE(re.CASH_REGISTER_TYPE_CD)	AS CASH_REGISTER_TYPE_CD

	,1										as event_cnt
	,any_value(ABS(re.TXN_NET_VAL)) 		as event_net_val
	,count(*)								as event_line_cnt

FROM T_TMP_RETAIL_EVENT re
	join T_TMP_PRODUCT_RETAIL_LINE prl
			on re.RETAIL_EVENT_SID = prl.RETAIL_EVENT_SID

WHERE 1=1
	AND re.RETAIL_EVENT_TYPE_CD = 'S'
	AND re.TURNOVER_RELEVANT_FG = TRUE
	AND prl.PROD_RETAIL_LINE_TYPE_CD = 'S'
	and prl.TURNOVER_RELEVANT_FG = TRUE

	AND re.CUST_IDENT_TYPE_CD is not null -- cust identified him/herself somehow as lidl plus user (by using phone number, plastic card ... )
group by re.RETAIL_EVENT_SID
;




-- 	2.11
-- Creating a separate temporary table as this set will be used twice - in steps 2.12 and in 3.2
CREATE OR REPLACE TEMP TABLE T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- ) 
AS
WITH
--The granularity of statistics table has changed from store/cashier/day to store/cashier/day/hour.
--In such circumstances the technical events temp table cannot be treated as an anchor anymore - despite the fact that it has to be at least a pair of tech events daily for a cashier (1 log on and 1 log off) it may happen that these events can occur just twice per whole cashier shift, i.e. log on at 8:00 and log off at 16:00
--In that case all retail events that could be registered in between but in hours not being the ones coming from log on and log off, like 9:30, 12:13, 15:59 will not have their matching anchor records coming from tech events and thus will be discarded
--To avoid replacing left joins with full outer joins in the last query of this temp table which would make join conditions very extensive and less readible the anchor data set will be represented by distinctive combinations of store/cashier/day values from data of all types of events cross joined with generated numbers from 0 to 23 representing day hours
--As last step all store/cashier/day/hour combinations are filtered - if there is no data attached from all scenario CTEs to any of these combinations then they will be discarded as dummy

--Union of technical, price info and retail events - this is to prevent the situation when we are lacking some part of POS source data for some reason.
--It happened in the past that we missed some part of technical events data - when tech events CTE was the only anchor this caused other retail data to be discarded during statistics table load
--Now if the similar data issue appears again we will at least be able to load retail data, even without tech events being available in the source
store_date_cashier as
(
	SELECT
		store_sid
		, bus_dt
		, cashier_nr
		, sales_company_sid
		, store_selected_fg
	FROM
		T_TMP_TECH_EVENTS
	UNION DISTINCT
	SELECT
		store_sid
		, bus_dt
		, cashier_nr
		, sales_company_sid
		, store_selected_fg
	FROM
		T_TMP_PRICE_CHECK_SCENARIOS
	UNION DISTINCT
	SELECT
		store_sid
		, bus_dt
		, cashier_nr
		, sales_company_sid
		, store_selected_fg
	FROM
		T_TMP_RETAIL_EVENT
)
--working_hours set will be used as the anchor. It contains all store/cashier/day/hour combinations for the scope of the ordered data so all other scenario CTEs will be added with LEFT JOIN to this one. sales_company_sid and store_selected_fg added for further ranking purposes - both will not impact the anchor grain
,working_hours as
(
SELECT
    sdc.store_sid
    , sdc.bus_dt
    , sdc.cashier_nr
    , sdc.sales_company_sid
    , sdc.store_selected_fg
    , ROW_NUMBER() OVER (PARTITION BY sdc.store_sid, sdc.bus_dt, sdc.cashier_nr ORDER BY g) - 1 AS event_end_hr
FROM
    store_date_cashier sdc,
    --Cross join applied to distribute 0-23 numbers through all store/cashier/day combinations
	UNNEST(GENERATE_ARRAY(1, 24)) AS g
)
-- The "other" CTEs that will be joined with the "anchor"
-- from 2.8
,tech_events_agg as
(
	SELECT
		STORE_SID
		, BUS_DT
		, CASHIER_NR
		, EVENT_END_HR
		, ANY_VALUE(SALES_COMPANY_SID)								AS sales_company_sid
		, ANY_VALUE(STORE_SELECTED_FG)								AS store_selected_fg
		, COUNT(CASH_REGISTER_EVENT_SID)							AS tech_events_cnt
		, SUM(IF(cast(TECH_CASH_REGISTER_EVENT_TYPE_CD as BIGNUMERIC) = 415, 1, 0)) 	AS login_cnt
		, SUM(IF(cast(TECH_CASH_REGISTER_EVENT_TYPE_CD as BIGNUMERIC) = 410, 1, 0)) 	AS logoff_cnt
	FROM T_TMP_TECH_EVENTS
	--WHERE CASH_REGISTER_TYPE_CD = 'TIL'
	GROUP BY
		STORE_SID
		, BUS_DT
		, CASHIER_NR
		, EVENT_END_HR
)
-- CTE for all retail events split into two - sales_returns_header_agg and sales_returns_agg
-- First step: calculate sales, return and total net values from header information
,sales_returns_header_agg as
(
	SELECT
		re.retail_event_sid
		, re.retail_event_type_cd
		, re.store_sid
		, re.bus_dt
		, re.cashier_nr
		, EXTRACT(HOUR FROM re.event_end_tmsp) AS event_end_hr
		, SUM(CASE WHEN re.turnover_relevant_fg = True THEN re.txn_net_val ELSE 0 END) OVER(PARTITION BY re.store_sid, re.bus_dt, re.cashier_nr, EXTRACT(HOUR FROM re.event_end_tmsp)) AS retail_net_val
		, SUM(CASE WHEN re.turnover_relevant_fg = True and re.RETAIL_EVENT_TYPE_CD = 'S' THEN re.txn_net_val ELSE 0 END) OVER(PARTITION BY re.store_sid, re.bus_dt, re.cashier_nr, EXTRACT(HOUR FROM re.event_end_tmsp)) AS sales_net_val
		, SUM(CASE WHEN re.turnover_relevant_fg = True and re.RETAIL_EVENT_TYPE_CD = 'R' THEN re.txn_net_val ELSE 0 END) OVER(PARTITION BY re.store_sid, re.bus_dt, re.cashier_nr, EXTRACT(HOUR FROM re.event_end_tmsp)) AS return_net_val

	FROM T_TMP_RETAIL_EVENT re
	--WHERE re.CASH_REGISTER_TYPE_CD = 'TIL'

)
-- Second step: calculate event counts and event line counts with use of receipt lines information
, sales_returns_agg as
(
	SELECT
		srha.store_sid
		, srha.bus_dt
		, srha.cashier_nr
		, srha.event_end_hr

		, COUNT(distinct srha.RETAIL_EVENT_SID) 	AS RETAIL_EVENT_CNT
		, COUNT(prl.RETAIL_EVENT_LINE_SEQ) 		AS RETAIL_EVENT_LINE_CNT
		, ANY_VALUE(retail_net_val) 			AS RETAIL_NET_VAL

		, COUNT(distinct IF(srha.RETAIL_EVENT_TYPE_CD = 'S', srha.RETAIL_EVENT_SID, NULL)) 	AS sales_event_cnt
		, SUM(IF(srha.RETAIL_EVENT_TYPE_CD = 'S', 1, 0)) 									AS sales_event_line_cnt
		, ANY_VALUE(srha.sales_net_val) 														AS sales_net_val

		, COUNT(distinct IF(srha.RETAIL_EVENT_TYPE_CD = 'R', srha.retail_event_sid, NULL)) 	AS return_event_cnt
		, SUM(IF(srha.RETAIL_EVENT_TYPE_CD = 'R', 1, 0)) 									AS return_event_line_cnt
		, ANY_VALUE(srha.return_net_val) 														AS return_net_val

	FROM sales_returns_header_agg srha
		INNER JOIN T_TMP_PRODUCT_RETAIL_LINE prl
				ON srha.RETAIL_EVENT_SID = prl.RETAIL_EVENT_SID
	GROUP BY
		srha.store_sid
		, srha.bus_dt
		, srha.cashier_nr
		, srha.event_end_hr

)
,  outlier_days_calc AS (
  SELECT
    store_sid,
    bus_dt,
    cashier_nr,

    ABS(SUM(retail_net_val)) AS daily_retail_net_val,
    ABS(SUM(return_net_val)) AS daily_return_net_val,
    SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))) AS daily_return_percentage,

    -- Supporting attribute for ORDER BY clause in rankings in case of no returns were generated by cashier in the whole day
    -- In such situations when no returns are made, only the total turnover should be considered for ranking purposes but only as a secondary ORDER BY expression
    -- It means that if there ARE returns made by cashier then this attribute should not affect the primary ranking expression which is the return/retail percentage, hence the -1 assignment
    IF(SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))) = 0,
       ABS(SUM(retail_net_val)), -1) AS no_return_expr,

    -- When no returns are available the rule is: higher retail value means lesser return percentage for ranking. Hence the ascending ordering for no_return_expr in highest_rnk and descending ordering in lowest_rnk
    RANK() OVER (PARTITION BY store_sid, cashier_nr ORDER BY SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))) DESC NULLS LAST, IF(SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))) = 0,ABS(SUM(retail_net_val)), -1) ASC) AS highest_rnk,
    RANK() OVER (PARTITION BY store_sid, cashier_nr ORDER BY SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))) ASC NULLS LAST, IF(SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))) = 0, ABS(SUM(retail_net_val)), -1) DESC) AS lowest_rnk,
    CASE
      WHEN RANK() OVER (
        PARTITION BY store_sid, cashier_nr
        ORDER BY
          SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))) DESC NULLS LAST,
          IF(SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))) = 0,
             ABS(SUM(retail_net_val)), -1) ASC
      ) <= 2 THEN TRUE
      WHEN RANK() OVER (
        PARTITION BY store_sid, cashier_nr
        ORDER BY
          SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))) ASC NULLS LAST,
          IF(SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))) = 0,
             ABS(SUM(retail_net_val)), -1) DESC
      ) <= 2 THEN TRUE
      ELSE FALSE
    END AS is_outlier_day_return_fg

  FROM sales_returns_agg
  GROUP BY
    store_sid,
    bus_dt,
    cashier_nr,
    return_net_val 
  HAVING
        --Days with no retail and no returns made should be excluded from outlier ranking logic
    ABS(SUM(retail_net_val)) + ABS(SUM(return_net_val)) > 0
  QUALIFY
		--Cashier needs to have any return made within the timeframe to be assessed
    SUM(ABS(return_net_val)) OVER (PARTITION BY store_sid, cashier_nr) <> 0
)
-- from 2.1
, discount_scenarios_agg AS
(
	SELECT
		STORE_SID
		,BUS_DT
		,CASHIER_NR
		,EVENT_END_HR
		,sum(MANUAL_DISCOUNT_LINE_CNT) 			as DISCOUNT_LINE_CNT
		,sum(MANUAL_DISCOUNT_NET_VAL)			as DISCOUNT_NET_VAL
	FROM T_TMP_DISCOUNT_SCENARIOS
	WHERE (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		and HAS_MANUAL_DISCOUNT_FG = 1
	GROUP BY
		STORE_SID
		,BUS_DT
		,CASHIER_NR
		,EVENT_END_HR
)
-- from 2.2
,storno_scenarios_agg AS
(
	SELECT
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
		, SUM(total_cancelled_line_cnt)		AS cancelled_line_cnt
		, SUM(total_cancelled_net_val)			AS cancelled_net_val
		, SUM(total_cancelled_gross_val)		AS cancelled_gross_val
	FROM T_TMP_STORNO_SCENARIOS
	WHERE (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		-- take only events with cancellation of important products. If event has cancellations only of  Flowers/Bakery/Fruit/Veggies and no other product, then it is excluded
		-- but for included events, take all lines and amounts (event flowers/bakery/fruit/veggies)
		and IMPORTANT_PROD_CANCELLED_LINE_CNT > 0
	GROUP BY
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
)
-- from 2.3
,price_info_agg as
(
	SELECT
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
		, COUNT(*)							AS price_info_cnt
	FROM T_TMP_PRICE_CHECK_SCENARIOS
	WHERE CASH_REGISTER_TYPE_CD = 'TIL'
		OR CASH_REGISTER_TYPE_CD IS NULL
	GROUP BY
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
)
-- from 2.4
,suspend_receipt_scenarios_agg as
(
	SELECT
		store_sid
		,bus_dt
		,cashier_nr
		,event_end_hr
		,COUNT(*) 							as SUSPENDED_UNRESOLVED_CNT
		,sum(SUSPENDED_NET_VAL)				as SUSPENDED_UNRESOLVED_NET_VAL
	FROM T_TMP_SUSPEND_SCENARIOS
	WHERE IS_RECEIPT_RESOLVED_FG = 0
		and (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
	GROUP BY
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
)
-- from 2.5
,abort_scenarios_agg AS
(
	SELECT
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr

		--ABORT_CNT is for Gesamtanzahl Bonabbruch scenario - doesn't require the threshold filter
		, COUNT(*) AS ABORT_CNT

		--ABORT_NET_VAL is for Gesamtwert Bonabbruch scenario - this one requires the threshold filter
		, SUM(IF(IS_VALUE_ABOVE_THRESHOLD_FG = 1, ABORT_NET_VAL, 0)) AS ABORT_NET_VAL
	FROM T_TMP_ABORT_SCENARIOS
	WHERE CASH_REGISTER_TYPE_CD = 'TIL'
		OR CASH_REGISTER_TYPE_CD IS NULL
	GROUP BY
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
)
-- from 2.6
,return_scenarios_agg AS
(
	SELECT
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
		, COUNT(*) 										as RETURN_CNT
		, SUM(RETURN_NET_VAL)							as RETURN_NET_VAL
		, SUM(IF(RETURN_MANUAL_LINE_CNT = 0, 0, 1))	as RETURN_MANUAL_RECEIPT_CNT
		, SUM(RETURN_MANUAL_NET_VAL)					as RETURN_MANUAL_RECEIPT_NET_VAL
		, SUM(IF(RETURN_NO_ORIG_LINE_CNT = 0, 0, 1))	as RETURN_WITHOUT_RECEIPT_CNT
		, SUM(RETURN_NO_ORIG_NET_VAL)					as RETURN_WITHOUT_RECEIPT_NET_VAL
		, SUM(RETURN_ITEMS_QTY)							as RETURN_ITEMS_QTY
	FROM T_TMP_RETURN_SCENARIOS
	-- include self-checkout to make it identical to old system. For "returns" self-checkout is included there
	-- this is why the filter is commented
	--WHERE CASH_REGISTER_TYPE_CD = 'TIL'
	GROUP BY
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
)
-- from 2.7
,small_sale_scenarios_agg AS
(
	SELECT
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
		, COUNT(*) 							as SMALL_SALE_CNT
		, SUM(SMALL_SALE_NET_VAL)			as SMALL_SALE_NET_VAL
	FROM T_TMP_SMALL_SALE_SCENARIOS
	WHERE CASH_REGISTER_TYPE_CD = 'TIL'
		OR CASH_REGISTER_TYPE_CD IS NULL
	GROUP BY
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
)
-- from 2.9
,deposit_scenarios_agg AS
(
	SELECT
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
		, SUM(DEPOSIT_SALES_NET_VAL) 											as DEPOSIT_SALES_NET_VAL
		, SUM(DEPOSIT_RETURN_NET_VAL)											as DEPOSIT_RETURN_NET_VAL
		, SUM(DEPOSIT_RETURN_MANUAL_INPUT_NET_VAL)								as DEPOSIT_RETURN_MANUAL_INPUT_NET_VAL
		, SUM(DEPOSIT_RETURN_MANUAL_INPUT_GROSS_VAL)							as DEPOSIT_RETURN_MANUAL_INPUT_GROSS_VAL
		, SUM(IF(NON_DEPOSIT_LINES_CNT = 0, DEPOSIT_RETURN_NET_VAL, 0))		as DEPOSIT_ONLY_RETURN_NET_VAL
	FROM T_TMP_DEPOSIT_SCENARIOS
	-- including self-checkout intentionally. to make this identical to old world.
	-- This is why the filter is commented
	--WHERE CASH_REGISTER_TYPE_CD = 'TIL'
	GROUP BY
		store_sid
		, bus_dt
		, cashier_nr
		, event_end_hr
)
SELECT
	wh.STORE_SID
	,wh.BUS_DT
	,wh.CASHIER_NR
	,wh.EVENT_END_HR

	--pulling sales_company_sid, store_selected_fg and is_qualified_cashier flags for ranking purposes in step 2.12
	,wh.SALES_COMPANY_SID
	,wh.STORE_SELECTED_FG

	,COALESCE(sra.SALES_NET_VAL, 0) 								as SALES_NET_VAL
	,COALESCE(rsa.RETURN_NET_VAL, 0) 								as RETURN_NET_VAL

	--outlier_days_calc CTE was left joined - if the flag is null then it means that the cashier didn't make any return transactions during the timeframe or there was no retail and returns made during any specific day by a cashier
	--If it's set to True then the data for that store/cashier/day combination should be skipped in rankings and in further processing in a frontend mat view - return/retail percentage is a the outlier value
	--If it's set to False then the data can be included in rankings and in a frontend layer
	,odc.IS_OUTLIER_DAY_RETURN_FG

	,COALESCE(sra.RETAIL_EVENT_CNT, 0) + COALESCE(pia.PRICE_INFO_CNT, 0) + COALESCE(tea.TECH_EVENTS_CNT, 0) 		as EVENT_CNT

	-- tech and price_info events are always 1 line
	,COALESCE(sra.RETAIL_EVENT_LINE_CNT, 0) + COALESCE(pia.PRICE_INFO_CNT, 0) + COALESCE(tea.TECH_EVENTS_CNT, 0) 	as EVENT_LINE_CNT

	,COALESCE(rsa.RETURN_CNT, 0) 									as RETURN_CNT
	,COALESCE(ssa.cancelled_line_cnt, 0) 							as CANCELLED_LINE_CNT
	,COALESCE(ssa.cancelled_net_val, 0) 								as CANCELLED_NET_VAL
	,COALESCE(dsa.DISCOUNT_LINE_CNT, 0) 								as DISCOUNT_LINE_CNT
	,COALESCE(dsa.DISCOUNT_NET_VAL, 0) 								as DISCOUNT_NET_VAL
	,COALESCE(asa.ABORT_CNT, 0) 										as ABORT_CNT
	,COALESCE(asa.ABORT_NET_VAL, 0) 									as ABORT_NET_VAL
	,COALESCE(srsa.SUSPENDED_UNRESOLVED_CNT, 0) 						as SUSPENDED_UNRESOLVED_CNT
	,COALESCE(srsa.SUSPENDED_UNRESOLVED_NET_VAL, 0) 					as SUSPENDED_UNRESOLVED_NET_VAL
	,COALESCE(pia.PRICE_INFO_CNT, 0) 								as PRICE_INFO_CNT
	,COALESCE(rsa.RETURN_WITHOUT_RECEIPT_CNT, 0)						as RETURN_WITHOUT_RECEIPT_CNT
	,COALESCE(rsa.RETURN_WITHOUT_RECEIPT_NET_VAL, 0)					as RETURN_WITHOUT_RECEIPT_NET_VAL
	,COALESCE(desa.DEPOSIT_SALES_NET_VAL, 0)							as DEPOSIT_SALES_NET_VAL
	,COALESCE(desa.DEPOSIT_RETURN_NET_VAL, 0)						as DEPOSIT_RETURN_NET_VAL
	,COALESCE(desa.DEPOSIT_RETURN_MANUAL_INPUT_NET_VAL, 0)			as DEPOSIT_RETURN_MANUAL_INPUT_NET_VAL
	,COALESCE(desa.DEPOSIT_RETURN_MANUAL_INPUT_GROSS_VAL, 0)			as DEPOSIT_RETURN_MANUAL_INPUT_GROSS_VAL
	,COALESCE(desa.DEPOSIT_ONLY_RETURN_NET_VAL, 0)					as DEPOSIT_ONLY_RETURN_NET_VAL
	,COALESCE(sssa.SMALL_SALE_CNT, 0)								as SMALL_SALES_CNT
	,COALESCE(tea.LOGIN_CNT, 0) 										as LOGIN_CNT
	,COALESCE(tea.LOGOFF_CNT, 0) 									as LOGOFF_CNT

	--added these 3 columns to calculate few rankings properly
	,COALESCE(rsa.RETURN_MANUAL_RECEIPT_CNT, 0)						as RETURN_MANUAL_RECEIPT_CNT
	,COALESCE(rsa.RETURN_ITEMS_QTY, 0)								as RETURN_ITEMS_QTY
	,COALESCE(sra.RETAIL_NET_VAL, 0)									as RETAIL_NET_VAL


FROM working_hours wh
	left join tech_events_agg tea
			on tea.STORE_SID = wh.STORE_SID
			and tea.BUS_DT = wh.BUS_DT
			and tea.CASHIER_NR = wh.CASHIER_NR
			and tea.EVENT_END_HR = wh.EVENT_END_HR

	left join sales_returns_agg sra
			on sra.STORE_SID = wh.STORE_SID
			and sra.BUS_DT = wh.BUS_DT
			and sra.CASHIER_NR = wh.CASHIER_NR
			and sra.EVENT_END_HR = wh.EVENT_END_HR

	left join discount_scenarios_agg dsa
			on dsa.STORE_SID = wh.STORE_SID
			and dsa.BUS_DT = wh.BUS_DT
			and dsa.CASHIER_NR = wh.CASHIER_NR
			and dsa.EVENT_END_HR = wh.EVENT_END_HR

	left join storno_scenarios_agg ssa
			on ssa.STORE_SID = wh.STORE_SID
			and ssa.BUS_DT = wh.BUS_DT
			and ssa.CASHIER_NR = wh.CASHIER_NR
			and ssa.EVENT_END_HR = wh.EVENT_END_HR

	left join price_info_agg pia
			on pia.STORE_SID = wh.STORE_SID
			and pia.BUS_DT = wh.BUS_DT
			and pia.CASHIER_NR = wh.CASHIER_NR
			and pia.EVENT_END_HR = wh.EVENT_END_HR

	left join suspend_receipt_scenarios_agg srsa
			on srsa.STORE_SID = wh.STORE_SID
			and srsa.BUS_DT = wh.BUS_DT
			and srsa.CASHIER_NR = wh.CASHIER_NR
			and srsa.EVENT_END_HR = wh.EVENT_END_HR

	left join abort_scenarios_agg asa
			on asa.STORE_SID = wh.STORE_SID
			and asa.BUS_DT = wh.BUS_DT
			and asa.CASHIER_NR = wh.CASHIER_NR
			and asa.EVENT_END_HR = wh.EVENT_END_HR

	left join return_scenarios_agg rsa
			on rsa.STORE_SID = wh.STORE_SID
			and rsa.BUS_DT = wh.BUS_DT
			and rsa.CASHIER_NR = wh.CASHIER_NR
			and rsa.EVENT_END_HR = wh.EVENT_END_HR

	left join small_sale_scenarios_agg sssa
			on sssa.STORE_SID = wh.STORE_SID
			and sssa.BUS_DT = wh.BUS_DT
			and sssa.CASHIER_NR = wh.CASHIER_NR
			and sssa.EVENT_END_HR = wh.EVENT_END_HR

	left join deposit_scenarios_agg desa
			on desa.STORE_SID = wh.STORE_SID
			and desa.BUS_DT = wh.BUS_DT
			and desa.CASHIER_NR = wh.CASHIER_NR
			and desa.EVENT_END_HR = wh.EVENT_END_HR

	left join outlier_days_calc odc
			on odc.STORE_SID = wh.STORE_SID
			and odc.BUS_DT = wh.BUS_DT
			and odc.CASHIER_NR = wh.CASHIER_NR

--Filtering out store/cashier/day/hour combinations with no events assigned
--Checking store_sid attribute only - if it's null after joining then it means that there is no data for that scenario at all. Discard the whole combination only when ALL scenario store_sid attributes are null
WHERE
	tea.STORE_SID IS NOT NULL
	OR sra.STORE_SID IS NOT NULL
	OR dsa.STORE_SID IS NOT NULL
	OR ssa.STORE_SID IS NOT NULL
	OR pia.STORE_SID IS NOT NULL
	OR srsa.STORE_SID IS NOT NULL
	OR asa.STORE_SID IS NOT NULL
	OR rsa.STORE_SID IS NOT NULL
	OR sssa.STORE_SID IS NOT NULL
	OR desa.STORE_SID IS NOT NULL
;


--2.12
CREATE OR REPLACE TEMP TABLE T_TMP_CASHIER_RANKINGS_BY_WAREHOUSE 
-- OPTIONS ( 
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- ) 
AS
WITH
agg as
(
	SELECT
		stats.sales_company_sid
		, stats.store_sid
		, stats.cashier_nr

		, ANY_VALUE(stats.store_selected_fg) 		AS store_selected_fg

		-- cq.CASHIER_NR is either equal to stats.CASHIER_NR for all rows of the store/company or null for all rows of Store/company
		-- we put it in aggregate so we can use it in the select
		, IF(max(cq.CASHIER_NR) IS NULL, 0, 1) 	AS is_cashier_qualified_fg

		, SUM(stats.deposit_only_return_net_val) 											as deposit_only_return_net_val
		, SUM(stats.deposit_return_manual_input_gross_val)									as deposit_return_manual_input_gross_val
		, SAFE_DIVIDE(SUM(stats.deposit_return_net_val), SUM(stats.deposit_sales_net_val))			as deposit_return_sales_percentage
		, SAFE_DIVIDE(SUM(stats.login_cnt), COUNT(DISTINCT stats.bus_dt)) 							as login_avg_cnt
		, SUM(stats.small_sales_cnt) 														as small_sales_cnt
		, SUM(stats.return_cnt) 															as return_cnt
		, SUM(stats.return_manual_receipt_cnt) 												as return_manual_receipt_cnt
		, SAFE_DIVIDE(SUM(stats.return_net_val), SUM(stats.return_items_qty)) 						as return_avg_val

		--Exception for Geldrückgabenquote ranking - include the data in calculation only if it's not coming from outlier days
		, ABS(SAFE_DIVIDE(
			SUM(IF(stats.is_outlier_day_return_fg = False, stats.return_net_val, 0))
			, SUM(IF(stats.is_outlier_day_return_fg = False, stats.retail_net_val, 0))
			)) 																				as return_retail_percentage

		, SUM(stats.return_without_receipt_cnt) 											as return_without_receipt_cnt
		, SUM(stats.suspended_unresolved_cnt) 												as suspended_unresolved_cnt
		, SUM(stats.abort_net_val) 															as abort_val
		, SUM(stats.abort_cnt) 																as abort_cnt
		, SAFE_DIVIDE(SUM(stats.cancelled_line_cnt), SUM(stats.event_cnt)) 						as cancelled_line_cnt_percentage
		, SAFE_DIVIDE(SUM(stats.cancelled_net_val), SUM(stats.retail_net_val)) 					as cancelled_line_val_percentage
		, SUM(stats.price_info_cnt) 														as price_info_cnt
		, SUM(stats.discount_line_cnt) 														as discount_line_cnt
		, SAFE_DIVIDE(SUM(stats.discount_net_val), SUM(stats.retail_net_val)) 						as discount_line_val_percentage

	FROM
		T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS stats
			left join T_TMP_CASHIERS_QUALIFIED cq
					on stats.STORE_SID = cq.STORE_SID
					and stats.BUS_DT = cq.BUS_DT
					and stats.CASHIER_NR = cq.CASHIER_NR
	GROUP BY
		stats.sales_company_sid
		, stats.store_sid
		, stats.cashier_nr
)
SELECT
	sales_company_sid
	, store_sid
	, cashier_nr

	, store_selected_fg
	, is_cashier_qualified_fg

    , RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, deposit_only_return_net_val desc) 			AS rnk_deposit_only_return_val
    , RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, deposit_return_manual_input_gross_val desc) AS rnk_deposit_manual_input_val
    , RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, deposit_return_sales_percentage desc) 		AS rnk_deposit_return_sales_percentage
    , RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, login_avg_cnt desc) 						AS rnk_login_avg_cnt
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, small_sales_cnt desc) 						AS rnk_small_sales_cnt
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, return_cnt desc) 							AS rnk_return_cnt
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, return_manual_receipt_cnt desc) 			AS rnk_return_manual_receipt_cnt
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, return_avg_val desc) 						AS rnk_return_avg_val
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, return_retail_percentage desc) 				AS rnk_return_retail_percentage
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, return_without_receipt_cnt desc) 			AS rnk_return_without_receipt_cnt
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, suspended_unresolved_cnt desc) 				AS rnk_suspended_unresolved_cnt
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, abort_val desc) 							AS rnk_abort_val
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, abort_cnt desc) 							AS rnk_abort_cnt
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, cancelled_line_cnt_percentage desc) 		AS rnk_cancelled_line_cnt_percentage
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, cancelled_line_val_percentage desc) 		AS rnk_cancelled_line_val_percentage
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, price_info_cnt desc) 						AS rnk_price_info_cnt
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, discount_line_cnt desc) 					AS rnk_discount_line_cnt
	, RANK() OVER(PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg desc, discount_line_val_percentage desc) 			AS rnk_discount_line_val_percentage

FROM
	agg
;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Load Targets
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--3.0
--delete before insert to update receipts information in case it comes with changes for the same period

DELETE FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION` c
WHERE c.scenario_id IN (
    SELECT s.scenario_id
    FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO` s
    WHERE s.SCENARIO_TYPE_CD = 'MAN'
)
AND EXISTS (
    SELECT 1
    FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` q
    WHERE q.store_sid = c.store_sid
      AND q.bus_dt = c.bus_dt
);


DELETE FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_STATISTICS_BY_STORE_HOUR_CASHIER` c
WHERE EXISTS (
    SELECT 1
    FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` q
    WHERE q.store_sid = c.int_org_sid
      AND q.bus_dt = c.bus_dt
);


-- we want to delete the data for all cashiers and all scenarios for these stores
-- this is why STORE_SID as filter is enough
DELETE FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_RANKING_BY_FRAUD_SCENARIO` trg
WHERE trg.STORE_SID in (SELECT sq.STORE_SID FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq);


--	3.1
INSERT into `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION`
(
   CASH_REGISTER_EVENT_SID
   ,CASH_REGISTER_EVENT_NR
   ,SCENARIO_ID
   ,COUNTRY_ORG_CD
   ,STORE_SID
   ,BUS_DT
   ,EVENT_END_HR
   ,CUST_SID
   ,CUST_IDENT_TYPE_CD
   ,CASHIER_NR
   ,CASH_REGISTER_EVENT_CNT
   ,CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
   ,CASH_REGISTER_EVENT_AFFECTED_NET_VAL
   ,CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

   ,DWH_CREATED_TMSP
   ,DWH_UPDATED_TMSP
   ,DWH_LOAD_ID
   ,DWH_NODE_CD
)
WITH
enabled_scenarios AS
(
	SELECT
		DISTINCT
		scenario_id
		,country_org_cd
	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE`
	WHERE IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
)
,gather_all_kpis as
(
	-- Manual Discount Scenario (from 2.1) - Gesamtanzahl manueller Rabatt
	SELECT
		ds.CASH_REGISTER_EVENT_SID
		, cast(ds.CASH_REGISTER_EVENT_NR as bignumeric) as CASH_REGISTER_EVENT_NR
		, 38						as SCENARIO_ID
		, ds.COUNTRY_ORG_CD
		, ds.STORE_SID
		, ds.BUS_DT
		, CAST(ds.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ds.CUST_SID
		, ds.CUST_IDENT_TYPE_CD
		, ds.CASHIER_NR

		, 1 								as CASH_REGISTER_EVENT_CNT
		, ds.MANUAL_DISCOUNT_LINE_CNT 		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ds.MANUAL_DISCOUNT_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, ds.MANUAL_DISCOUNT_GROSS_VAL		as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_DISCOUNT_SCENARIOS ds
	WHERE 1=1
		AND (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 38)
		AND HAS_MANUAL_DISCOUNT_FG = 1

	UNION ALL

	-- Manual Discount Scenario (from 2.1) - Rabattquote (manuell)
	SELECT
		ds.CASH_REGISTER_EVENT_SID
		, cast(ds.CASH_REGISTER_EVENT_NR AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 39						as SCENARIO_ID
		, ds.COUNTRY_ORG_CD
		, ds.STORE_SID
		, ds.BUS_DT
		, CAST(ds.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ds.CUST_SID
		, ds.CUST_IDENT_TYPE_CD
		, ds.CASHIER_NR

		, 1 								as CASH_REGISTER_EVENT_CNT
		, ds.MANUAL_DISCOUNT_LINE_CNT 		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ds.MANUAL_DISCOUNT_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, ds.MANUAL_DISCOUNT_GROSS_VAL		as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_DISCOUNT_SCENARIOS ds
	WHERE 1=1
		AND (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 39)
		AND HAS_MANUAL_DISCOUNT_FG = 1

	UNION ALL

	-- Discount Scenario (from 2.1) - Rabattquote in %
	SELECT
		ds.CASH_REGISTER_EVENT_SID
		, CAST(ds.CASH_REGISTER_EVENT_NR AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 53						as SCENARIO_ID
		, ds.COUNTRY_ORG_CD
		, ds.STORE_SID
		, ds.BUS_DT
		, CAST(ds.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ds.CUST_SID
		, ds.CUST_IDENT_TYPE_CD
		, ds.CASHIER_NR

		, 1 						as CASH_REGISTER_EVENT_CNT
		, ds.DISCOUNT_LINE_CNT 		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ds.DISCOUNT_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, ds.DISCOUNT_GROSS_VAL		as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_DISCOUNT_SCENARIOS ds
	WHERE 1=1
		AND (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 53)
		AND HAS_MANUAL_DISCOUNT_FG = 1

	UNION ALL

	-- Discount Scenario (from 2.1) - Anzahl Bons mit >=X rabattierten Artikeln pro Bon
	SELECT
		ds.CASH_REGISTER_EVENT_SID
		, CAST(ds.CASH_REGISTER_EVENT_NR AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 54						as SCENARIO_ID
		, ds.COUNTRY_ORG_CD
		, ds.STORE_SID
		, ds.BUS_DT
		, CAST(ds.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ds.CUST_SID
		, ds.CUST_IDENT_TYPE_CD
		, ds.CASHIER_NR

		, 1 								as CASH_REGISTER_EVENT_CNT
		, ds.MANUAL_DISCOUNT_LINE_CNT 		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ds.MANUAL_DISCOUNT_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, ds.MANUAL_DISCOUNT_GROSS_VAL		as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_DISCOUNT_SCENARIOS ds
	WHERE 1=1
		AND (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 54)
		AND HAS_MANY_DISCOUNTED_LINES_FG = 1
		AND HAS_MANUAL_DISCOUNT_FG = 1

	UNION ALL

	-- Discount Scenario (from 2.1) - Anzahl Bons mit Rabattwert >=X pro Bon
	SELECT
		ds.CASH_REGISTER_EVENT_SID
		, CAST(ds.CASH_REGISTER_EVENT_NR AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 55						as SCENARIO_ID
		, ds.COUNTRY_ORG_CD
		, ds.STORE_SID
		, ds.BUS_DT
		, CAST(ds.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ds.CUST_SID
		, ds.CUST_IDENT_TYPE_CD
		, ds.CASHIER_NR

		, 1 								as CASH_REGISTER_EVENT_CNT
		, ds.MANUAL_DISCOUNT_LINE_CNT 		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ds.MANUAL_DISCOUNT_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, ds.MANUAL_DISCOUNT_GROSS_VAL		as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_DISCOUNT_SCENARIOS ds
	WHERE 1=1
		AND (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 55)
		AND HAS_HIGH_VALUE_DISCOUNT_FG = 1
		AND HAS_MANUAL_DISCOUNT_FG = 1

	UNION ALL

	-- Storno Scenarios (from 2.2) - Anzahl storni per 100 bons
	SELECT
		tss.CASH_REGISTER_EVENT_SID
		,CAST(tss.CASH_REGISTER_EVENT_NR AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		,34								as SCENARIO_ID
		,tss.COUNTRY_ORG_CD
		,tss.STORE_SID
		,tss.BUS_DT
		,CAST(tss.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		,tss.CUST_SID
		,tss.CUST_IDENT_TYPE_CD
		,tss.CASHIER_NR

		,1								as CASH_REGISTER_EVENT_CNT
		,tss.TOTAL_CANCELLED_LINE_CNT 	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		,tss.TOTAL_CANCELLED_NET_VAL 	as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		,NULL							as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
	FROM T_TMP_STORNO_SCENARIOS tss
	WHERE 1=1
		AND (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 34)
		-- take only events with cancellation of important products. If event has cancellations only of  Flowers/Bakery/Fruit/Veggies and no other product, then it is excluded
		-- but for included events, take all lines and amounts (event flowers/bakery/fruit/veggies)
		and IMPORTANT_PROD_CANCELLED_LINE_CNT > 0

	UNION ALL

	-- Storno Scenarios (from 2.2) - Stornoquote
	SELECT
		tss.CASH_REGISTER_EVENT_SID
		,CAST(tss.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		,35								as SCENARIO_ID
		,tss.COUNTRY_ORG_CD
		,tss.STORE_SID
		,tss.BUS_DT
		,CAST(tss.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		,tss.CUST_SID
		,tss.CUST_IDENT_TYPE_CD
		,tss.CASHIER_NR

		,1								as CASH_REGISTER_EVENT_CNT
		,tss.TOTAL_CANCELLED_LINE_CNT 	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		,tss.TOTAL_CANCELLED_NET_VAL 	as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		,NULL							as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
	FROM T_TMP_STORNO_SCENARIOS tss
	WHERE 1=1
		AND (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 35)
		-- take only events with cancellation of important products. If event has cancellations only of  Flowers/Bakery/Fruit/Veggies and no other product, then it is excluded
		-- but for included events, take all lines and amounts (event flowers/bakery/fruit/veggies)
		and IMPORTANT_PROD_CANCELLED_LINE_CNT > 0

	UNION ALL

	-- Price Check Scenarios (from 2.3) - Gesamtanzahl Preisanzeigen
	SELECT
		tpcs.cash_register_event_sid
		, CAST(tpcs.cash_register_event_nr  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 36 AS scenario_id
		, tpcs.country_org_cd
		, tpcs.store_sid
		, tpcs.bus_dt
		, CAST(tpcs.event_end_hr AS BIGNUMERIC ) AS EVENT_END_HR
		, tpcs.CUST_SID
        , tpcs.CUST_IDENT_TYPE_CD
		, tpcs.cashier_nr

		, 1	AS cash_register_event_cnt
		, 1 AS cash_register_event_affected_line_cnt
		, 0 AS cash_register_event_affected_net_val
		, tpcs.TXN_GROSS_VAL 	as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
	FROM
		T_TMP_PRICE_CHECK_SCENARIOS tpcs
	WHERE
		(CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 36)

	UNION ALL

	-- Price Check Scenarios (from 2.3) - "Anzahl Preisanzeigen mit Non-Food Artikeln >= X LW"
	SELECT
		tpcs.cash_register_event_sid
		, CAST(tpcs.cash_register_event_nr  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 47 AS scenario_id
		, tpcs.country_org_cd
		, tpcs.store_sid
		, tpcs.bus_dt
		, CAST(tpcs.event_end_hr AS BIGNUMERIC ) AS EVENT_END_HR
		, tpcs.CUST_SID
        , tpcs.CUST_IDENT_TYPE_CD
		, tpcs.cashier_nr

		, 1	AS cash_register_event_cnt
		, 1 AS cash_register_event_affected_line_cnt
		, 0 AS cash_register_event_affected_net_val
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
	FROM
		T_TMP_PRICE_CHECK_SCENARIOS tpcs
	WHERE
		(CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 47)
		AND IS_NON_FOOD_FG = 1

	UNION ALL

	-- Price Check Scenarios (from 2.3) - "Anzahl Preisanzeigen mit Tabakartikeln"
	SELECT
		tpcs.cash_register_event_sid
		, CAST(tpcs.cash_register_event_nr  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 48 AS scenario_id
		, tpcs.country_org_cd
		, tpcs.store_sid
		, tpcs.bus_dt
		, CAST(tpcs.event_end_hr AS BIGNUMERIC ) AS EVENT_END_HR
		, tpcs.CUST_SID
        , tpcs.CUST_IDENT_TYPE_CD
		, tpcs.cashier_nr

		, 1	AS cash_register_event_cnt
		, 1 AS cash_register_event_affected_line_cnt
		, 0 AS cash_register_event_affected_net_val
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
	FROM
		T_TMP_PRICE_CHECK_SCENARIOS tpcs
	WHERE
		(CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 48)
		AND IS_TOBACCO_FG = 1

	UNION ALL

	-- Price Check Scenarios (from 2.3) - "Anzahl Preisanzeigen mit Alkoholartikeln"
	SELECT
		tpcs.cash_register_event_sid
		, CAST(tpcs.cash_register_event_nr  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 49 AS scenario_id
		, tpcs.country_org_cd
		, tpcs.store_sid
		, tpcs.bus_dt
		, CAST(tpcs.event_end_hr AS BIGNUMERIC ) AS EVENT_END_HR
		, tpcs.CUST_SID
        , tpcs.CUST_IDENT_TYPE_CD
		, tpcs.cashier_nr

		, 1	AS cash_register_event_cnt
		, 1 AS cash_register_event_affected_line_cnt
		, 0 AS cash_register_event_affected_net_val
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
	FROM
		T_TMP_PRICE_CHECK_SCENARIOS tpcs
	WHERE
		(CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 49)
		AND IS_ALCOHOL_FG = 1

	UNION ALL

	-- Price Check Scenarios (from 2.3) - "Anzahl Vorgänge > X Preisanzeigen in Folge"
	SELECT
		tpcs.cash_register_event_sid
		, CAST(tpcs.cash_register_event_nr  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 50 AS scenario_id
		, tpcs.country_org_cd
		, tpcs.store_sid
		, tpcs.bus_dt
		, CAST(tpcs.event_end_hr AS BIGNUMERIC ) AS EVENT_END_HR
		, tpcs.CUST_SID
        , tpcs.CUST_IDENT_TYPE_CD
		, tpcs.cashier_nr

		, 1	AS cash_register_event_cnt
		, 1 AS cash_register_event_affected_line_cnt
		, 0 AS cash_register_event_affected_net_val
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
	FROM
		T_TMP_PRICE_CHECK_SCENARIOS tpcs
	WHERE
		(CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 50)
		AND IS_MULTI_PIE_FG = 1

	UNION ALL

	-- Price Check Scenarios (from 2.3) - "Anzahl Preisanzeigen direkt vor Abmeldung"
	SELECT
		tpcs.cash_register_event_sid
		, CAST(tpcs.cash_register_event_nr  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 51 AS scenario_id
		, tpcs.country_org_cd
		, tpcs.store_sid
		, tpcs.bus_dt
		, CAST(tpcs.event_end_hr AS BIGNUMERIC ) AS EVENT_END_HR
		, tpcs.CUST_SID
        , tpcs.CUST_IDENT_TYPE_CD
		, tpcs.cashier_nr

		, 1	AS cash_register_event_cnt
		, 1 AS cash_register_event_affected_line_cnt
		, 0 AS cash_register_event_affected_net_val
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
	FROM
		T_TMP_PRICE_CHECK_SCENARIOS tpcs
	WHERE
		(CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 51)
		AND IS_NEXT_LOGOFF_FG = 1

	UNION ALL

	-- Price Check Scenarios (from 2.3) - "Anzahl Preisanzeigen direkt vor Kleinstbon"
	SELECT
		tpcs.cash_register_event_sid
		, CAST(tpcs.cash_register_event_nr  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 52 AS scenario_id
		, tpcs.country_org_cd
		, tpcs.store_sid
		, tpcs.bus_dt
		, CAST(tpcs.event_end_hr AS BIGNUMERIC ) AS EVENT_END_HR
		, tpcs.CUST_SID
        , tpcs.CUST_IDENT_TYPE_CD
		, tpcs.cashier_nr

		, 1	AS cash_register_event_cnt
		, 1 AS cash_register_event_affected_line_cnt
		, 0 AS cash_register_event_affected_net_val
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL
	FROM
		T_TMP_PRICE_CHECK_SCENARIOS tpcs
	WHERE
		(CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 52)
		AND IS_NEXT_SMALL_SALE_FG = 1

	UNION ALL

	-- Suspended Receipts Scenarios (from 2.4) - Gesamtanzahl Bonrückstellungen
	SELECT
		ss.CASH_REGISTER_EVENT_SID
		, CAST(ss.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 31 						as SCENARIO_ID
		, ss.COUNTRY_ORG_CD
		, ss.STORE_SID
		, ss.BUS_DT
		, CAST(ss.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ss.CUST_SID
		, ss.CUST_IDENT_TYPE_CD
		, ss.CASHIER_NR

		, 1 						as CASH_REGISTER_EVENT_CNT
		, ss.SUSPENDED_CNT 			as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ss.SUSPENDED_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_SUSPEND_SCENARIOS ss
	WHERE (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND ss.IS_RECEIPT_RESOLVED_FG = 0 -- only unresolved receipts are counted in scenario 31
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 31)

	UNION ALL
	-- all suspended reciepts are counted in scenario 42
	SELECT
		ss.CASH_REGISTER_EVENT_SID
		,CAST(ss.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 42 						as SCENARIO_ID
		, ss.COUNTRY_ORG_CD
		, ss.STORE_SID
		, ss.BUS_DT
		, CAST(ss.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ss.CUST_SID
		, ss.CUST_IDENT_TYPE_CD
		, ss.CASHIER_NR

		, 1 						as CASH_REGISTER_EVENT_CNT
		, ss.SUSPENDED_CNT 			as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ss.SUSPENDED_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_SUSPEND_SCENARIOS ss
	WHERE (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 42)

	UNION ALL

	-- Aborted Receipts Scenarios (from 2.5) - Gesamtwert Bonabbruch
	SELECT
		ab_s.CASH_REGISTER_EVENT_SID
		, CAST(ab_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 32							as SCENARIO_ID
		, ab_s.COUNTRY_ORG_CD
		, ab_s.STORE_SID
		, ab_s.BUS_DT
		, CAST(ab_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ab_s.CUST_SID
		, ab_s.CUST_IDENT_TYPE_CD
		, ab_s.CASHIER_NR

		, 1 							as CASH_REGISTER_EVENT_CNT
		, ab_s.CASH_REGISTER_ABORT_CNT	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ab_s.ABORT_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_ABORT_SCENARIOS ab_s
	WHERE 1=1
		AND (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND IS_VALUE_ABOVE_THRESHOLD_FG = 1		--only receipts with the gross value above the threshold
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 32)

	UNION ALL

	-- Aborted Receipts Scenarios (from 2.5) - Gesamtanzahl Bonabbruch
	SELECT
		ab_s.CASH_REGISTER_EVENT_SID
		, CAST(ab_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 33							as SCENARIO_ID
		, ab_s.COUNTRY_ORG_CD
		, ab_s.STORE_SID
		, ab_s.BUS_DT
		, CAST(ab_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ab_s.CUST_SID
		, ab_s.CUST_IDENT_TYPE_CD
		, ab_s.CASHIER_NR

		, 1 							as CASH_REGISTER_EVENT_CNT
		, ab_s.CASH_REGISTER_ABORT_CNT	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ab_s.ABORT_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_ABORT_SCENARIOS ab_s
	WHERE 1=1
		AND (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 33)

	UNION ALL

	-- Generic return receipts Scenarios - no filter on specific return type (from 2.6) - Gesamtanzahl Geldrückgaben
	SELECT
		r_s.CASH_REGISTER_EVENT_SID
		, CAST(r_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 26							as SCENARIO_ID
		, r_s.COUNTRY_ORG_CD
		, r_s.STORE_SID
		, r_s.BUS_DT
		, CAST(r_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, r_s.CUST_SID
		, r_s.CUST_IDENT_TYPE_CD
		, r_s.CASHIER_NR

		, 1 							as CASH_REGISTER_EVENT_CNT
		, r_s.RETURN_LINE_CNT			as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, r_s.RETURN_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_RETURN_SCENARIOS r_s
	WHERE 1=1
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 26)
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--AND CASH_REGISTER_TYPE_CD = 'TIL'

	UNION ALL

	-- Generic return receipts Scenarios - no filter on specific return type (from 2.6) - Ø-Geldrückgabenwert
	SELECT
		r_s.CASH_REGISTER_EVENT_SID
		, CAST(r_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 28							as SCENARIO_ID
		, r_s.COUNTRY_ORG_CD
		, r_s.STORE_SID
		, r_s.BUS_DT
		, CAST(r_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, r_s.CUST_SID
		, r_s.CUST_IDENT_TYPE_CD
		, r_s.CASHIER_NR

		, 1 							as CASH_REGISTER_EVENT_CNT
		, r_s.RETURN_LINE_CNT			as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, r_s.RETURN_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_RETURN_SCENARIOS r_s
	WHERE 1=1
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 28)
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--AND CASH_REGISTER_TYPE_CD = 'TIL'

	UNION ALL

	-- Generic return receipts Scenarios - no filter on specific return type (from 2.6) - Geldrückgabenquote
	SELECT
		r_s.CASH_REGISTER_EVENT_SID
		, CAST(r_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 29							as SCENARIO_ID
		, r_s.COUNTRY_ORG_CD
		, r_s.STORE_SID
		, r_s.BUS_DT
		, CAST(r_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, r_s.CUST_SID
		, r_s.CUST_IDENT_TYPE_CD
		, r_s.CASHIER_NR

		, 1 							as CASH_REGISTER_EVENT_CNT
		, r_s.RETURN_LINE_CNT			as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, r_s.RETURN_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_RETURN_SCENARIOS r_s
	WHERE 1=1
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 29)
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--AND CASH_REGISTER_TYPE_CD = 'TIL'

	UNION ALL

	-- Manual return receipts Scenarios - at least one manual return line available in return receipt (from 2.6) - Gesamtanzahl manuelle Geldrückgaben
	SELECT
		mr_s.CASH_REGISTER_EVENT_SID
		, CAST(mr_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 27 AS SCENARIO_ID
		, mr_s.COUNTRY_ORG_CD
		, mr_s.STORE_SID
		, mr_s.BUS_DT
		, CAST(mr_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, mr_s.CUST_SID
		, mr_s.CUST_IDENT_TYPE_CD
		, mr_s.CASHIER_NR

		, 1 							as CASH_REGISTER_EVENT_CNT
		, mr_s.RETURN_MANUAL_LINE_CNT	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, mr_s.RETURN_MANUAL_NET_VAL	as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_RETURN_SCENARIOS mr_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--AND CASH_REGISTER_TYPE_CD = 'TIL'
		AND mr_s.RETURN_MANUAL_LINE_CNT > 0								--manual line count filter
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 27)

	UNION ALL

	-- Return receipts with no original receipt Scenarios - at least one return line without an original receipt (from 2.6) - Gesamtanzahl Geldrückgabe ohne Originalbon
	SELECT
		nor_s.CASH_REGISTER_EVENT_SID
		, CAST(nor_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 30 AS SCENARIO_ID
		, nor_s.COUNTRY_ORG_CD
		, nor_s.STORE_SID
		, nor_s.BUS_DT
		, CAST(nor_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, nor_s.CUST_SID
		, nor_s.CUST_IDENT_TYPE_CD
		, nor_s.CASHIER_NR

		, 1 							as CASH_REGISTER_EVENT_CNT
		, nor_s.RETURN_NO_ORIG_LINE_CNT	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, nor_s.RETURN_NO_ORIG_NET_VAL	as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_RETURN_SCENARIOS nor_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--AND CASH_REGISTER_TYPE_CD = 'TIL'
		AND nor_s.RETURN_NO_ORIG_LINE_CNT > 0								--no original receipt filter
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 30)

	UNION ALL

	-- Return receipts for which the date and cashier is the same as those of the original purchase receipt (from 2.6)
	-- unlike scenario 46, here the data of purchase and return must be the same
	SELECT
		rsdc_s.CASH_REGISTER_EVENT_SID
		, CAST(rsdc_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 41 AS SCENARIO_ID
		, rsdc_s.COUNTRY_ORG_CD
		, rsdc_s.STORE_SID
		, rsdc_s.BUS_DT
		, CAST(rsdc_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, rsdc_s.CUST_SID
		, rsdc_s.CUST_IDENT_TYPE_CD
		, rsdc_s.CASHIER_NR

		, 1 						as CASH_REGISTER_EVENT_CNT
		, rsdc_s.RETURN_LINE_CNT	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, rsdc_s.RETURN_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_RETURN_SCENARIOS rsdc_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		and IS_SAME_CASHIER_DAY_FG = 1 		--same cashier and day filter
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 41)

	UNION ALL

	-- "Gesamtanzahl gescannte Geldrückgaben" - Amount and line count of scanned Returns
	SELECT
		rs_s.CASH_REGISTER_EVENT_SID
		, CAST(rs_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 43 AS SCENARIO_ID
		, rs_s.COUNTRY_ORG_CD
		, rs_s.STORE_SID
		, rs_s.BUS_DT
		, CAST(rs_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, rs_s.CUST_SID
		, rs_s.CUST_IDENT_TYPE_CD
		, rs_s.CASHIER_NR

		, 1 							as CASH_REGISTER_EVENT_CNT
		, rs_s.RETURN_SCANNED_LINE_CNT	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, rs_s.RETURN_SCANNED_NET_VAL	as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL							as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_RETURN_SCENARIOS rs_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		AND rs_s.COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 43)
		and rs_s.RETURN_SCANNED_LINE_CNT > 0

	UNION ALL

	-- "Gesamtanzahl manuelle Geldrückgabe (ohne DV)" - Amount and line count of manually entered returns (excluding entry method "DV")
	SELECT
		rm_nodv_s.CASH_REGISTER_EVENT_SID
		, CAST(rm_nodv_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 44 AS SCENARIO_ID
		, rm_nodv_s.COUNTRY_ORG_CD
		, rm_nodv_s.STORE_SID
		, rm_nodv_s.BUS_DT
		, CAST(rm_nodv_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, rm_nodv_s.CUST_SID
		, rm_nodv_s.CUST_IDENT_TYPE_CD
		, rm_nodv_s.CASHIER_NR

		, 1 										as CASH_REGISTER_EVENT_CNT
		, rm_nodv_s.RETURN_MANUAL_NO_DV_LINE_CNT	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, rm_nodv_s.RETURN_MANUAL_NO_DV_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL										as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_RETURN_SCENARIOS rm_nodv_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		AND rm_nodv_s.COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 44)
		AND rm_nodv_s.RETURN_MANUAL_NO_DV_LINE_CNT > 0

	UNION ALL

	-- "Anzahl Geldrückgaben DV" - Amount and line count of manually entered returns only considering entry method "DV"
	SELECT
		rm_dv_s.CASH_REGISTER_EVENT_SID
		, CAST(rm_dv_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 45 AS SCENARIO_ID
		, rm_dv_s.COUNTRY_ORG_CD
		, rm_dv_s.STORE_SID
		, rm_dv_s.BUS_DT
		, CAST(rm_dv_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, rm_dv_s.CUST_SID
		, rm_dv_s.CUST_IDENT_TYPE_CD
		, rm_dv_s.CASHIER_NR

		, 1 								as CASH_REGISTER_EVENT_CNT
		, rm_dv_s.RETURN_MANUAL_DV_LINE_CNT	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, rm_dv_s.RETURN_MANUAL_DV_NET_VAL	as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL								as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_RETURN_SCENARIOS rm_dv_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		AND rm_dv_s.COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 45)
		AND rm_dv_s.RETURN_MANUAL_DV_LINE_CNT > 0

	UNION ALL

	-- "Anzahl Geldrückgaben mit Originalbon vom selben Bediener" - Return receipts for which the cashier is the same as those of the original purchase receipt (from 2.6)
	-- unlike scenario 41, here the data of purchase and return could be different
	SELECT
		rsc_s.CASH_REGISTER_EVENT_SID
		, CAST(rsc_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 46 AS SCENARIO_ID
		, rsc_s.COUNTRY_ORG_CD
		, rsc_s.STORE_SID
		, rsc_s.BUS_DT
		, CAST(rsc_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, rsc_s.CUST_SID
		, rsc_s.CUST_IDENT_TYPE_CD
		, rsc_s.CASHIER_NR

		, 1 						as CASH_REGISTER_EVENT_CNT
		, rsc_s.RETURN_LINE_CNT	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, rsc_s.RETURN_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_RETURN_SCENARIOS rsc_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		and IS_SAME_CASHIER_FG = 1 		--same cashier and day filter
		AND rsc_s.COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 46)

	UNION ALL

	-- Small sale scenarios (from 2.7) - Anzahl Kleinstbon
	SELECT
		ss_s.CASH_REGISTER_EVENT_SID
		, CAST(ss_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 25 AS SCENARIO_ID
		, ss_s.COUNTRY_ORG_CD
		, ss_s.STORE_SID
		, ss_s.BUS_DT
		, CAST(ss_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ss_s.CUST_SID
		, ss_s.CUST_IDENT_TYPE_CD
		, ss_s.CASHIER_NR

		, 1 							as CASH_REGISTER_EVENT_CNT
		, ss_s.SMALL_SALE_LINE_CNT		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ss_s.SMALL_SALE_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_SMALL_SALE_SCENARIOS ss_s
	WHERE (CASH_REGISTER_TYPE_CD = 'TIL'
			OR CASH_REGISTER_TYPE_CD IS NULL)
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 25)

	UNION ALL

	-- Logon logoff scenarios (from 2.8) - Anzahl An-/Abmeldung
	SELECT
		ll_s.CASH_REGISTER_EVENT_SID
		, CAST(ll_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 24 AS SCENARIO_ID
		, ll_s.COUNTRY_ORG_CD
		, ll_s.STORE_SID
		, ll_s.BUS_DT
		, CAST(ll_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, ll_s.CUST_SID
		, ll_s.CUST_IDENT_TYPE_CD
		, ll_s.CASHIER_NR

		, 1 							as CASH_REGISTER_EVENT_CNT
		, ll_s.LOGON_LOGOFF_LINE_CNT	as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, ll_s.LOGON_LOGOFF_NET_VAL		as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_TECH_EVENTS ll_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		and cast(ll_s.TECH_CASH_REGISTER_EVENT_TYPE_CD as BIGNUMERIC) IN (410, 415)				--loading logon and logoff event types only for this scenario
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 24)

	UNION ALL

	-- Deposit generic scenario (from 2.9) - Pfandquote
	SELECT
		dg_s.CASH_REGISTER_EVENT_SID
		, CAST(dg_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 23 AS SCENARIO_ID
		, dg_s.COUNTRY_ORG_CD
		, dg_s.STORE_SID
		, dg_s.BUS_DT
		, CAST(dg_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, dg_s.CUST_SID
		, dg_s.CUST_IDENT_TYPE_CD
		, dg_s.CASHIER_NR

		, 1 																as CASH_REGISTER_EVENT_CNT
		, dg_s.SOLD_DEPOSIT_LINE_CNT + dg_s.RETURNED_DEPOSIT_LINE_CNT		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, dg_s.DEPOSIT_SALES_NET_VAL + dg_s.DEPOSIT_RETURN_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, dg_s.DEPOSIT_SALES_GROSS_VAL + dg_s.DEPOSIT_RETURN_GROSS_VAL		as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_DEPOSIT_SCENARIOS dg_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 23)

	UNION ALL

	-- Deposit manual scenario (from 2.9) - Wert manuelle Pfandauszahlungen
	SELECT
		dm_s.CASH_REGISTER_EVENT_SID
		, CAST(dm_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 22 AS SCENARIO_ID
		, dm_s.COUNTRY_ORG_CD
		, dm_s.STORE_SID
		, dm_s.BUS_DT
		, CAST(dm_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
		, dm_s.CUST_SID
		, dm_s.CUST_IDENT_TYPE_CD
		, dm_s.CASHIER_NR

		, 1 												as CASH_REGISTER_EVENT_CNT
		, dm_s.DEPOSIT_RETURN_MANUAL_INPUT_LINES_CNT		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, dm_s.DEPOSIT_RETURN_MANUAL_INPUT_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, dm_s.DEPOSIT_RETURN_MANUAL_INPUT_GROSS_VAL		as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_DEPOSIT_SCENARIOS dm_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		AND dm_s.DEPOSIT_RETURN_MANUAL_INPUT_LINES_CNT > 0					--loading only these receipts with any manual deposit
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 22)

	UNION ALL

	-- Deposit only scenario (from 2.9) - Wert reine Pfandauszahlungen
	SELECT
		do_s.CASH_REGISTER_EVENT_SID
		, CAST(do_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 21 AS SCENARIO_ID
		, do_s.COUNTRY_ORG_CD
		, do_s.STORE_SID
		, do_s.BUS_DT
		, CAST(do_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
	    , do_s.CUST_SID
	    , do_s.CUST_IDENT_TYPE_CD
		, do_s.CASHIER_NR

		, 1 									as CASH_REGISTER_EVENT_CNT
		, do_s.RETURNED_DEPOSIT_LINE_CNT		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, do_s.DEPOSIT_RETURN_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, do_s.DEPOSIT_RETURN_GROSS_VAL			as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_DEPOSIT_SCENARIOS do_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		AND do_s.NON_DEPOSIT_LINES_CNT = 0									--loading only these receipts with no other lines than deposits
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 21)

	UNION ALL

	-- Deposit ALL scenario (from 2.9) - Wert Pfandauszahlungen (similar to 21, but we include all receipts with any deposit returns, not only "PURE" deposit returns
	SELECT
		do_s.CASH_REGISTER_EVENT_SID
		, CAST(do_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 56 AS SCENARIO_ID
		, do_s.COUNTRY_ORG_CD
		, do_s.STORE_SID
		, do_s.BUS_DT
		, CAST(do_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
	    , do_s.CUST_SID
	    , do_s.CUST_IDENT_TYPE_CD
		, do_s.CASHIER_NR

		, 1 									as CASH_REGISTER_EVENT_CNT
		, do_s.RETURNED_DEPOSIT_LINE_CNT		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, do_s.DEPOSIT_RETURN_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, do_s.DEPOSIT_RETURN_GROSS_VAL			as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_DEPOSIT_SCENARIOS do_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		AND do_s.RETURNED_DEPOSIT_LINE_CNT > 0							--loading only these receipts with any deposit return lines
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 56)

	UNION ALL

	-- Manual Deposit only scenario (from 2.9) - Reine und manuelle Pfandauszahlung
	SELECT
		do_s.CASH_REGISTER_EVENT_SID
		, CAST(do_s.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 57 AS SCENARIO_ID
		, do_s.COUNTRY_ORG_CD
		, do_s.STORE_SID
		, do_s.BUS_DT
		, CAST(do_s.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
	    , do_s.CUST_SID
	    , do_s.CUST_IDENT_TYPE_CD
		, do_s.CASHIER_NR

		, 1 												as CASH_REGISTER_EVENT_CNT
		, do_s.DEPOSIT_RETURN_MANUAL_INPUT_LINES_CNT		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, do_s.DEPOSIT_RETURN_MANUAL_INPUT_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, do_s.DEPOSIT_RETURN_MANUAL_INPUT_GROSS_VAL		as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_DEPOSIT_SCENARIOS do_s
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		AND do_s.NON_DEPOSIT_LINES_CNT = 0													--loading only these receipts with no other lines than deposits
		AND do_s.DEPOSIT_RETURN_MANUAL_INPUT_LINES_CNT = do_s.RETURNED_DEPOSIT_LINE_CNT		--loading only these receipts where the total number of deposit return lines is coming only from manual deposit returns
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 57)

	UNION ALL

	-- Lidl Plus usage scenario (from 2.10)
	SELECT
		lps.CASH_REGISTER_EVENT_SID
		, CAST(lps.CASH_REGISTER_EVENT_NR  AS BIGNUMERIC) AS CASH_REGISTER_EVENT_NR
		, 40 AS SCENARIO_ID
		, lps.COUNTRY_ORG_CD
		, lps.STORE_SID
		, lps.BUS_DT
		, CAST(lps.EVENT_END_HR AS BIGNUMERIC ) AS EVENT_END_HR
	    , lps.CUST_SID
	    , lps.CUST_IDENT_TYPE_CD
		, lps.CASHIER_NR

		, 1 						as CASH_REGISTER_EVENT_CNT
		, lps.EVENT_LINE_CNT		as CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
		, lps.EVENT_NET_VAL			as CASH_REGISTER_EVENT_AFFECTED_NET_VAL
		, NULL						as CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	FROM T_TMP_LIDL_PLUS_SCENARIOS lps
	WHERE 1=1
		-- Intentionally including "self-checkout" events, to make the logic same as "old system"
		--and CASH_REGISTER_TYPE_CD = 'TIL'
		AND COUNTRY_ORG_CD in (SELECT COUNTRY_ORG_CD FROM enabled_scenarios WHERE scenario_id = 40)
)
SELECT
	CASH_REGISTER_EVENT_SID
	,CAST(CASH_REGISTER_EVENT_NR AS STRING) AS CASH_REGISTER_EVENT_NR
	,SCENARIO_ID
	,COUNTRY_ORG_CD
	,STORE_SID
	,BUS_DT
	,EVENT_END_HR
	-- in reporting schemas (CORE_DIM, CORE_APP_FRAUD_DETECTION) WE set dummy values, not NULLs
	,COALESCE(CUST_SID, -1)
	,COALESCE(CUST_IDENT_TYPE_CD, '@')
	,CASHIER_NR

	,CASH_REGISTER_EVENT_CNT
	,CASH_REGISTER_EVENT_AFFECTED_LINE_CNT
	,CASH_REGISTER_EVENT_AFFECTED_NET_VAL
	,CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL

	,CURRENT_TIMESTAMP() 	AS dwh_created_tmsp
	,CURRENT_TIMESTAMP() 	AS dwh_updated_tmsp
	,${LOAD_ID} 				AS dwh_load_id

	,'CORE_REL' 				AS dwh_node_cd

FROM gather_all_kpis
ORDER BY BUS_DT
;
--------------------------------------------





------------------------------------------------------------

-- 3.2
-- INSERT into "STATISTICS table"
INSERT INTO `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_STATISTICS_BY_STORE_HOUR_CASHIER`
(
	INT_ORG_SID
	,BUS_DT
	,CASHIER_NR
	,EVENT_END_HR

	,SALES_NET_VAL
	,RETURN_NET_VAL
	,IS_OUTLIER_DAY_RETURN_FG
	,EVENT_CNT
	,EVENT_LINE_CNT
	,RETURN_CNT
	,CANCELLED_LINE_CNT
	,CANCELLED_NET_VAL
	,DISCOUNT_LINE_CNT
	,DISCOUNT_NET_VAL
	,ABORT_CNT
	,ABORT_NET_VAL
	,SUSPENDED_UNRESOLVED_CNT
	,SUSPENDED_UNRESOLVED_NET_VAL
	,PRICE_INFO_CNT
	,RETURN_WITHOUT_RECEIPT_CNT
	,RETURN_WITHOUT_RECEIPT_NET_VAL
	,DEPOSIT_SALES_NET_VAL
	,DEPOSIT_RETURN_NET_VAL
	,DEPOSIT_RETURN_MANUAL_INPUT_NET_VAL
	,DEPOSIT_RETURN_MANUAL_INPUT_GROSS_VAL
	,DEPOSIT_ONLY_RETURN_NET_VAL
	,SMALL_SALES_CNT
	,LOGIN_CNT
	,LOGOFF_CNT

	,DWH_CREATED_TMSP
	,DWH_UPDATED_TMSP
	,DWH_LOAD_ID
	,DWH_NODE_CD
)
SELECT
	store_sid
	, bus_dt
	, cashier_nr
	, event_end_hr

	, sales_net_val
	, return_net_val
	, is_outlier_day_return_fg
	, event_cnt
	, event_line_cnt
	, return_cnt
	, cancelled_line_cnt
	, cancelled_net_val
	, discount_line_cnt
	, discount_net_val
	, abort_cnt
	, abort_net_val
	, suspended_unresolved_cnt
	, suspended_unresolved_net_val
	, price_info_cnt
	, return_without_receipt_cnt
	, return_without_receipt_net_val

	, deposit_sales_net_val
	, deposit_return_net_val

	, deposit_return_manual_input_net_val
	, deposit_return_manual_input_gross_val
	, deposit_only_return_net_val
	, small_sales_cnt
	, login_cnt
	, logoff_cnt

	, CURRENT_TIMESTAMP() AS dwh_created_tmsp
	, CURRENT_TIMESTAMP() AS dwh_updated_tmsp
	, ${LOAD_ID} AS dwh_load_id
  
	, 'CORE_REL' AS dwh_node_cd
FROM
	T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS
;

------------------------------------------------------------




------------------------------------------------------------
-- 3.3 INSERT into "Ranking" Table
INSERT into `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_RANKING_BY_FRAUD_SCENARIO`
(
    SALES_COMPANY_SID
    ,STORE_SID
    ,CASHIER_NR
    ,SCENARIO_ID
    ,RANK_SEQ
    ,RELEVANT_FOR_MANUAL_REPORT_FG
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
WITH
materialize_param_view AS
(
    -- 1 row per Country+Scenario with the value of the ranking threshold
	SELECT
        SCENARIO_ID
        ,COUNTRY_ORG_CD
        ,MAX(CASE
                WHEN PARAM_ID in (
                        65      -- for scenario_id 21
                        ,68     -- for scenario_id 22
                        ,71     -- for scenario_id 23
                        ,74     -- for scenario_id 24
                        ,78     -- for scenario_id 25

                        ,79     -- for scenario_id 26
                        ,82     -- for scenario_id 27
                        ,85     -- for scenario_id 28
                        ,88     -- for scenario_id 29
                        ,91     -- for scenario_id 30

                        ,94     -- for scenario_id 31
                        ,98     -- for scenario_id 32
                        ,101    -- for scenario_id 33
                        ,107    -- for scenario_id 34
                        ,110    -- for scenario_id 35

                        ,113    -- for scenario_id 36
                        ,119    -- for scenario_id 38
                        ,122    -- for scenario_id 39
                    ) THEN PARAM_VAL_QTY
                ELSE NULL
            END) AS SCENARIO_RANK_THRESHOLD

    FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE`
    WHERE 1=1
        --Manual scenario IDs (ranking thresholds available for 21 to 39)
        -- the target table should be populated only for scenarios for which the ranking matters
        and SCENARIO_ID BETWEEN 21 AND 39
		-- if scneario is not enabled all cashiers/stores from that country will be eliminated in the inner join
		and IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
    GROUP BY
        scenario_id
        ,country_org_cd
    HAVING 1=1
        -- scenarios like 37 should also be eliminated
        and scenario_rank_threshold is not null
)
, ranked as (
    select
        cr.SALES_COMPANY_SID
        ,cr.STORE_SID
        ,cr.CASHIER_NR
        ,mpv.SCENARIO_ID
        ,mpv.SCENARIO_RANK_THRESHOLD
        ,cr.STORE_SELECTED_FG
        ,CASE
                WHEN mpv.SCENARIO_ID in (21) THEN RNK_DEPOSIT_ONLY_RETURN_VAL
                WHEN mpv.SCENARIO_ID in (22) THEN RNK_DEPOSIT_MANUAL_INPUT_VAL
                WHEN mpv.SCENARIO_ID in (23) THEN RNK_DEPOSIT_RETURN_SALES_PERCENTAGE
                WHEN mpv.SCENARIO_ID in (24) THEN RNK_LOGIN_AVG_CNT
                WHEN mpv.SCENARIO_ID in (25) THEN RNK_SMALL_SALES_CNT

                WHEN mpv.SCENARIO_ID in (26) THEN RNK_RETURN_CNT
                WHEN mpv.SCENARIO_ID in (27) THEN RNK_RETURN_MANUAL_RECEIPT_CNT
                WHEN mpv.SCENARIO_ID in (28) THEN RNK_RETURN_AVG_VAL
                WHEN mpv.SCENARIO_ID in (29) THEN RNK_RETURN_RETAIL_PERCENTAGE
                WHEN mpv.SCENARIO_ID in (30) THEN RNK_RETURN_WITHOUT_RECEIPT_CNT

                WHEN mpv.SCENARIO_ID in (31) THEN RNK_SUSPENDED_UNRESOLVED_CNT
                WHEN mpv.SCENARIO_ID in (32) THEN RNK_ABORT_VAL
                WHEN mpv.SCENARIO_ID in (33) THEN RNK_ABORT_CNT
                WHEN mpv.SCENARIO_ID in (34) THEN RNK_CANCELLED_LINE_CNT_PERCENTAGE
                WHEN mpv.SCENARIO_ID in (35) THEN RNK_CANCELLED_LINE_VAL_PERCENTAGE

                WHEN mpv.SCENARIO_ID in (36) THEN RNK_PRICE_INFO_CNT
                WHEN mpv.SCENARIO_ID in (38) THEN RNK_DISCOUNT_LINE_CNT
                WHEN mpv.SCENARIO_ID in (39) THEN RNK_DISCOUNT_LINE_VAL_PERCENTAGE
                ELSE NULL
            END as RANK_SEQ
    from T_TMP_CASHIER_RANKINGS_BY_WAREHOUSE cr -- 1 row per Cashier (cashier_nr+store_sid)
        join `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_INTERNAL_ORGANIZATION` io -- add CountryCD attribute for each Cashier
                on io.INT_ORG_SID = cr.STORE_SID
                and io.DWH_VALID_FG = TRUE
        join materialize_param_view mpv  -- 1 row per Country+Scenario, but also eliminate disabled scenarios
                on mpv.COUNTRY_ORG_CD = io.COUNTRY_ORG_CD
)
select
    SALES_COMPANY_SID
    ,STORE_SID
    ,CASHIER_NR
    ,SCENARIO_ID
    ,RANK_SEQ
    ,(RANK_SEQ<=SCENARIO_RANK_THRESHOLD or STORE_SELECTED_FG = 1) as RELEVANT_FOR_MANUAL_REPORT_FG
	, CURRENT_TIMESTAMP() AS dwh_created_tmsp
	, CURRENT_TIMESTAMP() AS dwh_updated_tmsp
	, ${LOAD_ID} AS dwh_load_id

	, 'CORE_REL' AS dwh_node_cd
from ranked;
