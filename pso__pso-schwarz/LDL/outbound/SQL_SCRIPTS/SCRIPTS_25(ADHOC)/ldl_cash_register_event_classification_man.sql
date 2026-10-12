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
															- changed the anchor logic for etl.T_TMP_STORE_CASHIER_BY_DAY_STATISTICS to adjust to the new attribute - temp table renamed to etl.T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS

# 1.11 29.01.2025  Kamil Roszczyk                  - Bugfix - change in etl.T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS temp table: replaced the source for SALES_COMPANY_SID and STORE_SELECTED_FG from tech_events_agg to working_hours CTE

# 1.12 30.01.2025  Kamil Roszczyk				   - removed SUSPEND_FG and CANCEL_FG filters for continuation receipts in etl.T_TMP_SUSPEND_SCENARIOS temp table
														US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/62636
														
# 1.13 05.02.2025  Kamil Roszczyk				   - added the filter in etl.T_TMP_ABORT_SCENARIOS temp table logic to exclude aborted receipts that do not have any lines
														Task: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/55436
														
# 1.14 12.02.2025  Kamil Roszczyk				   - bugfix - changed the logic of calculating retail, sales and return net values within sales_returns_agg CTE in ETL.T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS temp table
														All these three metrics are now calculated based on txn_net_val taken from receipt header information (core_rel.t_retail_event). Before they were calculated using receipt lines but it led to slightly different values than expected by checking the old system reports
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
														added is_outlier_day_return_fg to etl.T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS and core_app_fraud_detection.T_STATISTICS_BY_STORE_HOUR_CASHIER
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
														
# 1.38  20.08.2025  Mihail Ivanov  					- Changes:
														Add filter to exclude training receipts - as of this time TRAINING_FG is not correctly set in CORE_REL tables so we use retail_event_scenario_id
														https://jira.schwarz/browse/NEOGFPL-71572	
														
														Added one more acceptable option for CASH_REGISTER_TYPE_CD (value 'POS') to handle locations where OmniPos system is used
														Requested here: https://jira.schwarz/browse/NEOGFPL-71619


# 1.39  22.08.2025  Mihail Ivanov  					- Changes:	
														- New scenarios for KPIs requested here: https://jira.schwarz/browse/NEOGFPL-71593
															SCENARIO_ID		NAME:
																59			Anzahl Stornozeilen > X  pro Bon
																60			Anzahl Bons mit Storno an letzter Position
																61			Anzahl Bons mit Storno außerhalb der Öffnungszeiten
																62			Anzahl Bons mit Pfandauszahlungen außerhalb der Öffnungszeiten
																63			Anzahl Geldrückgaben mit Auswahl am Kassendisplay
																64			Anzahl Geldrückgaben bar
																65			Anzahl Geldrückgaben außerhalb der Öffnungszeiten
																67			Anzahl Bonabbruch direkt vor Kleinstbon oder Abmeldung
																68			Anzahl offene Bonrückstellung direkt vor Kleinstbon oder Abmeldung
																69			Bonrückstellung außerhalb der Öffnungszeiten
																70			Preisanzeigen außerhalb der Öffnungszeiten
																71			Bonabbruch außerhalb der Öffnungszeiten
																72			Manueller Rabatt außerhalb der Öffnungszeiten
																73			Kleinstbons außerhalb der Öffnungszeiten

														
														 - For Cancellation (Storno) scenarios now Flowers(Blumen) are considered to be "important" product
															so, INT_ITEM_GRP_NR = 20  is not longer excluded
															
														 - Optimizations:
																Added filter in Return Scenarios - now getting only PROD_RETAIL_LINE_TYPE_CD in ('R', 'RD') - only those are possible for return events.


# 1.40  03.09.2025  Mihail Ivanov  					- Changes 	in table T_STATISTICS_BY_STORE_HOUR_CASHIER
														new columns - SALES_OUTSIDE_WORK_HR_NET_VAL, RETURN_OUTSIDE_WORK_HR_NET_VAL, SALES_OUTSIDE_WORK_HR_CNT, RETURN_OUTSIDE_WORK_HR_CNT
															needed for the metrics requested here: https://jira.schwarz/browse/NEOGFPL-71580
														
														changed how RETURN_NET_VAL is populated - no longer using T_TMP_RETURN_SCENARIOS, the result is the same, as the new source produces same number, in more simple way
														
# 1.41  17.09.2025  Mihail Ivanov  					- Changes:
														Now populating also "affected GROSS val" for scenarios 32,33 (aborted receipts)
														
# 1.42  22.09.2025  Andrzej Wandtke  					- Changes:
														Now populating also "affected GROSS val" for scenarios: 31 (suspended receipts) - NEOGFPL-71593, 35 (Storno) - NEOGFPL-71639


# 1.41  27.10.2025  Mihail Ivanov  					- Bugfix:
														For scenario 68, "Anzahl offene Bonrückstellung direkt vor Kleinstbon oder Abmeldung"
															added filter to take only "UNRESOLVED" suspended receipts
															reported here:  https://jira.schwarz/browse/NEOGFPL-71674
															
# 1.42  30.10.2025  Mihail Ivanov  					- Bugfix:
														For scenarios derived from T_TMP_DISCOUNT_SCENARIOS
															added filter to evaluate only non-cancelled retail lines. If there is storno( cancellation line) for a retail_line, it will not be evaluated, even if we have discount for it.
															reported here:  https://jira.schwarz/browse/NEOGFPL-71685
														

# 1.43  12.11.2025  Mihail Ivanov  					- Bugfix:
														Added the following sub-scenarios (related to 67 and 68) to the classification table 
															670100 	Anzahl Bonabbruch direkt vor Kleinstbon
															670200 	Anzahl Bonabbruch direkt vor Abmeldung
															680100 	Anzahl offene Bonrückstellung direkt vor Kleinstbon
															680200 	Anzahl offene Bonrückstellung direkt vor Abmeldung
															reported here:  https://jira.schwarz/browse/NEOGFPL-71683													
														

# 1.44  29.01.2026  Andrzej Wandtke  					- Bugfix:
														Scenario 62: select only returned deposits
															reported here:  https://jira.schwarz/browse/NEOGFPL-71855


# 1.45  03.02.2026  Andrzej Wandtke  					- Bugfix:
														Table T_TMP_DEPOSIT_SCENARIOS: include RP (repeated) deposit entries
															reported here:  https://jira.schwarz/browse/NEOGFPL-71809
														
# 1.46  16.02.2026  Andrzej Wandtke  					- Change:
														Add column ABORT_GROSS_VAL in T_STATISTICS_BY_STORE_HOUR_CASHIER
														Requested: https://jira.schwarz/browse/NEOGFPL-71873


# 1.47  24.02.2026  Mihail Ivanov  					- bugfix:
														Scenario 50, "Gesamtanzahl Preisanzeigen | Vorgänge > X Preisanzeigen in Folge"
                                                                                                                parameter 128, "Anzahl Vorgänge >X Preisanzeigen in Folge", now compared with > (before was >=)
														Requested: https://jira.schwarz/browse/NEOGFPL-71877

# 1.48  25.02.2026  Mihail Ivanov  					- bugfix:
														joins with table T_CASHIER_ENCRYPTION should be done only by column CASHIER_HASH
                                                                                                                We were using BUS_DT and COUNTRY_ORG_CD as conditions in the join improves the performance
                                                                                                                But this does not work for Spain, because all receipts have COUNTRY_ORG_CD = 'ES'
                                                                                                                , but some rows in T_CASHIER_ENCRYPTION have country_org_cd = 'CS' for the corresponding cashiers.
*/



/*
Script content:

	1.1		CREATE temp tables:	etl.T_TMP_RETAIL_EVENT, etl.T_TMP_PRODUCT_RETAIL_LINE, etl.T_TMP_PRICE_INFORMATION_EVENT and etl.T_TMP_TECHNICAL_CASH_REGISTER_EVENT
	1.2		CREATE temp table:	etl.T_TMP_CASHIERS_QUALIFIED
	
	2.1		CREATE temp table:	etl.T_TMP_DISCOUNT_SCENARIOS 		(SCENARIO_IDs: 38, 39)
	2.2		CREATE temp table:	etl.T_TMP_STORNO_SCENARIOS			(SCENARIO_IDs: 34, 35)
	2.3		CREATE temp table:	etl.T_TMP_PRICE_CHECK_SCENARIOS		(SCENARIO_IDs: 36)
	2.4		CREATE temp table:	etl.T_TMP_SUSPEND_SCENARIOS			(SCENARIO_IDs: 31, 42)
	2.5		CREATE temp table:	etl.T_TMP_ABORT_SCENARIOS			(SCENARIO_IDs: 32, 33)
	2.6		CREATE temp table:	etl.T_TMP_RETURN_SCENARIOS			(SCENARIO_IDs: 26, 28, 29, 30)
	2.7		CREATE temp table:	etl.T_TMP_SMALL_SALE_SCENARIOS		(SCENARIO_IDs: 25)
	2.8		CREATE temp table:	etl.T_TMP_TECH_EVENTS				(SCENARIO_IDs: 24)
	2.9		CREATE temp table:	etl.T_TMP_DEPOSIT_SCENARIOS			(SCENARIO_IDs: 23, 22, 21)
	2.10	CREATE temp table:	etl.T_TMP_LIDL_PLUS_SCENARIOS		(SCENARIO_IDs: 40)
	2.11	CREATE temp table:	etl.T_TMP_STORE_CASHIER_BY_HOUR_STATISTICS
	2.12	CREATE temp table:	etl.T_TMP_CASHIER_RANKINGS_BY_WAREHOUSE

	3.0		DELETE old data from  T_CASH_REGISTER_EVENT_CLASSIFICATION  &  T_STATISTICS_BY_STORE_HOUR_CASHIER & T_CASHIER_RANKING_BY_FRAUD_SCENARIO
	3.1		INSERT INTO core_app_fraud_detection.T_CASH_REGISTER_EVENT_CLASSIFICATION
	3.2		INSERT INTO core_app_fraud_detection.T_STATISTICS_BY_STORE_HOUR_CASHIER
	3.3		INSERT INTO core_app_fraud_detection.T_CASHIER_RANKING_BY_FRAUD_SCENARIO

*/




--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--	Common/Reusable Objects (views or temp tables)
--
-- 
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--!SET exit_on_error=True;
BEGIN

DECLARE SV_MIN_DT DATE;
DECLARE SV_MAX_DT DATE;
DECLARE SV_MIN_WORK_DAYS INT64;
DECLARE SV_MIN_RECEIPTS INT64;
DECLARE SV_SELF_CASH_REGISTER_NR INT64;


SET SV_MIN_WORK_DAYS = 7; 	-- Cashiers qualify for audit only if they have worked at least this number of days
SET SV_MIN_RECEIPTS = 200;	-- Cashiers qualify for audit only if they have made at least this number of receipts 
SET SV_SELF_CASH_REGISTER_NR = 80; -- Cash Registers with higher number are self-checkout, and should be excluded

-- setting session variable for performance optimization (T_STORES_QUALIFIED is transient table populated before this script is invoked)
SET SV_MIN_DT = (SELECT min(bus_dt) FROM ETL.T_STORES_QUALIFIED);
SET SV_MAX_DT = (SELECT max(bus_dt) FROM ETL.T_STORES_QUALIFIED);



SET SV_MIN_WORK_DAYS = 7; 	-- Cashiers qualify for audit only if they have worked at least this number of days
SET SV_MIN_RECEIPTS = 200;	-- Cashiers qualify for audit only if they have made at least this number of receipts 
SET SV_SELF_CASH_REGISTER_NR = 80; -- Cash Registers with higher number are self-checkout, and should be excluded

-- setting session variable for performance optimization (T_STORES_QUALIFIED is transient table populated before this script is invoked)

SET SV_MIN_DT = (
  SELECT
      min(t_stores_qualified.bus_dt)
    from
      ldl_data_etl.t_stores_qualified 
);
SET SV_MAX_DT = (
  SELECT
      max(t_stores_qualified.bus_dt)
    from
      ldl_data_etl.t_stores_qualified
);
--------------------------------------------------------------------------------
-- 1.1 Make temp tables will all relavant RetailEvents (T_RETAIL_EVENT) and all relevant line (T_PRODUCT_RETAIL_LINE)
--	these temp tables will be used 8-9 later so we save a lot of time that could be wasted querying these big tables
--
--	especially considering the fetish snowflake has for T_PRODUCT_RETAIL_LINE and how often it just decides to read it fist -
--		the full table, with no filers (instead of reading T_STORES_QUALIFIED first and using it as filter for T_PRODUCT_RETAIL_LINE)
--
--	we also take only necessary cols


CREATE OR REPLACE TEMPORARY TABLE t_tmp_retail_event (
retail_event_sid BIGNUMERIC(38,0),
cash_register_event_nr BIGNUMERIC(38,0),
event_start_tmsp TIMESTAMP,
event_end_tmsp TIMESTAMP,
bus_dt DATE,
store_sid BIGNUMERIC(38,0),
country_org_cd STRING(2),
cash_register_sid BIGNUMERIC(38,0),
cash_register_type_cd STRING(20),
cashier_hash STRING(32),
cust_sid BIGNUMERIC(38,0),
cust_ident_type_cd STRING(20),
retail_event_type_cd STRING(20),
retail_event_scenario_id BIGNUMERIC(38,0),
cancel_fg BOOL,
suspend_fg BOOL,
susp_retail_event_sid BIGNUMERIC(38,0),
txn_gross_val BIGNUMERIC(38,5),
txn_net_val BIGNUMERIC(38,5),
txn_vat_val BIGNUMERIC(38,5),
turnover_relevant_fg BOOL,
	-- enriched with these five additional cols
cash_register_nr BIGNUMERIC(38,0),
cashier_nr STRING(20),
sales_company_sid BIGNUMERIC(38,0),
store_selected_fg INTEGER,
is_directly_ordered INTEGER
) AS
SELECT RE.retail_event_sid,
 RE.cash_register_event_nr,
 RE.event_start_tmsp,
 RE.event_end_tmsp,
 RE.bus_dt,
 RE.store_sid,
 RE.country_org_cd,
 RE.cash_register_sid,
 RE.cash_register_type_cd,
 RE.cashier_hash,
 RE.cust_sid,
 RE.cust_ident_type_cd,
 RE.retail_event_type_cd,
 RE.retail_event_scenario_id,
 RE.cancel_fg,
 RE.suspend_fg,
 RE.susp_retail_event_sid,
 RE.txn_gross_val,
 RE.txn_net_val,
 RE.txn_vat_val,
 RE.turnover_relevant_fg,
 CR.cash_register_nr,
 CE.cashier_nr,
 S.sales_company_sid,
 S.store_selected_fg,
 S.is_directly_ordered
FROM ldl_data_etl.t_stores_qualified AS S
 INNER JOIN ldl_data_core_rel.t_retail_event AS RE ON S.country_org_cd = RE.country_org_cd AND S.store_sid = RE.store_sid
     AND S.bus_dt = RE.bus_dt
 INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption AS CE ON RE.cashier_hash = CE.cashier_hash
 INNER JOIN ldl_data_core_rel.t_cash_register AS CR ON RE.cash_register_sid = CR.cash_register_sid AND CR.dwh_valid_fg
WHERE RE.retail_event_scenario_id NOT IN (101, 151, 201, 251, 301, 351);


