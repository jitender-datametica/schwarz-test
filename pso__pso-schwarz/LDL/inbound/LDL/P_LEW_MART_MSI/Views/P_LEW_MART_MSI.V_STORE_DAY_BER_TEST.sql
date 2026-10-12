CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_STORE_DAY_BER_TEST as
	
   SELECT	
        a11.client_id,	
   a11.store_id,	
   a11.currency_iso_cd,	
   a11.dat_formdate,	
   a11.val_retail_asis         AS val_retail_asis_ber,	
   a11.val_retail_net_asis     AS val_retail_net_asis_ber,	
   a11.cnt_customer_asis       AS cnt_customer_asis_ber	
	
  FROM p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis  a11	
	
   JOIN p_lew_mart_msi.v_org_store a12	
   ON (a11.client_id = a12.client_id	
   AND a11.store_id = a12.store_id)	
	
   JOIN p_lew_mart_msi.v_org_all_store_reloc  a13	
   ON (a11.client_id = a13.client_id	
   AND a11.store_id = a13.store_id)	
   WHERE	
   (	
      a11.dat_formdate BETWEEN a12.dat_calc_start_py AND a12.dat_calc_end_py	
      OR a11.dat_formdate >= a12.dat_calc_start_py AND a13.move_fg = 1	
      OR (a11.dat_formdate >= a12.dat_calc_start_py AND a12.dat_calc_end_py IS NULL)	
   );