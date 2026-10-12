CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_CURRENCY_TOTAL_1 AS
   /*
   #DescStart#
   #$Revision: 6244 $, $LastChangedBy: hwieber $
   #SubjectAreas#: Währung
   #DescEnd#
   */
   SELECT
    CASE
     WHEN currency_iso_cd = 'EUR' THEN 0
     WHEN currency_iso_cd = 'GBP' THEN 40
     ELSE client_id
    END AS curr_tot_id
   ,currency_iso_cd
   ,currency_desc
   ,CASE
     WHEN currency_iso_cd = 'HRK' THEN -(curr_tot_id)
     ELSE curr_tot_id
    END AS currency_sort
   FROM p_lew_core_ac.v_wawi_ref_currency_act_1
   GROUP BY
    curr_tot_id
   ,currency_iso_cd
   ,currency_desc
   ,currency_sort
;
