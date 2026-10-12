DELETE FROM core_dim.t_fact_write_off_by_organization_day
;

INSERT INTO core_dim.t_fact_write_off_by_organization_day (
	bus_dt
	, int_org_sid
	, int_org_type_cd
	, country_org_cd
	, write_off_for_breakage_net_val
	, write_off_for_breakage_bytd_net_val
	, write_off_for_breakage_py_net_val
	, write_off_for_breakage_py_bytd_net_val
	, write_off_for_breakage_py_swday_net_val
	, write_off_for_breakage_py_swday_bytd_net_val
	, write_off_for_sell_by_dt_net_val
	, write_off_for_sell_by_dt_bytd_net_val
	, write_off_for_sell_by_dt_py_net_val
	, write_off_for_sell_by_dt_py_bytd_net_val
	, write_off_for_sell_by_dt_py_swday_net_val
	, write_off_for_sell_by_dt_py_swday_bytd_net_val
	, write_off_for_deliv_quality_net_val
	, write_off_for_deliv_quality_bytd_net_val
	, write_off_for_deliv_quality_py_net_val
	, write_off_for_deliv_quality_py_bytd_net_val
	, write_off_for_deliv_quality_py_swday_net_val
	, write_off_for_deliv_quality_py_swday_bytd_net_val
	, write_off_for_defective_non_food_net_val
	, write_off_for_defective_non_food_bytd_net_val
	, write_off_for_defective_non_food_py_net_val
	, write_off_for_defective_non_food_py_bytd_net_val
	, write_off_for_defective_non_food_py_swday_net_val
	, write_off_for_defective_non_food_py_swday_bytd_net_val
	, write_off_for_donations_net_val
	, write_off_for_donations_bytd_net_val
	, write_off_for_donations_py_net_val
	, write_off_for_donations_py_bytd_net_val
	, write_off_for_donations_py_swday_net_val
	, write_off_for_donations_py_swday_bytd_net_val
	, write_off_for_taken_prod_net_val
	, write_off_for_taken_prod_bytd_net_val
	, write_off_for_taken_prod_py_net_val
	, write_off_for_taken_prod_py_bytd_net_val
	, write_off_for_taken_prod_py_swday_net_val
	, write_off_for_taken_prod_py_swday_bytd_net_val
	, write_off_for_discounts_net_val
	, write_off_for_discounts_bytd_net_val
	, write_off_for_discounts_py_net_val
	, write_off_for_discounts_py_bytd_net_val
	, write_off_for_discounts_py_swday_net_val
	, write_off_for_discounts_py_swday_bytd_net_val
	, write_off_for_force_majeure_net_val 
	, write_off_for_force_majeure_bytd_net_val
	, write_off_for_force_majeure_py_net_val
	, write_off_for_force_majeure_py_bytd_net_val
	, write_off_for_force_majeure_py_swday_net_val
	, write_off_for_force_majeure_py_swday_bytd_net_val
	, write_off_for_stock_clearance_net_val 
	, write_off_for_stock_clearance_bytd_net_val
	, write_off_for_stock_clearance_py_net_val
	, write_off_for_stock_clearance_py_bytd_net_val
	, write_off_for_stock_clearance_py_swday_net_val
	, write_off_for_stock_clearance_py_swday_bytd_net_val
	, write_off_net_val 
	, write_off_bytd_net_val
	, write_off_py_net_val
	, write_off_py_bytd_net_val
	, write_off_py_swday_net_val
	, write_off_py_swday_bytd_net_val
	, turnover_net_val
	, turnover_bytd_net_val
	, turnover_py_net_val
	, turnover_py_bytd_net_val
	, turnover_py_swday_net_val
	, turnover_py_swday_bytd_net_val
	, cash_register_turnover_net_val
	, cash_register_turnover_bytd_net_val
	, cash_register_turnover_py_net_val
	, cash_register_turnover_py_bytd_net_val
	, cash_register_turnover_py_swday_net_val
	, cash_register_turnover_py_swday_bytd_net_val
	, curr_cd
	, dwh_created_tmsp
	, dwh_updated_tmsp
	, dwh_load_id
	, dwh_node_cd
)
WITH 
int_org_years AS (
	SELECT  
		f.int_org_sid
		, d1.bus_year
		, f.int_org_type_cd
		, f.country_org_cd
		, f.curr_cd
	FROM etl_process.t_tcache_write_off_by_organization_day AS f 
	JOIN core_dim.t_dim_calendar_date d1
		ON d1.cal_dt = f.bus_dt
			AND f.bus_dt <= CURRENT_DATE 
	UNION 
	SELECT 
		f.int_org_sid
		, d1.bus_year + 1
		, f.int_org_type_cd
		, f.country_org_cd
		, f.curr_cd
	FROM etl_process.t_tcache_write_off_by_organization_day AS f 
	JOIN core_dim.t_dim_calendar_date d1
		ON d1.cal_dt = f.bus_dt
			AND f.bus_dt <= CURRENT_DATE 
	),