CREATE OR REPLACE TEMPORARY TABLE t_tmp_product_retail_line (
retail_event_sid BIGNUMERIC(38,0),
retail_event_line_seq BIGNUMERIC(38,0),
event_start_tmsp TIMESTAMP,
event_end_tmsp TIMESTAMP,
bus_dt DATE,
store_sid BIGNUMERIC(38,0),
country_org_cd STRING(2),
cash_register_sid BIGNUMERIC(38,0),
cashier_hash STRING(32),
prod_retail_line_type_cd STRING(20),
retail_event_line_scenario_id BIGNUMERIC(38,0),
prod_variant_sid BIGNUMERIC(38,0),
local_prod_nr STRING(100),
prod_variant_input_nr STRING(100),
prod_variant_cnt BIGNUMERIC(38,0),
prod_variant_qty BIGNUMERIC(38,5),
retail_line_gross_val BIGNUMERIC(38,5),
retail_line_net_val BIGNUMERIC(38,5),
retail_line_vat_val BIGNUMERIC(38,5),
tax_pct BIGNUMERIC(38,5),
turnover_relevant_fg BOOL,
prod_entry_method_cd STRING(20),
orig_sales_event_sid BIGNUMERIC(38,0),
cancel_line_seq BIGNUMERIC(38,0)
) AS
SELECT PRL.retail_event_sid,
 PRL.retail_event_line_seq,
 PRL.event_start_tmsp,
 PRL.event_end_tmsp,
 PRL.bus_dt,
 PRL.store_sid,
 PRL.country_org_cd,
 PRL.cash_register_sid,
 PRL.cashier_hash,
 PRL.prod_retail_line_type_cd,
 PRL.retail_event_line_scenario_id,
 PRL.prod_variant_sid,
 PRL.local_prod_nr,
 PRL.prod_variant_input_nr,
 PRL.prod_variant_cnt,
 PRL.prod_variant_qty,
 PRL.retail_line_gross_val,
 PRL.retail_line_net_val,
 PRL.retail_line_vat_val,
 PRL.tax_pct,
 PRL.turnover_relevant_fg,
 PRL.prod_entry_method_cd,
 PRL.orig_sales_event_sid,
 PRL.cancel_line_seq
FROM ldl_data_etl.t_stores_qualified AS S
 INNER JOIN ldl_data_core_rel.t_product_retail_line AS PRL ON S.country_org_cd = PRL.country_org_cd AND S.store_sid =
    PRL.store_sid AND S.bus_dt = PRL.bus_dt;


CREATE OR REPLACE TEMPORARY TABLE t_tmp_price_information_event (
price_info_event_sid BIGNUMERIC(38,0),
cash_register_event_nr BIGNUMERIC(38,0),
country_org_cd STRING(2),
store_sid BIGNUMERIC(38,0),
bus_dt DATE,
event_tmsp TIMESTAMP,
cash_register_type_cd STRING(20),
cashier_hash STRING(32),
prod_price BIGNUMERIC(38,5),
curr_cd STRING(3),
cash_register_sid BIGNUMERIC(38,0),
prod_variant_sid BIGNUMERIC(38,0),
	-- enriched with these five additional cols

cashier_nr STRING(20),
cash_register_nr BIGNUMERIC(38,0),
sales_company_sid BIGNUMERIC(38,0),
store_selected_fg INTEGER,
is_directly_ordered INTEGER
) AS
SELECT TPIE.price_info_event_sid,
 TPIE.cash_register_event_nr,
 TPIE.country_org_cd,
 TPIE.store_sid,
 TPIE.bus_dt,
 TPIE.event_tmsp,
 TPIE.cash_register_type_cd,
 TPIE.cashier_hash,
 TPIE.prod_price,
 TPIE.curr_cd,
 TPIE.cash_register_sid,
 TPIE.prod_variant_sid,
 CE.cashier_nr,
 CR.cash_register_nr,
 SQ.sales_company_sid,
 SQ.store_selected_fg,
 SQ.is_directly_ordered
FROM ldl_data_etl.t_stores_qualified AS SQ
 INNER JOIN ldl_data_core_rel.t_price_information_event AS TPIE ON SQ.store_sid = TPIE.store_sid AND SQ.bus_dt = TPIE.bus_dt
     AND SQ.country_org_cd = TPIE.country_org_cd
 INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption AS CE ON TPIE.cashier_hash = CE.cashier_hash
 INNER JOIN ldl_data_core_rel.t_cash_register AS CR ON TPIE.cash_register_sid = CR.cash_register_sid AND CR.dwh_valid_fg;


CREATE OR REPLACE TEMPORARY TABLE t_tmp_technical_cash_register_event (
tech_cash_register_event_sid BIGNUMERIC(38,0),
cash_register_event_nr BIGNUMERIC(38,0),
country_org_cd STRING(2),
store_sid BIGNUMERIC(38,0),
bus_dt DATE,
event_tmsp TIMESTAMP,
cash_register_type_cd STRING(20),
tech_cash_register_event_type_cd STRING(20),
cashier_hash STRING(32),
cash_register_sid BIGNUMERIC(38,0),	
-- enriched with these five additional cols
cashier_nr STRING(20),
cash_register_nr BIGNUMERIC(38,0),
sales_company_sid BIGNUMERIC(38,0),
store_selected_fg INTEGER,
is_directly_ordered INTEGER
) AS
SELECT TTCRE.tech_cash_register_event_sid,
 TTCRE.cash_register_event_nr,
 TTCRE.country_org_cd,
 TTCRE.store_sid,
 TTCRE.bus_dt,
 TTCRE.event_tmsp,
 TTCRE.cash_register_type_cd,
 TTCRE.tech_cash_register_event_type_cd,
 TTCRE.cashier_hash,
 TTCRE.cash_register_sid,
 TCE.cashier_nr,
 CR.cash_register_nr,
 SQ.sales_company_sid,
 SQ.store_selected_fg,
 SQ.is_directly_ordered
FROM ldl_data_etl.t_stores_qualified AS SQ
 INNER JOIN ldl_data_core_rel.t_technical_cash_register_event AS TTCRE ON SQ.store_sid = TTCRE.store_sid AND SQ.bus_dt =
    TTCRE.bus_dt AND SQ.country_org_cd = TTCRE.country_org_cd
 INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption AS TCE ON TTCRE.cashier_hash = TCE.cashier_hash
 INNER JOIN ldl_data_core_rel.t_cash_register AS CR ON TTCRE.cash_register_sid = CR.cash_register_sid AND CR.dwh_valid_fg;
-- precalculate what is the next event (of certain type) after each one.
-- useful in several scenarios where we need to mark receipt if it is followed (or not) by specific event (abort+lofogg/small_sale, suspend + logoff/small_sale)

CREATE OR REPLACE TEMPORARY TABLE t_tmp_event_and_next_event AS WITH ALL_EVENTS AS (SELECT retail_event_sid AS cash_register_event_sid,
    'RETAIL_EVENT' AS event_category_cd,
    retail_event_type_cd AS event_subcategory_cd,
    bus_dt,
    cash_register_sid,
    cash_register_event_nr
   FROM ldl_data_etl.t_tmp_retail_event
   UNION ALL
   SELECT tech_cash_register_event_sid AS cash_register_event_sid,
    'TECH_EVENT' AS event_category_cd,
    tech_cash_register_event_type_cd AS event_subcategory_cd,
    bus_dt,
    cash_register_sid,
    cash_register_event_nr
   FROM ldl_data_etl.t_tmp_technical_cash_register_event
   WHERE CAST(tech_cash_register_event_type_cd AS INTEGER) NOT IN (400, 405, 420, 425, 430)) (SELECT
   cash_register_event_sid,
   event_category_cd,
   event_subcategory_cd,
   LEAD(cash_register_event_sid) OVER (PARTITION BY cash_register_sid, bus_dt ORDER BY
      cash_register_event_nr IS NULL, cash_register_event_nr) AS next_cash_register_event_sid,
   LEAD(event_category_cd) OVER (PARTITION BY cash_register_sid, bus_dt ORDER BY cash_register_event_nr
      IS NULL, cash_register_event_nr) AS next_event_category_cd,
   LEAD(event_subcategory_cd) OVER (PARTITION BY cash_register_sid, bus_dt ORDER BY
      cash_register_event_nr IS NULL, cash_register_event_nr) AS next_event_subcategory_cd
  FROM ALL_EVENTS AS ae);
--------------------------------------------------------------------------------






--------------------------------------------------------------------------------
--	1.2
-- 	Granularity: STORE_SID, CASHIER_HASH (alternatively STORE_SID + CASHIER_NR + BUS_DT0, as we have new Hash each day)
-- 		We will use this view to filter cashiers only for classification table
--		this is why we have the filter and s.IS_DIRECTLY_ORDERED = 1

