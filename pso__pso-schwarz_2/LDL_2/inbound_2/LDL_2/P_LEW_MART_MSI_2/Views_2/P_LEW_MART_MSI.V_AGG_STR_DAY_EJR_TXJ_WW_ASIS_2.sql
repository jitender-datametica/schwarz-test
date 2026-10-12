CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STR_DAY_EJR_TXJ_WW_ASIS_2 as
        /* 
        #DescStart# 
        #$Revision: 6244 $, $LastChangedBy: hwieber $ 
        #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi) 
        #DescEnd# 
        */
       SELECT
        client_id,
       dat_formdate,
       cy_month,
       src_orig_store_nr          AS orig_store_nr,
       loc_sid_store              AS store_id,
       val_retail_asis,
       val_retail_net_asis,
       cnt_customer_asis,
       val_retail_wawi_asis,
       val_retail_net_wawi_asis,
       val_retail_txj_asis,
       val_retail_net_txj_asis,
       val_retail_txj_str,
       val_retail_net_txj_str,
       val_retail_ejr_asis,
       val_retail_net_ejr_asis,
       cnt_customer_wawi_asis,
       cnt_customer_txj_asis,
       cnt_customer_ejr_he_asis,
       currency_iso_cd

       FROM p_lew_bil_ac.v_agg_str_day_ejr_txj_ww_asis_2;