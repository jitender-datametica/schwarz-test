/* 
This view calculates all inventory turnovers and inventory differences for all stores (actual values, business year cumulations and variances from plan values).
*/
CREATE OR REPLACE VIEW core_dim.v_fact_inventory_difference_2 (
	country_org_cd COMMENT 'The code of the business country_2 for which the related country_2 organization is responsible. (The business country_2 is not identical to a political country.)',
	int_org_sid COMMENT 'The unique identifier (surrogate key) for the store or warehouse, where the inventory was done.',
	int_org_type_cd COMMENT 'The code identifying the discriminators for internal organizations',
	curr_int_org_nr COMMENT 'The number by which the internal organization is currently known to business. (This number may change over time)',
	int_org_name COMMENT 'The name of the internal organization.',
	cal_dt COMMENT 'The date for which the inventory was done.',
	bus_year COMMENT 'Business year of the inventory',
	cal_month COMMENT 'Calendar_2 month of the inventory',
	cal_week COMMENT 'Calendar_2 week of the inventory',
	last_day_of_bus_year_fg  COMMENT 'An indicator showing if this is the last day of the containing business year.',
	last_day_of_month_fg COMMENT 'An indicator showing if this is the last day of the containing month.',
	last_day_of_week_fg COMMENT 'An indicator showing if this is the last day of the containing week.',
	last_inv_of_day_fg  COMMENT 'An indicator showing if this is the last inventory of the day.',
	cal_month_py COMMENT 'Calendar_2 month of the inventory in the previous year',
	cal_week_py COMMENT 'Calendar_2 week of the inventory in the previous year',
	inv_period_start_dt COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.',
	inv_period_end_dt COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.',
	inv_type_cd COMMENT 'The code identifying the subtype discriminator for inventories. It distinguishes between full and partial inventories.',
	inv_sid COMMENT 'The unique identifier (surrogate key) for the inventory event.',
	inv_nr COMMENT 'The number which identifies the inventory event in a given country.', 
	curr_cd COMMENT 'The code identifying the currency according to ISO-4217.',
	inv_net_val COMMENT 'The total value of all products which have been counted as part of the inventory process in this internal organization (i.e. store or warehouse) on the inventory date. The value is based on the net sales_2 price that applies to this organization and and on the counted quantity. This measure is not additive across time! It is not necessarily in sync with the sum of the inventory amounts on product level.',
	inv_turnover_net_val COMMENT 'The net turnover amount in the given currency which was generated in this internal organization (i.e. store or warehouse) for the inventory period. This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_2 and returns. (In case the internal organization references a warehouse, this is only that portion of the turnover which was generated directly in the warehouse. Turnover of stores which are managed by this warehouse, are not included.) The inventory period is the time interval between the last full inventory and this inventory. This measure is not necessarily in sync with the sum of the inventory turnover on product level.',
	inv_diff_net_val COMMENT 'The net amount of the inventory difference, i.e. the difference between the value of the calculated stock and the counted stock. This measure is not necessarily in sync with the sum of the inventory differences on product level.',
	inv_cnt COMMENT 'Number of inventories for an inventory which serves as an indicator',
	inv_turnover_net_val_sum_by COMMENT 'The absolute sum of net turnover amount for the current business year',
	inv_turnover_net_val_sum_mth COMMENT 'The absolute sum of net turnover amount for the current month',
	inv_turnover_net_val_sum_wk COMMENT 'The absolute sum of net turnover amount for the current week',
	inv_diff_net_val_sum_by COMMENT 'The absolute sum of net inventory difference amount for the current business year', 
	inv_diff_net_val_sum_mth COMMENT 'The absolute sum of net inventory difference amount for the current month', 
	inv_diff_net_val_sum_wk COMMENT 'The absolute sum of net inventory difference amount for the current week', 
	inv_cnt_sum_by COMMENT 'The absolute number of inventories for the current business year',
	inv_cnt_sum_mth COMMENT 'The absolute number of inventories for the current month',
	inv_cnt_sum_wk COMMENT 'The absolute number of inventories for the current week',
	inv_turnover_net_val_cum_by COMMENT 'The cumulated sum of net turnover amount for the current business year',
	inv_turnover_net_val_cum_mth COMMENT 'The cumulated sum of net turnover amount for the current month',
	inv_turnover_net_val_cum_wk COMMENT 'The cumulated sum of net turnover amount for the current week',
	inv_turnover_net_val_cum_inv COMMENT 'The cumulated sum of net turnover amount for the current inventory day',
	inv_diff_net_val_cum_by COMMENT 'The cumulated sum of net inventory difference amount for the current business year', 
	inv_diff_net_val_cum_mth COMMENT 'The cumulated sum of net inventory difference amount for the current month', 
	inv_diff_net_val_cum_wk COMMENT 'The cumulated sum of net inventory difference amount for the current week', 
	inv_diff_net_val_cum_inv COMMENT 'The cumulated sum of net turnover amount for the current inventory day',
	inv_cnt_cum_by COMMENT 'The cumulated number of inventories for the current business year', 
	inv_cnt_cum_mth COMMENT 'The cumulated number of inventories for the current month', 
	inv_cnt_cum_wk COMMENT 'The cumulated number of inventories for the current week', 
	inv_cnt_cum_inv COMMENT 'The cumulated number of inventories for the current inventory day',
	inv_turnover_net_val_sum_mth_py COMMENT 'The absolute sum of net turnover amount for the current month of previous business year',
	inv_turnover_net_val_sum_wk_py COMMENT 'The absolute sum of net turnover amount for the current week of previous business year',
	inv_diff_net_val_sum_mth_py COMMENT 'The absolute sum of net inventory difference amount for the current month of previous business year',
	inv_diff_net_val_sum_wk_py COMMENT 'The absolute sum of net inventory difference amount for the current week of previous business year',
	inv_cnt_sum_mth_py COMMENT 'The absolute number of inventories for the current month of previous business year',
	inv_cnt_sum_wk_py COMMENT 'The absolute number of inventories for the current week of previous business year',
	inv_turnover_net_val_cum_mth_py COMMENT 'The cumulated sum of net turnover amount for the current month of previous business year',
	inv_turnover_net_val_cum_wk_py COMMENT 'The cumulated sum of net turnover amount for the current week of previous business year',
	inv_diff_net_val_cum_mth_py COMMENT 'The cumulated sum of net inventory difference amount for the current month of previous business year',
	inv_diff_net_val_cum_wk_py COMMENT 'The cumulated sum of net inventory difference amount for the current week of previous business year',
	inv_cnt_cum_mth_py COMMENT 'The cumulated number of inventories for the current month of previous business year',
	inv_cnt_cum_wk_py COMMENT 'The cumulated number of inventories for the current week of previous business year'
	) COMMENT= 'Calculations of all inventory turnovers and inventory differences for all stores (actual values, business year cumulations, year-to-year comparison and variances from plan values).'
