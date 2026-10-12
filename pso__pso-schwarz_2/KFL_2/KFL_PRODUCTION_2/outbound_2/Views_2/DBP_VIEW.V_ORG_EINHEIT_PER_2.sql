CREATE OR REPLACE VIEW kfl_production_dbp_view.v_org_einheit_per_2 AS SELECT mandant_id,
 hr_objekt_id,
 kjmo,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.org_einheit_per_2;