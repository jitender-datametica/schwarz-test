CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ppm_projekt (projekt_nr, projekt_id, psp_projekt,
in_budget_typ_id, mandant_id) AS SELECT T1.projekt_id AS projekt_nr,
 V111.projekt_id,
 T2.in_projekt_id_char AS psp_projekt,
 T3.in_budget_typ_id,
 T1.mandant_id
FROM kfl_production_dbp_view.v_rpm_element_per AS T1
 INNER JOIN kfl_production_dbp_view.v_in_projekt AS T2 ON T1.mandant_id = T2.mandant_id AND T1.projekt_id = T2.projekt_ext_id
     AND T1.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_in_projekt AS T3 ON T1.mandant_id = T3.mandant_id AND T2.in_projekt_id = T3.in_projekt_id
   
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per AS V111 ON T1.projekt_id = V111.cpr_ext_id AND V111.dat_bis =
   DATE '9999-12-31'
GROUP BY projekt_nr,
 V111.projekt_id,
 psp_projekt,
 T3.in_budget_typ_id,
 T1.mandant_id;