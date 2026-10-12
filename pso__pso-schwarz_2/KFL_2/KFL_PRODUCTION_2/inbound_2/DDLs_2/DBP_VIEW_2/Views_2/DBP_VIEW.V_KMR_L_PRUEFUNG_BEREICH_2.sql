CREATE OR REPLACE VIEW DBP_VIEW.V_KMR_L_PRUEFUNG_BEREICH_2 (
   amx_system_id                            COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'
  ,pruefung_bereich_id                      COMMENT 'Zu berücksichtigende Bereiche / Code of area which should be considered / revisioned in a quick audit / "Kurzcheck". For other audit types these codes are not applicable.'
  ,pruefung_bereich_bez                     COMMENT 'Zu berücksichtigende Bereiche / Name of area which should be considered / revisioned in a quick audit / "Kurzcheck". For other audit types these names are not applicable.'
)
COMMENT = 'KMR - Lookup table for the areas that have to be cosidered for a "Kurzcheck". Source view: v_dwh_kl_data_guideline.'
 AS 
    SELECT 
        amx_system_id,
        pruefung_bereich_id,
        pruefung_bereich_bez

FROM DBP_DATA.KMR_L_PRUEFUNG_BEREICH_2 ;