AS
WITH
/* Preselection of relevant time period and identification of the inventory period */
limitation_time_period AS (
	SELECT d.cal_dt
		, d.bus_year
		, d.cal_month
		, d.cal_week
		--, d.prev_1y_cal_dt
		, d.last_day_of_bus_year_fg
		, d.last_day_of_month_fg
		, d.last_day_of_week_fg
		, d.bus_year_offset 
		, d.cal_dt_offset
		, m.prev_1y_cal_month AS cal_month_py
		--, m.bus_year AS bus_year_py
		--, m.cal_month_begin_dt
		--, m.cal_month_end_dt
		, w.prev_1y_cal_week AS cal_week_py
		--, w.cal_week_begin_dt
		--, w.cal_week_end_dt
	FROM core_dim.t_dim_calendar_date_2 d -- PK cal_dt 
	LEFT OUTER JOIN core_dim.t_dim_calendar_month_2 m -- PK cal_month
		USING (cal_month)
	LEFT OUTER JOIN core_dim.t_dim_calendar_week_2 w -- PK cal_week
		USING (cal_week)
	WHERE bus_year_offset BETWEEN -5 AND 0 -- last 5 business years and current business year
		AND cal_dt_offset <= 0 -- until current day  
	),
/* Preselection of all relevant inventories */ 
limitation_inventories AS (
	SELECT i.country_org_sid
		, i.country_org_cd
		, i.int_org_sid
		, i.int_org_type_cd
		, i.inv_sid
		, i.inv_nr
		, i.inv_dt
		, t.bus_year -- needed to filter out irrelevant data later 
		, i.inv_period_start_dt -- important to differentiate between two inventories on the same day regarding time order 
		, i.inv_period_end_dt
		, i.inv_type_cd
		, i.inv_reason_id
		--, dwh_created_tmsp
		--, dwh_updated_tmsp
	FROM core_dim.t_dim_inventory_2 i -- PK: inv_sid
	JOIN limitation_time_period t
		ON i.inv_dt = t.cal_dt
	WHERE i.inv_type_cd = 'FULL' -- inventory facts are only available for full inventories anyway 
	),