CREATE OR REPLACE TEMPORARY TABLE t_tmp_cashiers_qualified AS WITH ALL_EVENTS AS (SELECT cashier_hash,
    store_sid,
    cashier_nr,
    bus_dt,
    country_org_cd,
    --In MIS system only sales receipts with transaction code 100 were qualified for workdays count filter
		--100 means sales receipts that were not suspended or aborted so both conditions in a CASE statement below should correspond to that logic
     CASE
     WHEN retail_event_type_cd = 'S' AND turnover_relevant_fg
     THEN 1
     ELSE 0
     END AS workdays_cnt_relevant_fg
   FROM ldl_data_etl.t_tmp_retail_event
   -- IS_DIRECTLY_ORDERED=1 means store is explicitly ordered for investigation or belongs to company that is ordered for investigation
	-- IS_DIRECTLY_ORDERED=0 (sibling store) means store is NOT ordered, but is included because another store from same company is explicitly ordered (while the whole company is NOT ordered)
	-- also field STORE_SELECTED_FG exists. It is 1 only for stores that are explicitly ordered while their company is NOT ordered
   WHERE is_directly_ordered = 1
   UNION ALL
   SELECT cashier_hash,
    store_sid,
    cashier_nr,
    bus_dt,
    country_org_cd,
    --No workdays count relevant events within technical events set so setting the flag to 0
    0 AS workdays_cnt_relevant_fg
   FROM ldl_data_etl.t_tmp_technical_cash_register_event
   WHERE is_directly_ordered = 1
   UNION ALL
   SELECT cashier_hash,
    store_sid,
    cashier_nr,
    bus_dt,
    country_org_cd,
    --No workdays count relevant events within price check events set so setting the flag to 0
    0 AS workdays_cnt_relevant_fg
   FROM ldl_data_etl.t_tmp_price_information_event
   WHERE is_directly_ordered = 1), CASHIER_DAILY_STATS AS (SELECT cashier_hash,
   store_sid,
   cashier_nr,
   bus_dt,
   country_org_cd,
   SUM(workdays_cnt_relevant_fg) AS cashier_daily_sales_cnt,
   COUNT(*) AS cashier_daily_retail_events_cnt,
   SUM(CASE
     WHEN SUM(workdays_cnt_relevant_fg) = 0
     THEN 0
     ELSE 1
     END) OVER (PARTITION BY store_sid, cashier_nr RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS cashier_workdays_cnt,
   SUM(COUNT(*)) OVER (PARTITION BY store_sid, cashier_nr RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS cashier_retail_events_cnt
  FROM ALL_EVENTS
  GROUP BY cashier_hash,
   store_sid,
   cashier_nr,
   bus_dt,
   country_org_cd) (SELECT store_sid,
   country_org_cd,
   cashier_nr,
   cashier_hash,
   bus_dt
  FROM CASHIER_DAILY_STATS
  WHERE cashier_workdays_cnt > 0
   AND cashier_retail_events_cnt > 0);

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

CREATE OR REPLACE TEMPORARY TABLE t_tmp_discount_scenarios AS WITH DISCOUNT_LINES_EVAL AS (SELECT RE.retail_event_sid,
   RE.cash_register_event_nr,
   RE.country_org_cd,
   RE.store_sid,
   RE.bus_dt,
   RE.event_end_tmsp,
   RE.cust_sid,
   RE.cust_ident_type_cd,
   RE.cashier_nr,
   RE.cash_register_nr,
   RE.cash_register_type_cd,
   PRL.retail_event_line_seq,
   PRL.tax_pct,
   PRL.event_start_tmsp AS line_start_tmsp,
   PRL.event_end_tmsp AS line_end_tmsp,
   DL.discount_val,
    CASE
    WHEN DL.retail_event_line_scenario_id BETWEEN 400 AND 599 AND (NOT LENGTH(PRL.prod_variant_input_nr) BETWEEN 15 AND
        17 OR PRL.prod_variant_input_nr NOT LIKE '55%' AND PRL.prod_variant_input_nr NOT LIKE '56%')
    THEN 1
    ELSE 0
    END AS is_manual_discount_line_fg
  FROM ldl_data_etl.t_tmp_retail_event AS RE
   INNER JOIN ldl_data_core_rel.t_discount_line AS DL ON RE.retail_event_sid = DL.retail_event_sid AND RE.country_org_cd
       = DL.country_org_cd AND RE.bus_dt = DL.bus_dt
   INNER JOIN ldl_data_etl.t_tmp_product_retail_line AS PRL ON DL.retail_event_sid = PRL.retail_event_sid AND DL.discounted_line_seq
      = PRL.retail_event_line_seq
  WHERE RE.turnover_relevant_fg
   AND PRL.turnover_relevant_fg
   AND ABS(DL.discount_val) > 0.01
   AND DL.bus_dt BETWEEN DATE SV_MIN_DT AND DATE SV_MIN_DT), DISCOUNTS_EVAL AS (SELECT retail_event_sid AS
   cash_register_event_sid,
   ANY_VALUE(cash_register_event_nr) AS cash_register_event_nr,
   ANY_VALUE(country_org_cd) AS country_org_cd,
   ANY_VALUE(store_sid) AS store_sid,
   ANY_VALUE(bus_dt) AS bus_dt,
   ANY_VALUE(EXTRACT(HOUR FROM event_end_tmsp)) AS event_end_hr,
   ANY_VALUE(cust_sid) AS cust_sid,
   ANY_VALUE(cust_ident_type_cd) AS cust_ident_type_cd,
   ANY_VALUE(cashier_nr) AS cashier_nr,
   ANY_VALUE(cash_register_nr) AS cash_register_nr,
   ANY_VALUE(cash_register_type_cd) AS cash_register_type_cd,
   TIME(MIN(line_start_tmsp)) AS first_line_time,
   TIME(MAX(line_end_tmsp)) AS last_line_time,
   COUNT(*) AS discount_line_cnt,
   COUNT(DISTINCT retail_event_line_seq) AS discounted_lines_cnt,
   SUM(ABS(discount_val)) AS discount_gross_val,
   SUM(ABS(discount_val / (1 + tax_pct / 100))) AS discount_net_val,
   SUM(is_manual_discount_line_fg) AS manual_discount_line_cnt,
   COUNT(DISTINCT CASE
     WHEN is_manual_discount_line_fg = 1
     THEN retail_event_line_seq
     ELSE NULL
     END) AS manual_discounted_lines_cnt,
   SUM(ABS(discount_val * is_manual_discount_line_fg)) AS manual_discount_gross_val,
   SUM(ABS(discount_val * is_manual_discount_line_fg / (1 + tax_pct / 100))) AS manual_discount_net_val
  FROM DISCOUNT_LINES_EVAL AS dle
  GROUP BY cash_register_event_sid), MATERIALIZE_PARAM_VIEW AS (SELECT *
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id IN (54, 55)) (SELECT de.cash_register_event_sid,
   de.cash_register_event_nr,
   de.country_org_cd,
   de.store_sid,
   de.bus_dt,
   de.event_end_hr,
   de.cust_sid,
   de.cust_ident_type_cd,
   de.cashier_nr,
   de.cash_register_nr,
   de.cash_register_type_cd,
   de.discount_line_cnt,
   de.discounted_lines_cnt,
   de.discount_net_val,
   de.discount_gross_val,
   de.manual_discount_line_cnt,
   de.manual_discounted_lines_cnt,
   de.manual_discount_net_val,
   de.manual_discount_gross_val,
   IF(de.manual_discounted_lines_cnt > 0, 1, 0) AS has_manual_discount_fg,
    CASE
    WHEN p_mdl.is_scenario_enabled_in_country_fg AND de.manual_discounted_lines_cnt >= p_mdl.param_val_qty
    THEN 1
    ELSE 0
    END AS has_many_discounted_lines_fg,
    CASE
    WHEN p_mdv.is_scenario_enabled_in_country_fg AND de.manual_discount_gross_val >= p_mdv.param_val_qty
    THEN 1
    ELSE 0
    END AS has_high_value_discount_fg,
   IF(de.first_line_time < SOH.open_tm OR de.last_line_time > SOH.close_tm, 1, 0) AS is_outside_work_hr_fg
  FROM DISCOUNTS_EVAL AS de
   LEFT JOIN MATERIALIZE_PARAM_VIEW AS p_mdl ON de.country_org_cd = p_mdl.country_org_cd AND p_mdl.scenario_id = 54 AND
     p_mdl.param_id = 131
   LEFT JOIN MATERIALIZE_PARAM_VIEW AS p_mdv ON de.country_org_cd = p_mdv.country_org_cd AND p_mdv.scenario_id = 55 AND
     p_mdv.param_id = 132
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours AS SOH ON de.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        de.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg);

-- 	2.2

CREATE OR REPLACE TEMPORARY TABLE t_tmp_storno_scenarios AS WITH TAIL_POSITION_CANCEL AS (SELECT RE0.retail_event_sid,
   CL.retail_event_line_seq AS tail_cancel_line_seq
  FROM ldl_data_etl.t_tmp_retail_event AS RE0
   INNER JOIN ldl_data_core_rel.t_cancellation_line AS CL ON RE0.retail_event_sid = CL.retail_event_sid AND RE0.store_sid
        = CL.store_sid AND RE0.bus_dt = CL.bus_dt AND RE0.country_org_cd = CL.country_org_cd
   LEFT JOIN ldl_data_etl.t_tmp_product_retail_line AS PRL0 ON RE0.retail_event_sid = PRL0.retail_event_sid AND RE0.store_sid
         = PRL0.store_sid AND RE0.bus_dt = PRL0.bus_dt AND RE0.country_org_cd = PRL0.country_org_cd AND (CL.event_tmsp <
       PRL0.event_start_tmsp OR CL.event_tmsp = PRL0.event_start_tmsp AND CL.retail_event_line_seq < PRL0.retail_event_line_seq
        )
  WHERE PRL0.retail_event_sid IS NULL
   AND RE0.turnover_relevant_fg
   AND RE0.retail_event_type_cd = 'S'), LINES_IMPORTANT_PROD_FLAG AS (SELECT RE.retail_event_sid AS
   cash_register_event_sid,
   RE.cash_register_event_nr,
   RE.country_org_cd,
   RE.store_sid,
   RE.bus_dt,
   EXTRACT(HOUR FROM RE.event_end_tmsp) AS event_end_hr,
   RE.cust_sid,
   RE.cust_ident_type_cd,
   RE.cashier_nr,
   RE.cash_register_nr,
   RE.cash_register_type_cd,
   PRL.retail_line_gross_val,
    PRL.retail_line_gross_val - PRL.retail_line_vat_val AS cancelled_net_val,
    CASE
    WHEN P.sub_item_grp_nr <> '74' AND P.int_item_grp_nr NOT IN ('10') AND P.int_item_grp_nr IS NOT NULL
    THEN 1
    ELSE 0
    END AS is_prod_important_fg,
   IF(tpc.retail_event_sid IS NOT NULL, 1, 0) AS is_line_cancelled_last_pos_fg,
   IF(TIME(PRL.event_start_tmsp) < SOH.open_tm OR TIME(PRL.event_end_tmsp) > SOH.close_tm, 1, 0) AS
   is_line_outside_work_hr_fg
  FROM ldl_data_etl.t_tmp_retail_event AS RE
   INNER JOIN ldl_data_etl.t_tmp_product_retail_line AS PRL ON RE.retail_event_sid = PRL.retail_event_sid
   INNER JOIN ldl_data_core_dim.t_dim_sales_variant AS P ON PRL.prod_variant_sid = P.sales_variant_sid AND P.dwh_valid_fg
    
   LEFT JOIN TAIL_POSITION_CANCEL AS tpc ON PRL.retail_event_sid = tpc.retail_event_sid AND PRL.cancel_line_seq = tpc.tail_cancel_line_seq
     
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours AS SOH ON RE.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        RE.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg
  WHERE RE.retail_event_type_cd = 'S'
   AND RE.turnover_relevant_fg
   AND PRL.cancel_line_seq IS NOT NULL), EVENT_FLAGS AS (SELECT cash_register_event_sid,
   ANY_VALUE(cash_register_event_nr) AS cash_register_event_nr,
   ANY_VALUE(country_org_cd) AS country_org_cd,
   ANY_VALUE(store_sid) AS store_sid,
   ANY_VALUE(bus_dt) AS bus_dt,
   ANY_VALUE(event_end_hr) AS event_end_hr,
   ANY_VALUE(cust_sid) AS cust_sid,
   ANY_VALUE(cust_ident_type_cd) AS cust_ident_type_cd,
   ANY_VALUE(cashier_nr) AS cashier_nr,
   ANY_VALUE(cash_register_nr) AS cash_register_nr,
   ANY_VALUE(cash_register_type_cd) AS cash_register_type_cd,
   COUNT(*) AS total_cancelled_line_cnt,
   SUM(cancelled_net_val) AS total_cancelled_net_val,
   SUM(retail_line_gross_val) AS total_cancelled_gross_val,
   SUM(is_prod_important_fg) AS important_prod_cancelled_line_cnt,
   SUM(is_prod_important_fg * cancelled_net_val) AS important_prod_cancelled_net_val,
   SUM(is_prod_important_fg * retail_line_gross_val) AS important_prod_cancelled_gross_val,
   IF(SUM(is_line_cancelled_last_pos_fg) > 0, 1, 0) AS cancel_last_pos_fg,
   IF(SUM(is_line_outside_work_hr_fg) > 0, 1, 0) AS cancel_outside_work_hr_fg
  FROM LINES_IMPORTANT_PROD_FLAG AS ipf
  GROUP BY cash_register_event_sid), MATERIALIZE_PARAM_VIEW AS (SELECT *
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id IN (59)) (SELECT ef.cash_register_event_sid,
   ef.cash_register_event_nr,
   ef.country_org_cd,
   ef.store_sid,
   ef.bus_dt,
   ef.event_end_hr,
   ef.cust_sid,
   ef.cust_ident_type_cd,
   ef.cashier_nr,
   ef.cash_register_nr,
   ef.cash_register_type_cd,
   ef.total_cancelled_line_cnt,
   ef.total_cancelled_net_val,
   ef.total_cancelled_gross_val,
   ef.important_prod_cancelled_line_cnt,
   ef.important_prod_cancelled_net_val,
   ef.important_prod_cancelled_gross_val,
   ef.cancel_last_pos_fg,
   ef.cancel_outside_work_hr_fg,
   IF(ef.total_cancelled_line_cnt >= p_clc.param_val_qty, 1, 0) AS has_many_cancelled_lines_fg
  FROM EVENT_FLAGS AS ef
   LEFT JOIN MATERIALIZE_PARAM_VIEW AS p_clc ON ef.country_org_cd = p_clc.country_org_cd AND p_clc.param_id = 153 AND
    p_clc.is_scenario_enabled_in_country_fg);

-- 	2.3

CREATE OR REPLACE TEMPORARY TABLE t_tmp_price_check_scenarios AS WITH ALL_EVENTS AS (SELECT retail_event_sid AS cash_register_event_sid,
    cash_register_event_nr,
    country_org_cd,
    store_sid,
    bus_dt,
    event_end_tmsp AS event_tmsp,
    retail_event_scenario_id AS cash_register_event_type_cd,
    cash_register_sid,
    cash_register_type_cd,
    cash_register_nr,
    cashier_nr,
    CAST(NULL AS BIGNUMERIC) AS prod_variant_sid,
    txn_gross_val,
    sales_company_sid,
    store_selected_fg,
    is_directly_ordered
   FROM ldl_data_etl.t_tmp_retail_event
   UNION ALL
   SELECT tech_cash_register_event_sid AS cash_register_event_sid,
    cash_register_event_nr,
    country_org_cd,
    store_sid,
    bus_dt,
    event_tmsp,
    ROUND(CAST(tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS cash_register_event_type_cd,
    cash_register_sid,
    cash_register_type_cd,
    cash_register_nr,
    cashier_nr,
    CAST(NULL AS BIGNUMERIC) AS prod_variant_sid,
    0 AS txn_gross_val,
    sales_company_sid,
    store_selected_fg,
    is_directly_ordered
   FROM ldl_data_etl.t_tmp_technical_cash_register_event
   UNION ALL
   SELECT price_info_event_sid AS cash_register_event_sid,
    cash_register_event_nr,
    country_org_cd,
    store_sid,
    bus_dt,
    event_tmsp,
    480 AS cash_register_event_type_cd,
    cash_register_sid,
    cash_register_type_cd,
    cash_register_nr,
    cashier_nr,
    prod_variant_sid,
    prod_price AS txn_gross_val,
    sales_company_sid,
    store_selected_fg,
    is_directly_ordered
   FROM ldl_data_etl.t_tmp_price_information_event), ALL_EVENTS_WITH_CHANGE_FLAG AS (SELECT cash_register_event_sid,
   cash_register_event_nr,
   country_org_cd,
   store_sid,
   bus_dt,
   event_tmsp,
   cash_register_event_type_cd,
   cash_register_sid,
   cash_register_type_cd,
   cash_register_nr,
   cashier_nr,
   prod_variant_sid,
   txn_gross_val,
   sales_company_sid,
   store_selected_fg,
   is_directly_ordered,
    CASE
    WHEN cash_register_event_type_cd <> (LAG(cash_register_event_type_cd) OVER (PARTITION BY bus_dt, cash_register_sid
         ORDER BY cash_register_event_nr IS NULL, cash_register_event_nr))
    THEN 1
    ELSE 0
    END AS event_type_change_fg,
   ROW_NUMBER() OVER (PARTITION BY bus_dt, cash_register_sid ORDER BY event_tmsp IS NULL, event_tmsp,
      cash_register_event_nr IS NULL, cash_register_event_nr) AS rnk
  FROM ALL_EVENTS AS ae), ALL_EVENTS_WITH_GROUPS AS (SELECT cash_register_event_sid,
   cash_register_event_nr,
   country_org_cd,
   store_sid,
   bus_dt,
   event_tmsp,
   cash_register_event_type_cd,
   cash_register_sid,
   cash_register_type_cd,
   cash_register_nr,
   cashier_nr,
   prod_variant_sid,
   txn_gross_val,
   sales_company_sid,
   store_selected_fg,
   is_directly_ordered,
   event_type_change_fg,
   rnk,
   SUM(event_type_change_fg) OVER (PARTITION BY cash_register_sid, bus_dt ORDER BY rnk IS NULL, rnk
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
  FROM ALL_EVENTS_WITH_CHANGE_FLAG AS ae1), PRICE_INFO_EVENTS_WITH_NEXT_EVENT AS (SELECT t11.cash_register_event_sid,
   t11.cash_register_event_nr,
   t11.country_org_cd,
   t11.store_sid,
   t11.bus_dt,
   t11.event_tmsp,
   t11.cash_register_type_cd,
   t11.cash_register_nr,
   t11.cashier_nr,
   t11.txn_gross_val,
   t11.cash_register_sid,
   t11.prod_variant_sid,
   t11.group_id,
   t11.sales_company_sid,
   t11.store_selected_fg,
   t11.is_directly_ordered,
   t11.next_event_sid,
   t11.next_event_type_cd,
   t11.next_txn_gross_val
  FROM (SELECT pie.cash_register_event_sid,
     pie.cash_register_event_nr,
     pie.country_org_cd,
     pie.store_sid,
     pie.bus_dt,
     pie.event_tmsp,
     pie.cash_register_type_cd,
     pie.cash_register_nr,
     pie.cashier_nr,
     pie.txn_gross_val,
     pie.cash_register_sid,
     pie.prod_variant_sid,
     pie.group_id,
     pie.sales_company_sid,
     pie.store_selected_fg,
     pie.is_directly_ordered,
     anpe.cash_register_event_sid AS next_event_sid,
     anpe.cash_register_event_type_cd AS next_event_type_cd,
     anpe.txn_gross_val AS next_txn_gross_val,
     anpe.cash_register_event_nr AS cash_register_event_nr0
    FROM ALL_EVENTS_WITH_GROUPS AS pie
     LEFT JOIN ALL_EVENTS AS anpe ON pie.bus_dt = anpe.bus_dt AND pie.cash_register_sid = anpe.cash_register_sid AND pie
        .cash_register_event_nr < anpe.cash_register_event_nr AND anpe.cash_register_event_type_cd NOT IN (480, 400, 405
        , 420, 425, 430)
    WHERE pie.cash_register_event_type_cd = 480
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY ie.cash_register_event_sid ORDER BY
          cash_register_event_nr0 IS NULL, cash_register_event_nr0)) = 1) AS t11), MATERIALIZE_PARAM_VIEW AS (SELECT *
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id IN (47, 50, 52)), SMALL_SALE_EVENTS AS (SELECT PRL.retail_event_sid
  FROM ldl_data_etl.t_tmp_product_retail_line AS PRL
   INNER JOIN MATERIALIZE_PARAM_VIEW AS p_ssma ON PRL.country_org_cd = p_ssma.country_org_cd AND p_ssma.scenario_id = 52
        AND p_ssma.param_id = 130 AND p_ssma.is_scenario_enabled_in_country_fg
  WHERE PRL.turnover_relevant_fg
  GROUP BY PRL.retail_event_sid
  HAVING SUM(CASE
       WHEN PRL.retail_event_line_scenario_id IN (101, 102, 120, 122, 201, 202, 220, 222)
       THEN 1
       ELSE 0
       END) = 1 AND SUM(CASE
       WHEN PRL.cancel_line_seq IS NOT NULL AND PRL.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END) = 0 AND SUM(CASE
      WHEN PRL.retail_event_line_scenario_id IN (101, 102, 120, 122, 201, 202, 220, 222)
      THEN PRL.retail_line_gross_val
      ELSE 0
      END) < ANY_VALUE(p_ssma.param_val_qty)) (SELECT pie.cash_register_event_sid,
   pie.cash_register_event_nr,
   pie.country_org_cd,
   pie.store_sid,
   pie.bus_dt,
   EXTRACT(HOUR FROM pie.event_tmsp) AS event_end_hr,
   CAST(NULL AS BIGNUMERIC) AS cust_sid,
   CAST(NULL AS STRING) AS cust_ident_type_cd,
   pie.cashier_nr,
   pie.cash_register_nr,
   pie.cash_register_type_cd,
   pie.sales_company_sid,
   pie.store_selected_fg,
   pie.txn_gross_val,
   COUNT(*) OVER (PARTITION BY pie.bus_dt, pie.cash_register_sid, pie.group_id RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS consecutive_pie_in_group_cnt,
   ROW_NUMBER() OVER (PARTITION BY pie.bus_dt, pie.cash_register_sid, pie.group_id ORDER BY pie.cash_register_event_nr
      IS NULL, pie.cash_register_event_nr) AS rn_in_group,
    CASE
    WHEN p_nfama.is_scenario_enabled_in_country_fg AND pie.txn_gross_val >= p_nfama.param_val_qty AND ROUND(SAFE_CAST(PV
        .int_item_grp_nr AS BIGNUMERIC), 0) = 70
    THEN 1
    ELSE 0
    END AS is_non_food_fg,
   IF(ROUND(SAFE_CAST(PV.sub_item_grp_nr AS BIGNUMERIC), 0) = 80, 1, 0) AS is_tobacco_fg,
   IF(ROUND(SAFE_CAST(PV.sub_item_grp_nr AS BIGNUMERIC), 0) IN (60, 61, 63), 1, 0) AS is_alcohol_fg,
    CASE
    WHEN p_cpc.is_scenario_enabled_in_country_fg AND (COUNT(*) OVER (PARTITION BY pie.bus_dt, pie.cash_register_sid
           , pie.group_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > p_cpc.param_val_qty AND (ROW_NUMBER()
       OVER (PARTITION BY pie.bus_dt, pie.cash_register_sid, pie.group_id ORDER BY pie.cash_register_event_nr
          IS NULL, pie.cash_register_event_nr)) = 1
    THEN 1
    ELSE 0
    END AS is_multi_pie_fg,
   IF(pie.next_event_type_cd = 410, 1, 0) AS is_next_logoff_fg,
   IF(pie.next_event_type_cd = 100 AND sse.retail_event_sid IS NOT NULL, 1, 0) AS is_next_small_sale_fg,
   IF(TIME(pie.event_tmsp) < SOH.open_tm OR TIME(pie.event_tmsp) > SOH.close_tm, 1, 0) AS is_outside_work_hr_fg
  FROM PRICE_INFO_EVENTS_WITH_NEXT_EVENT AS pie
   LEFT JOIN ldl_data_core_dim.t_dim_sales_variant AS PV ON pie.prod_variant_sid = PV.sales_variant_sid AND PV.dwh_valid_fg
    
   LEFT JOIN MATERIALIZE_PARAM_VIEW AS p_nfama ON pie.country_org_cd = p_nfama.country_org_cd AND p_nfama.scenario_id =
      47 AND p_nfama.param_id = 129
   LEFT JOIN MATERIALIZE_PARAM_VIEW AS p_cpc ON pie.country_org_cd = p_cpc.country_org_cd AND p_cpc.scenario_id = 50 AND
     p_cpc.param_id = 128
   LEFT JOIN SMALL_SALE_EVENTS AS sse ON pie.next_event_sid = sse.retail_event_sid
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours AS SOH ON pie.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        pie.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg);

-- 	2.4

CREATE OR REPLACE TEMPORARY TABLE t_tmp_suspend_scenarios AS WITH MATERIALIZE_PARAM_VIEW AS (SELECT *
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id = 68), SMALL_SALES AS (SELECT RE0.retail_event_sid
  FROM ldl_data_etl.t_tmp_retail_event AS RE0
   INNER JOIN ldl_data_etl.t_tmp_product_retail_line AS PRL ON RE0.retail_event_sid = PRL.retail_event_sid
   INNER JOIN MATERIALIZE_PARAM_VIEW AS mpv ON RE0.country_org_cd = mpv.country_org_cd AND mpv.param_id = 155
  WHERE RE0.retail_event_type_cd = 'S'
   AND RE0.txn_gross_val < mpv.param_val_qty
   AND RE0.turnover_relevant_fg
  GROUP BY RE0.retail_event_sid
  HAVING SUM(CASE
       WHEN PRL.prod_retail_line_type_cd = 'S'
       THEN 1
       ELSE 0
       END) = 1 AND SUM(CASE
       WHEN PRL.prod_retail_line_type_cd = 'D'
       THEN 1
       ELSE 0
       END) = 0 AND SUM(CASE
      WHEN PRL.cancel_line_seq IS NOT NULL AND PRL.retail_line_gross_val > 0
      THEN 1
      ELSE 0
      END) = 0), CONT_SALES_EVENT AS (SELECT susp_retail_event_sid
  FROM ldl_data_etl.t_tmp_retail_event AS C_RE
  WHERE retail_event_type_cd = 'S'
   AND susp_retail_event_sid IS NOT NULL
  GROUP BY susp_retail_event_sid) (SELECT RE.retail_event_sid AS cash_register_event_sid,
   RE.cash_register_event_nr,
   RE.country_org_cd,
   RE.store_sid,
   RE.bus_dt,
   EXTRACT(HOUR FROM RE.event_end_tmsp) AS event_end_hr,
   RE.cust_sid,
   RE.cust_ident_type_cd,
   RE.cashier_nr,
   RE.cash_register_nr,
   RE.cash_register_type_cd,
   IF(t9.susp_retail_event_sid IS NOT NULL, 1, 0) AS is_receipt_resolved_fg,
   IF(ENE.next_event_category_cd = 'TECH_EVENT' AND ENE.next_event_subcategory_cd = '410', 1, 0) AS is_next_logoff_fg,
   IF(ENE.next_event_category_cd = 'RETAIL_EVENT' AND ss.retail_event_sid IS NOT NULL, 1, 0) AS is_next_small_sale_fg,
   IF(TIME(RE.event_start_tmsp) < SOH.open_tm OR TIME(RE.event_end_tmsp) > SOH.close_tm, 1, 0) AS is_outside_work_hr_fg
   ,
   1 AS suspended_cnt,
   ABS(RE.txn_net_val) AS suspended_net_val,
   ABS(RE.txn_gross_val) AS suspended_gross_val
  FROM ldl_data_etl.t_tmp_retail_event AS RE
   INNER JOIN ldl_data_etl.t_tmp_event_and_next_event AS ENE ON RE.retail_event_sid = ENE.cash_register_event_sid
   LEFT JOIN SMALL_SALES AS ss ON ENE.next_cash_register_event_sid = ss.retail_event_sid
   LEFT JOIN (SELECT DISTINCT *
    FROM CONT_SALES_EVENT AS cse) AS t9 ON RE.retail_event_sid = t9.susp_retail_event_sid
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours AS SOH ON RE.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        RE.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg
  WHERE RE.retail_event_type_cd = 'S'
   AND RE.suspend_fg
   AND NOT RE.cancel_fg);

-- 	2.5

CREATE OR REPLACE TEMPORARY TABLE t_tmp_abort_scenarios AS WITH MATERIALIZE_PARAM_VIEW AS (SELECT *
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id IN (32, 67)), SMALL_SALES AS (SELECT RE0.retail_event_sid
  FROM ldl_data_etl.t_tmp_retail_event AS RE0
   INNER JOIN ldl_data_etl.t_tmp_product_retail_line AS PRL ON RE0.retail_event_sid = PRL.retail_event_sid
   INNER JOIN MATERIALIZE_PARAM_VIEW AS mpv ON RE0.country_org_cd = mpv.country_org_cd AND mpv.param_id = 154
  WHERE RE0.retail_event_type_cd = 'S'
   AND RE0.txn_gross_val < mpv.param_val_qty
   AND RE0.turnover_relevant_fg
  GROUP BY RE0.retail_event_sid
  HAVING SUM(CASE
       WHEN PRL.prod_retail_line_type_cd = 'S'
       THEN 1
       ELSE 0
       END) = 1 AND SUM(CASE
       WHEN PRL.prod_retail_line_type_cd = 'D'
       THEN 1
       ELSE 0
       END) = 0 AND SUM(CASE
      WHEN PRL.cancel_line_seq IS NOT NULL AND PRL.retail_line_gross_val > 0
      THEN 1
      ELSE 0
      END) = 0) (SELECT RE.retail_event_sid AS cash_register_event_sid,
   RE.cash_register_event_nr,
   RE.country_org_cd,
   RE.store_sid,
   RE.bus_dt,
   EXTRACT(HOUR FROM RE.event_end_tmsp) AS event_end_hr,
   RE.cust_sid,
   RE.cust_ident_type_cd,
   RE.cashier_nr,
   RE.cash_register_nr,
   RE.cash_register_type_cd,
   1 AS cash_register_abort_cnt,
   ABS(RE.txn_net_val) AS abort_net_val,
   ABS(RE.txn_gross_val) AS abort_gross_val,
    CASE
    WHEN RE.txn_gross_val >= mpv.param_val_qty 
    THEN 1
    ELSE 0
    END AS is_value_above_threshold_fg,
   IF(ENE.next_event_category_cd = 'TECH_EVENT' AND ENE.next_event_subcategory_cd = '410', 1, 0) AS is_next_logoff_fg,
   IF(ENE.next_event_category_cd = 'RETAIL_EVENT' AND ss.retail_event_sid IS NOT NULL, 1, 0) AS is_next_small_sale_fg,
   IF(TIME(RE.event_start_tmsp) < SOH.open_tm OR TIME(RE.event_end_tmsp) > SOH.close_tm, 1, 0) AS is_outside_work_hr_fg
  FROM ldl_data_etl.t_tmp_retail_event AS RE
   INNER JOIN MATERIALIZE_PARAM_VIEW AS mpv ON RE.country_org_cd = mpv.country_org_cd AND mpv.param_id = 97
   INNER JOIN ldl_data_etl.t_tmp_event_and_next_event AS ENE ON RE.retail_event_sid = ENE.cash_register_event_sid
   LEFT JOIN SMALL_SALES AS ss ON ENE.next_cash_register_event_sid = ss.retail_event_sid
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours AS SOH ON RE.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        RE.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg
  WHERE RE.retail_event_type_cd = 'S'
   AND RE.cancel_fg
   AND EXISTS (SELECT 1
    FROM ldl_data_etl.t_tmp_product_retail_line AS PRL
    WHERE retail_event_sid = RE.retail_event_sid));

-- 	2.6

CREATE OR REPLACE TEMPORARY TABLE t_tmp_return_scenarios AS WITH ORIG_RE AS (SELECT ORIG_RE.retail_event_sid,
   ORIG_RE.bus_dt,
   ORIG_RE.store_sid,
   ORIG_CE.cashier_nr
  FROM ldl_data_core_rel.t_retail_event AS ORIG_RE
   LEFT JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption AS ORIG_CE ON ORIG_RE.cashier_hash = ORIG_CE.cashier_hash
    
  WHERE ORIG_RE.country_org_cd IN (SELECT DISTINCT country_org_cd
     FROM ldl_data_etl.t_stores_qualified)
   AND ORIG_RE.bus_dt >= DATE_SUB(DATE(SV_MIN_DT), INTERVAL 365 DAY)), AGG_RETURN_LINES AS (SELECT TPRL.retail_event_sid
   ,
   COUNT(*) AS return_line_cnt,
   SUM(IF(TPRL.prod_entry_method_cd IN ('SC'), 1, 0)) AS return_scanned_line_cnt,
   SUM(IF(TPRL.prod_entry_method_cd IN ('KE'), 1, 0)) AS return_manual_no_dv_line_cnt,
   SUM(IF(TPRL.prod_entry_method_cd IN ('DV'), 1, 0)) AS return_manual_dv_line_cnt,
   SUM(IF(TPRL.prod_entry_method_cd IN ('LS'), 1, 0)) AS return_ls_line_cnt,
    SUM(IF(TPRL.prod_entry_method_cd IN ('KE'), 1, 0)) + SUM(IF(TPRL.prod_entry_method_cd IN ('DV'), 1, 0)) AS
   return_manual_line_cnt,
   SUM(IF(t3.retail_event_sid IS NULL AND TPRL.prod_retail_line_type_cd = 'R', 1, 0)) AS return_no_orig_line_cnt,
   SUM(IF(TPRL.prod_entry_method_cd IN ('SC'), ABS(TPRL.retail_line_gross_val - TPRL.retail_line_vat_val), 0)) AS
   return_scanned_net_val,
   SUM(IF(TPRL.prod_entry_method_cd IN ('KE'), ABS(TPRL.retail_line_gross_val - TPRL.retail_line_vat_val), 0)) AS
   return_manual_no_dv_net_val,
   SUM(IF(TPRL.prod_entry_method_cd IN ('DV'), ABS(TPRL.retail_line_gross_val - TPRL.retail_line_vat_val), 0)) AS
   return_manual_dv_net_val,
   SUM(IF(TPRL.prod_entry_method_cd IN ('LS'), ABS(TPRL.retail_line_gross_val - TPRL.retail_line_vat_val), 0)) AS
   return_ls_net_val,
    SUM(IF(TPRL.prod_entry_method_cd IN ('KE'), ABS(TPRL.retail_line_gross_val - TPRL.retail_line_vat_val), 0)) + SUM(IF(TPRL
       .prod_entry_method_cd IN ('DV'), ABS(TPRL.retail_line_gross_val - TPRL.retail_line_vat_val), 0)) AS
   return_manual_net_val,
   SUM(IF(t3.retail_event_sid IS NULL AND TPRL.prod_retail_line_type_cd = 'R', ABS(TPRL.retail_line_gross_val - TPRL.retail_line_vat_val
       ), 0)) AS return_no_orig_net_val,
   SUM(IF(TPRL.prod_retail_line_type_cd = 'R', COALESCE(TPRL.prod_variant_cnt, TPRL.prod_variant_qty), 0)) AS
   return_items_qty,
   TIME(MIN(TPRL.event_start_tmsp)) AS first_line_time,
   TIME(MAX(TPRL.event_end_tmsp)) AS last_line_time,
   MAX(t3.bus_dt) AS o_bus_dt,
   MAX(t3.store_sid) AS o_store_sid,
   MAX(t3.cashier_nr) AS o_cashier_nr
  FROM ldl_data_etl.t_tmp_product_retail_line AS TPRL
   LEFT JOIN ORIG_RE AS t3 ON TPRL.orig_sales_event_sid = t3.retail_event_sid
  WHERE TPRL.cancel_line_seq IS NULL
   AND TPRL.prod_retail_line_type_cd IN ('R', 'RD')
  GROUP BY TPRL.retail_event_sid), CASH_PAYMENTS AS (SELECT PL.retail_event_sid
  FROM ldl_data_etl.t_stores_qualified AS SQ
   INNER JOIN ldl_data_core_rel.t_payment_line AS PL ON SQ.store_sid = PL.store_sid AND SQ.bus_dt = PL.bus_dt AND SQ.country_org_cd
       = PL.country_org_cd AND PL.bus_dt BETWEEN DATE(SV_MIN_DT) AND (DATE(SV_MIN_DT))
  WHERE PL.paym_type_id = 11
  GROUP BY PL.retail_event_sid) (SELECT RE.retail_event_sid AS cash_register_event_sid,
   RE.cash_register_event_nr,
   RE.country_org_cd,
   RE.store_sid,
   RE.bus_dt,
   EXTRACT(HOUR FROM RE.event_end_tmsp) AS event_end_hr,
   RE.cust_sid,
   RE.cust_ident_type_cd,
   RE.cashier_nr,
   RE.cash_register_nr,
   RE.cash_register_type_cd,
   IF(RE.cashier_nr = arl.o_cashier_nr AND RE.store_sid = arl.o_store_sid, 1, 0) AS is_same_cashier_fg,
   IF(IF(RE.cashier_nr = arl.o_cashier_nr AND RE.store_sid = arl.o_store_sid, 1, 0) = 1 AND RE.bus_dt = arl.o_bus_dt, 1
    , 0) AS is_same_cashier_day_fg,
   1 AS cash_register_event_cnt,
   arl.return_line_cnt,
   arl.return_scanned_line_cnt,
   arl.return_manual_no_dv_line_cnt,
   arl.return_manual_dv_line_cnt,
   arl.return_manual_line_cnt,
   arl.return_ls_line_cnt,
   arl.return_no_orig_line_cnt,
   ABS(RE.txn_net_val) AS return_net_val,
   arl.return_scanned_net_val,
   arl.return_manual_no_dv_net_val,
   arl.return_manual_dv_net_val,
   arl.return_manual_net_val,
   arl.return_ls_net_val,
   arl.return_no_orig_net_val,
   ABS(arl.return_items_qty) AS return_items_qty,
   IF(t11.retail_event_sid IS NOT NULL, 1, 0) AS has_cash_payment_fg,
   IF(arl.first_line_time < SOH.open_tm OR arl.last_line_time > SOH.close_tm, 1, 0) AS is_outside_work_hr_fg
  FROM ldl_data_etl.t_tmp_retail_event AS RE
   INNER JOIN AGG_RETURN_LINES AS arl ON RE.retail_event_sid = arl.retail_event_sid
   LEFT JOIN (SELECT DISTINCT *
    FROM CASH_PAYMENTS AS cp) AS t11 ON arl.retail_event_sid = t11.retail_event_sid
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours AS SOH ON RE.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        RE.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg
  WHERE RE.retail_event_type_cd = 'R'
   AND RE.turnover_relevant_fg);

-- 	2.7

CREATE OR REPLACE TEMPORARY TABLE t_tmp_small_sale_scenarios AS WITH MATERIALIZE_PARAM_VIEW AS (SELECT *
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id = 25), SMALL_SALE_EVENTS AS (SELECT RE.retail_event_sid AS cash_register_event_sid,
   ANY_VALUE(RE.cash_register_event_nr) AS cash_register_event_nr,
   ANY_VALUE(RE.country_org_cd) AS country_org_cd,
   ANY_VALUE(RE.store_sid) AS store_sid,
   ANY_VALUE(RE.bus_dt) AS bus_dt,
   ANY_VALUE(EXTRACT(HOUR FROM RE.event_end_tmsp)) AS event_end_hr,
   ANY_VALUE(RE.cust_sid) AS cust_sid,
   ANY_VALUE(RE.cust_ident_type_cd) AS cust_ident_type_cd,
   ANY_VALUE(RE.cashier_nr) AS cashier_nr,
   ANY_VALUE(RE.cash_register_nr) AS cash_register_nr,
   ANY_VALUE(RE.cash_register_type_cd) AS cash_register_type_cd,
   TIME(MIN(PRL.event_start_tmsp)) AS first_line_time,
   TIME(MAX(PRL.event_end_tmsp)) AS last_line_time,
   1 AS cash_register_event_cnt,
   COUNT(PRL.retail_event_line_seq) AS small_sale_line_cnt,
   ANY_VALUE(RE.txn_net_val) AS small_sale_net_val
  FROM ldl_data_etl.t_tmp_retail_event AS RE
   INNER JOIN ldl_data_etl.t_tmp_product_retail_line AS PRL ON RE.retail_event_sid = PRL.retail_event_sid
   INNER JOIN MATERIALIZE_PARAM_VIEW AS mpv ON RE.country_org_cd = mpv.country_org_cd AND mpv.param_id = 77
  WHERE RE.retail_event_type_cd = 'S'
   AND RE.txn_gross_val < mpv.param_val_qty
   AND RE.turnover_relevant_fg
  GROUP BY cash_register_event_sid
  HAVING SUM(IF(PRL.prod_retail_line_type_cd = 'S', 1, 0)) = 1 
     AND SUM(IF(PRL.prod_retail_line_type_cd = 'D', 1, 0)) = 0 
     AND SUM(IF(PRL.cancel_line_seq IS NOT NULL AND PRL.retail_line_gross_val > 0, 1, 0)) = 0) 
  (SELECT sse.cash_register_event_sid,
   sse.cash_register_event_nr,
   sse.country_org_cd,
   sse.store_sid,
   sse.bus_dt,
   sse.event_end_hr,
   sse.cust_sid,
   sse.cust_ident_type_cd,
   sse.cashier_nr,
   sse.cash_register_nr,
   sse.cash_register_type_cd,
   sse.cash_register_event_cnt,
   sse.small_sale_line_cnt,
   sse.small_sale_net_val,
   IF(sse.first_line_time < SOH.open_tm OR sse.last_line_time > SOH.close_tm, 1, 0) AS is_outside_work_hr_fg
  FROM SMALL_SALE_EVENTS AS sse
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours AS SOH ON sse.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        sse.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg);

-- 	2.8
--Creating a temp table for all technical events
--This will be used as a source for classification table load (logon, logoff events) and as a base for the anchor CTE in cashier by store day load

CREATE OR REPLACE TEMPORARY TABLE t_tmp_tech_events AS
SELECT tech_cash_register_event_sid AS cash_register_event_sid,
 cash_register_event_nr,
 country_org_cd,
 store_sid,
 bus_dt,
 EXTRACT(HOUR FROM event_tmsp) AS event_end_hr,
 CAST(NULL AS BIGNUMERIC) AS cust_sid,
 CAST(NULL AS STRING) AS cust_ident_type_cd,
 cashier_nr,
 cash_register_nr,
 cash_register_type_cd,
 sales_company_sid,
 store_selected_fg,
 1 AS cash_register_event_cnt,
 0 AS logon_logoff_line_cnt,
 0 AS logon_logoff_net_val,
 tech_cash_register_event_type_cd
FROM ldl_data_etl.t_tmp_technical_cash_register_event;

-- 	2.9

CREATE OR REPLACE TEMPORARY TABLE t_tmp_deposit_scenarios AS WITH DEPOSITS AS (SELECT RE.retail_event_sid AS cash_register_event_sid,
   ANY_VALUE(RE.cash_register_event_nr) AS cash_register_event_nr,
   ANY_VALUE(RE.country_org_cd) AS country_org_cd,
   ANY_VALUE(RE.store_sid) AS store_sid,
   ANY_VALUE(RE.bus_dt) AS bus_dt,
   ANY_VALUE(EXTRACT(HOUR FROM RE.event_end_tmsp)) AS event_end_hr,
   ANY_VALUE(RE.cust_sid) AS cust_sid,
   ANY_VALUE(RE.cust_ident_type_cd) AS cust_ident_type_cd,
   ANY_VALUE(RE.cashier_nr) AS cashier_nr,
   ANY_VALUE(RE.cash_register_nr) AS cash_register_nr,
   ANY_VALUE(RE.cash_register_type_cd) AS cash_register_type_cd,
   SUM(CASE
     WHEN PRL.prod_retail_line_type_cd = 'SD'
     THEN 1
     ELSE 0
     END) AS sold_deposit_line_cnt,
   SUM(CASE
     WHEN PRL.prod_retail_line_type_cd = 'D'
     THEN 1
     ELSE 0
     END) AS returned_deposit_line_cnt,
   SUM(CASE
     WHEN PRL.prod_retail_line_type_cd IN ('D', 'SD')
     THEN 0
     ELSE 1
     END) AS non_deposit_lines_cnt,
   SUM(CASE
     WHEN PRL.prod_retail_line_type_cd = 'D' AND PRL.prod_entry_method_cd IN ('KE', 'DV', 'RP') AND LENGTH(PRL.prod_variant_input_nr
        ) < 19
     THEN 1
     ELSE 0
     END) AS deposit_return_manual_input_lines_cnt,
   SUM(CASE
     WHEN PRL.prod_retail_line_type_cd = 'SD'
     THEN PRL.retail_line_gross_val - PRL.retail_line_vat_val
     ELSE 0
     END) AS deposit_sales_net_val,
   ABS(SUM(CASE
      WHEN PRL.prod_retail_line_type_cd = 'D'
      THEN PRL.retail_line_gross_val - PRL.retail_line_vat_val
      ELSE 0
      END)) AS deposit_return_net_val,
   ABS(SUM(CASE
      WHEN PRL.prod_retail_line_type_cd = 'D' AND PRL.prod_entry_method_cd IN ('KE', 'DV', 'RP') AND LENGTH(PRL.prod_variant_input_nr
         ) < 19
      THEN PRL.retail_line_gross_val - PRL.retail_line_vat_val
      ELSE 0
      END)) AS deposit_return_manual_input_net_val,
   SUM(CASE
     WHEN PRL.prod_retail_line_type_cd = 'SD'
     THEN PRL.retail_line_gross_val
     ELSE 0
     END) AS deposit_sales_gross_val,
   ABS(SUM(CASE
      WHEN PRL.prod_retail_line_type_cd = 'D'
      THEN PRL.retail_line_gross_val
      ELSE 0
      END)) AS deposit_return_gross_val,
   ABS(SUM(CASE
      WHEN PRL.prod_retail_line_type_cd = 'D' AND PRL.prod_entry_method_cd IN ('KE', 'DV', 'RP') AND LENGTH(PRL.prod_variant_input_nr
         ) < 19
      THEN PRL.retail_line_gross_val
      ELSE 0
      END)) AS deposit_return_manual_input_gross_val,
   TIME(MIN(PRL.event_start_tmsp)) AS first_line_time,
   TIME(MAX(PRL.event_end_tmsp)) AS last_line_time
  FROM ldl_data_etl.t_tmp_retail_event AS RE
   INNER JOIN ldl_data_etl.t_tmp_product_retail_line AS PRL ON RE.retail_event_sid = PRL.retail_event_sid
  WHERE RE.retail_event_type_cd = 'S'
   AND RE.turnover_relevant_fg
   AND PRL.turnover_relevant_fg
  GROUP BY cash_register_event_sid
  HAVING returned_deposit_line_cnt + sold_deposit_line_cnt > 0) (SELECT d.cash_register_event_sid,
   d.cash_register_event_nr,
   d.country_org_cd,
   d.store_sid,
   d.bus_dt,
   d.event_end_hr,
   d.cust_sid,
   d.cust_ident_type_cd,
   d.cashier_nr,
   d.cash_register_nr,
   d.cash_register_type_cd,
   1 AS cash_register_event_cnt,
   d.sold_deposit_line_cnt,
   d.returned_deposit_line_cnt,
   d.non_deposit_lines_cnt,
   d.deposit_return_manual_input_lines_cnt,
   d.deposit_sales_net_val,
   d.deposit_return_net_val,
   d.deposit_return_manual_input_net_val,
   d.deposit_sales_gross_val,
   d.deposit_return_gross_val,
   d.deposit_return_manual_input_gross_val,
   IF(d.first_line_time < SOH.open_tm OR d.last_line_time > SOH.close_tm, 1, 0) AS is_outside_work_hr_fg
  FROM DEPOSITS AS d
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours AS SOH ON d.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM d
        .bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg);

-- 	2.10

CREATE OR REPLACE TEMPORARY TABLE t_tmp_lidl_plus_scenarios AS
SELECT RE.retail_event_sid AS cash_register_event_sid,
 ANY_VALUE(RE.cash_register_event_nr) AS cash_register_event_nr,
 ANY_VALUE(RE.country_org_cd) AS country_org_cd,
 ANY_VALUE(RE.store_sid) AS store_sid,
 ANY_VALUE(RE.bus_dt) AS bus_dt,
 ANY_VALUE(EXTRACT(HOUR FROM RE.event_end_tmsp)) AS event_end_hr,
 ANY_VALUE(RE.cust_sid) AS cust_sid,
 ANY_VALUE(RE.cust_ident_type_cd) AS cust_ident_type_cd,
 ANY_VALUE(RE.cashier_nr) AS cashier_nr,
 ANY_VALUE(RE.cash_register_nr) AS cash_register_nr,
 ANY_VALUE(RE.cash_register_type_cd) AS cash_register_type_cd,
 1 AS event_cnt,
 ANY_VALUE(ABS(RE.txn_net_val)) AS event_net_val,
 COUNT(*) AS event_line_cnt
FROM ldl_data_etl.t_tmp_retail_event AS RE
 INNER JOIN ldl_data_etl.t_tmp_product_retail_line AS PRL ON RE.retail_event_sid = PRL.retail_event_sid
WHERE RE.retail_event_type_cd = 'S'
 AND RE.turnover_relevant_fg
 AND PRL.prod_retail_line_type_cd = 'S'
 AND PRL.turnover_relevant_fg
 AND RE.cust_ident_type_cd IS NOT NULL
GROUP BY cash_register_event_sid;

-- 	2.11
-- Creating a separate temporary table as this set will be used twice - in steps 2.12 and in 3.2

CREATE OR REPLACE TEMPORARY TABLE t_tmp_store_cashier_by_hour_statistics AS WITH STORE_DATE_CASHIER AS ((SELECT store_sid,
     bus_dt,
     cashier_nr,
     sales_company_sid,
     store_selected_fg
    FROM ldl_data_etl.t_tmp_tech_events
    UNION DISTINCT
    SELECT store_sid,
     bus_dt,
     cashier_nr,
     sales_company_sid,
     store_selected_fg
    FROM ldl_data_etl.t_tmp_price_check_scenarios)
   UNION DISTINCT
   SELECT store_sid,
    bus_dt,
    cashier_nr,
    sales_company_sid,
    store_selected_fg
   FROM ldl_data_etl.t_tmp_retail_event), WORKING_HOURS AS (SELECT sdc.store_sid,
   sdc.bus_dt,
   sdc.cashier_nr,
   sdc.sales_company_sid,
   sdc.store_selected_fg,
     (ROW_NUMBER() OVER (PARTITION BY sdc.store_sid, sdc.bus_dt, sdc.cashier_nr ORDER BY 1 IS NULL, 1))
    - 1 AS event_end_hr
  FROM UNNEST(GENERATE_ARRAY(0, 23)) AS SEQ
   INNER JOIN STORE_DATE_CASHIER AS sdc ON TRUE), TECH_EVENTS_AGG AS (SELECT store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr,
   ANY_VALUE(sales_company_sid) AS sales_company_sid,
   ANY_VALUE(store_selected_fg) AS store_selected_fg,
   COUNT(cash_register_event_sid) AS tech_events_cnt,
   SUM(CASE
     WHEN tech_cash_register_event_type_cd = '415'
     THEN 1
     ELSE 0
     END) AS login_cnt,
   SUM(CASE
     WHEN tech_cash_register_event_type_cd = '410'
     THEN 1
     ELSE 0
     END) AS logoff_cnt
  FROM ldl_data_etl.t_tmp_tech_events
  GROUP BY store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr), 
   --The granularity of statistics table has changed from store/cashier/day to store/cashier/day/hour.
--In such circumstances the technical events temp table cannot be treated as an anchor anymore - despite the fact that it has to be at least a pair of tech events daily for a cashier (1 log on and 1 log off) it may happen that these events can occur just twice per whole cashier shift, i.e. log on at 8:00 and log off at 16:00
--In that case all retail events that could be registered in between but in hours not being the ones coming from log on and log off, like 9:30, 12:13, 15:59 will not have their matching anchor records coming from tech events and thus will be discarded
--To avoid replacing left joins with full outer joins in the last query of this temp table which would make join conditions very extensive and less readible the anchor data set will be represented by distinctive combinations of store/cashier/day values from data of all types of events cross joined with generated numbers from 0 to 23 representing day hours
--As last step all store/cashier/day/hour combinations are filtered - if there is no data attached from all scenario CTEs to any of these combinations then they will be discarded as dummy

-- used to determine when event (receipt) is outside work hours and calculate some columns
   MAT_PARAMS AS (SELECT *
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id = 74
   AND is_scenario_enabled_in_country_fg), SALES_RETURNS_HEADER_AGG AS (SELECT RE.retail_event_sid,
   RE.retail_event_type_cd,
   RE.store_sid,
   RE.bus_dt,
   RE.cashier_nr,
   RE.turnover_relevant_fg,
   IF(arl.retail_event_sid IS NOT NULL, 1, 0) AS has_retail_lines_fg,
   EXTRACT(HOUR FROM RE.event_end_tmsp) AS event_end_hr,
    CASE
    WHEN TIME(RE.event_start_tmsp) <= TIME_ADD(SOH.open_tm, INTERVAL CAST(- 1 * obo.param_val_qty AS INTEGER) MINUTE)
       OR TIME(RE.event_end_tmsp) >= TIME_ADD(SOH.close_tm, INTERVAL CAST(oac.param_val_qty AS INTEGER) MINUTE)
    THEN 1
    ELSE 0
    END AS event_outside_work_hr_fg,
   SUM(CASE
     WHEN RE.turnover_relevant_fg = TRUE
     THEN RE.txn_net_val
     ELSE 0
     END) OVER (PARTITION BY RE.store_sid, RE.bus_dt, RE.cashier_nr, EXTRACT(HOUR FROM RE.event_end_tmsp
       ) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS retail_net_val,
   SUM(CASE
     WHEN RE.turnover_relevant_fg = TRUE AND RE.retail_event_type_cd = 'S' AND IF(arl.retail_event_sid IS NOT NULL, 1, 0
        ) = 1
     THEN RE.txn_net_val
     ELSE 0
     END) OVER (PARTITION BY RE.store_sid, RE.bus_dt, RE.cashier_nr, EXTRACT(HOUR FROM RE.event_end_tmsp
       ) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sales_net_val,
   SUM(CASE
     WHEN RE.turnover_relevant_fg = TRUE AND RE.retail_event_type_cd = 'R' AND IF(arl.retail_event_sid IS NOT NULL, 1, 0
        ) = 1
     THEN ABS(RE.txn_net_val)
     ELSE 0
     END) OVER (PARTITION BY RE.store_sid, RE.bus_dt, RE.cashier_nr, EXTRACT(HOUR FROM RE.event_end_tmsp
       ) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS return_net_val,
   SUM(CASE
     WHEN RE.turnover_relevant_fg = TRUE AND RE.retail_event_type_cd = 'S' AND IF(arl.retail_event_sid IS NOT NULL, 1, 0
         ) = 1 AND CASE
        WHEN TIME(RE.event_start_tmsp) <= TIME_ADD(SOH.open_tm, INTERVAL CAST(- 1 * obo.param_val_qty AS INTEGER)
           MINUTE) OR TIME(RE.event_end_tmsp) >= TIME_ADD(SOH.close_tm, INTERVAL CAST(oac.param_val_qty AS INTEGER)
           MINUTE)
        THEN 1
        ELSE 0
        END = 1
     THEN RE.txn_net_val
     ELSE 0
     END) OVER (PARTITION BY RE.store_sid, RE.bus_dt, RE.cashier_nr, EXTRACT(HOUR FROM RE.event_end_tmsp
       ) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sales_outside_work_hr_net_val,
   SUM(CASE
     WHEN RE.turnover_relevant_fg = TRUE AND RE.retail_event_type_cd = 'R' AND IF(arl.retail_event_sid IS NOT NULL, 1, 0
         ) = 1 AND CASE
        WHEN TIME(RE.event_start_tmsp) <= TIME_ADD(SOH.open_tm, INTERVAL CAST(- 1 * obo.param_val_qty AS INTEGER)
           MINUTE) OR TIME(RE.event_end_tmsp) >= TIME_ADD(SOH.close_tm, INTERVAL CAST(oac.param_val_qty AS INTEGER)
           MINUTE)
        THEN 1
        ELSE 0
        END = 1
     THEN ABS(RE.txn_net_val)
     ELSE 0
     END) OVER (PARTITION BY RE.store_sid, RE.bus_dt, RE.cashier_nr, EXTRACT(HOUR FROM RE.event_end_tmsp
       ) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS return_outside_work_hr_net_val
  FROM ldl_data_etl.t_tmp_retail_event AS RE
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours AS SOH ON RE.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        RE.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg
   LEFT JOIN MAT_PARAMS AS obo ON RE.country_org_cd = obo.country_org_cd AND obo.param_id = 136
   LEFT JOIN MAT_PARAMS AS oac ON RE.country_org_cd = oac.country_org_cd AND oac.param_id = 137
   LEFT JOIN (SELECT DISTINCT retail_event_sid
    FROM ldl_data_etl.t_tmp_product_retail_line AS PRL
    WHERE cancel_line_seq IS NULL) AS arl ON RE.retail_event_sid = arl.retail_event_sid), SALES_RETURNS_AGG AS (SELECT
   srha.store_sid,
   srha.bus_dt,
   srha.cashier_nr,
   srha.event_end_hr,
   COUNT(DISTINCT srha.retail_event_sid) AS retail_event_cnt,
   COUNT(PRL0.retail_event_line_seq) AS retail_event_line_cnt,
   ANY_VALUE(srha.retail_net_val) AS retail_net_val,
   COUNT(DISTINCT CASE
     WHEN srha.retail_event_type_cd = 'S' AND srha.turnover_relevant_fg AND srha.has_retail_lines_fg = 1
     THEN srha.retail_event_sid
     ELSE NULL
     END) AS sales_event_cnt,
   SUM(CASE
     WHEN srha.retail_event_type_cd = 'S' AND PRL0.turnover_relevant_fg AND srha.turnover_relevant_fg AND srha.has_retail_lines_fg
        = 1
     THEN 1
     ELSE 0
     END) AS sales_event_line_cnt,
   ANY_VALUE(srha.sales_net_val) AS sales_net_val,
   COUNT(DISTINCT CASE
     WHEN srha.retail_event_type_cd = 'R' AND srha.turnover_relevant_fg AND srha.has_retail_lines_fg = 1
     THEN srha.retail_event_sid
     ELSE NULL
     END) AS return_event_cnt,
   SUM(CASE
     WHEN srha.retail_event_type_cd = 'R' AND PRL0.turnover_relevant_fg AND srha.turnover_relevant_fg AND srha.has_retail_lines_fg
        = 1
     THEN 1
     ELSE 0
     END) AS return_event_line_cnt,
   ANY_VALUE(srha.return_net_val) AS return_net_val,
   COUNT(DISTINCT CASE
     WHEN srha.retail_event_type_cd = 'S' AND srha.turnover_relevant_fg AND srha.event_outside_work_hr_fg = 1 AND srha.has_retail_lines_fg
        = 1
     THEN srha.retail_event_sid
     ELSE NULL
     END) AS sales_outside_work_hr_cnt,
   COUNT(DISTINCT CASE
     WHEN srha.retail_event_type_cd = 'R' AND srha.turnover_relevant_fg AND srha.event_outside_work_hr_fg = 1 AND srha.has_retail_lines_fg
        = 1
     THEN srha.retail_event_sid
     ELSE NULL
     END) AS return_outside_work_hr_cnt,
   ANY_VALUE(srha.sales_outside_work_hr_net_val) AS sales_outside_work_hr_net_val,
   ANY_VALUE(srha.return_outside_work_hr_net_val) AS return_outside_work_hr_net_val
  FROM SALES_RETURNS_HEADER_AGG AS srha
   INNER JOIN ldl_data_etl.t_tmp_product_retail_line AS PRL0 ON srha.retail_event_sid = PRL0.retail_event_sid
  GROUP BY srha.store_sid,
   srha.bus_dt,
   srha.cashier_nr,
   srha.event_end_hr), DISCOUNT_SCENARIOS_AGG AS (SELECT store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr,
   SUM(manual_discount_line_cnt) AS discount_line_cnt,
   SUM(manual_discount_net_val) AS discount_net_val
  FROM ldl_data_etl.t_tmp_discount_scenarios
  WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
   AND has_manual_discount_fg = 1
  GROUP BY store_sid,
   bus_dt,
   event_end_hr,
   cashier_nr), STORNO_SCENARIOS_AGG AS (SELECT store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr,
   SUM(total_cancelled_line_cnt) AS cancelled_line_cnt,
   SUM(total_cancelled_net_val) AS cancelled_net_val,
   SUM(total_cancelled_gross_val) AS cancelled_gross_val
  FROM ldl_data_etl.t_tmp_storno_scenarios
  WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
   AND important_prod_cancelled_line_cnt > 0
  GROUP BY store_sid,
   bus_dt,
   event_end_hr,
   cashier_nr), PRICE_INFO_AGG AS (SELECT store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr,
   COUNT(*) AS price_info_cnt
  FROM ldl_data_etl.t_tmp_price_check_scenarios
  WHERE cash_register_type_cd IN ('TIL', 'POS')
   OR cash_register_type_cd IS NULL
  GROUP BY store_sid,
   bus_dt,
   event_end_hr,
   cashier_nr), SUSPEND_RECEIPT_SCENARIOS_AGG AS (SELECT store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr,
   COUNT(*) AS suspended_unresolved_cnt,
   SUM(suspended_net_val) AS suspended_unresolved_net_val
  FROM ldl_data_etl.t_tmp_suspend_scenarios
  WHERE is_receipt_resolved_fg = 0
   AND (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
  GROUP BY store_sid,
   bus_dt,
   event_end_hr,
   cashier_nr), ABORT_SCENARIOS_AGG AS (SELECT store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr,
   COUNT(*) AS abort_cnt,
   SUM(CASE
     WHEN is_value_above_threshold_fg = 1
     THEN abort_net_val
     ELSE 0
     END) AS abort_net_val,
   SUM(CASE
     WHEN is_value_above_threshold_fg = 1
     THEN abort_gross_val
     ELSE 0
     END) AS abort_gross_val
  FROM ldl_data_etl.t_tmp_abort_scenarios
  WHERE cash_register_type_cd IN ('TIL', 'POS')
   OR cash_register_type_cd IS NULL
  GROUP BY store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr), RETURN_SCENARIOS_AGG AS (SELECT store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr,
   COUNT(*) AS return_cnt,
   SUM(return_net_val) AS return_net_val,
   SUM(CASE
     WHEN return_manual_line_cnt = 0
     THEN 0
     ELSE 1
     END) AS return_manual_receipt_cnt,
   SUM(return_manual_net_val) AS return_manual_receipt_net_val,
   SUM(CASE
     WHEN return_no_orig_line_cnt = 0
     THEN 0
     ELSE 1
     END) AS return_without_receipt_cnt,
   SUM(return_no_orig_net_val) AS return_without_receipt_net_val,
   SUM(return_items_qty) AS return_items_qty
  FROM ldl_data_etl.t_tmp_return_scenarios
  GROUP BY store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr), SMALL_SALE_SCENARIOS_AGG AS (SELECT store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr,
   COUNT(*) AS small_sale_cnt,
   SUM(small_sale_net_val) AS small_sale_net_val
  FROM ldl_data_etl.t_tmp_small_sale_scenarios
  WHERE cash_register_type_cd IN ('TIL', 'POS')
   OR cash_register_type_cd IS NULL
  GROUP BY store_sid,
   bus_dt,
   event_end_hr,
   cashier_nr), DEPOSIT_SCENARIOS_AGG AS (SELECT store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr,
   SUM(deposit_sales_net_val) AS deposit_sales_net_val,
   SUM(deposit_return_net_val) AS deposit_return_net_val,
   SUM(deposit_return_manual_input_net_val) AS deposit_return_manual_input_net_val,
   SUM(deposit_return_manual_input_gross_val) AS deposit_return_manual_input_gross_val,
   SUM(CASE
     WHEN non_deposit_lines_cnt = 0
     THEN deposit_return_net_val
     ELSE 0
     END) AS deposit_only_return_net_val
  FROM ldl_data_etl.t_tmp_deposit_scenarios
  GROUP BY store_sid,
   bus_dt,
   cashier_nr,
   event_end_hr), OUTLIER_DAYS_CALC AS (SELECT store_sid,
   bus_dt,
   cashier_nr,
   ABS(SUM(retail_net_val)) AS daily_retail_net_val,
   ABS(SUM(return_net_val)) AS daily_return_net_val,
   IF(ABS(SUM(retail_net_val)) = 0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))) AS
   daily_return_percentage,
    CASE
    WHEN IF(ABS(SUM(retail_net_val)) = 0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))) = 0
    THEN ABS(SUM(retail_net_val))
    ELSE CAST(- 1 AS BIGNUMERIC)
    END AS no_return_expr,
   RANK() OVER (PARTITION BY store_sid, cashier_nr ORDER BY IF(ABS(SUM(retail_net_val)) = 0, 0,
       SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))) IS NULL, IF(ABS(SUM(retail_net_val)) = 0,
       0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))), CASE
       WHEN IF(ABS(SUM(retail_net_val)) = 0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))) =
        0
       THEN ABS(SUM(retail_net_val))
       ELSE CAST(- 1 AS BIGNUMERIC)
       END IS NULL, CASE
       WHEN IF(ABS(SUM(retail_net_val)) = 0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))) =
        0
       THEN ABS(SUM(retail_net_val))
       ELSE CAST(- 1 AS BIGNUMERIC)
       END) AS highest_rnk,
   RANK() OVER (PARTITION BY store_sid, cashier_nr ORDER BY IF(ABS(SUM(retail_net_val)) = 0, 0,
       SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))) IS NULL, IF(ABS(SUM(retail_net_val)) = 0,
       0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))), CASE
       WHEN IF(ABS(SUM(retail_net_val)) = 0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))) =
        0
       THEN ABS(SUM(retail_net_val))
       ELSE CAST(- 1 AS BIGNUMERIC)
       END IS NULL DESC, CASE
       WHEN IF(ABS(SUM(retail_net_val)) = 0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))) =
        0
       THEN ABS(SUM(retail_net_val))
       ELSE CAST(- 1 AS BIGNUMERIC)
       END DESC) AS lowest_rnk,
    CASE
    WHEN (RANK() OVER (PARTITION BY store_sid, cashier_nr ORDER BY IF(ABS(SUM(retail_net_val)) = 0, 0,
          SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))) IS NULL, IF(ABS(SUM(retail_net_val)) =
           0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))), CASE
          WHEN IF(ABS(SUM(retail_net_val)) = 0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))
             )) = 0
          THEN ABS(SUM(retail_net_val))
          ELSE CAST(- 1 AS BIGNUMERIC)
          END IS NULL, CASE
          WHEN IF(ABS(SUM(retail_net_val)) = 0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))
             )) = 0
          THEN ABS(SUM(retail_net_val))
          ELSE CAST(- 1 AS BIGNUMERIC)
          END)) <= 2
    THEN TRUE
    WHEN (RANK() OVER (PARTITION BY store_sid, cashier_nr ORDER BY IF(ABS(SUM(retail_net_val)) = 0, 0,
          SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))) IS NULL, IF(ABS(SUM(retail_net_val)) =
           0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val)))), CASE
          WHEN IF(ABS(SUM(retail_net_val)) = 0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))
             )) = 0
          THEN ABS(SUM(retail_net_val))
          ELSE CAST(- 1 AS BIGNUMERIC)
          END IS NULL DESC, CASE
          WHEN IF(ABS(SUM(retail_net_val)) = 0, 0, SAFE_DIVIDE(ABS(SUM(return_net_val)) * 100, ABS(SUM(retail_net_val))
             )) = 0
          THEN ABS(SUM(retail_net_val))
          ELSE CAST(- 1 AS BIGNUMERIC)
          END DESC)) <= 2
    THEN TRUE
    ELSE FALSE
    END AS is_outlier_day_return_fg
  FROM SALES_RETURNS_AGG
  GROUP BY store_sid,
   bus_dt,
   cashier_nr
  HAVING ABS(SUM(retail_net_val)) + ABS(SUM(return_net_val)) > 0
  QUALIFY (SUM(daily_return_net_val) OVER (PARTITION BY store_sid, cashier_nr RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) <> 0) (SELECT wh.store_sid,
   wh.bus_dt,
   wh.cashier_nr,
   wh.event_end_hr,
   wh.sales_company_sid,
   wh.store_selected_fg,
   IFNULL(sra.sales_net_val, 0) AS sales_net_val,
   IFNULL(sra.return_net_val, 0) AS return_net_val,
   IFNULL(sra.sales_outside_work_hr_net_val, 0) AS sales_outside_work_hr_net_val,
   IFNULL(sra.return_outside_work_hr_net_val, 0) AS return_outside_work_hr_net_val,
   odc.is_outlier_day_return_fg,
     IFNULL(sra.retail_event_cnt, 0) + IFNULL(pia.price_info_cnt, 0) + IFNULL(tea.tech_events_cnt, 0) AS event_cnt,
     IFNULL(sra.retail_event_line_cnt, 0) + IFNULL(pia.price_info_cnt, 0) + IFNULL(tea.tech_events_cnt, 0) AS
   event_line_cnt,
   IFNULL(sra.return_event_cnt, 0) AS return_cnt,
   IFNULL(sra.return_outside_work_hr_cnt, 0) AS return_outside_work_hr_cnt,
   IFNULL(sra.sales_outside_work_hr_cnt, 0) AS sales_outside_work_hr_cnt,
   IFNULL(ssa.cancelled_line_cnt, 0) AS cancelled_line_cnt,
   IFNULL(ssa.cancelled_net_val, 0) AS cancelled_net_val,
   IFNULL(dsa.discount_line_cnt, 0) AS discount_line_cnt,
   IFNULL(dsa.discount_net_val, 0) AS discount_net_val,
   IFNULL(asa.abort_cnt, 0) AS abort_cnt,
   IFNULL(asa.abort_net_val, 0) AS abort_net_val,
   IFNULL(asa.abort_gross_val, 0) AS abort_gross_val,
   IFNULL(srsa.suspended_unresolved_cnt, 0) AS suspended_unresolved_cnt,
   IFNULL(srsa.suspended_unresolved_net_val, 0) AS suspended_unresolved_net_val,
   IFNULL(pia.price_info_cnt, 0) AS price_info_cnt,
   IFNULL(rsa.return_without_receipt_cnt, 0) AS return_without_receipt_cnt,
   IFNULL(rsa.return_without_receipt_net_val, 0) AS return_without_receipt_net_val,
   IFNULL(desa.deposit_sales_net_val, 0) AS deposit_sales_net_val,
   IFNULL(desa.deposit_return_net_val, 0) AS deposit_return_net_val,
   IFNULL(desa.deposit_return_manual_input_net_val, 0) AS deposit_return_manual_input_net_val,
   IFNULL(desa.deposit_return_manual_input_gross_val, 0) AS deposit_return_manual_input_gross_val,
   IFNULL(desa.deposit_only_return_net_val, 0) AS deposit_only_return_net_val,
   IFNULL(sssa.small_sale_cnt, 0) AS small_sales_cnt,
   IFNULL(tea.login_cnt, 0) AS login_cnt,
   IFNULL(tea.logoff_cnt, 0) AS logoff_cnt,
   IFNULL(rsa.return_manual_receipt_cnt, 0) AS return_manual_receipt_cnt,
   IFNULL(rsa.return_items_qty, 0) AS return_items_qty,
   IFNULL(sra.retail_net_val, 0) AS retail_net_val
  FROM WORKING_HOURS AS wh
   LEFT JOIN TECH_EVENTS_AGG AS tea ON wh.store_sid = tea.store_sid AND wh.bus_dt = tea.bus_dt AND wh.cashier_nr = tea.cashier_nr
       AND wh.event_end_hr = tea.event_end_hr
   LEFT JOIN SALES_RETURNS_AGG AS sra ON wh.store_sid = sra.store_sid AND wh.bus_dt = sra.bus_dt AND wh.cashier_nr = sra
      .cashier_nr AND wh.event_end_hr = sra.event_end_hr
   LEFT JOIN DISCOUNT_SCENARIOS_AGG AS dsa ON wh.store_sid = dsa.store_sid AND wh.bus_dt = dsa.bus_dt AND wh.cashier_nr
      = dsa.cashier_nr AND wh.event_end_hr = dsa.event_end_hr
   LEFT JOIN STORNO_SCENARIOS_AGG AS ssa ON wh.store_sid = ssa.store_sid AND wh.bus_dt = ssa.bus_dt AND wh.cashier_nr =
      ssa.cashier_nr AND wh.event_end_hr = ssa.event_end_hr
   LEFT JOIN PRICE_INFO_AGG AS pia ON wh.store_sid = pia.store_sid AND wh.bus_dt = pia.bus_dt AND wh.cashier_nr = pia.cashier_nr
       AND wh.event_end_hr = pia.event_end_hr
   LEFT JOIN SUSPEND_RECEIPT_SCENARIOS_AGG AS srsa ON wh.store_sid = srsa.store_sid AND wh.bus_dt = srsa.bus_dt AND wh.cashier_nr
       = srsa.cashier_nr AND wh.event_end_hr = srsa.event_end_hr
   LEFT JOIN ABORT_SCENARIOS_AGG AS asa ON wh.store_sid = asa.store_sid AND wh.bus_dt = asa.bus_dt AND wh.cashier_nr =
      asa.cashier_nr AND wh.event_end_hr = asa.event_end_hr
   LEFT JOIN RETURN_SCENARIOS_AGG AS rsa ON wh.store_sid = rsa.store_sid AND wh.bus_dt = rsa.bus_dt AND wh.cashier_nr =
      rsa.cashier_nr AND wh.event_end_hr = rsa.event_end_hr
   LEFT JOIN SMALL_SALE_SCENARIOS_AGG AS sssa ON wh.store_sid = sssa.store_sid AND wh.bus_dt = sssa.bus_dt AND wh.cashier_nr
       = sssa.cashier_nr AND wh.event_end_hr = sssa.event_end_hr
   LEFT JOIN DEPOSIT_SCENARIOS_AGG AS desa ON wh.store_sid = desa.store_sid AND wh.bus_dt = desa.bus_dt AND wh.cashier_nr
       = desa.cashier_nr AND wh.event_end_hr = desa.event_end_hr
   LEFT JOIN OUTLIER_DAYS_CALC AS odc ON wh.store_sid = odc.store_sid AND wh.bus_dt = odc.bus_dt AND wh.cashier_nr = odc
     .cashier_nr
  WHERE tea.store_sid IS NOT NULL
   OR sra.store_sid IS NOT NULL
   OR dsa.store_sid IS NOT NULL
   OR ssa.store_sid IS NOT NULL
   OR pia.store_sid IS NOT NULL
   OR srsa.store_sid IS NOT NULL
   OR asa.store_sid IS NOT NULL
   OR rsa.store_sid IS NOT NULL
   OR sssa.store_sid IS NOT NULL
   OR desa.store_sid IS NOT NULL);

