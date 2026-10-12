CREATE OR REPLACE VIEW kfl_production_dbp_view.v_org_einheit_zu_per_2 AS SELECT hr_objekt_id_zu,
 richtung_kz,
 relat,
 kjmo,
 mandant_id,
 hr_objekt_id,
 dat_von,
 dat_bis,
 system_id
FROM kfl_production_dbp_data.org_einheit_zu_per_2;