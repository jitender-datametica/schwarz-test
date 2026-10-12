CREATE OR REPLACE VIEW kfl_production_dbp_view.v_nfmd_article_store_scorecard (mandant_id
OPTIONS(description='Mandant im DWH'), aktion_id OPTIONS(description='Unique identifier of the NFMD campaign'), art_id
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wup_id OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'), discount_type_name
OPTIONS(description='Describes the discount type for this article in the given store and promotion campaing. "nfmd" - is the defatult, initial discount. "second_discount" means the price of the product has been reduced for a second time in the same promotion.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), wg_id OPTIONS(description='Warengruppenid'),
kjwo_ww OPTIONS(description='Calendar year-week when the promotion campaign started. Format JJJJWW'), promo_start_dt
OPTIONS(description='Date when the promotion campaign starts'), selling_price_gross_local_val
OPTIONS(description='semi additive - gross selling price of a single article in currency expressed in column WRG_ID'),
promo_stores_cnt OPTIONS(description='semi additive - Number (count) of stores where the promotion is active'),
parameter_config OPTIONS(description='Not in use. Populated always with PARAM_A'), cluster_config
OPTIONS(description='Not in use. Populated always with CLUSTER_A'), promo_week_sell_rate
OPTIONS(description='non additive - percentage of the stock sold in the first week of the campaign  ( 0.0 to 1.0)'),
model_price_gross_local_val
OPTIONS(description='non additive - gross retail price recommended by the AI model (in local currency)'),
sales_promo_week_cnt OPTIONS(description='semi additive - sales in the first campaign week'), model_discount_opt_rate
OPTIONS(description='non additive - Discount percent recommended by the AI model as fraction of 1 (ex 0.70)'),
sales_total_cnt OPTIONS(description='semi additive - total number of articles sold'), stock_initial_cnt
OPTIONS(description='semi additive - stock count  at the beginning of campaign'), current_discount_rate
OPTIONS(description='non additive - current discount  as fraction of 1 (ex. -0,10)'), current_week_nr
OPTIONS(description='current week of the promotion ( ex 2 - second week of promotion)'), current_sell_rate
OPTIONS(description='non additive - percentage of the stock that is currently sold (as fraction of 1)'),
remaining_weeks_cnt OPTIONS(description='non additive - how many weeks are left of the promotion'), remaining_stock_cnt
OPTIONS(description='semi additive - stock count currently remaining'), total_revenue_gross_local_val
OPTIONS(description='additive - total revenue amount of the prmotion to date (since start till this week inclusive)'),
revenue_last_week_gross_local_val OPTIONS(description='additive -  revenue amount for this promotion in the last week '),
model_execution_tmsp OPTIONS(description='timestamp when the AI model was executed'), ai_model_id
OPTIONS(description='Unique identifier of the AI model'), curve_type_cd
OPTIONS(description='Type of model curve for this Store and Article'), rule_created_dt
OPTIONS(description='creation date of the rule matrix for this Store and Article'), is_in_experiment_fg
OPTIONS(description='Flag indicating if this an experiment'), experiment_group_cd
OPTIONS(description='For A/B testing this shows if this is the "A" group or the "B" group'), experiment_stores_cnt
OPTIONS(description='semi additive - Number of stores which are part of this experiment'), display_art_id
OPTIONS(description='Artikelnummer des Display-Artikels (the display component ID if an article is display article )'),
rule_decision_record
OPTIONS(description='the four dimentions of a rule matrix concatenated as a string (curve_type_cd, hwg_id, price_class_cd, sell_wk34_from_wk3_rate)'),
sell_ratio_wk12
OPTIONS(description='non additive. sell ratio - all items sold in week 1 and 2 relative to the initial stock count'),
sell_ratio_wk123
OPTIONS(description='non additive. sell ratio - all items sold in week 1, 2 and 3 relative to the initial stock count'),
orig_promo_start_dt
OPTIONS(description='"Standart" Promotion cycle is 6,7 or 8 days long.In cases when have promotions that are 2,3,4 or 5 days long we say they have "Short" Promotion Cycle.If a "Short" promotion cycle completely fits into a 6,7,8-day time interval of a single standart promotion,  then we expand the interval of the short promotion and overwrite the Start and End date.This is done so we can associate this "Short" promotion cycle with a single "Standart" promotion cycle.Still we need to keep the original dates also. So in this column we have the originial Start Date (of the non-standart promotion cycle)'),
orig_promo_end_dt
OPTIONS(description='"Standart" Promotion cycle is 6,7 or 8 days long.In cases when have promotions that are 2,3,4 or 5 days long we say they have "Short" Promotion Cycle.If a "Short" promotion cycle completely fits into a 6,7,8-day time interval of a single standart promotion,  then we expand the interval of the short promotion and overwrite the Start and End date.This is done so we can associate this "Short" promotion cycle with a single "Standart" promotion cycle.Still we need to keep the original dates also. So in this column we have the originial End  Date (of the non-standart promotion cycle)'),
orig_promo_cycle_type_name
OPTIONS(description='"Standart" Promotion cycle is 6,7 or 8 days long.In cases when have promotions that are 2,3,4 or 5 days long we say they have "Short" Promotion Cycle.If a "Short" promotion cycle completely fits into a 6,7,8-day time interval of a single standart promotion,  then we expand the interval of the short promotion and overwrite the Start and End date.This is done so we can associate this "Short" promotion cycle with a single "Standart" promotion cycle.Still we need to keep the original cycle type of the promotion (Short, Custom ...). This field keeps the original value of the promotion cycle type'),
second_discount_start_dt
OPTIONS(description='For products that have their price reduced for a second time in the same campaing, this is the date on which the second dicount takes effect.'),
second_discount_end_dt
OPTIONS(description='For products that have their price reduced for a second time in the same campaing, this is the date on which the second dicount expires.'),
discount_base_gross_local_val
OPTIONS(description='Base gross price for second discount calculation in currency expressed in column WRG_ID'))
OPTIONS(DESCRIPTION = `The table contains discount suggestions for each article-market combination, for a promotion campaign. . Data is retained for certain number of  weeks controlled by a patameter in NFMD_PARAMETER table. After that older data is removed`)
AS SELECT mandant_id,
 aktion_id,
 art_id,
 wup_id,
 discount_type_name,
 wrg_id,
 wg_id,
 kjwo_ww,
 promo_start_dt,
 selling_price_gross_local_val,
 promo_stores_cnt,
 parameter_config,
 cluster_config,
 promo_week_sell_rate,
 model_price_gross_local_val,
 sales_promo_week_cnt,
 model_discount_opt_rate,
 sales_total_cnt,
 stock_initial_cnt,
 current_discount_rate,
 current_week_nr,
 current_sell_rate,
 remaining_weeks_cnt,
 remaining_stock_cnt,
 total_revenue_gross_local_val,
 revenue_last_week_gross_local_val,
 model_execution_tmsp,
 ai_model_id,
 curve_type_cd,
 rule_created_dt,
 is_in_experiment_fg,
 experiment_group_cd,
 experiment_stores_cnt,
 display_art_id,
 rule_decision_record,
 sell_ratio_wk12,
 sell_ratio_wk123,
 orig_promo_start_dt,
 orig_promo_end_dt,
 orig_promo_cycle_type_name,
 second_discount_start_dt,
 second_discount_end_dt,
 discount_base_gross_local_val
FROM kfl_production_dbp_data.nfmd_article_store_scorecard;