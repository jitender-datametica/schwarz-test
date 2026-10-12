create or replace view SMP_PRODUCTION.FE_MSTR_SMP.V_DOOH_AB_CAMPAIGN_DATA_1(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	PERIOD,
	CY_WEEK,
	GTIN_ID,
	CAMPAIGN_HALO,
	CONTROL_QTY,
	TEST_QTY,
	BASELINE_CONTROL_QTY,
	BASELINE_TEST_QTY,
	CONTROL_VAL,
	TEST_VAL,
	BASELINE_CONTROL_VAL,
	BASELINE_TEST_VAL
) as 
SELECT 
   division_id
  ,country_id
  ,campaign_id
  ,PERIOD 
  ,cy_week
  ,gtin_id
  ,campaign_halo
  ,control_qty
  ,test_qty
  ,CAST
   (
     DIV0(SUM(CASE WHEN PERIOD = '1 PRE' THEN control_qty ELSE 0 END) OVER (PARTITION BY PERIOD, gtin_id)
     , SUM(CASE WHEN PERIOD = '1 PRE' THEN 1 ELSE 0 END) OVER (PARTITION BY PERIOD, gtin_id)) 
     AS INTEGER
   ) AS baseline_control_qty
  ,CAST
   (
     DIV0(SUM(CASE WHEN PERIOD = '1 PRE' THEN test_qty ELSE 0 END) OVER (PARTITION BY PERIOD, gtin_id)
     , SUM(CASE WHEN PERIOD = '1 PRE' THEN 1 ELSE 0 END) OVER (PARTITION BY PERIOD, gtin_id)) 
     AS INTEGER
   ) AS baseline_test_qty 
  ,control_val
  ,test_val
  ,CAST
   (
     DIV0(SUM(CASE WHEN PERIOD = '1 PRE' THEN control_val ELSE 0 END) OVER (PARTITION BY PERIOD, gtin_id)
     , SUM(CASE WHEN PERIOD = '1 PRE' THEN 1 ELSE 0 END) OVER (PARTITION BY PERIOD, gtin_id)) 
     AS INTEGER
   ) AS baseline_control_val
  ,CAST
   ( 
     DIV0(SUM(CASE WHEN PERIOD = '1 PRE' THEN test_val ELSE 0 END) OVER (PARTITION BY PERIOD, gtin_id)
     , SUM(CASE WHEN PERIOD = '1 PRE' THEN 1 ELSE 0 END) OVER (PARTITION BY PERIOD, gtin_id)) 
    AS INTEGER
   ) AS baseline_test_val 
FROM    
(
  SELECT 
     r.division_id
    ,r.country_id
    ,r.campaign_id
    ,r.PERIOD
    ,CASE WHEN gg.faecher = 1 AND r.campaign_fg = 1 THEN 'CAMPAIGN'
          WHEN gg.faecher = 2 AND r.campaign_fg = 0 AND r.art_hierarchy_level_id = 1 THEN 'HALO 1'
          WHEN gg.faecher = 3 AND r.campaign_fg = 0 AND r.art_hierarchy_level_id IN (1,2) THEN 'HALO 2'
          ELSE '' 
     END AS campaign_halo
    ,r.cy_week
    ,r.gtin_id            
    ,SUM(control_qty) AS control_qty
    ,SUM(test_qty) AS test_qty  
    ,SUM(control_val) AS control_val
    ,SUM(test_val) AS test_val  
  FROM core.v_ab_test_result_week_1 r
  
  
  INNER JOIN 
  (
    SELECT 1 AS faecher  
    UNION 
    SELECT 2 AS faecher  
    UNION
    SELECT 3 AS faecher  
  ) gg
  ON 1=1
  
  WHERE r.campaign_type_id = 'DOOH'
    AND campaign_halo <> ''

  GROUP BY 1,2,3,4,5,6,7
) a
;