write_off_fulldates AS (
	SELECT 
		d2.cal_dt
		, d2.bus_year
		, ioy.int_org_sid
		, ioy.int_org_type_cd
		, ioy.country_org_cd
		, ioy.curr_cd
	FROM int_org_years ioy
	JOIN core_dim.t_dim_calendar_date d2
		ON d2.bus_year = ioy.bus_year
	WHERE d2.cal_dt <= CURRENT_DATE 
	),
-- all values, previous year
py AS (
	SELECT 
		dr.cal_dt
		, src.int_org_sid
		, SUM (write_off_for_breakage_net_val) 			AS write_off_for_breakage_py_net_val  -- bruch
		, SUM (write_off_for_sell_by_dt_net_val) 		AS write_off_for_sell_by_dt_py_net_val --mhd
		, SUM (write_off_for_deliv_quality_net_val) 		AS write_off_for_deliv_quality_py_net_val -- anlieferung qualitat
		, SUM (write_off_for_defective_non_food_net_val) 	AS write_off_for_defective_non_food_py_net_val  -- defektes nf 
		, SUM (write_off_for_donations_net_val) 		AS write_off_for_donations_py_net_val  -- spenden 
		, SUM (write_off_for_discounts_net_val) 		AS write_off_for_discounts_py_net_val -- rabattierung
		, SUM (write_off_for_taken_prod_net_val) 		AS write_off_for_taken_prod_py_net_val -- warenentnahme 
		, SUM (write_off_for_force_majeure_net_val) 		AS write_off_for_force_majeure_py_net_val
		, SUM (write_off_for_stock_clearance_net_val) 		AS write_off_for_stock_clearance_py_net_val
		, SUM (write_off_net_val)				AS write_off_py_net_val
	FROM etl_process.t_tcache_write_off_by_organization_day AS src
	INNER JOIN core_rel.t_cal_date_adjusted_relationship AS dr
		ON src.bus_dt = dr.rel_cal_dt
			AND dr.cal_dt_adjust_type_cd = 'M'
			AND dr.bus_year_diff = 1
	GROUP BY dr.cal_dt 
		, src.int_org_sid
	),
-- all values, previous year/same business day
pybd AS (
	SELECT dr.cal_dt
		, src.int_org_sid
		, SUM (write_off_for_breakage_net_val) 			AS write_off_for_breakage_py_bytd_net_val  -- BRUCH
		, SUM (write_off_for_sell_by_dt_net_val) 		AS write_off_for_sell_by_dt_py_bytd_net_val --MHD
		, SUM (write_off_for_deliv_quality_net_val) 	        AS write_off_for_deliv_quality_py_bytd_net_val -- ANLIEFERUNG QUALITAT
		, SUM (write_off_for_defective_non_food_net_val)        AS write_off_for_defective_non_food_py_bytd_net_val  -- DEFEKTES NF 
		, SUM (write_off_for_donations_net_val) 		AS write_off_for_donations_py_bytd_net_val  -- SPENDEN 
		, SUM (write_off_for_discounts_net_val) 		AS write_off_for_discounts_py_bytd_net_val -- RABATTIERUNG
		, SUM (write_off_for_taken_prod_net_val) 		AS write_off_for_taken_prod_py_bytd_net_val -- WARENENTNAHME 
		, SUM (write_off_for_force_majeure_net_val) 		AS write_off_for_force_majeure_py_bytd_net_val
		, SUM (write_off_for_stock_clearance_net_val) 		AS write_off_for_stock_clearance_py_bytd_net_val
		, SUM (write_off_net_val) 				AS write_off_py_bytd_net_val
	FROM etl_process.t_tcache_write_off_by_organization_day AS src
	INNER JOIN core_rel.t_cal_date_adjusted_relationship AS dr
		ON src.bus_dt = dr.rel_cal_dt
			AND dr.cal_dt_adjust_type_cd = 'MC'
			AND dr.bus_year_diff = 1
	GROUP BY dr.cal_dt 
		, src.int_org_sid
	),