/* Preselection of relevant stores that have an inventory */
limitation_organization AS (
	SELECT country_org_cd
		--, country_org_sid
		, int_org_sid
		, int_org_type_cd 
		, curr_int_org_nr
		, int_org_name
		, dwh_valid_from_tmsp
		--, dwh_valid_to_tmsp
		, dwh_valid_fg
		--, int_org_type_descr
		--, int_org_status_cd
		--, iso_country_cd
	FROM core_dim.t_dim_internal_organization_2 o -- PK: int_org_sid, dwh_valid_from_tmsp 
	WHERE dwh_valid_fg = TRUE  
		AND int_org_type_cd = 'STORE' 
		AND EXISTS (SELECT 1 -- consider only stores that have an inventory at all and therefore are relevant  
			FROM limitation_inventories i
			WHERE o.int_org_sid = i.int_org_sid
			)
	),
/* Definition of the overall data row level with regard to store, day and inventory if two inventories are done on the same day (FE attributes for organisation, time and inventory) */ 
list_of_relevant_combinations AS (
	SELECT o.country_org_cd
		, o.int_org_sid
		, o.int_org_type_cd
		, o.curr_int_org_nr
		, o.int_org_name
		, t.cal_dt
		, t.bus_year
		, t.cal_month
		, t.cal_week
		, t.last_day_of_bus_year_fg
		, t.last_day_of_month_fg
		, t.last_day_of_week_fg
		, t.cal_month_py
		, t.cal_week_py
		, i.inv_period_start_dt
		, i.inv_period_end_dt
		, i.inv_type_cd
		, i.inv_sid
		, i.inv_nr
		, IFF(i.inv_sid IS NOT NULL AND ROW_NUMBER() OVER (PARTITION BY o.int_org_sid, t.cal_dt ORDER BY i.inv_nr DESC) = 1, TRUE, FALSE) AS last_inv_of_day_fg -- last inventory is valid if two full inventories happen on one day in a store 
	FROM limitation_organization o
	JOIN limitation_time_period t
		ON (
			-- all last days of all weeks, months and business years 
			(t.last_day_of_week_fg = TRUE -- for cumulation on week level at the end of each week 
			OR t.last_day_of_month_fg = TRUE -- for cumulation on month level at the end of each month 
			OR t.last_day_of_bus_year_fg= TRUE   
			)
			-- but excluding business years without an inventory, for example when a store has not been existing yet  
			AND EXISTS (SELECT 1 
				FROM limitation_inventories i
				WHERE o.int_org_sid = i.int_org_sid
					AND t.bus_year = i.bus_year
				)
			)
		-- including days on which inventories took place 
			OR EXISTS (SELECT 1 
				FROM limitation_inventories i
				WHERE o.int_org_sid = i.int_org_sid
					AND t.cal_dt = i.inv_dt
				) 
	LEFT OUTER JOIN limitation_inventories i -- considering also inventories that are conducted on the same day  
		ON o.int_org_sid = i.int_org_sid
			AND t.cal_dt = i.inv_dt
	),
