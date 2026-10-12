CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_abt_per AS SELECT gjmo,
 wup_id,
 mandant_id,
 nb_id,
 abt_id,
 arthiertyp_id,
 umsatz_netto_plan,
 umsatz_netto_plan_wrg,
 umsatz_netto_plan_konz,
 td_insert,
 td_update
FROM kfl_production_dbp_data.wup_abt_per;