-- all values, previous year, same week
pysw AS (
	SELECT dr.cal_dt
		, src.int_org_sid
		, SUM (write_off_for_breakage_net_val) 			AS write_off_for_breakage_py_swday_net_val  -- BRUCH
		, SUM (write_off_for_sell_by_dt_net_val) 		AS write_off_for_sell_by_dt_py_swday_net_val --MHD
		, SUM (write_off_for_deliv_quality_net_val) 		AS write_off_for_deliv_quality_py_swday_net_val -- ANLIEFERUNG QUALITAT
		, SUM (write_off_for_defective_non_food_net_val) 	AS write_off_for_defective_non_food_py_swday_net_val  -- DEFEKTES NF 
		, SUM (write_off_for_donations_net_val) 		AS write_off_for_donations_py_swday_net_val  -- SPENDEN 
		, SUM (write_off_for_discounts_net_val) 		AS write_off_for_discounts_py_swday_net_val -- RABATTIERUNG
		, SUM (write_off_for_taken_prod_net_val) 		AS write_off_for_taken_prod_py_swday_net_val -- WARENENTNAHME 
		, SUM (write_off_for_force_majeure_net_val) 		AS write_off_for_force_majeure_py_swday_net_val
		, SUM (write_off_for_stock_clearance_net_val) 		AS write_off_for_stock_clearance_py_swday_net_val
		, SUM (write_off_net_val) 				AS write_off_py_swday_net_val
	FROM etl_process.t_tcache_write_off_by_organization_day AS src
	INNER JOIN core_rel.t_cal_date_adjusted_relationship AS dr
		ON src.bus_dt = dr.rel_cal_dt
			AND dr.cal_dt_adjust_type_cd = 'W'
			AND dr.bus_year_diff = 1
	GROUP BY dr.cal_dt 
		, src.int_org_sid
	), 
