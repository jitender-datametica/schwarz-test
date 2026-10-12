create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ZB_PROJEKT_PROJEKTROLLE_ZU(
	MANDANT_ID COMMENT 'Mandant im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Nummer des Projektes aus ePPM. ',
	PROJEKTROLLE_CD COMMENT 'Eindeutiger Code der Projektrolle.',
	MITARBEITER_NAME COMMENT 'Name des Mitarbeiters der zum aktuellen Zeitpunkt die Rolle innerhalb des Projektes ausübt.'
) COMMENT='Zuordnungstabelle zwischen einem  Projekt aus den Zentralbereichen und alle darin ausgeübten Projektrollen.'
 as 
    SELECT 
        mandant_id,
        projekt_nr,
        projektrolle_cd,
        mitarbeiter_name

FROM DBP_DATA.ZB_PROJEKT_PROJEKTROLLE_ZU ;
