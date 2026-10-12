CREATE OR REPLACE VIEW kfl_production_dbp_view.v_it_projekt_plan_nutzen_2 AS SELECT it_projekt_id,
 plan_revision_id,
 gj,
 einm_nutzen_betrag,
 lfd_nutzen_betrag
FROM kfl_production_dbp_data.it_projekt_plan_nutzen_2;