-- all values, previous year, same week (business specified)
pyswbd AS (
	SELECT dr.cal_dt
		, src.int_org_sid
		, SUM (write_off_for_breakage_net_val)			AS write_off_for_breakage_py_swday_bytd_net_val  -- BRUCH
		, SUM (write_off_for_sell_by_dt_net_val) 		AS write_off_for_sell_by_dt_py_swday_bytd_net_val --MHD
		, SUM (write_off_for_deliv_quality_net_val) 		AS write_off_for_deliv_quality_py_swday_bytd_net_val -- ANLIEFERUNG QUALITAT
		, SUM (write_off_for_defective_non_food_net_val) 	AS write_off_for_defective_non_food_py_swday_bytd_net_val  -- DEFEKTES NF 
		, SUM (write_off_for_donations_net_val) 		AS write_off_for_donations_py_swday_bytd_net_val  -- SPENDEN
		, SUM (write_off_for_discounts_net_val) 		AS write_off_for_discounts_py_swday_bytd_net_val -- RABATTIERUNG
		, SUM (write_off_for_taken_prod_net_val) 		AS write_off_for_taken_prod_py_swday_bytd_net_val -- WARENENTNAHME 
		, SUM (write_off_for_force_majeure_net_val) 		AS write_off_for_force_majeure_py_swday_bytd_net_val
		, SUM (write_off_for_stock_clearance_net_val) 		AS write_off_for_stock_clearance_py_swday_bytd_net_val
		, SUM (write_off_net_val) 				AS write_off_py_swday_bytd_net_val
	FROM etl_process.t_tcache_write_off_by_organization_day AS src
	INNER JOIN core_rel.t_cal_date_adjusted_relationship AS dr
		ON src.bus_dt = dr.rel_cal_dt
			AND dr.cal_dt_adjust_type_cd = 'WC'
			AND dr.bus_year_diff = 1
	GROUP BY dr.cal_dt 
		, src.int_org_sid
)
SELECT
	src.cal_dt AS bus_dt                  
	, src.int_org_sid AS int_org_sid            
	, src.int_org_type_cd AS int_org_type_cd       
	, src.country_org_cd AS country_org_cd
	-- all write off values have to be negative since these KPIs are a loss for the stores 
	--  WRITE_OFF_FOR_BREAKAGE
	, fsrc.write_off_for_breakage_net_val * -1 AS write_off_for_breakage_net_val 
	, SUM(fsrc.write_off_for_breakage_net_val) OVER (
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_breakage_bytd_net_val
	, write_off_for_breakage_py_net_val * -1 AS write_off_for_breakage_py_net_val
	, SUM(write_off_for_breakage_py_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_breakage_py_bytd_net_val 
	, write_off_for_breakage_py_swday_net_val * -1 AS write_off_for_breakage_py_swday_net_val
	, SUM(write_off_for_breakage_py_swday_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_breakage_py_swday_bytd_net_val 
	-- WRITE_OFF_FOR_SEL_BY_DT
	, fsrc.write_off_for_sell_by_dt_net_val * -1 AS write_off_for_sell_by_dt_net_val
	, SUM(fsrc.write_off_for_sell_by_dt_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_sell_by_dt_bytd_net_val
	, write_off_for_sell_by_dt_py_net_val * -1 AS write_off_for_sell_by_dt_py_net_val
	, SUM(write_off_for_sell_by_dt_py_bytd_net_val) OVER (
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_sell_by_dt_py_bytd_net_val 
	, write_off_for_sell_by_dt_py_swday_net_val * -1 AS write_off_for_sell_by_dt_py_swday_net_val
	, SUM(write_off_for_sell_by_dt_py_swday_bytd_net_val) OVER (
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_sell_by_dt_py_swday_bytd_net_val 
	-- WRITE_OFF_FOR_DELIV_QUALITY
	, fsrc.write_off_for_deliv_quality_net_val * -1 AS write_off_for_deliv_quality_net_val
	, SUM(fsrc.write_off_for_deliv_quality_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_deliv_quality_bytd_net_val
	, write_off_for_deliv_quality_py_net_val * -1 AS write_off_for_deliv_quality_py_net_val
	, SUM(write_off_for_deliv_quality_py_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_deliv_quality_py_bytd_net_val 
	, write_off_for_deliv_quality_py_swday_net_val * -1 AS write_off_for_deliv_quality_py_swday_net_val
	, SUM(write_off_for_deliv_quality_py_swday_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_deliv_quality_py_swday_bytd_net_val 
	-- WRITE_OFF_FOR_DEFECTIVE_NON_FOOD
	, fsrc.write_off_for_defective_non_food_net_val * -1 AS write_off_for_defective_non_food_net_val
	,SUM(fsrc.write_off_for_defective_non_food_net_val) OVER (
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_defective_non_food_bytd_net_val
	, write_off_for_defective_non_food_py_net_val * -1 AS write_off_for_defective_non_food_py_net_val
	, SUM(write_off_for_defective_non_food_py_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_defective_non_food_py_bytd_net_val 
	, write_off_for_defective_non_food_py_swday_net_val * -1 AS write_off_for_defective_non_food_py_swday_net_val
	, SUM(write_off_for_defective_non_food_py_swday_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_defective_non_food_py_swday_bytd_net_val 
	-- WRITE_OFF_FOR_DONATIONS
	, fsrc.write_off_for_donations_net_val * -1 AS write_off_for_donations_net_val
	, SUM(fsrc.write_off_for_donations_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_donations_bytd_net_val
	, write_off_for_donations_py_net_val * -1 AS write_off_for_donations_py_net_val
	, SUM(write_off_for_donations_py_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_donations_py_bytd_net_val 
	, write_off_for_donations_py_swday_net_val * -1 AS write_off_for_donations_py_swday_net_val
	, SUM(write_off_for_donations_py_swday_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_donations_py_swday_bytd_net_val 
	--WRITE_OFF_FOR_TAKEN_PROD
	, fsrc.write_off_for_taken_prod_net_val * -1 AS write_off_for_taken_prod_net_val
	, SUM(fsrc.write_off_for_taken_prod_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_taken_prod_bytd_net_val
	, write_off_for_taken_prod_py_net_val * -1 AS write_off_for_taken_prod_py_net_val
	, SUM(write_off_for_taken_prod_py_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_taken_prod_py_bytd_net_val 
	, write_off_for_taken_prod_py_swday_net_val * -1 AS write_off_for_taken_prod_py_swday_net_val
	, SUM(write_off_for_taken_prod_py_swday_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_taken_prod_py_swday_bytd_net_val 
	-- WRITE_OFF_FOR_DISCOUNTS
	, fsrc.write_off_for_discounts_net_val * -1 AS write_off_for_discounts_net_val
	, SUM(fsrc.write_off_for_discounts_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_discounts_bytd_net_val
	, write_off_for_discounts_py_net_val * -1 AS write_off_for_discounts_py_net_val
	, SUM(write_off_for_discounts_py_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_discounts_py_bytd_net_val 
	, write_off_for_discounts_py_swday_net_val * -1 AS write_off_for_discounts_py_swday_net_val
	, SUM(write_off_for_discounts_py_swday_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_discounts_py_swday_bytd_net_val 
	-- WRITE_OFF_FOR_FORCE_MAJEURE
	, fsrc.write_off_for_force_majeure_net_val * -1 AS write_off_for_force_majeure_net_val
	, SUM(fsrc.write_off_for_force_majeure_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_force_majeure_bytd_net_val
	, write_off_for_force_majeure_py_net_val * -1 AS write_off_for_force_majeure_py_net_val
	, SUM(write_off_for_force_majeure_py_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_force_majeure_py_bytd_net_val 
	, write_off_for_force_majeure_py_swday_net_val * -1 AS write_off_for_force_majeure_py_swday_net_val
	, SUM(write_off_for_force_majeure_py_swday_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_force_majeure_py_swday_bytd_net_val 
	-- WRITE_OFF_FOR_STOCK_CLEARANCE
	, fsrc.write_off_for_stock_clearance_net_val * -1 AS write_off_for_stock_clearance_net_val
	, SUM(fsrc.write_off_for_stock_clearance_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_stock_clearance_bytd_net_val
	, write_off_for_stock_clearance_py_net_val * -1 AS write_off_for_stock_clearance_py_net_val
	, SUM(write_off_for_stock_clearance_py_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_stock_clearance_py_bytd_net_val 
	, write_off_for_stock_clearance_py_swday_net_val * -1 AS write_off_for_stock_clearance_py_swday_net_val
	, SUM(write_off_for_stock_clearance_py_swday_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_for_stock_clearance_py_swday_bytd_net_val 
	-- WRITE_OFF
	, fsrc.write_off_net_val * -1 AS write_off_net_val
	, SUM(fsrc.write_off_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_bytd_net_val
	, write_off_py_net_val * -1 AS write_off_py_net_val
	, SUM(write_off_py_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
		* -1 AS write_off_py_bytd_net_val 
	, write_off_py_swday_net_val * -1 AS write_off_py_swday_net_val
	, SUM(write_off_py_swday_bytd_net_val) OVER (	
		PARTITION BY src.int_org_sid, src.bus_year
		ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) * -1 AS write_off_py_swday_bytd_net_val 
	, sa.turnover_net_val AS turnover_net_val
	, sa.turnover_bytd_net_val AS turnover_bytd_net_val
	, sa.turnover_py_net_val AS turnover_py_net_val
	, sa.turnover_py_bytd_net_val AS turnover_py_bytd_net_val
	, sa.turnover_py_swday_net_val AS turnover_py_swday_net_val
	, sa.turnover_py_swday_bytd_net_val AS turnover_py_swday_bytd_net_val
	, sa.cash_register_sales_net_val + sa.cash_register_return_net_val AS cash_register_turnover_net_val
	, sa.cash_register_sales_bytd_net_val + sa.cash_register_return_bytd_net_val AS cash_register_turnover_bytd_net_val
	, sa.cash_register_sales_py_net_val + sa.cash_register_return_py_net_val AS cash_register_turnover_py_net_val
	, sa.cash_register_sales_py_bytd_net_val + sa.cash_register_sales_py_bytd_net_val AS cash_register_turnover_py_bytd_net_val
	, sa.cash_register_sales_py_swday_net_val + sa.cash_register_return_py_swday_net_val AS cash_register_turnover_py_swday_net_val
	, sa.cash_register_sales_py_swday_bytd_net_val + sa.cash_register_return_py_swday_bytd_net_val AS cash_register_turnover_py_swday_bytd_net_val
	, src.curr_cd
	, CURRENT_TIMESTAMP AS dwh_created_tmsp
	, CURRENT_TIMESTAMP AS dwh_updated_tmsp
	, '${LOAD_ID}' AS dwh_load_id
	, 'CORE_REL' AS dwh_node_cd
FROM write_off_fulldates AS src  
LEFT JOIN etl_process.t_tcache_write_off_by_organization_day AS fsrc
	ON src.cal_dt = fsrc.bus_dt
		AND src.int_org_sid = fsrc.int_org_sid
LEFT JOIN py
	ON src.cal_dt = py.cal_dt
		AND src.int_org_sid = py.int_org_sid
LEFT JOIN pybd
	ON src.cal_dt = pybd.cal_dt
		AND src.int_org_sid = pybd.int_org_sid
LEFT JOIN pysw
	ON src.cal_dt = pysw.cal_dt
		AND src.int_org_sid = pysw.int_org_sid
LEFT JOIN pyswbd
	ON src.cal_dt = pyswbd.cal_dt
		AND src.int_org_sid = pyswbd.int_org_sid
LEFT JOIN core_dim.t_fact_retail_by_store_day sa
	ON sa.bus_dt = src.cal_dt
		AND sa.int_org_sid = src.int_org_sid
;
