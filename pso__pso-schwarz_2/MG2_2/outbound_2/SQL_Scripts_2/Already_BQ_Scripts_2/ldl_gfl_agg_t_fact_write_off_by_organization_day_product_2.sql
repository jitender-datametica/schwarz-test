CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.vt3 AS
SELECT agg.bus_dt
	, agg.int_org_sid
	, agg.int_org_type_cd
	, COALESCE(prdvar.prod_sid, - 1) AS prod_sid
	, agg.logistic_variant_sid
	, agg.country_org_sid
	, agg.country_org_cd
	-- all write off values have to be negative since these KPIs are a loss for the stores 
	, agg.write_off_for_breakage_net_val * -1 AS write_off_for_breakage_net_val
	, agg.write_off_for_sell_by_dt_net_val * -1 AS write_off_for_sell_by_dt_net_val
	, agg.write_off_for_deliv_quality_net_val * -1 AS write_off_for_deliv_quality_net_val
	, agg.write_off_for_defective_non_food_net_val * -1 AS write_off_for_defective_non_food_net_val
	, agg.write_off_for_donations_net_val * -1 AS write_off_for_donations_net_val
	, agg.write_off_for_taken_prod_net_val * -1 AS write_off_for_taken_prod_net_val
	, agg.write_off_for_discounts_net_val * -1 AS write_off_for_discounts_net_val
	, agg.write_off_net_val * -1 AS write_off_net_val
	, agg.write_off_for_force_majeure_net_val * -1 AS write_off_for_force_majeure_net_val
	, agg.write_off_for_stock_clearance_net_val * -1 AS write_off_for_stock_clearance_net_val
	, agg.curr_cd
	, CURRENT_TIMESTAMP AS dwh_created_tmsp
	, CURRENT_TIMESTAMP AS dwh_updated_tmsp
	, '${LOAD_ID}' AS dwh_load_id
	, 'CORE_REL' AS dwh_node_cd
FROM (
        SELECT wr.bus_dt AS bus_dt
		, wr.int_org_sid
		, 'STORE' AS int_org_type_cd
		, wr.logistic_variant_sid
		, ANY_VALUE(wr.country_org_sid) AS country_org_sid
		, ANY_VALUE(wr.country_org_cd) AS country_org_cd
		, SUM(CASE WHEN write_off_reason_id IN (2, 128) THEN wr.write_off_net_val ELSE 0 END) AS write_off_for_breakage_net_val -- BRUCH
		, SUM(CASE WHEN write_off_reason_id IN (1, 127, 134, 135) THEN wr.write_off_net_val ELSE 0 END) AS write_off_for_sell_by_dt_net_val -- MHD
		, SUM(CASE WHEN write_off_reason_id IN (8) THEN wr.write_off_net_val ELSE 0 END) AS write_off_for_deliv_quality_net_val -- ANLIEFERUNG QUALITAT
		, SUM(CASE WHEN write_off_reason_id IN (9, 10, 11) THEN wr.write_off_net_val ELSE 0 END) AS write_off_for_defective_non_food_net_val -- DEFEKTES NF
		, SUM(CASE WHEN write_off_reason_id IN (7, 130, 131) THEN wr.write_off_net_val ELSE 0 END) AS write_off_for_donations_net_val -- SPENDEN
		, SUM(CASE WHEN write_off_reason_id IN (4, 101, 102, 110, 111, 129, 155) THEN wr.write_off_net_val ELSE 0 END) AS write_off_for_taken_prod_net_val -- WARENENTNAHME
		, SUM(CASE WHEN write_off_reason_id IN (5) THEN wr.write_off_net_val ELSE 0 END) AS write_off_for_discounts_net_val -- RABATTIERUNG
		, SUM(wr.write_off_net_val) AS write_off_net_val --TOTAL
		, SUM(CASE WHEN write_off_reason_id IN (3, 136, 137, 152) THEN wr.write_off_net_val ELSE 0 END) AS write_off_for_force_majeure_net_val -- höhere Gewalt Filiale
		, SUM(CASE WHEN write_off_reason_id IN (6, 151) THEN wr.write_off_net_val ELSE 0 END) AS write_off_for_stock_clearance_net_val -- Restantenverwertung (PV) Aktion_2
		, ANY_VALUE(COALESCE(wr.curr_cd, '@')) AS curr_cd
	FROM core_rel.t_write_off_event_2 wr
	INNER JOIN ${FWRK_WORK_DB}.vt1 dk
		ON dk.loc_sid = wr.int_org_sid
			AND dk.dwh_cal_dt = wr.bus_dt
	WHERE wr.write_off_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
		AND wr.curr_stat_fg = TRUE
		AND wr.int_org_type_cd = 'STORE'
		AND wr.write_off_event_type_id IN (137, 147)
	GROUP BY wr.bus_dt
		, wr.int_org_sid
		, wr.logistic_variant_sid
		, wr.curr_cd
	) AS agg
LEFT OUTER JOIN core_rel.t_product_variant_2 AS prdvar
	ON prdvar.prod_variant_sid = agg.logistic_variant_sid
		AND prdvar.dwh_valid_fg = TRUE
;

BEGIN TRANSACTION;

DELETE
FROM core_dim.t_fact_write_off_by_organization_day_product_2 agg USING ${FWRK_WORK_DB}.vt1 b
WHERE b.dwh_cal_dt = agg.bus_dt
	AND b.loc_sid = agg.int_org_sid
;

INSERT INTO core_dim.t_fact_write_off_by_organization_day_product_2 (
	bus_dt
	, int_org_sid
	, int_org_type_cd
	, prod_sid
	, logistic_variant_sid
	, country_org_sid
	, country_org_cd
	, write_off_for_breakage_net_val
	, write_off_for_sell_by_dt_net_val
	, write_off_for_deliv_quality_net_val
	, write_off_for_defective_non_food_net_val
	, write_off_for_donations_net_val
	, write_off_for_taken_prod_net_val
	, write_off_for_discounts_net_val
	, write_off_net_val
	, write_off_for_force_majeure_net_val
	, write_off_for_stock_clearance_net_val
	, curr_cd
	, dwh_created_tmsp
	, dwh_updated_tmsp
	, dwh_load_id
	, dwh_node_cd
	)
SELECT bus_dt
	, int_org_sid
	, int_org_type_cd
	, prod_sid
	, logistic_variant_sid
	, country_org_sid
	, country_org_cd
	, write_off_for_breakage_net_val
	, write_off_for_sell_by_dt_net_val
	, write_off_for_deliv_quality_net_val
	, write_off_for_defective_non_food_net_val
	, write_off_for_donations_net_val
	, write_off_for_taken_prod_net_val
	, write_off_for_discounts_net_val
	, write_off_net_val
	, write_off_for_force_majeure_net_val
	, write_off_for_stock_clearance_net_val
	, curr_cd
	, dwh_created_tmsp
	, dwh_updated_tmsp
	, dwh_load_id
	, dwh_node_cd
FROM ${FWRK_WORK_DB}.vt3
;

COMMIT;
