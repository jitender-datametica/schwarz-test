CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_stammdaten_ios_2 (projekt_id, ims_projekt_typ_id,
in_projekt_id_char, besitzverhaeltnis_id, rpm_projekt_typ_id, rpm_phase_id, rpm_hierarchie_id, rpm_status_id) AS SELECT
 V01.projekt_id,
 V04.ims_projekt_typ_id,
 V04.in_projekt_id_char,
 V02.besitzverhaeltnis_id,
 V02.rpm_projekt_typ_id,
 V02.rpm_phase_id,
 V02.rpm_hierarchie_id,
 V02.rpm_status_id
FROM kfl_production_dbp_view.v_cpr_projekt_bauabschnitt_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_rpm_element_per_2 AS V02 ON V01.projekt_id = V02.projekt_id
 INNER JOIN kfl_production_dbp_view.v_in_projekt_2 AS V04 ON V02.rpm_projekt_typ_id = V04.rpm_projekt_typ_id;