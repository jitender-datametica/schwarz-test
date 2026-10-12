/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi.v_bo_abs_sig_day
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  18.12.2017    Arnold,Arne              Referenz für Beschreibungen auf V_BO_ABS_DESCS umgestellt und CROSS JOIN korrigiert.
#  1.3  18.12.2017    Arnold,Arne              Bestimmung der Landeswährung auf f_lew_mart_msi.v_report_fixed_exchange_rate umgestellt.
#  1.4  21.12.2017    Arnold,Arne              Anpassung der Kennzahlenformate
#  1.5  17.01.2018    Wieber,Harald            Release 2.2
#  1.6  13.06.2018    Arnold,Arne              Konsolidierung
#  1.7  28.06.2018    Arnold,Arne              Filter CURRENT_YEAR_DATA_FG
#  1.8  02.07.2018    Arnold,Arne              DDL Kommentierung aufgenommen
#  1.9  04.07.2018    Arnold,Arne              Filter CURRENT_YEAR_DATA_FG fuer HotFix ausgebaut
#  1.10 16.11.2018    Michael Strauch          20181113_1882_Differ_writeoff_reasons_FBO_Rep1 - extended by some columns to differenziate the values by pcwo_resons
#  1.11 11.01.2021    Stephane Tonga           20201007_2609_WG_id_ext_Frischfisch - Extending the view with new WG-ids
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_bo_abs_sig_day (client_id, country_desc, country_id, country_iso_cd,
store_id, orig_store_nr, store_desc, city, wh_id, wh_desc, sales_manager_id, sales_manager_name, account_manager_id,
account_manager_name, subitemgroup_id, dat_formdate, week_page_by, currency_iso_cd, val_rtl_rl_sfo_store_asis,
val_rtl_rl_net_sfo_store_asis, val_rtl_net_sfo_mhd_break, val_rtl_net_sfo_other_stc_loss, val_rtl_net_sfo_str_deliv_qlty
, val_wrtoff_zero_asis, val_wrtoff_zero_net_asis, val_discount_sfo_asis, val_discount_net_sfo_asis, val_rtl_ejr_adj_asis
, val_rtl_net_ejr_adj_asis, sfo_to_val_retail_pct, sfo_to_val_retail_net_pct)
OPTIONS(DESCRIPTION = `EXTRACTS ABSCHRIFTEN FOR SUBITEMGROUPS PER DAY.`) AS SELECT client_id,
 country_desc,
 country_id,
 country_iso_cd,
 store_id,
 orig_store_nr,
 store_desc,
 city,
 wh_id,
 wh_desc,
 sales_manager_id,
 sales_manager_name,
 account_manager_id,
 account_manager_name,
 subitemgroup_id,
 dat_formdate,
 cy_week AS week_page_by,
 currency_iso_cd,
 val_rtl_rl_sfo AS val_rtl_rl_sfo_store_asis,
 val_rtl_rl_net_sfo AS val_rtl_rl_net_sfo_store_asis,
 val_rtl_net_sfo_mhd_break,
 val_rtl_net_sfo_other_stc_loss,
 val_rtl_net_sfo_str_deliv_qlty,
 val_wrtoff_zero AS val_wrtoff_zero_asis,
 val_wrtoff_zero_net AS val_wrtoff_zero_net_asis,
 val_discount_ejr AS val_discount_sfo_asis,
 val_discount_net_ejr AS val_discount_net_sfo_asis,
 val_rtl_ejr_adj AS val_rtl_ejr_adj_asis,
 val_rtl_net_ejr_adj AS val_rtl_net_ejr_adj_asis,
 CAST(IFNULL(val_rtl_rl_sfo / IF(val_rtl_ejr_adj = 0, NULL, val_rtl_ejr_adj), 0) AS BIGNUMERIC) AS sfo_to_val_retail_pct
 ,
 CAST(IFNULL(val_rtl_rl_net_sfo / IF(val_rtl_net_ejr_adj = 0, NULL, val_rtl_net_ejr_adj), 0) AS BIGNUMERIC) AS
 sfo_to_val_retail_net_pct
FROM ldl_p_lew_mart_msi.t_bo_base_abs AS BASE
WHERE itemgroup_int_id IN (9, 90)
 AND cy_week_seq BETWEEN - 4 AND 0
 AND (val_rtl_rl_sfo IS NOT NULL OR val_rtl_rl_net_sfo IS NOT NULL OR val_wrtoff_zero IS NOT NULL OR val_wrtoff_zero_net
       IS NOT NULL OR val_discount_ejr IS NOT NULL OR val_discount_net_ejr IS NOT NULL OR val_rtl_ejr_adj IS NOT NULL OR
   val_rtl_net_ejr_adj IS NOT NULL);