CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_wup_abt_per_1 (gjmo, wup_id, mandant_id, nb_id, abt_id,
umsatz_netto_plan, umsatz_netto_plan_wrg, umsatz_netto_plan_konz) AS SELECT gjmo,
 wup_id,
 mandant_id,
 nb_id,
 abt_id,
 umsatz_netto_plan,
 umsatz_netto_plan_wrg,
 umsatz_netto_plan_konz
FROM kfl_production_dbp_view.v_wup_abt_per_1 AS V01
WHERE arthiertyp_id = 2;