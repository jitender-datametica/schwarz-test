create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_AAD_SCENARIO_GRP_2(
	SCENARIO_GRP_ID
) as
--20.06.2023 snik: SPEC0200569 Lookup AAD Scenario-Gruppe_2, da es keine Lookuptabelle gibt, aus der Sprachtabelle ableiten
   SELECT
    v01.scenario_grp_id 
   FROM DBP_VIEW.V_AAD_SCENARIO_GRP_SPR_ZU_2 v01
   GROUP BY v01.scenario_grp_id ;