--2.12

CREATE OR REPLACE TEMPORARY TABLE t_tmp_cashier_rankings_by_warehouse AS WITH AGG AS (SELECT STATS.sales_company_sid,
   STATS.store_sid,
   STATS.cashier_nr,
   ANY_VALUE(STATS.store_selected_fg) AS store_selected_fg,
    CASE
    WHEN MAX(CQ.cashier_nr) IS NULL
    THEN 0
    ELSE 1
    END AS is_cashier_qualified_fg,
   SUM(STATS.deposit_only_return_net_val) AS deposit_only_return_net_val,
   SUM(STATS.deposit_return_manual_input_gross_val) AS deposit_return_manual_input_gross_val,
   IF(SUM(STATS.deposit_sales_net_val) = 0, 0, SAFE_DIVIDE(SUM(STATS.deposit_return_net_val), SUM(STATS.deposit_sales_net_val
      ))) AS deposit_return_sales_percentage,
   IF(COUNT(DISTINCT STATS.bus_dt) = 0, 0, SAFE_DIVIDE(SUM(STATS.login_cnt), COUNT(DISTINCT STATS.bus_dt))) AS
   login_avg_cnt,
   SUM(STATS.small_sales_cnt) AS small_sales_cnt,
   SUM(STATS.return_cnt) AS return_cnt,
   SUM(STATS.return_manual_receipt_cnt) AS return_manual_receipt_cnt,
   IF(SUM(STATS.return_items_qty) = 0, 0, SAFE_DIVIDE(SUM(STATS.return_net_val), SUM(STATS.return_items_qty))) AS
   return_avg_val,
   ABS(IF(SUM(CASE
        WHEN STATS.is_outlier_day_return_fg = FALSE
        THEN STATS.retail_net_val
        ELSE 0
        END) = 0, 0, SAFE_DIVIDE(SUM(CASE
        WHEN STATS.is_outlier_day_return_fg = FALSE
        THEN STATS.return_net_val
        ELSE 0
        END), SUM(CASE
        WHEN STATS.is_outlier_day_return_fg = FALSE
        THEN STATS.retail_net_val
        ELSE 0
        END)))) AS return_retail_percentage,
   SUM(STATS.return_without_receipt_cnt) AS return_without_receipt_cnt,
   SUM(STATS.suspended_unresolved_cnt) AS suspended_unresolved_cnt,
   SUM(STATS.abort_net_val) AS abort_val,
   SUM(STATS.abort_cnt) AS abort_cnt,
   IF(SUM(STATS.event_cnt) = 0, 0, SAFE_DIVIDE(SUM(STATS.cancelled_line_cnt), SUM(STATS.event_cnt))) AS
   cancelled_line_cnt_percentage,
   IF(SUM(STATS.retail_net_val) = 0, 0, SAFE_DIVIDE(SUM(STATS.cancelled_net_val), SUM(STATS.retail_net_val))) AS
   cancelled_line_val_percentage,
   SUM(STATS.price_info_cnt) AS price_info_cnt,
   SUM(STATS.discount_line_cnt) AS discount_line_cnt,
   IF(SUM(STATS.retail_net_val) = 0, 0, SAFE_DIVIDE(SUM(STATS.discount_net_val), SUM(STATS.retail_net_val))) AS
   discount_line_val_percentage
  FROM ldl_data_etl.t_tmp_store_cashier_by_hour_statistics AS STATS
   LEFT JOIN ldl_data_etl.t_tmp_cashiers_qualified AS CQ ON STATS.store_sid = CQ.store_sid AND STATS.bus_dt = CQ.bus_dt
    AND STATS.cashier_nr = CQ.cashier_nr
  GROUP BY STATS.sales_company_sid,
   STATS.store_sid,
   STATS.cashier_nr) (SELECT sales_company_sid,
   store_sid,
   cashier_nr,
   store_selected_fg,
   is_cashier_qualified_fg,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, deposit_only_return_net_val IS NULL DESC, deposit_only_return_net_val DESC) AS
   rnk_deposit_only_return_val,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, deposit_return_manual_input_gross_val IS NULL DESC,
      deposit_return_manual_input_gross_val DESC) AS rnk_deposit_manual_input_val,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, deposit_return_sales_percentage IS NULL DESC, deposit_return_sales_percentage DESC)
   AS rnk_deposit_return_sales_percentage,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, login_avg_cnt IS NULL DESC, login_avg_cnt DESC) AS rnk_login_avg_cnt,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, small_sales_cnt IS NULL DESC, small_sales_cnt DESC) AS rnk_small_sales_cnt,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, return_cnt IS NULL DESC, return_cnt DESC) AS rnk_return_cnt,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, return_manual_receipt_cnt IS NULL DESC, return_manual_receipt_cnt DESC) AS
   rnk_return_manual_receipt_cnt,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, return_avg_val IS NULL DESC, return_avg_val DESC) AS rnk_return_avg_val,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, return_retail_percentage IS NULL DESC, return_retail_percentage DESC) AS
   rnk_return_retail_percentage,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, return_without_receipt_cnt IS NULL DESC, return_without_receipt_cnt DESC) AS
   rnk_return_without_receipt_cnt,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, suspended_unresolved_cnt IS NULL DESC, suspended_unresolved_cnt DESC) AS
   rnk_suspended_unresolved_cnt,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, abort_val IS NULL DESC, abort_val DESC) AS rnk_abort_val,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, abort_cnt IS NULL DESC, abort_cnt DESC) AS rnk_abort_cnt,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, cancelled_line_cnt_percentage IS NULL DESC, cancelled_line_cnt_percentage DESC) AS
   rnk_cancelled_line_cnt_percentage,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, cancelled_line_val_percentage IS NULL DESC, cancelled_line_val_percentage DESC) AS
   rnk_cancelled_line_val_percentage,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, price_info_cnt IS NULL DESC, price_info_cnt DESC) AS rnk_price_info_cnt,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, discount_line_cnt IS NULL DESC, discount_line_cnt DESC) AS rnk_discount_line_cnt,
   RANK() OVER (PARTITION BY sales_company_sid ORDER BY is_cashier_qualified_fg IS NULL DESC,
      is_cashier_qualified_fg DESC, discount_line_val_percentage IS NULL DESC, discount_line_val_percentage DESC) AS
   rnk_discount_line_val_percentage
  FROM AGG);

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Load Targets 
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--3.0
--delete before insert to update receipts information in case it comes with changes for the same period

