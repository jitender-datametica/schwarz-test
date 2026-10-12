CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_l_pruefung_bereich_2 (amx_system_id
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
pruefung_bereich_id
OPTIONS(description='Zu berücksichtigende Bereiche / Code of area which should be considered / revisioned in a quick audit / "Kurzcheck". For other audit types these codes are not applicable.'),
pruefung_bereich_bez
OPTIONS(description='Zu berücksichtigende Bereiche / Name of area which should be considered / revisioned in a quick audit / "Kurzcheck". For other audit types these names are not applicable.'))
OPTIONS(DESCRIPTION = `KMR - LOOKUP TABLE FOR THE AREAS THAT HAVE TO BE COSIDERED FOR A "KURZCHECK". SOURCE VIEW: V_DWH_KL_DATA_GUIDELINE.`)
AS SELECT amx_system_id,
 pruefung_bereich_id,
 pruefung_bereich_bez
FROM kfl_production_dbp_data.kmr_l_pruefung_bereich_2;