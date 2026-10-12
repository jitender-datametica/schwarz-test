CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_dt.mv_ims_standort_dat_gr_kauf_zu_1 (standort_id, mandant_id, dat_
, dat_gr_kauf) AS SELECT V01.standort_id,
 V01.mandant_id,
 MIN(CASE
   WHEN V04.berichts_position_invest_id = 90
   THEN V04.dat_buch
   ELSE PARSE_DATE('%F', '9999-12-31')
   END) AS dat_,
  CASE
  WHEN MIN(CASE
     WHEN V04.berichts_position_invest_id = 90
     THEN V04.dat_buch
     ELSE PARSE_DATE('%F', '9999-12-31')
     END) = DATE '9999-12-31'
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE MIN(CASE
    WHEN V04.berichts_position_invest_id = 90
    THEN V04.dat_buch
    ELSE PARSE_DATE('%F', '9999-12-31')
    END)
  END AS dat_gr_kauf
FROM kfl_production_dbp_view.v_ims_standort_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_in_projekt_1 AS V02 ON V01.standort_id = V02.standort_id AND V01.mandant_id = V02.mandant_id
   
 LEFT JOIN kfl_production_dbp_view.v_in_psp_element_1 AS V03 ON V02.in_projekt_id = V03.in_projekt_id AND V02.mandant_id =
    V03.mandant_id AND V03.statistisch_fg = 1
 LEFT JOIN kfl_production_dbp_view.v_ist_kosten_det_1 AS V04 ON V03.psp_id = V04.psp_id AND V03.mandant_id = V04.mandant_id
        AND V04.psp_id <> - 1 AND UPPER(COLLATE(V04.kostenart_id, '')) NOT LIKE 'I%' AND UPPER(COLLATE(V04.kostenart_id
      , '')) NOT LIKE 'S%' AND TRIM(COLLATE(V04.kostenart_id, ''), '0') NOT IN ('912000', '979002', 'H912000', 'H979002'
    )
GROUP BY V01.standort_id,
 V01.mandant_id;