DELETE FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification AS C
WHERE scenario_id IN (SELECT scenario_id
   FROM ldl_data_core_app_fraud_detection.t_fraud_detection_scenario AS S
   WHERE scenario_type_cd = 'MAN') AND (store_sid, bus_dt) IN (SELECT (store_sid, bus_dt)
   FROM (SELECT DISTINCT store_sid,
      bus_dt
     FROM ldl_data_etl.t_stores_qualified) AS t3);


DELETE FROM ldl_data_core_app_fraud_detection.t_statistics_by_store_hour_cashier AS C
WHERE (int_org_sid, bus_dt) IN (SELECT (store_sid, bus_dt)
  FROM (SELECT DISTINCT store_sid,
     bus_dt
    FROM ldl_data_etl.t_stores_qualified) AS t1);
-- we want to delete the data for all cashiers and all scenarios for these stores
-- this is why STORE_SID as filter is enough

DELETE FROM ldl_data_core_app_fraud_detection.t_cashier_ranking_by_fraud_scenario AS TRG
WHERE store_sid IN (SELECT store_sid
  FROM ldl_data_etl.t_stores_qualified AS SQ);


INSERT INTO ldl_data_core_app_fraud_detection.t_cash_register_event_classification (cash_register_event_sid,
 cash_register_event_nr, scenario_id, country_org_cd, store_sid, bus_dt, event_end_hr, cashier_nr, cust_sid,
 cust_ident_type_cd, cash_register_event_cnt, cash_register_event_affected_line_cnt,
 cash_register_event_affected_gross_val, cash_register_event_affected_net_val, dwh_created_tmsp, dwh_updated_tmsp,
 dwh_load_id, dwh_node_cd)
