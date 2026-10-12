CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_shr_ncs_empfaenger_1 (mandant_id,
hr_objekt_ebene1_id, email, vorname, nachname, geschlecht_id, kjmo) AS SELECT V01.mandant_id,
 V01.hr_objekt_ebene1_id,
 V01.email,
 V01.vorname,
 V01.nachname,
 V01.geschlecht_id,
 V01.kjmo
FROM kfl_production_dbp_security.shr_ncs_empfaenger_1 AS V01
 INNER JOIN kfl_production_dbp_msi_view_shr_materialized.mv_abrechnungsmonat_1 AS V02 ON V01.kjmo = V02.kjmo_abr AND V01.mandant_id
    = V02.mandant_id;