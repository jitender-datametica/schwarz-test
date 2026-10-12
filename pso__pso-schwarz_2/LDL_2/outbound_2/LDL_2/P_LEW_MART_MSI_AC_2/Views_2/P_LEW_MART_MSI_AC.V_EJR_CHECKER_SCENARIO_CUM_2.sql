/* ************************************************************************* */
/* #DescStart#
#$Revision: 12041 $, $LastChangedBy: dpurseth $
#SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_checker_scenario_cum_2 (client_id, st_loc_sid, checker_id, dat_formdate
, cy_week, cy_month, cnt_all_suspend, cnt_all_void, cnt_all_show_price, cnt_all_return, cnt_all_deposit, cnt_all_resumed
, cnt_all_cancelled) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_checker_scenario_cum_2;