WITH ENABLED_SCENARIOS AS (SELECT DISTINCT scenario_id,
    country_org_cd
   FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
   WHERE is_scenario_enabled_in_country_fg) (SELECT cash_register_event_sid,
    SUBSTR(CAST(cash_register_event_nr AS STRING), 1, 20) AS cash_register_event_nr,
    scenario_id,
    country_org_cd,
    store_sid,
    bus_dt,
    event_end_hr,
    cashier_nr,
    cust_sid,
    cust_ident_type_cd,
    cash_register_event_cnt,
    cash_register_event_affected_line_cnt,
    cash_register_event_affected_gross_val,
    cash_register_event_affected_net_val,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
   FROM (WITH ENABLED_SCENARIOS AS (SELECT DISTINCT scenario_id,
         country_org_cd
        FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
        WHERE is_scenario_enabled_in_country_fg), GATHER_ALL_KPIS AS (SELECT cash_register_event_sid,
          cash_register_event_nr,
          38 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          manual_discount_line_cnt AS cash_register_event_affected_line_cnt,
          manual_discount_net_val AS cash_register_event_affected_net_val,
          manual_discount_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_discount_scenarios AS DS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 38)
          AND has_manual_discount_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          39 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          manual_discount_line_cnt AS cash_register_event_affected_line_cnt,
          manual_discount_net_val AS cash_register_event_affected_net_val,
          manual_discount_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_discount_scenarios AS DS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 39)
          AND has_manual_discount_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          53 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          discount_line_cnt AS cash_register_event_affected_line_cnt,
          discount_net_val AS cash_register_event_affected_net_val,
          discount_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_discount_scenarios AS DS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 53)
          AND has_manual_discount_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          54 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          manual_discount_line_cnt AS cash_register_event_affected_line_cnt,
          manual_discount_net_val AS cash_register_event_affected_net_val,
          manual_discount_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_discount_scenarios AS DS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 54)
          AND has_many_discounted_lines_fg = 1
          AND has_manual_discount_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          55 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          manual_discount_line_cnt AS cash_register_event_affected_line_cnt,
          manual_discount_net_val AS cash_register_event_affected_net_val,
          manual_discount_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_discount_scenarios AS DS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 55)
          AND has_high_value_discount_fg = 1
          AND has_manual_discount_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          72 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          manual_discount_line_cnt AS cash_register_event_affected_line_cnt,
          manual_discount_net_val AS cash_register_event_affected_net_val,
          manual_discount_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_discount_scenarios AS DS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 72)
          AND has_manual_discount_fg = 1
          AND is_outside_work_hr_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          34 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          total_cancelled_line_cnt AS cash_register_event_affected_line_cnt,
          total_cancelled_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_storno_scenarios AS TSS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 34)
          AND important_prod_cancelled_line_cnt > 0
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          35 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          total_cancelled_line_cnt AS cash_register_event_affected_line_cnt,
          total_cancelled_net_val AS cash_register_event_affected_net_val,
          total_cancelled_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_storno_scenarios AS TSS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 35)
          AND important_prod_cancelled_line_cnt > 0
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          59 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          total_cancelled_line_cnt AS cash_register_event_affected_line_cnt,
          total_cancelled_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_storno_scenarios AS TSS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 59)
          AND important_prod_cancelled_line_cnt > 0
          AND has_many_cancelled_lines_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          60 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          total_cancelled_line_cnt AS cash_register_event_affected_line_cnt,
          total_cancelled_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_storno_scenarios AS TSS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 60)
          AND important_prod_cancelled_line_cnt > 0
          AND cancel_last_pos_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          61 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          total_cancelled_line_cnt AS cash_register_event_affected_line_cnt,
          total_cancelled_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_storno_scenarios AS TSS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 61)
          AND important_prod_cancelled_line_cnt > 0
          AND cancel_outside_work_hr_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          36 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          1 AS cash_register_event_affected_line_cnt,
          0 AS cash_register_event_affected_net_val,
          txn_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_price_check_scenarios AS TPCS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 36)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          47 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          1 AS cash_register_event_affected_line_cnt,
          0 AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_price_check_scenarios AS TPCS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 47)
          AND is_non_food_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          48 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          1 AS cash_register_event_affected_line_cnt,
          0 AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_price_check_scenarios AS TPCS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 48)
          AND is_tobacco_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          49 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          1 AS cash_register_event_affected_line_cnt,
          0 AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_price_check_scenarios AS TPCS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 49)
          AND is_alcohol_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          50 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          1 AS cash_register_event_affected_line_cnt,
          0 AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_price_check_scenarios AS TPCS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 50)
          AND is_multi_pie_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          51 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          1 AS cash_register_event_affected_line_cnt,
          0 AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_price_check_scenarios AS TPCS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 51)
          AND is_next_logoff_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          52 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          1 AS cash_register_event_affected_line_cnt,
          0 AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_price_check_scenarios AS TPCS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 52)
          AND is_next_small_sale_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          70 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          1 AS cash_register_event_affected_line_cnt,
          0 AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_price_check_scenarios AS TPCS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 70)
          AND is_outside_work_hr_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          31 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          suspended_cnt AS cash_register_event_affected_line_cnt,
          suspended_net_val AS cash_register_event_affected_net_val,
          suspended_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_suspend_scenarios AS SS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND is_receipt_resolved_fg = 0
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 31)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          42 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          suspended_cnt AS cash_register_event_affected_line_cnt,
          suspended_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_suspend_scenarios AS SS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 42)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          68 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          suspended_cnt AS cash_register_event_affected_line_cnt,
          suspended_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_suspend_scenarios AS SS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 68)
          AND is_receipt_resolved_fg = 0
          AND (is_next_logoff_fg = 1 OR is_next_small_sale_fg = 1)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          680100 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          suspended_cnt AS cash_register_event_affected_line_cnt,
          suspended_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_suspend_scenarios AS SS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 68)
          AND is_receipt_resolved_fg = 0
          AND is_next_small_sale_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          680200 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          suspended_cnt AS cash_register_event_affected_line_cnt,
          suspended_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_suspend_scenarios AS SS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 68)
          AND is_receipt_resolved_fg = 0
          AND is_next_logoff_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          69 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          suspended_cnt AS cash_register_event_affected_line_cnt,
          suspended_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_suspend_scenarios AS SS
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 69)
          AND is_outside_work_hr_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          32 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          cash_register_abort_cnt AS cash_register_event_affected_line_cnt,
          abort_net_val AS cash_register_event_affected_net_val,
          abort_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_abort_scenarios AS AB_S
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND is_value_above_threshold_fg = 1
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 32)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          33 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          cash_register_abort_cnt AS cash_register_event_affected_line_cnt,
          abort_net_val AS cash_register_event_affected_net_val,
          abort_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_abort_scenarios AS AB_S
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 33)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          71 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          cash_register_abort_cnt AS cash_register_event_affected_line_cnt,
          abort_net_val AS cash_register_event_affected_net_val,
          abort_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_abort_scenarios AS AB_S
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 71)
          AND is_outside_work_hr_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          67 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          cash_register_abort_cnt AS cash_register_event_affected_line_cnt,
          abort_net_val AS cash_register_event_affected_net_val,
          abort_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_abort_scenarios AS AB_S
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 67)
          AND (is_next_logoff_fg = 1 OR is_next_small_sale_fg = 1)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          670100 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          cash_register_abort_cnt AS cash_register_event_affected_line_cnt,
          abort_net_val AS cash_register_event_affected_net_val,
          abort_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_abort_scenarios AS AB_S
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 67)
          AND is_next_small_sale_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          670200 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          cash_register_abort_cnt AS cash_register_event_affected_line_cnt,
          abort_net_val AS cash_register_event_affected_net_val,
          abort_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_abort_scenarios AS AB_S
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 67)
          AND is_next_logoff_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          26 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_line_cnt AS cash_register_event_affected_line_cnt,
          return_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios AS R_S
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 26)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          28 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_line_cnt AS cash_register_event_affected_line_cnt,
          return_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios AS R_S
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 28)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          29 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_line_cnt AS cash_register_event_affected_line_cnt,
          return_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios AS R_S
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 29)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          27 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_manual_line_cnt AS cash_register_event_affected_line_cnt,
          return_manual_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios AS MR_S
         WHERE return_manual_line_cnt > 0
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 27)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          30 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_no_orig_line_cnt AS cash_register_event_affected_line_cnt,
          return_no_orig_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios AS NOR_S
         WHERE return_no_orig_line_cnt > 0
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 30)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          41 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_line_cnt AS cash_register_event_affected_line_cnt,
          return_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios AS RSDC_S
         WHERE is_same_cashier_day_fg = 1
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 41)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          43 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_scanned_line_cnt AS cash_register_event_affected_line_cnt,
          return_scanned_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios AS RS_S
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 43)
          AND return_scanned_line_cnt > 0
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          44 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_manual_no_dv_line_cnt AS cash_register_event_affected_line_cnt,
          return_manual_no_dv_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios AS RM_NODV_S
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 44)
          AND return_manual_no_dv_line_cnt > 0
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          45 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_manual_dv_line_cnt AS cash_register_event_affected_line_cnt,
          return_manual_dv_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios AS RM_DV_S
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 45)
          AND return_manual_dv_line_cnt > 0
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          46 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_line_cnt AS cash_register_event_affected_line_cnt,
          return_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios AS RSC_S
         WHERE is_same_cashier_fg = 1
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 46)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          65 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_line_cnt AS cash_register_event_affected_line_cnt,
          return_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 65)
          AND is_outside_work_hr_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          64 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_line_cnt AS cash_register_event_affected_line_cnt,
          return_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 64)
          AND has_cash_payment_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          63 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          return_ls_line_cnt AS cash_register_event_affected_line_cnt,
          return_ls_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_return_scenarios
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 63)
          AND return_ls_line_cnt > 0
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          25 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          small_sale_line_cnt AS cash_register_event_affected_line_cnt,
          small_sale_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_small_sale_scenarios AS SS_S
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 25)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          73 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          small_sale_line_cnt AS cash_register_event_affected_line_cnt,
          small_sale_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_small_sale_scenarios AS SS_S
         WHERE (cash_register_type_cd IN ('TIL', 'POS') OR cash_register_type_cd IS NULL)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 73)
          AND is_outside_work_hr_fg = 1
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          24 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          logon_logoff_line_cnt AS cash_register_event_affected_line_cnt,
          logon_logoff_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_tech_events AS LL_S
         WHERE CAST(tech_cash_register_event_type_cd AS INTEGER) IN (410, 415)
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 24)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          23 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
           sold_deposit_line_cnt + returned_deposit_line_cnt AS cash_register_event_affected_line_cnt,
           deposit_sales_net_val + deposit_return_net_val AS cash_register_event_affected_net_val,
           deposit_sales_gross_val + deposit_return_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_deposit_scenarios AS DG_S
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 23)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          22 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          deposit_return_manual_input_lines_cnt AS cash_register_event_affected_line_cnt,
          deposit_return_manual_input_net_val AS cash_register_event_affected_net_val,
          deposit_return_manual_input_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_deposit_scenarios AS DM_S
         WHERE deposit_return_manual_input_lines_cnt > 0
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 22)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          21 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          returned_deposit_line_cnt AS cash_register_event_affected_line_cnt,
          deposit_return_net_val AS cash_register_event_affected_net_val,
          deposit_return_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_deposit_scenarios AS DO_S
         WHERE non_deposit_lines_cnt = 0
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 21)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          56 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          returned_deposit_line_cnt AS cash_register_event_affected_line_cnt,
          deposit_return_net_val AS cash_register_event_affected_net_val,
          deposit_return_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_deposit_scenarios AS DO_S
         WHERE returned_deposit_line_cnt > 0
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 56)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          57 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          deposit_return_manual_input_lines_cnt AS cash_register_event_affected_line_cnt,
          deposit_return_manual_input_net_val AS cash_register_event_affected_net_val,
          deposit_return_manual_input_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_deposit_scenarios AS DO_S
         WHERE non_deposit_lines_cnt = 0
          AND deposit_return_manual_input_lines_cnt = returned_deposit_line_cnt
          AND country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 57)
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          62 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          returned_deposit_line_cnt AS cash_register_event_affected_line_cnt,
          deposit_return_net_val AS cash_register_event_affected_net_val,
          deposit_return_gross_val AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_deposit_scenarios AS DG_S
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 62)
          AND is_outside_work_hr_fg = 1
          AND returned_deposit_line_cnt > 0
         UNION ALL
         SELECT cash_register_event_sid,
          cash_register_event_nr,
          40 AS scenario_id,
          country_org_cd,
          store_sid,
          bus_dt,
          event_end_hr,
          cust_sid,
          cust_ident_type_cd,
          cashier_nr,
          1 AS cash_register_event_cnt,
          event_line_cnt AS cash_register_event_affected_line_cnt,
          event_net_val AS cash_register_event_affected_net_val,
          CAST(NULL AS BIGNUMERIC) AS cash_register_event_affected_gross_val
         FROM ldl_data_etl.t_tmp_lidl_plus_scenarios AS LPS
         WHERE country_org_cd IN (SELECT country_org_cd
            FROM ENABLED_SCENARIOS
            WHERE scenario_id = 40)) (SELECT cash_register_event_sid,
         cash_register_event_nr,
         scenario_id,
         country_org_cd,
         store_sid,
         bus_dt,
         event_end_hr,
         IFNULL(cust_sid, - 1) AS cust_sid,
         IFNULL(cust_ident_type_cd, '@') AS cust_ident_type_cd,
         cashier_nr,
         cash_register_event_cnt,
         cash_register_event_affected_line_cnt,
         cash_register_event_affected_net_val,
         cash_register_event_affected_gross_val,
         CURRENT_TIMESTAMP() AS dwh_created_tmsp,
         CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
         ${LOAD_ID} AS dwh_load_id,
         'CORE_REL' AS dwh_node_cd
        FROM GATHER_ALL_KPIS
        ORDER BY bus_dt NULLS LAST)));