/* Preselection of all facts regarding inventory differences */ 
facts_inventory_differences AS (
	SELECT d.country_org_cd
		, d.int_org_type_cd
		, d.inv_sid
		, d.inv_dt
		, d.inv_type_cd
		, d.curr_cd -- There only is the local currency for each country.
		--, d.calc_stock_net_val
		, d.inv_net_val
		, d.inv_diff_net_val -- Inventurdifferenz 
		, d.turnover_net_val -- Inventurumsatz 
		, d.dwh_created_tmsp
		, d.dwh_updated_tmsp
	FROM core_dim.t_fact_inventory_difference_2 d -- PK: inv_sid 
	JOIN limitation_time_period t
		ON d.inv_dt = t.cal_dt
	),
/* Preselection of defined planning data for inventories */ 
/*
planning_data AS (
	SELECT p.int_org_sid
		, p.int_org_type_cd
		--, p.real_estate_sid
		, p.cal_month
		, p.planned_val_type_sid
		--, p.plan_pos_nr
		, p.planned_kpi_meas
		, p.dwh_valid_from_tmsp
		, p.dwh_valid_to_tmsp
		, p.dwh_valid_fg
		--, p.dwh_created_tmsp
		--, p.dwh_updated_tmsp
		, pvt.planned_val_type_descr
	FROM core_rel.t_plan_by_month_2 p -- PK: planned_val_type_sid, real_estate_sid, cal_month, int_org_sid, plan_pos_nr, dwh_valid_from_tmsp 
	JOIN core_rel.t_planned_value_type_2 pvt 
		ON p.planned_val_type_sid = pvt.planned_val_type_sid
			AND pvt.planned_val_type_sid = 000 -- TO BE DETERMINED BECAUSE THE PLANNING VALUES ARE NOT EXISTING AT THE MOMENT!!! 
	JOIN limitation_time_period t
		USING (cal_month)
	),
*/
/* Cumulation of relevant facts per business year and calculation of plan deltas using the leading possible comnbinations of store and day (organization, time and inventory) */ 
fact_cumulations AS (
	SELECT l.country_org_cd
		, l.int_org_sid
		, l.int_org_type_cd
		, l.curr_int_org_nr
		, l.int_org_name
		, l.cal_dt
		, l.bus_year
		, l.cal_month
		, l.cal_week
		, l.last_day_of_bus_year_fg
		, l.last_day_of_month_fg
		, l.last_day_of_week_fg
		, l.last_inv_of_day_fg
		, l.cal_month_py
		, l.cal_week_py
		, l.inv_period_start_dt
		, l.inv_period_end_dt
		, l.inv_type_cd
		, l.inv_sid
		, l.inv_nr
		, d.curr_cd -- There only is the local currency for each country.
		, d.inv_net_val
		, d.turnover_net_val -- Inventurumsatz 
		, d.inv_diff_net_val -- Inventurdifferenz 
		, IFF(l.inv_sid IS NOT NULL, 1, NULL) AS inv_cnt  
		/* Total sums per each year, month and week for inventory turnover, inventory difference and number of inventories */  
		-- for inventory turnover 
		, IFF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(SUM(d.turnover_net_val) OVER (PARTITION BY l.int_org_sid, l.bus_year), 0)
			, NULL
			) AS turnover_net_val_sum_by 
		, IFF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(SUM(d.turnover_net_val) OVER (PARTITION BY l.int_org_sid, l.cal_month), 0)
			, NULL
			) AS turnover_net_val_sum_mth 
		, IFF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(SUM(d.turnover_net_val) OVER (PARTITION BY l.int_org_sid, l.cal_week), 0)
			, NULL
			) AS turnover_net_val_sum_wk 
		-- for inventory difference 
		, IFF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(SUM(d.inv_diff_net_val) OVER (PARTITION BY l.int_org_sid, l.bus_year), 0)
			, NULL
			) AS inv_diff_net_val_sum_by 
		, IFF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(SUM(d.inv_diff_net_val) OVER (PARTITION BY l.int_org_sid, l.cal_month), 0)
			, NULL
			) AS inv_diff_net_val_sum_mth 
		, IFF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(SUM(d.inv_diff_net_val) OVER (PARTITION BY l.int_org_sid, l.cal_week), 0)
			, NULL
			) AS inv_diff_net_val_sum_wk 
		-- for number of inventories 
		, IFF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(SUM(inv_cnt) OVER (PARTITION BY l.int_org_sid, l.bus_year), 0)
			, NULL
			) AS inv_cnt_sum_by 
		, IFF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(SUM(inv_cnt) OVER (PARTITION BY l.int_org_sid, l.cal_month), 0)
			, NULL
			) AS inv_cnt_sum_mth 
		, IFF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(SUM(inv_cnt) OVER (PARTITION BY l.int_org_sid, l.cal_week), 0)
			, NULL
			) AS inv_cnt_sum_wk 
		/* Continuously cumulated value per business year for each row */
		, SUM(d.turnover_net_val) OVER (
			PARTITION BY l.int_org_sid, l.bus_year 
			ORDER BY l.cal_dt, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS turnover_net_val_cum 
		, SUM(d.inv_diff_net_val) OVER (
			PARTITION BY l.int_org_sid, l.bus_year
			ORDER BY l.cal_dt, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS inv_diff_net_val_cum 
		, SUM(inv_cnt) OVER (
			PARTITION BY l.int_org_sid, l.bus_year 
			ORDER BY l.cal_dt, l.inv_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS inv_cnt_cum 
		/* Cumulated values shown only for relevant time rows of year, month, week or day of inventory */
		-- for inventory turnover 
		, IFF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(turnover_net_val_cum, 0)
			, NULL
			) AS turnover_net_val_cum_by 
		, IFF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(turnover_net_val_cum, 0)
			, NULL
			) AS turnover_net_val_cum_mth 
		, IFF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(turnover_net_val_cum, 0)
			, NULL
			) AS turnover_net_val_cum_wk 
		, IFF(l.inv_sid IS NOT NULL
			, NVL(turnover_net_val_cum, 0)
			, NULL
			) AS turnover_net_val_cum_inv 
		-- for inventory difference 
		, IFF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(inv_diff_net_val_cum, 0)
			, NULL
			) AS inv_diff_net_val_cum_by 
		, IFF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(inv_diff_net_val_cum, 0)
			, NULL
			) AS inv_diff_net_val_cum_mth 
		, IFF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(inv_diff_net_val_cum, 0)
			, NULL
			) AS inv_diff_net_val_cum_wk 
		, IFF(l.inv_sid IS NOT NULL
			, NVL(inv_diff_net_val_cum, 0)
			, NULL
			) AS inv_diff_net_val_cum_inv 
		-- for number of inventories  
		, IFF(l.last_day_of_bus_year_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(inv_cnt_cum, 0)
			, NULL
			) AS inv_cnt_cum_by 
		, IFF(l.last_day_of_month_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(inv_cnt_cum, 0)
			, NULL
			) AS inv_cnt_cum_mth 
		, IFF(l.last_day_of_week_fg = TRUE AND (l.inv_sid IS NULL OR l.inv_sid IS NOT NULL AND l.last_inv_of_day_fg = TRUE)
			, NVL(inv_cnt_cum, 0)
			, NULL
			) AS inv_cnt_cum_wk 
		, IFF(l.inv_sid IS NOT NULL
			, NVL(inv_cnt_cum, 0)
			, NULL
			) AS inv_cnt_cum_inv 
		, d.dwh_created_tmsp
		, d.dwh_updated_tmsp
	FROM list_of_relevant_combinations l
	LEFT OUTER JOIN facts_inventory_differences d
		USING (inv_sid)
	),
