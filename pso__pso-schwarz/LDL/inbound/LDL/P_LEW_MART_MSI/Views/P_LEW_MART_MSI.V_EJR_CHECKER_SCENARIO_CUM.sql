CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_CHECKER_SCENARIO_CUM
/**************************************************************************	
	
**************************************************************************/	
/*	
#DescStart#	
#$Revision: 12115 $, $LastChangedBy: mmorris $	
#SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
#DescEnd#	
*/	
(	
  client_id	
, st_loc_sid	
, checker_id	
, dat_formdate	
, cy_week	
, cy_month	
, cnt_all_suspend	
, cnt_all_void	
, cnt_all_show_price	
, cnt_all_return	
, cnt_all_deposit	
, cnt_all_resumed
, cnt_all_cancelled	
)	
AS	
   SELECT	
     t2t.p_client_id                                               AS client_id	
   ,t2t.p_store_id                                                AS st_loc_sid
   ,t2t.p_checker_id                                              AS checker_id
   ,t2t.p_dat_formdate                                            AS dat_formdate	
   ,cdt.cy_week                                                   AS cy_week
   ,cdt.cy_month                                                  AS cy_month
   ,SUM(CASE WHEN t2t.scenario_group_id = 1001 THEN 1 ELSE 0 END) AS cnt_all_suspend	
   ,SUM(CASE WHEN t2t.scenario_group_id = 1002 THEN 1 ELSE 0 END) AS cnt_all_void
   ,SUM(CASE WHEN t2t.scenario_group_id = 1003 THEN 1 ELSE 0 END) AS cnt_all_show_pric	
   ,SUM(CASE WHEN t2t.scenario_group_id = 1004 THEN 1 ELSE 0 END) AS cnt_all_return
   ,SUM(CASE WHEN t2t.scenario_group_id = 1005 THEN 1 ELSE 0 END) AS cnt_all_deposit	
   ,SUM(CASE WHEN t2t.scenario_group_id = 1006 THEN 1 ELSE 0 END) AS cnt_all_resumed
   ,SUM(CASE WHEN t2t.scenario_group_id = 1007 THEN 1 ELSE 0 END) AS cnt_all_cancelled	
   FROM p_lew_mart_msi.v_ejr_rel_trans_to_trans t2t	
   INNER JOIN p_lew_mart_msi.v_cal_calendarday cdt	
   ON t2t.p_dat_formdate = cdt.dat_calendar	
   WHERE t2t.scenario_group_id IN ( 1001, 1002, 1003, 1004, 1005, 1006, 1007)	
     AND t2t.resumed_trans_seqnr = 1	
   GROUP BY	
             t2t.p_client_id	
           , t2t.p_store_id	
           , t2t.p_checker_id	
           , t2t.p_dat_formdate	
           , cdt.cy_week	
           , cdt.cy_month	
;