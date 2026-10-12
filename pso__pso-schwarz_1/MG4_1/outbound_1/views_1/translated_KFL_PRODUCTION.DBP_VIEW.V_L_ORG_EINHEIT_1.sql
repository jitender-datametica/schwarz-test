CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_org_einheit_1 (mandant_id, hr_objekt_id, objekt_typ_id,
hr_objekt_bez_kurz, ki_fg, hr_objekt_bereich_id) AS SELECT mandant_id,
 hr_objekt_id,
 objekt_typ_id,
 hr_objekt_bez_kurz,
 ki_fg,
 hr_objekt_bereich_id
FROM kfl_production_dbp_data.l_org_einheit_1;