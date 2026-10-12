CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.AUTDI_11(
	  FST_FACTOR
	 , FORECAST_TREND
	 , COUNTRY
	 , PFC
	 , PFC_DAY_BEFORE
	 , PFC_TWO_DAY_BEFORE
	 , FORECAST_NO_RATIO
	 , PFC_BEFORE_TREND
	 , D_MIN
	 , HOUR_LAST_SALE
	 , D_PLUS
	 , D_PFC
	 , SUBGROUPNO
	 , FAMILYNO
	 , STORE 
     , DATE
     , WH
     , PROMOTION
     , AMOUNT 
     , AVG_AMOUNT 
     , IS_AMOUNT_ZERO
	 , ITEMNO
	 , SPECIAL_PLACEMENT
	 , V_MODEL
	 , IS_TREND
	 , FORECAST_DAY
	 , TAB
	
) AS
	/* Version: 1.2
	** Author:	Dominik Pfarr
	** Date: 	2022-11-02
	** Changes:	adding coalesce to have factor of 1 if there is no trend applied
	*/
	WITH t AS (
			SELECT COUNTRY
				,DATE
				,STORE_NR
				,STORE_WH
				,ITEMNO
				,EXP(SUM(LN(fst_percent / 100))) AS fst_factor
			FROM "CORE"."T_ORACLE_V_FK_STORE_TREND_TRANSFORMED"
			GROUP BY COUNTRY
				,DATE
				,STORE_NR
				,STORE_WH
				,ITEMNO
			)
		,a AS (
			SELECT DR.COUNTRY
				,DR.pfc
				,DR.pfc_day_before
				,DR.pfc_two_day_before
				,DR.pfc_model AS forecast_no_ratio
				,DR.pfc_before_trend
				,DR.d_min
				,TO_TIME(SALE_LAST_TIME_INT) AS hour_last_sale
				,DR.d_plus
				,DR.d_pfc
				,DR.subgroupno
				,DR.familyno
				,DR.store
				,date_::DATE AS DATE
				,DR.wh
				,DR.promotion
				,DR.amount
				,0 AS avg_amount
				,CASE WHEN AMOUNT = 0 THEN 1 ELSE 0 END AS IS_AMOUNT_ZERO
				,DR.itemno
				,DR.special_placement
				,DR.v_model
				,IS_TREND
				,FORECAST_DAY
				,'fqr' AS tab
			FROM CORE.T_HIVE_V_FORECAST_QUALITY_REDUCED dr
			WHERE FORECAST_DAY = 1
			
			UNION ALL
			
			SELECT fr.country
				,pfc
				,0 AS pfc_day_before
				,0 AS pfc_two_day_before
				,pfc_model AS forecast_no_ratio
				,pfc_before_trend
				,0 AS d_min
				,NULL AS hour_last_sale
				,0 AS d_plus
				,0 AS d_pfc
				,fr.subgroupno
				,familyno
				,store
				,date_::DATE AS DATE
				,wh
				,promotion
				,NULL AS amount
				,NULL AS avg_amount
				,0 AS IS_AMOUNT_ZERO
				,itemno
				,spec_placement AS special_placement
				,v_model
				,NULL AS IS_TREND
				,fd.forecast_day AS FORECAST_DAY
				,'frr' AS tab
			FROM CORE.T_HIVE_FINAL_RESULTS_REDUCED fr
			JOIN CORE.T_HIVE_DIM_FORECAST_DAY fd ON fr.country = fd.country
			WHERE DATE >= CURRENT_DATE ()
			)

SELECT 
	fst_factor
	,pfc  * COALESCE(fst_factor,1) AS forecast_trend
    ,a.*
FROM a
LEFT OUTER JOIN t 
    ON (a.country = t.country AND a.DATE = t.DATE AND a.store = t.store_nr AND a.itemno = t.itemno);