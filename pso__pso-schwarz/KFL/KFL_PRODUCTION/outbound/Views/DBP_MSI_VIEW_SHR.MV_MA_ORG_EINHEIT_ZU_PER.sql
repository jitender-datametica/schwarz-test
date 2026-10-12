CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_org_einheit_zu_per (mandant_id, hr_objekt_id,
mitarbeiter_id, kjmo) AS SELECT V01.mandant_id,
 V01.hr_objekt_id,
 V01.mitarbeiter_id,
 V01.kjmo
FROM kfl_production_dbp_view.v_mitarbeiterbew AS V01
 INNER JOIN kfl_production_dbp_view.v_monat AS V02 ON V01.kjmo = V02.kjmo;