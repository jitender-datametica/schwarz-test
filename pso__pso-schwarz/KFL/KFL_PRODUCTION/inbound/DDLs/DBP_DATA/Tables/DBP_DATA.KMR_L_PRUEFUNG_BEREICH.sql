--==============================================================
-- Table: kmr_l_pruefung_bereich
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_pruefung_bereich
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:12:41
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_PRUEFUNG_BEREICH (
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
   pruefung_bereich_id                 NUMBER(38,0)     NOT NULL COMMENT 'Zu berücksichtigende Bereiche / Code of area which should be considered / revisioned in a quick audit / "Kurzcheck". For other audit types these codes are not applicable.',
   pruefung_bereich_bez                VARCHAR(255)     NOT NULL COMMENT 'Zu berücksichtigende Bereiche / Name of area which should be considered / revisioned in a quick audit / "Kurzcheck". For other audit types these names are not applicable.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_PRUEFUNG_BEREICH PRIMARY KEY (pruefung_bereich_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the areas that have to be cosidered for a "Kurzcheck". Source view: v_dwh_kl_data_guideline.';