/* Corresponding facts in the past for the inventory period of previous business year */ 
fact_consolidation AS (
	SELECT c.country_org_cd
		, c.int_org_sid
		, c.int_org_type_cd
		, c.curr_int_org_nr
		, c.int_org_name
		, c.cal_dt
		, c.bus_year
		, c.cal_month
		, c.cal_week
		, c.last_day_of_bus_year_fg
		, c.last_day_of_month_fg
		, c.last_day_of_week_fg
		, c.last_inv_of_day_fg	
		, c.cal_month_py
		, c.cal_week_py
		, c.inv_period_start_dt
		, c.inv_period_end_dt
		, c.inv_type_cd
		, c.inv_sid
		, c.inv_nr
		, c.curr_cd
		, c.inv_net_val
		, c.turnover_net_val			-- absolute value for inventory day  
		, c.inv_diff_net_val			-- absolute value for inventory day
		, c.inv_cnt						-- absolute value for inventory day
		, c.turnover_net_val_sum_by		-- absolute value for year
		, c.turnover_net_val_sum_mth	-- absolute value for month
		, c.turnover_net_val_sum_wk		-- absolute value for week
		, c.inv_diff_net_val_sum_by		-- absolute value for year
		, c.inv_diff_net_val_sum_mth	-- absolute value for month
		, c.inv_diff_net_val_sum_wk		-- absolute value for week
		, c.inv_cnt_sum_by				-- absolute value for year
		, c.inv_cnt_sum_mth				-- absolute value for month
		, c.inv_cnt_sum_wk				-- absolute value for week
		--, c.turnover_net_val_cum -- only used to calculate cumulation once for all rows  
		--, c.inv_diff_net_val_cum -- only used to calculate cumulation once for all rows
		--, c.inv_cnt_cum -- only used to calculate cumulation once for all rows
		, c.turnover_net_val_cum_by		-- relative value for year
		, c.turnover_net_val_cum_mth	-- relative value for month
		, c.turnover_net_val_cum_wk		-- relative value for week
		, c.turnover_net_val_cum_inv	-- relative value for inventory day
		, c.inv_diff_net_val_cum_by		-- relative value for year
		, c.inv_diff_net_val_cum_mth	-- relative value for month
		, c.inv_diff_net_val_cum_wk		-- relative value for week
		, c.inv_diff_net_val_cum_inv	-- relative value for inventory day
		, c.inv_cnt_cum_by				-- relative value for year
		, c.inv_cnt_cum_mth				-- relative value for month
		, c.inv_cnt_cum_wk				-- relative value for week
		, c.inv_cnt_cum_inv				-- relative value for inventory day 
		, pym.turnover_net_val_sum_mth AS turnover_net_val_sum_mth_py	-- absolute value for month py 
		, pyw.turnover_net_val_sum_wk AS turnover_net_val_sum_wk_py		-- absolute value for week py
		, pym.inv_diff_net_val_sum_mth AS inv_diff_net_val_sum_mth_py	-- absolute value for month py
		, pyw.inv_diff_net_val_sum_wk AS inv_diff_net_val_sum_wk_py		-- absolute value for week py 
		, pym.inv_cnt_sum_mth AS inv_cnt_sum_mth_py						-- absolute value for month py
		, pyw.inv_cnt_sum_wk AS inv_cnt_sum_wk_py						-- absolute value for week py
		, pym.turnover_net_val_cum_mth AS turnover_net_val_cum_mth_py	-- relative value for month
		, pyw.turnover_net_val_cum_wk AS turnover_net_val_cum_wk_py		-- relative value for week
		, pym.inv_diff_net_val_cum_mth AS inv_diff_net_val_cum_mth_py	-- relative value for month
		, pyw.inv_diff_net_val_cum_wk AS inv_diff_net_val_cum_wk_py		-- relative value for week
		, pym.inv_cnt_cum_mth AS inv_cnt_cum_mth_py						-- relative value for month
		, pyw.inv_cnt_cum_wk AS inv_cnt_cum_wk_py						-- relative value for week
		, c.dwh_created_tmsp
		, c.dwh_updated_tmsp
FROM fact_cumulations c
LEFT OUTER JOIN fact_cumulations pym -- mapping month values from previous year  
	ON c.int_org_sid = pym.int_org_sid 
		AND c.cal_month_py = pym.cal_month
		AND c.last_day_of_month_fg = TRUE AND (c.inv_sid IS NULL OR c.inv_sid IS NOT NULL AND c.last_inv_of_day_fg = TRUE)
		AND pym.last_day_of_month_fg = TRUE AND (pym.inv_sid IS NULL OR pym.inv_sid IS NOT NULL AND pym.last_inv_of_day_fg = TRUE)
LEFT OUTER JOIN fact_cumulations pyw -- mapping week values from previous year 
	ON c.int_org_sid = pyw.int_org_sid 
		AND c.cal_week_py = pyw.cal_week
		AND c.last_day_of_week_fg = TRUE AND (c.inv_sid IS NULL OR c.inv_sid IS NOT NULL AND c.last_inv_of_day_fg = TRUE)
		AND pyw.last_day_of_week_fg = TRUE AND (pyw.inv_sid IS NULL OR pyw.inv_sid IS NOT NULL AND pyw.last_inv_of_day_fg = TRUE)
	)
