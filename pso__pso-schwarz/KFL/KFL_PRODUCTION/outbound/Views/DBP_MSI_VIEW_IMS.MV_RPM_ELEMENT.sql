CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_rpm_element AS SELECT COALESCE(v01.rpm_hierarchie_id, '-1') AS
 rpm_hierarchie_id,
 v01.dat_von,
 INPR.projekt_ext_id,
 INPR.in_projekt_id,
 INPR.mandant_id,
 v01.dat_bis,
 v01.rpm_status_id,
 v01.dat_start_prognose,
 v01.dat_start_plan,
 v01.dat_start,
 v01.dat_ende_prognose,
 v01.dat_ende_plan,
 v01.dat_ende,
 v01.land_id,
 COALESCE(v01.rpm_phase_id, '1') AS rpm_phase_id,
 COALESCE(v01.rpm_projekt_typ_id, 'ZPPM_SONSTIGES') AS rpm_projekt_typ_id
FROM kfl_production_dbp_view.v_in_projekt AS INPR
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_rpm_element_per AS T
  WHERE dat_bis = DATE '9999-12-31'
   AND rpm_status_id <> - 1) AS v01 ON INPR.projekt_ext_id = v01.projekt_id;