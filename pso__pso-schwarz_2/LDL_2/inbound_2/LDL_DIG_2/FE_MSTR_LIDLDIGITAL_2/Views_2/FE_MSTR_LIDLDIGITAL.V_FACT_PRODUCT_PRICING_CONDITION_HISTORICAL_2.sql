CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_PRODUCT_PRICING_CONDITION_HISTORICAL_2(
	WSHOP_CD
	,CURR_CD
	,PROD_VARIANT_SID
	,PRICE_TYPE_CD
	,ACTIVE_FROM_DT
	,ACTIVE_FROM_TMSP
	,ACTIVE_TO_DT
	,ACTIVE_TO_TMSP
	,PRICE_VAL
	,GC_LC_CD
) AS


  -- Show the global currency prices
    SELECT 
            IFNULL(ppc.wshop_cd, '-1')                          AS wshop_cd
            ,IFNULL(cer.to_curr_cd, '-1')                       AS curr_cd  
            ,IFNULL(ppc.prod_variant_sid, '-1')                 AS prod_variant_sid
            ,IFNULL(ppc.price_type_cd, '-1')                    AS price_type_cd
            ,TO_DATE(ppc.active_from_tmsp)                      AS active_from_dt
			,ppc.active_from_tmsp                               AS active_from_tmsp
			,TO_DATE(ppc.active_to_tmsp)                        AS active_to_dt
            ,ppc.active_to_tmsp                                 AS active_to_tmsp
            ,ROUND (ppc.price_val / cer.exchange_rate,3)        AS price_val 
            ,'GC'                                               AS gc_lc_cd 
      
    FROM
        lec_share.v_fact_product_pricing_condition_2 ppc
       JOIN 
            lec_share.v_fact_currency_exchange_rate_2 cer
            ON  ppc.curr_cd = cer.from_curr_cd
                AND DATE (active_from_tmsp) BETWEEN cer.active_from_dt AND cer.active_to_dt
                AND cer.curr_exchange_rate_type_cd = 'F'
                AND cer.to_curr_cd = 'EUR'            
 -- Show the Local Currency prices 
        UNION ALL  
            SELECT 
                IFNULL(wshop_cd, '-1')                          AS wshop_cd
                ,IFNULL(curr_cd, '-1')                          AS curr_cd  
                ,IFNULL(prod_variant_sid, '-1')                 AS prod_variant_sid
                ,IFNULL(price_type_cd, '-1')                    AS price_type_cd
                ,TO_DATE(active_from_tmsp)                      AS active_from_dt
				,active_from_tmsp                               AS active_from_tmsp
                ,TO_DATE(active_to_tmsp)                        AS active_to_dt
				,active_to_tmsp                                 AS active_to_tmsp
                ,price_val                                      AS price_val
                ,'LC'                                           AS gc_lc_cd
            FROM
                lec_share.v_fact_product_pricing_condition_2 ppc
            WHERE 
                curr_cd != 'EUR' 
              
 -- Show local currency values related to IVP and WSP 
        UNION ALL     
            SELECT
                IFNULL(ppc.wshop_cd, '-1')                      AS wshop_cd
                ,IFNULL(rwc.curr_cd, '-1')                      AS curr_cd  
                ,IFNULL(ppc.prod_variant_sid, '-1')             AS prod_variant_sid
                ,IFNULL(ppc.price_type_cd, '-1')                AS price_type_cd
				,TO_DATE(ppc.active_from_tmsp)                  AS active_from_dt
                ,ppc.active_from_tmsp                           AS active_from_tmsp
				,TO_DATE(ppc.active_to_tmsp)                    AS active_to_dt
                ,ppc.active_to_tmsp                             AS active_to_tmsp
                ,ROUND(ppc.price_val * cer.exchange_rate,3)     AS price_val 
                ,'LC'                                           AS gc_lc_cd
            FROM
                lec_share.v_fact_product_pricing_condition_2 ppc

            JOIN 
                lec_share.v_rel_webshop_currency_2 rwc
                ON  ppc.wshop_cd = rwc.wshop_cd
                    AND rwc.dwh_valid_fg
            JOIN 
                lec_share.v_fact_currency_exchange_rate_2 cer
                ON rwc.curr_cd = cer.from_curr_cd
                    AND DATE(active_from_tmsp) BETWEEN cer.active_from_dt AND cer.active_to_dt
                    AND cer.curr_exchange_rate_type_cd = 'F' 
            WHERE
                ppc.curr_cd = 'EUR'
                AND rwc.curr_cd != 'EUR'
            ;