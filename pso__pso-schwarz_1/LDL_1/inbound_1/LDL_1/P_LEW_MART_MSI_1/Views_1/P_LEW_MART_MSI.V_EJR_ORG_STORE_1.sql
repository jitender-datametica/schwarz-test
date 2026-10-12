CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_ORG_STORE_1 as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi) 	
   #DescEnd# 	
   */	
   SELECT	
   sto.client_id,	
   sto.store_id,	
   sto.country_cd,	
   sto.dat_opening,	
   sto.dat_closing,	
   sto.dat_valid_from,	
   sto.region_cd,	
   sto.object_nr,	
   sto.licence_nr,	
   sto.closed_fg,	
   sto.test_store_fg,	
   sto.transfer_fg,	
   sto.ord_unit_valid_store_cd,	
   sto.cnt_open_days,	
   sto.store_desc,	
   sto.orig_store_nr,	
   sto.dat_calc_end_py,	
   sto.dat_calc_start_ppy,	
   sto.dat_calc_start_py,	
   sto.dat_closing_ovis,	
   sto.dat_opening_ovis,	
   sto.objectstatus_id,	
   sto.dat_real_opening,	
   sto.qty_min_dflt,	
   sto.mde_lang_cd,	
   sto.mde_print_cd	
   FROM p_lew_mart_msi.v_org_store_1 sto	
   WHERE COALESCE(dat_closing, CURRENT_DATE) >= CURRENT_DATE;