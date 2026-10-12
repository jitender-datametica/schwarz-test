CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_LIL_RPT_COMMENT as
   /* 	
   #DescStart# 	
   #$Revision: 6388 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#:	
   #DescEnd# 	
   */	
   SELECT	
   story_id,	
   doc_id,	
   version_id,	
   user_name,	
   client_id,	
   clnt_rtl_id,	
   rtl_brand_id,	
   per_tp_id,	
   per_id,	
   lift_cat_id,	
   liam_parnt_clnt_cat_id,	
   liam_clnt_cat_id,	
   prom_id,	
   meas_id,	
   currency_iso_cd,	
   comment_1,	
   comment_2,	
   comment_p,	
   show_report_fg,	
   cmt_unit_id,	
   mod_tmsp	
    FROM p_lew_mart_msi.t_msi_lil_rpt_comment	
;