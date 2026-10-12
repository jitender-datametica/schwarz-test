CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_hr_mitarbeiter_1 (mandant_id, mitarbeiter_id, dat_geburtstag,
land_id, dat_uebernahme_azubi) AS SELECT mandant_id,
 mitarbeiter_id,
 dat_geburtstag,
 land_id,
 dat_uebernahme_azubi
FROM kfl_production_dbp_view.v_hr_mitarbeiter_1 AS V01;