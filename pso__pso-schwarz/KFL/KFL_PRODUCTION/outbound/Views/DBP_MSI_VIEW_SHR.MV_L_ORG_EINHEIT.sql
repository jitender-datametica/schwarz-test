CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_org_einheit (mandant_id, hr_objekt_id, objekt_typ_id,
hr_objekt_bez_kurz) AS SELECT mandant_id,
 hr_objekt_id,
 objekt_typ_id,
 hr_objekt_bez_kurz
FROM kfl_production_dbp_view.v_l_org_einheit AS V01;