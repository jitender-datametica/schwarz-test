CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_bestwertfortschreibung AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 owg_id,
 arthiertyp_id,
 wrg_id,
 umsatz_plan_brutto_owg,
 wareneingang_brutto_owg,
 schlussbestand_vormonat_brutto_owg,
 datzeit_pflege
FROM kfl_production_dbp_msi_data.ts_bestwertfortschreibung;