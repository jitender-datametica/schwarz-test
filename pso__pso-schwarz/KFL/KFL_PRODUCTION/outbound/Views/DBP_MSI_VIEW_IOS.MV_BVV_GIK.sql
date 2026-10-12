CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_gik AS SELECT DISTINCT IIPD.mandant_id,
 RPM.rpm_hierarchie_id,
 RPM.testmarkt_fg,
 CPRO.projekt_id,
 IPRO.projekt_ext_id AS projekt_nr,
 IIPD.psp_id,
 V02.psp_id_char,
 V02.psp_end_nr,
  CASE
  WHEN V02.psp_end_nr IN (3, 4, 5, 6, 7)
  THEN 1
  WHEN V02.psp_end_nr = 2 OR V02.psp_end_nr = 1 AND (best.in_wg_id IS NULL OR best.in_wg_id = '-1')
  THEN 0
  ELSE 1
  END AS ausblend,
 ROUND(IIPD.plan_betrag * ROUND(CAST(KURS0.faktor AS NUMERIC), 4), 4) AS gesamt_investitions_kosten,
 V99.wrg_id,
 V99.wrg_typ_id,
 KURS0.faktor,
 KURS0.kurs
FROM kfl_production_dbp_view.v_ims_invest_plan_det AS IIPD
 INNER JOIN kfl_production_dbp_view.v_in_psp_element AS V02 ON IIPD.mandant_id = V02.mandant_id AND IIPD.psp_id = V02.psp_id
   
 INNER JOIN kfl_production_dbp_view.v_in_projekt AS IPRO ON V02.mandant_id = IPRO.mandant_id AND V02.in_projekt_id =
    IPRO.in_projekt_id AND IPRO.ims_projekt_typ_id IN ('E', 'G', 'B')
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per AS CPRO ON IPRO.projekt_ext_id = CPRO.cpr_ext_id AND CPRO.dat_bis
   = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_rpm_element_per AS RPM ON CPRO.cpr_ext_id = RPM.projekt_id AND RPM.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN (SELECT IBBK.mandant_id,
   IBBK.psp_id,
   IBBD.in_wg_id
  FROM kfl_production_dbp_view.v_in_besch_best_kontierung AS IBBK
   INNER JOIN kfl_production_dbp_view.v_in_besch_best_det AS IBBD ON IBBK.best_beleg_id = IBBD.best_beleg_id AND IBBK.best_beleg_pos_id
         = IBBD.best_beleg_pos_id AND IBBK.mandant_id = IBBD.mandant_id AND IBBD.loesch_id = '' AND IBBK.psp_id > 0
  GROUP BY IBBK.mandant_id,
   IBBK.psp_id,
   IBBD.in_wg_id) AS best ON IIPD.mandant_id = best.mandant_id AND IIPD.psp_id = best.psp_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V99 ON IIPD.mandant_id = V99.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_user_kurs AS KURS0 ON V99.mandant_id = KURS0.mandant_id AND V99.wrg_typ_id
     = KURS0.wrg_typ_id AND V99.wrg_id = KURS0.wrg_id;