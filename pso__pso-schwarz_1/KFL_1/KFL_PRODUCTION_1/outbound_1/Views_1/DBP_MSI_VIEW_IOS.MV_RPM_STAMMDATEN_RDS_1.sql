CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_stammdaten_rds_1 AS SELECT V01.projekt_id,
 V03.ims_projekt_typ_id,
 V03.in_projekt_id_char,
 V01.mandant_id,
 COALESCE(v05.besitzstatus_id, ' -1') AS besitzverhaeltnis_id,
 V02.rpm_projekt_typ_id,
 V02.rpm_phase_id,
 V02.rpm_hierarchie_id,
 V02.rpm_status_id,
 V02.objekt_planer_name,
 V02.wup_standort,
 COALESCE(W.aktuell_wup_id, V02.wup_id) AS wup_id,
 TRIM(PR.techn_platz_id) AS techn_platz_id
FROM kfl_production_dbp_view.v_cpr_projekt_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_rpm_element_per_1 AS V02 ON V01.cpr_ext_id = V02.projekt_id AND V01.dat_bis = V02.dat_bis
   
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W ON V02.wup_id = W.wup_id AND V02.mandant_id = W.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_in_projekt_1 AS V03 ON V01.cpr_ext_id = V03.projekt_ext_id AND V01.mandant_id = V03.mandant_id
   
 LEFT JOIN (SELECT DISTINCT mandant_id,
   wirtschaftseinheit_id,
   besitzstatus_id
  FROM kfl_production_dbp_view.v_immo_wirtschaftseinheit_1 AS WE
  WHERE CURRENT_DATE BETWEEN dat_we_gueltig_von AND dat_we_gueltig_bis
   AND (mandant_id, we_intreno) NOT IN (SELECT (mandant_id, we_intreno)
     FROM kfl_production_dbp_view.v_immo_wirtschaftseinheit_1
     WHERE STRPOS(wirtschaftseinheit_bez, 'paob') <> 0
      OR STRPOS(wirtschaftseinheit_bez, 'UMGL') <> 0)) AS v05 ON V01.mandant_id = v05.mandant_id AND V02.wup_id = CAST(v05.wirtschaftseinheit_id AS FLOAT64)
   
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_1 AS PR ON V01.projekt_id = PR.projekt_id AND V01.dat_bis = PR.dat_bis
   
WHERE V01.dat_bis = DATE '9999-12-31';