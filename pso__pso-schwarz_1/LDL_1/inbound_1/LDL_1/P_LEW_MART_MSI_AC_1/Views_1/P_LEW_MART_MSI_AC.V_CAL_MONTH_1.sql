create or replace view LDL_PRODUCTION.P_LEW_MART_MSI_AC.V_CAL_MONTH_1(
	CY_MONTH,
	PREV_MONTH,
	PREV_CY_MONTH,
	PREPREV_CY_MONTH,
	CY,
	BYR,
	CY_MONTH_SEQUENCE,
	MONTH_ID
) as
   SELECT
       cy_month,
   prev_month,
   prev_cy_month,
   preprev_cy_month,
   cy,
   byr,
   cy_month_sequence,
   month_id
  FROM p_lew_mart_msi.v_cal_month_1
;
