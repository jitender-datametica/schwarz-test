create or replace view LDL_PRODUCTION.P_LEW_BIL.V_ORG_WH_PCH_SWITCH_2(
	ASPECT_ID,
	CLIENT_ID,
	WH_ID,
	PCH_BNL_SWITCH_FG,
	SWITCH_DATE,
	DWH_UPDATED
) COMMENT='Steering Table to determine when a country_2/wh switched to new BNL calculation.'
 as
SELECT a.aspect_id
, a.client_id
, a.wh_id
, a.pch_bnl_switch_fg
/*
, a.switch_date
, cntry_dat.switch_date
, a.switch_date-cntry_dat.switch_date
*/
, CASE WHEN a.switch_date-cntry_dat.switch_date > 30 THEN cntry_dat.switch_date ELSE  a.switch_date END switch_date
, dwh_updated
FROM P_LEW_BIL.t_org_wh_pch_switch_2 a
JOIN (
SELECT client_id, switch_date, dt_cnt
FROM (
SELECT client_id, switch_date, COUNT(1) dt_cnt
FROM P_LEW_BIL.t_wh_pch_switch_2
GROUP BY 1,2
) a
WHERE (client_id, dt_cnt)
IN ( SELECT 
       client_id
     , MAX(dt_cnt) dt_cnt
     FROM ( SELECT client_id, switch_date, COUNT(1) dt_cnt
            FROM P_LEW_BIL.t_wh_pch_switch_2
            GROUP BY 1,2
          ) A
    GROUP BY 1
   )
  ) cntry_dat
ON a.client_id = cntry_dat.client_id

;
