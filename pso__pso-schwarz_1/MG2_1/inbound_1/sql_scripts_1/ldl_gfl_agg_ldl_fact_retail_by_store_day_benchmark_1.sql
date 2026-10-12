!SET exit_on_error=True;

BEGIN WORK;

DELETE FROM core_dim.t_fact_retail_by_store_day_benchmark_1;

INSERT INTO core_dim.t_fact_retail_by_store_day_benchmark_1(
	bus_dt,
	int_org_sid,
	benchmarking_type_id,
	parent_int_org_sid,
	parent_int_org_nat_key_nr,
	int_org_type_cd,
	country_org_cd,
	turnover_net_val,
	turnover_bytd_net_val,
	turnover_py_net_val,
	turnover_py_bytd_net_val,
	turnover_py_swday_net_val,
	turnover_py_swday_bytd_net_val,
	cash_register_turnover_net_val,
	eod_turnover_net_val,
	booked_turnover_net_val,
	plan_turnover_net_val,
	plan_turnover_bytd_net_val,
	plan_turnover_py_net_val,
	plan_turnover_py_bytd_net_val,
	plan_turnover_py_swday_net_val,
	plan_turnover_py_swday_bytd_net_val,
	turnover_gross_val,
	turnover_bytd_gross_val,
	turnover_py_gross_val,
	turnover_py_bytd_gross_val,
	turnover_py_swday_gross_val,
	turnover_py_swday_bytd_gross_val,
	cash_register_turnover_gross_val,
	eod_turnover_gross_val,
	curr_cd,
	receipt_cnt,
	receipt_bytd_cnt,
	receipt_py_cnt,
	receipt_py_bytd_cnt,
	receipt_py_swday_cnt,
	receipt_py_swday_bytd_cnt,
	cash_register_receipt_cnt,
	eod_receipt_cnt,
	booked_receipt_cnt,
	plan_receipt_cnt,
	plan_receipt_bytd_cnt,
	plan_receipt_py_cnt,
	plan_receipt_py_bytd_cnt,
	plan_receipt_py_swday_cnt,
	plan_receipt_py_swday_bytd_cnt,
	dwh_created_tmsp,
	dwh_updated_tmsp,
	dwh_load_id,
	dwh_node_cd
) 
	SELECT
		  main.bus_dt AS bus_dt
		, main.int_org_sid AS int_org_sid
		, 1::NUMBER(38,0) AS benchmarking_type_id
		, org.sales_mgr_district_sid AS parent_int_org_sid           -- SID Sales_1 Manager (VL)
		, org.sales_mgr_district_name AS parent_int_org_nat_key_nr    -- Stays for Natural Key for Sales_1 Manager (VL), corresponds to org.int_org_name on Sales_1 Manager Level
		, org.int_org_type_cd AS int_org_type_cd
		, main.country_org_cd AS country_org_cd
		, main.turnover_net_val AS turnover_net_val
		, main.turnover_bytd_net_val  AS turnover_bytd_net_val
		, main.turnover_py_net_val  AS turnover_py_net_val
		, main.turnover_py_bytd_net_val  AS turnover_py_bytd_net_val
		, main.turnover_py_swday_net_val  AS turnover_py_swday_net_val
		, main.turnover_py_swday_bytd_net_val  AS turnover_py_swday_bytd_net_val
		, main.cash_register_sales_net_val + main.cash_register_return_net_val   AS cash_register_turnover_net_val
		, main.eod_turnover_net_val  AS eod_turnover_net_val
		, main.booked_turnover_net_val  AS booked_turnover_net_val
		, main.plan_turnover_net_val  AS plan_turnover_net_val
		, main.plan_turnover_bytd_net_val  AS plan_turnover_bytd_net_val
		, main.plan_turnover_py_net_val  AS plan_turnover_py_net_val
		, main.plan_turnover_py_bytd_net_val  AS plan_turnover_py_bytd_net_val
		, main.plan_turnover_py_swday_net_val  AS plan_turnover_py_swday_net_val
		, main.plan_turnover_py_swday_bytd_net_val  AS plan_turnover_py_swday_bytd_net_val
		, main.turnover_gross_val  AS turnover_gross_val
		, main.turnover_bytd_gross_val  AS turnover_bytd_gross_val
		, main.turnover_py_gross_val  AS turnover_py_gross_val
		, main.turnover_py_bytd_gross_val  AS turnover_py_bytd_gross_val
		, main.turnover_py_swday_gross_val  AS turnover_py_swday_gross_val
		, main.turnover_py_swday_bytd_gross_val  AS turnover_py_swday_bytd_gross_val
		, main.cash_register_sales_gross_val + main.cash_register_return_gross_val AS cash_register_turnover_gross_val
		, main.eod_turnover_gross_val  AS eod_turnover_gross_val
		, main.curr_cd AS curr_cd
		, main.receipt_cnt AS receipt_cnt
		, main.receipt_bytd_cnt AS receipt_bytd_cnt
		, main.receipt_py_cnt AS receipt_py_cnt
		, main.receipt_py_bytd_cnt AS receipt_py_bytd_cnt
		, main.receipt_py_swday_cnt AS receipt_py_swday_cnt
		, main.receipt_py_swday_bytd_cnt AS receipt_py_swday_bytd_cnt
		, main.cash_register_receipt_cnt AS cash_register_receipt_cnt
		, main.eod_receipt_cnt AS eod_receipt_cnt
		, main.booked_receipt_cnt AS booked_receipt_cnt
		, main.plan_receipt_cnt AS plan_receipt_cnt
		, main.plan_receipt_bytd_cnt AS plan_receipt_bytd_cnt
		, main.plan_receipt_py_cnt AS plan_receipt_py_cnt
		, main.plan_receipt_py_bytd_cnt AS plan_receipt_py_bytd_cnt
		, main.plan_receipt_py_swday_cnt AS plan_receipt_py_swday_cnt
		, main.plan_receipt_py_swday_bytd_cnt AS plan_receipt_py_swday_bytd_cnt
		, main.dwh_created_tmsp AS dwh_created_tmsp
		, main.dwh_updated_tmsp AS dwh_updated_tmsp
		, main.dwh_load_id AS dwh_load_id
		, main.dwh_node_cd AS dwh_node_cd
	 FROM core_dim.t_fact_retail_by_store_day_1 main
	INNER JOIN CORE_DIM.t_dim_internal_organization_1 org
	   ON org.int_org_sid = main.int_org_sid
        WHERE org.dwh_valid_fg = TRUE        -- 25.03.2025: additional condition to be extended
	UNION ALL

	SELECT 
		  main.bus_dt AS bus_dt
		, DECODE( org.is_country_org_fg, true, org.int_org_sid, org.sales_mgr_district_sid) AS int_org_sid
		, 2::NUMBER(38,0) AS benchmarking_type_id
		, org.acct_mgr_district_sid  AS parent_int_org_sid     -- group by - SID Account_1 Manager (VT)
		, org.acct_mgr_district_name  AS parent_int_org_nat_key_nr   -- group by - Stays for Natural Key of Account_1 Manager (VT)
		, org.int_org_type_cd AS int_org_type_cd
		, main.country_org_cd AS country_org_cd
		, SUM(main.turnover_net_val) AS turnover_net_val -- SUM
		, SUM(main.turnover_bytd_net_val) AS turnover_bytd_net_val
		, SUM(main.turnover_py_net_val) AS turnover_py_net_val
		, SUM(main.turnover_py_bytd_net_val) AS turnover_py_bytd_net_val
		, SUM(main.turnover_py_swday_net_val) AS turnover_py_swday_net_val
		, SUM(main.turnover_py_swday_bytd_net_val) AS turnover_py_swday_bytd_net_val
		, SUM(main.cash_register_sales_net_val + main.cash_register_return_net_val) AS cash_register_turnover_net_val
		, SUM(main.eod_turnover_net_val) AS eod_turnover_net_val
		, SUM(main.booked_turnover_net_val) AS booked_turnover_net_val
		, SUM(main.plan_turnover_net_val) AS plan_turnover_net_val
		, SUM(main.plan_turnover_bytd_net_val) AS plan_turnover_bytd_net_val
		, SUM(main.plan_turnover_py_net_val) AS plan_turnover_py_net_val
		, SUM(main.plan_turnover_py_bytd_net_val) AS plan_turnover_py_bytd_net_val
		, SUM(main.plan_turnover_py_swday_net_val) AS plan_turnover_py_swday_net_val
		, SUM(main.plan_turnover_py_swday_bytd_net_val) AS plan_turnover_py_swday_bytd_net_val
		, SUM(main.turnover_gross_val) AS turnover_gross_val
		, SUM(main.turnover_bytd_gross_val) AS turnover_bytd_gross_val
		, SUM(main.turnover_py_gross_val) AS turnover_py_gross_val
		, SUM(main.turnover_py_bytd_gross_val) AS turnover_py_bytd_gross_val
		, SUM(main.turnover_py_swday_gross_val) AS turnover_py_swday_gross_val
		, SUM(main.turnover_py_swday_bytd_gross_val) AS turnover_py_swday_bytd_gross_val
		, SUM(main.cash_register_sales_gross_val + main.cash_register_return_gross_val) AS cash_register_turnover_gross_val
		, SUM(main.eod_turnover_gross_val) AS eod_turnover_gross_val
		, main.curr_cd AS curr_cd
		, SUM(main.receipt_cnt) AS receipt_cnt
		, SUM(main.receipt_bytd_cnt) AS receipt_bytd_cnt
		, SUM(main.receipt_py_cnt) AS receipt_py_cnt
		, SUM(main.receipt_py_bytd_cnt) AS receipt_py_bytd_cnt
		, SUM(main.receipt_py_swday_cnt) AS receipt_py_swday_cnt
		, SUM(main.receipt_py_swday_bytd_cnt) AS receipt_py_swday_bytd_cnt
		, SUM(main.cash_register_receipt_cnt) AS cash_register_receipt_cnt
		, SUM(main.eod_receipt_cnt) AS eod_receipt_cnt
		, SUM(main.booked_receipt_cnt) AS booked_receipt_cnt
		, SUM(main.plan_receipt_cnt) AS plan_receipt_cnt
		, SUM(main.plan_receipt_bytd_cnt) AS plan_receipt_bytd_cnt
		, SUM(main.plan_receipt_py_cnt) AS plan_receipt_py_cnt
		, SUM(main.plan_receipt_py_bytd_cnt) AS plan_receipt_py_bytd_cnt
		, SUM(main.plan_receipt_py_swday_cnt) AS plan_receipt_py_swday_cnt
		, SUM(main.plan_receipt_py_swday_bytd_cnt) AS plan_receipt_py_swday_bytd_cnt
		, MAX(main.dwh_created_tmsp) AS dwh_created_tmsp
		, MAX(main.dwh_updated_tmsp) AS dwh_updated_tmsp
		, MAX(main.dwh_load_id) AS dwh_load_id
		, MAX(main.dwh_node_cd) AS dwh_node_cd
	FROM  core_dim.t_fact_retail_by_store_day_1 main
	INNER JOIN
		  ( SELECT
				  org_store.int_org_sid
				, org_store.is_country_org_fg
				, org_store.sales_mgr_district_sid
				, org_sales.int_org_type_cd
				, org_store.acct_mgr_district_sid
				, org_store.acct_mgr_district_name
				, org_store.dwh_valid_fg
			FROM  core_dim.t_dim_internal_organization_1 org_store
			INNER JOIN
				  core_dim.t_dim_internal_organization_1 org_sales
			  ON  org_sales.int_org_sid = org_store.sales_mgr_district_sid
			WHERE org_store.dwh_valid_fg = true
			  AND org_sales.dwh_valid_fg = true
		  ) org
	  ON  org.int_org_sid = main.int_org_sid
	GROUP BY
		  main.bus_dt
		, DECODE( org.is_country_org_fg
				, true, org.int_org_sid
				, org.sales_mgr_district_sid
		  )
		, benchmarking_type_id
		, parent_int_org_sid
		, parent_int_org_nat_key_nr
		, org.int_org_type_cd
		, main.country_org_cd
		, main.curr_cd

	UNION ALL

	SELECT
		  main.bus_dt AS bus_dt
		, DECODE( org.is_country_org_fg, true, org.int_org_sid, org.acct_mgr_district_sid) AS int_org_sid
		, 3::NUMBER(38,0) AS benchmarking_type_id
		, org.sales_company_sid AS parent_int_org_sid            -- group by - SID of Sales_1 Company (VGES)
		, org.SALES_COMPANY_NR AS parent_int_org_nat_key_nr      -- group by - Stays for Natural Key of Sales_1 Company (VGES)
		, org.int_org_type_cd AS int_org_type_cd
		, main.country_org_cd AS country_org_cd
		, SUM(main.turnover_net_val ) AS turnover_net_val
		, SUM(main.turnover_bytd_net_val ) AS turnover_bytd_net_val
		, SUM(main.turnover_py_net_val ) AS turnover_py_net_val
		, SUM(main.turnover_py_bytd_net_val ) AS turnover_py_bytd_net_val
		, SUM(main.turnover_py_swday_net_val ) AS turnover_py_swday_net_val
		, SUM(main.turnover_py_swday_bytd_net_val ) AS turnover_py_swday_bytd_net_val
		, SUM(main.cash_register_sales_net_val + main.cash_register_return_net_val) AS cash_register_turnover_net_val
		, SUM(main.eod_turnover_net_val ) AS eod_turnover_net_val
		, SUM(main.booked_turnover_net_val ) AS booked_turnover_net_val
		, SUM(main.plan_turnover_net_val ) AS plan_turnover_net_val
		, SUM(main.plan_turnover_bytd_net_val ) AS plan_turnover_bytd_net_val
		, SUM(main.plan_turnover_py_net_val ) AS plan_turnover_py_net_val
		, SUM(main.plan_turnover_py_bytd_net_val ) AS plan_turnover_py_bytd_net_val
		, SUM(main.plan_turnover_py_swday_net_val ) AS plan_turnover_py_swday_net_val
		, SUM(main.plan_turnover_py_swday_bytd_net_val ) AS plan_turnover_py_swday_bytd_net_val
		, SUM(main.turnover_gross_val ) AS turnover_gross_val
		, SUM(main.turnover_bytd_gross_val ) AS turnover_bytd_gross_val
		, SUM(main.turnover_py_gross_val ) AS turnover_py_gross_val
		, SUM(main.turnover_py_bytd_gross_val ) AS turnover_py_bytd_gross_val
		, SUM(main.turnover_py_swday_gross_val ) AS turnover_py_swday_gross_val
		, SUM(main.turnover_py_swday_bytd_gross_val ) AS turnover_py_swday_bytd_gross_val
		, SUM(main.cash_register_sales_gross_val + main.cash_register_return_gross_val) AS cash_register_turnover_gross_val
		, SUM(main.eod_turnover_gross_val ) AS eod_turnover_gross_val
		, main.curr_cd AS curr_cd
		, SUM(main.receipt_cnt) AS receipt_cnt
		, SUM(main.receipt_bytd_cnt) AS receipt_bytd_cnt
		, SUM(main.receipt_py_cnt) AS receipt_py_cnt
		, SUM(main.receipt_py_bytd_cnt) AS receipt_py_bytd_cnt
		, SUM(main.receipt_py_swday_cnt) AS receipt_py_swday_cnt
		, SUM(main.receipt_py_swday_bytd_cnt) AS receipt_py_swday_bytd_cnt
		, SUM(main.cash_register_receipt_cnt) AS cash_register_receipt_cnt
		, SUM(main.eod_receipt_cnt) AS eod_receipt_cnt
		, SUM(main.booked_receipt_cnt) AS booked_receipt_cnt
		, SUM(main.plan_receipt_cnt) AS plan_receipt_cnt
		, SUM(main.plan_receipt_bytd_cnt) AS plan_receipt_bytd_cnt
		, SUM(main.plan_receipt_py_cnt) AS plan_receipt_py_cnt
		, SUM(main.plan_receipt_py_bytd_cnt) AS plan_receipt_py_bytd_cnt
		, SUM(main.plan_receipt_py_swday_cnt) AS plan_receipt_py_swday_cnt
		, SUM(main.plan_receipt_py_swday_bytd_cnt) AS plan_receipt_py_swday_bytd_cnt
		, MAX(main.dwh_created_tmsp) AS dwh_created_tmsp
		, MAX(main.dwh_updated_tmsp) AS dwh_updated_tmsp
		, MAX(main.dwh_load_id) AS dwh_load_id
		, MAX(main.dwh_node_cd) AS dwh_node_cd
	FROM  core_dim.t_fact_retail_by_store_day_1 main
	INNER JOIN
		  ( SELECT
				  org_store.int_org_sid
				, org_store.is_country_org_fg
				, org_store.acct_mgr_district_sid
				, org_acct.int_org_type_cd
				, org_store.SALES_COMPANY_SID
				, org_store.SALES_COMPANY_NR
				, org_store.dwh_valid_fg
			FROM  core_dim.t_dim_internal_organization_1 org_store
			INNER JOIN
				  core_dim.t_dim_internal_organization_1 org_acct
			  ON  org_acct.int_org_sid = org_store.acct_mgr_district_sid
			WHERE org_store.dwh_valid_fg = true
			  AND org_acct.dwh_valid_fg = true
		  ) org
	   ON org.int_org_sid = main.int_org_sid
	GROUP BY
		  main.bus_dt
		, parent_int_org_sid
		, parent_int_org_nat_key_nr
		, DECODE( org.is_country_org_fg
				, true, org.int_org_sid
				, org.acct_mgr_district_sid
		  )
		, benchmarking_type_id
		, org.int_org_type_cd
		, main.country_org_cd
		, main.CURR_CD

	UNION ALL

	SELECT
		  main.bus_dt AS bus_dt
		, DECODE( org.is_country_org_fg, true, org.int_org_sid, org.sales_company_sid) AS int_org_sid
		, 4::NUMBER(38,0) AS benchmarking_type_id
		, org.country_org_sid AS parent_int_org_sid          -- group by - SID of Country_1 Org
		, main.country_org_cd AS parent_int_org_nat_key_nr   -- group by - Natural Key (code) of Country_1 Org
		, org.int_org_type_cd AS int_org_type_cd
		, main.country_org_cd AS country_org_cd
		, SUM(main.turnover_net_val) AS turnover_net_val -- SUM
		, SUM(main.turnover_bytd_net_val ) AS turnover_bytd_net_val
		, SUM(main.turnover_py_net_val ) AS turnover_py_net_val
		, SUM(main.turnover_py_bytd_net_val ) AS turnover_py_bytd_net_val
		, SUM(main.turnover_py_swday_net_val ) AS turnover_py_swday_net_val
		, SUM(main.turnover_py_swday_bytd_net_val ) AS turnover_py_swday_bytd_net_val
		, SUM(main.cash_register_sales_net_val + main.cash_register_return_net_val) AS cash_register_turnover_net_val
		, SUM(main.eod_turnover_net_val ) AS eod_turnover_net_val
		, SUM(main.booked_turnover_net_val ) AS booked_turnover_net_val
		, SUM(main.plan_turnover_net_val ) AS plan_turnover_net_val
		, SUM(main.plan_turnover_bytd_net_val ) AS plan_turnover_bytd_net_val
		, SUM(main.plan_turnover_py_net_val ) AS plan_turnover_py_net_val
		, SUM(main.plan_turnover_py_bytd_net_val ) AS plan_turnover_py_bytd_net_val
		, SUM(main.plan_turnover_py_swday_net_val ) AS plan_turnover_py_swday_net_val
		, SUM(main.plan_turnover_py_swday_bytd_net_val ) AS plan_turnover_py_swday_bytd_net_val
		, SUM(main.turnover_gross_val ) AS turnover_gross_val
		, SUM(main.turnover_bytd_gross_val ) AS turnover_bytd_gross_val
		, SUM(main.turnover_py_gross_val ) AS turnover_py_gross_val
		, SUM(main.turnover_py_bytd_gross_val ) AS turnover_py_bytd_gross_val
		, SUM(main.turnover_py_swday_gross_val ) AS turnover_py_swday_gross_val
		, SUM(main.turnover_py_swday_bytd_gross_val ) AS turnover_py_swday_bytd_gross_val
		, SUM(main.cash_register_sales_gross_val + main.cash_register_return_gross_val) AS cash_register_turnover_gross_val
		, SUM(main.eod_turnover_gross_val ) AS eod_turnover_gross_val
		, main.curr_cd  AS curr_cd
		, SUM(main.receipt_cnt) AS receipt_cnt
		, SUM(main.receipt_bytd_cnt) AS receipt_bytd_cnt
		, SUM(main.receipt_py_cnt) AS receipt_py_cnt
		, SUM(main.receipt_py_bytd_cnt) AS receipt_py_bytd_cnt
		, SUM(main.receipt_py_swday_cnt) AS receipt_py_swday_cnt
		, SUM(main.receipt_py_swday_bytd_cnt) AS receipt_py_swday_bytd_cnt
		, SUM(main.cash_register_receipt_cnt) AS cash_register_receipt_cnt
		, SUM(main.eod_receipt_cnt) AS eod_receipt_cnt
		, SUM(main.booked_receipt_cnt) AS booked_receipt_cnt
		, SUM(main.plan_receipt_cnt) AS plan_receipt_cnt
		, SUM(main.plan_receipt_bytd_cnt) AS plan_receipt_bytd_cnt
		, SUM(main.plan_receipt_py_cnt) AS plan_receipt_py_cnt
		, SUM(main.plan_receipt_py_bytd_cnt) AS plan_receipt_py_bytd_cnt
		, SUM(main.plan_receipt_py_swday_cnt) AS plan_receipt_py_swday_cnt
		, SUM(main.plan_receipt_py_swday_bytd_cnt) AS plan_receipt_py_swday_bytd_cnt
		, MAX(main.dwh_created_tmsp) AS dwh_created_tmsp
		, MAX(main.dwh_updated_tmsp) AS dwh_updated_tmsp
		, MAX(main.dwh_load_id) AS dwh_load_id
		, MAX(main.dwh_node_cd) AS dwh_node_cd
	FROM  core_dim.t_fact_retail_by_store_day_1 main
	INNER JOIN
		  ( SELECT org_store.country_org_sid
				 , org_store.int_org_sid
				 , org_store.is_country_org_fg
				 , org_store.sales_company_sid
				 , org_cmpy.int_org_type_cd
				 , org_store.dwh_valid_fg
			  FROM core_dim.t_dim_internal_organization_1 org_store
			 INNER JOIN
				   core_dim.t_dim_internal_organization_1 org_cmpy
			   ON org_cmpy.int_org_sid = org_store.sales_company_sid
			WHERE org_store.dwh_valid_fg = true
			  AND org_cmpy.dwh_valid_fg = true
		  ) org
	  ON  org.int_org_sid = main.int_org_sid
	GROUP BY
		  main.bus_dt
		, parent_int_org_sid
		, parent_int_org_nat_key_nr
		, DECODE( org.is_country_org_fg
				, true, org.int_org_sid
				, org.sales_company_sid
		  )
		, benchmarking_type_id
		, org.int_org_type_cd
		, main.country_org_cd
		, main.curr_cd

	-- UNION ALL

	UNION ALL

	SELECT
		  main.bus_dt AS bus_dt
		, org.country_org_sid AS int_org_sid
		, 6::NUMBER(38,0) AS benchmarking_type_id
		, -1 AS parent_int_org_sid              -- group by - value -1, there is no surrogate key value existing for this Level in dimension table
		, 'INT' AS parent_int_org_nat_key_nr    -- group by - Fix value INT (for international or all)
		, org.int_org_type_cd AS int_org_type_cd
		, main.country_org_cd AS country_org_cd
		, SUM(main.turnover_net_val) AS turnover_net_val -- SUM
		, SUM(main.turnover_bytd_net_val ) AS turnover_bytd_net_val
		, SUM(main.turnover_py_net_val ) AS turnover_py_net_val
		, SUM(main.turnover_py_bytd_net_val ) AS turnover_py_bytd_net_val
		, SUM(main.turnover_py_swday_net_val ) AS turnover_py_swday_net_val
		, SUM(main.turnover_py_swday_bytd_net_val ) AS turnover_py_swday_bytd_net_val
		, SUM(main.cash_register_sales_net_val + main.cash_register_return_net_val) AS cash_register_turnover_net_val
		, SUM(main.eod_turnover_net_val ) AS eod_turnover_net_val
		, SUM(main.booked_turnover_net_val ) AS booked_turnover_net_val
		, SUM(main.plan_turnover_net_val ) AS plan_turnover_net_val
		, SUM(main.plan_turnover_bytd_net_val ) AS plan_turnover_bytd_net_val
		, SUM(main.plan_turnover_py_net_val ) AS plan_turnover_py_net_val
		, SUM(main.plan_turnover_py_bytd_net_val ) AS plan_turnover_py_bytd_net_val
		, SUM(main.plan_turnover_py_swday_net_val ) AS plan_turnover_py_swday_net_val
		, SUM(main.plan_turnover_py_swday_bytd_net_val ) AS plan_turnover_py_swday_bytd_net_val
		, SUM(main.turnover_gross_val ) AS turnover_gross_val
		, SUM(main.turnover_bytd_gross_val ) AS turnover_bytd_gross_val
		, SUM(main.turnover_py_gross_val ) AS turnover_py_gross_val
		, SUM(main.turnover_py_bytd_gross_val ) AS turnover_py_bytd_gross_val
		, SUM(main.turnover_py_swday_gross_val ) AS turnover_py_swday_gross_val
		, SUM(main.turnover_py_swday_bytd_gross_val ) AS turnover_py_swday_bytd_gross_val
		, SUM(main.cash_register_sales_gross_val + main.cash_register_return_gross_val) AS cash_register_turnover_gross_val
		, SUM(main.eod_turnover_gross_val ) AS eod_turnover_gross_val
		, main.curr_cd AS curr_cd
		, SUM(main.receipt_cnt) AS receipt_cnt
		, SUM(main.receipt_bytd_cnt) AS receipt_bytd_cnt
		, SUM(main.receipt_py_cnt) AS receipt_py_cnt
		, SUM(main.receipt_py_bytd_cnt) AS receipt_py_bytd_cnt
		, SUM(main.receipt_py_swday_cnt) AS receipt_py_swday_cnt
		, SUM(main.receipt_py_swday_bytd_cnt) AS receipt_py_swday_bytd_cnt
		, SUM(main.cash_register_receipt_cnt) AS cash_register_receipt_cnt
		, SUM(main.eod_receipt_cnt) AS eod_receipt_cnt
		, SUM(main.booked_receipt_cnt) AS booked_receipt_cnt
		, SUM(main.plan_receipt_cnt) AS plan_receipt_cnt
		, SUM(main.plan_receipt_bytd_cnt) AS plan_receipt_bytd_cnt
		, SUM(main.plan_receipt_py_cnt) AS plan_receipt_py_cnt
		, SUM(main.plan_receipt_py_bytd_cnt) AS plan_receipt_py_bytd_cnt
		, SUM(main.plan_receipt_py_swday_cnt) AS plan_receipt_py_swday_cnt
		, SUM(main.plan_receipt_py_swday_bytd_cnt) AS plan_receipt_py_swday_bytd_cnt
		, MAX(main.dwh_created_tmsp) AS dwh_created_tmsp
		, MAX(main.dwh_updated_tmsp) AS dwh_updated_tmsp
		, MAX(main.dwh_load_id) AS dwh_load_id
		, MAX(main.dwh_node_cd) AS dwh_node_cd
	FROM  core_dim.t_fact_retail_by_store_day_1 main
	INNER JOIN
		  ( SELECT
				  org_store.int_org_sid
				, org_store.is_country_org_fg
				, org_store.country_org_sid
				, org_cntry.int_org_type_cd
				, org_store.dwh_valid_fg
			FROM  core_dim.t_dim_internal_organization_1 org_store
			INNER JOIN
				  core_dim.t_dim_internal_organization_1 org_cntry
			  ON  org_cntry.int_org_sid = org_store.country_org_sid
			WHERE org_store.dwh_valid_fg = true
			  AND org_cntry.dwh_valid_fg = true
		  ) org
	   ON org.int_org_sid = main.int_org_sid
	GROUP BY
		  main.bus_dt
		, parent_int_org_sid
		, parent_int_org_nat_key_nr  
		, org.country_org_sid
		, benchmarking_type_id
		, org.int_org_type_cd
		, main.country_org_cd
		, main.curr_cd
;

COMMIT;