/* Final columns */
SELECT country_org_cd
	, int_org_sid
	, int_org_type_cd
	, curr_int_org_nr
	, int_org_name
	, cal_dt
	, bus_year
	, cal_month
	, cal_week
	, last_day_of_bus_year_fg
	, last_day_of_month_fg
	, last_day_of_week_fg
	, last_inv_of_day_fg
	, cal_month_py
	, cal_week_py
	, inv_period_start_dt
	, inv_period_end_dt
	, inv_type_cd
	, inv_sid
	, inv_nr
	, curr_cd
	, inv_net_val
	, turnover_net_val AS inv_turnover_net_val
	, inv_diff_net_val
	, inv_cnt
	, turnover_net_val_sum_by AS inv_turnover_net_val_sum_by
	, turnover_net_val_sum_mth AS inv_turnover_net_val_sum_mth
	, turnover_net_val_sum_wk AS inv_turnover_net_val_sum_wk
	, inv_diff_net_val_sum_by 
	, inv_diff_net_val_sum_mth
	, inv_diff_net_val_sum_wk
	, inv_cnt_sum_by
	, inv_cnt_sum_mth
	, inv_cnt_sum_wk
	, turnover_net_val_cum_by AS inv_turnover_net_val_cum_by
	, turnover_net_val_cum_mth AS inv_turnover_net_val_cum_mth
	, turnover_net_val_cum_wk AS inv_turnover_net_val_cum_wk
	, turnover_net_val_cum_inv AS inv_turnover_net_val_cum_inv
	, inv_diff_net_val_cum_by
	, inv_diff_net_val_cum_mth
	, inv_diff_net_val_cum_wk
	, inv_diff_net_val_cum_inv
	, inv_cnt_cum_by
	, inv_cnt_cum_mth
	, inv_cnt_cum_wk
	, inv_cnt_cum_inv
	, turnover_net_val_sum_mth_py AS inv_turnover_net_val_sum_mth_py
	, turnover_net_val_sum_wk_py AS inv_turnover_net_val_sum_wk_py
	, inv_diff_net_val_sum_mth_py
	, inv_diff_net_val_sum_wk_py
	, inv_cnt_sum_mth_py
	, inv_cnt_sum_wk_py
	, turnover_net_val_cum_mth_py AS inv_turnover_net_val_cum_mth_py
	, turnover_net_val_cum_wk_py AS inv_turnover_net_val_cum_wk_py
	, inv_diff_net_val_cum_mth_py
	, inv_diff_net_val_cum_wk_py
	, inv_cnt_cum_mth_py
	, inv_cnt_cum_wk_py
	--, dwh_created_tmsp
	--, dwh_updated_tmsp
FROM fact_consolidation
--ORDER BY country_org_cd 
--	, int_org_sid
--	, cal_dt
--	, inv_nr
;