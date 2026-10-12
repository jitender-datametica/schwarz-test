create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.MV_IMS_STANDORT_DAT_GR_KAUF_ZU_2(
	STANDORT_ID,
	MANDANT_ID,
	DAT_,
	DAT_GR_KAUF
) as
   SELECT
     v01.standort_id,
     v01. mandant_id,
     MIN(CASE 
           WHEN v04.berichts_position_invest_id = 90 
                THEN v04.dat_buch
           ELSE to_date('9999-12-31','YYYY-MM_2-DD')
         END) AS dat_,
     CASE 
          WHEN dat_ = '9999-12-31'
             THEN to_date('1900-01-01','YYYY-MM_2-DD')
          ELSE dat_
     END AS dat_gr_kauf
   FROM  dbp_view.v_ims_standort_2 v01
   LEFT OUTER JOIN  dbp_view.v_in_projekt_2 v02 
   ON v01.standort_id = v02.standort_id 
   AND v01.mandant_id = v02.mandant_id
   LEFT OUTER JOIN  dbp_view.v_in_psp_element_2 v03 
   ON v02.in_projekt_id = v03.in_projekt_id 
   AND v02.mandant_id = v03.mandant_id 
   
   AND  v03.statistisch_fg  = 1
   LEFT OUTER JOIN  dbp_view.v_ist_kosten_det_2 v04  
   ON v03.psp_id = v04.psp_id 
   AND v03.mandant_id = v04.mandant_id 
   
   AND  v04.psp_id <> -1  
   
   AND NOT upper(collate(v04.kostenart_id,''))  LIKE ANY ('I%', 'S%')   
   
   AND TRIM(collate(v04.kostenart_id,''), '0')  NOT IN  ('912000', '979002', 'H912000', 'H979002')
   GROUP BY
   v01.standort_id
   ,v01. mandant_id;