CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hr_mitarbeiter AS SELECT mandant_id,
 mitarbeiter_id,
 dat_geburtstag,
 land_id,
 dat_uebernahme_azubi
FROM kfl_production_dbp_data.hr_mitarbeiter;