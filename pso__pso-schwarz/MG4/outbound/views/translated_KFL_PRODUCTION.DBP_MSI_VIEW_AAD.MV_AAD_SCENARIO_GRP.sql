-- 20.06.2023 snik: SPEC0200569 Lookup AAD Scenario-Gruppe, da es keine Lookuptabelle gibt, aus der Sprachtabelle ableiten

CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_aad_scenario_grp (scenario_grp_id) AS SELECT scenario_grp_id
FROM kfl_production_dbp_view.v_aad_scenario_grp_spr_zu AS v01
GROUP BY scenario_grp_id;