INSERT INTO ldl_data_core_app_fraud_detection.t_statistics_by_store_hour_cashier (int_org_sid, bus_dt, cashier_nr,
 event_end_hr, sales_net_val, return_net_val, event_cnt, event_line_cnt, return_cnt, cancelled_line_cnt,
 cancelled_net_val, discount_line_cnt, discount_net_val, abort_cnt, abort_net_val, abort_gross_val,
 suspended_unresolved_cnt, suspended_unresolved_net_val, price_info_cnt, return_without_receipt_cnt,
 return_without_receipt_net_val, is_outlier_day_return_fg, deposit_sales_net_val, deposit_return_net_val,
 deposit_return_manual_input_net_val, deposit_return_manual_input_gross_val, deposit_only_return_net_val,
 small_sales_cnt, login_cnt, logoff_cnt, sales_outside_work_hr_net_val, return_outside_work_hr_net_val,
 sales_outside_work_hr_cnt, return_outside_work_hr_cnt, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
(SELECT store_sid,
  bus_dt,
  cashier_nr,
  event_end_hr,
  sales_net_val,
  return_net_val,
  event_cnt,
  event_line_cnt,
  return_cnt,
  cancelled_line_cnt,
  cancelled_net_val,
  discount_line_cnt,
  discount_net_val,
  abort_cnt,
  abort_net_val,
  abort_gross_val,
  suspended_unresolved_cnt,
  suspended_unresolved_net_val,
  price_info_cnt,
  return_without_receipt_cnt,
  return_without_receipt_net_val,
  is_outlier_day_return_fg,
  deposit_sales_net_val,
  deposit_return_net_val,
  deposit_return_manual_input_net_val,
  deposit_return_manual_input_gross_val,
  deposit_only_return_net_val,
  small_sales_cnt,
  login_cnt,
  logoff_cnt,
  sales_outside_work_hr_net_val,
  return_outside_work_hr_net_val,
  sales_outside_work_hr_cnt,
  return_outside_work_hr_cnt,
  CURRENT_TIMESTAMP() AS dwh_created_tmsp,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
  ${LOAD_ID} AS dwh_load_id,
  'CORE_REL' AS dwh_node_cd
 FROM ldl_data_etl.t_tmp_store_cashier_by_hour_statistics);


INSERT INTO ldl_data_core_app_fraud_detection.t_cashier_ranking_by_fraud_scenario (sales_company_sid, store_sid,
 cashier_nr, scenario_id, rank_seq, relevant_for_manual_report_fg, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id,
 dwh_node_cd)
WITH MATERIALIZE_PARAM_VIEW AS (SELECT scenario_id,
    country_org_cd,
    MAX(CASE
      WHEN param_id IN (65, 68, 71, 74, 78, 79, 82, 85, 88, 91, 94, 98, 101, 107, 110, 113, 119, 122)
      THEN param_val_qty
      ELSE NULL
      END) AS scenario_rank_threshold
   FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
   WHERE scenario_id BETWEEN 21 AND 39
    AND is_scenario_enabled_in_country_fg
   GROUP BY scenario_id,
    country_org_cd
   HAVING scenario_rank_threshold IS NOT NULL) (SELECT CR.sales_company_sid,
    CR.store_sid,
    CR.cashier_nr,
    mpv.scenario_id,
     CASE
     WHEN mpv.scenario_id IN (21)
     THEN CR.rnk_deposit_only_return_val
     WHEN mpv.scenario_id IN (22)
     THEN CR.rnk_deposit_manual_input_val
     WHEN mpv.scenario_id IN (23)
     THEN CR.rnk_deposit_return_sales_percentage
     WHEN mpv.scenario_id IN (24)
     THEN CR.rnk_login_avg_cnt
     WHEN mpv.scenario_id IN (25)
     THEN CR.rnk_small_sales_cnt
     WHEN mpv.scenario_id IN (26)
     THEN CR.rnk_return_cnt
     WHEN mpv.scenario_id IN (27)
     THEN CR.rnk_return_manual_receipt_cnt
     WHEN mpv.scenario_id IN (28)
     THEN CR.rnk_return_avg_val
     WHEN mpv.scenario_id IN (29)
     THEN CR.rnk_return_retail_percentage
     WHEN mpv.scenario_id IN (30)
     THEN CR.rnk_return_without_receipt_cnt
     WHEN mpv.scenario_id IN (31)
     THEN CR.rnk_suspended_unresolved_cnt
     WHEN mpv.scenario_id IN (32)
     THEN CR.rnk_abort_val
     WHEN mpv.scenario_id IN (33)
     THEN CR.rnk_abort_cnt
     WHEN mpv.scenario_id IN (34)
     THEN CR.rnk_cancelled_line_cnt_percentage
     WHEN mpv.scenario_id IN (35)
     THEN CR.rnk_cancelled_line_val_percentage
     WHEN mpv.scenario_id IN (36)
     THEN CR.rnk_price_info_cnt
     WHEN mpv.scenario_id IN (38)
     THEN CR.rnk_discount_line_cnt
     WHEN mpv.scenario_id IN (39)
     THEN CR.rnk_discount_line_val_percentage
     ELSE NULL
     END AS rank_seq,
       CASE
       WHEN mpv.scenario_id IN (21)
       THEN CR.rnk_deposit_only_return_val
       WHEN mpv.scenario_id IN (22)
       THEN CR.rnk_deposit_manual_input_val
       WHEN mpv.scenario_id IN (23)
       THEN CR.rnk_deposit_return_sales_percentage
       WHEN mpv.scenario_id IN (24)
       THEN CR.rnk_login_avg_cnt
       WHEN mpv.scenario_id IN (25)
       THEN CR.rnk_small_sales_cnt
       WHEN mpv.scenario_id IN (26)
       THEN CR.rnk_return_cnt
       WHEN mpv.scenario_id IN (27)
       THEN CR.rnk_return_manual_receipt_cnt
       WHEN mpv.scenario_id IN (28)
       THEN CR.rnk_return_avg_val
       WHEN mpv.scenario_id IN (29)
       THEN CR.rnk_return_retail_percentage
       WHEN mpv.scenario_id IN (30)
       THEN CR.rnk_return_without_receipt_cnt
       WHEN mpv.scenario_id IN (31)
       THEN CR.rnk_suspended_unresolved_cnt
       WHEN mpv.scenario_id IN (32)
       THEN CR.rnk_abort_val
       WHEN mpv.scenario_id IN (33)
       THEN CR.rnk_abort_cnt
       WHEN mpv.scenario_id IN (34)
       THEN CR.rnk_cancelled_line_cnt_percentage
       WHEN mpv.scenario_id IN (35)
       THEN CR.rnk_cancelled_line_val_percentage
       WHEN mpv.scenario_id IN (36)
       THEN CR.rnk_price_info_cnt
       WHEN mpv.scenario_id IN (38)
       THEN CR.rnk_discount_line_cnt
       WHEN mpv.scenario_id IN (39)
       THEN CR.rnk_discount_line_val_percentage
       ELSE NULL
       END <= mpv.scenario_rank_threshold OR CR.store_selected_fg = 1 AS relevant_for_manual_report_fg,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
    ${LOAD_ID} AS dwh_load_id,
    'CORE_REL' AS dwh_node_cd
   FROM ldl_data_etl.t_tmp_cashier_rankings_by_warehouse AS CR
    INNER JOIN ldl_data_core_dim.t_dim_internal_organization AS IO ON CR.store_sid = IO.int_org_sid AND IO.dwh_valid_fg
    INNER JOIN MATERIALIZE_PARAM_VIEW AS mpv ON IO.country_org_cd = mpv.country_org_cd);

    END;