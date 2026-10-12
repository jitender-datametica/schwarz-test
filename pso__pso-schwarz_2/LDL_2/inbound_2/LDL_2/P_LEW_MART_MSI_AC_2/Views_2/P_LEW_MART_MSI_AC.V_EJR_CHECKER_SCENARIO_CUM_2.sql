CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_EJR_CHECKER_SCENARIO_CUM_2
/**************************************************************************

**************************************************************************/
/*
#DescStart#
#$Revision: 12041 $, $LastChangedBy: dpurseth $
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
     client_id
   ,st_loc_sid
   ,checker_id
   ,dat_formdate
   ,cy_week
   ,cy_month
   ,cnt_all_suspend
   ,cnt_all_void
   ,cnt_all_show_price
   ,cnt_all_return
   ,cnt_all_deposit
   ,cnt_all_resumed
   ,cnt_all_cancelled
  FROM p_lew_mart_msi.v_ejr_checker_scenario_cum_2
;