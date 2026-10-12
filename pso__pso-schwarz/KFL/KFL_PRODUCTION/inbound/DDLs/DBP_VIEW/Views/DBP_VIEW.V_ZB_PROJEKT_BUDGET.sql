create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ZB_PROJEKT_BUDGET(
	MANDANT_ID COMMENT 'Mandant im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	BUDGET_TYP_CD COMMENT 'Code des Budget Typs. (A1 = Budget bei Freigabe, A2 = Aktuelles Budget)',
	BUDGET_VERSION_NAME COMMENT 'Name der aktuellen Version des Budgets.',
	DAT_BUDGET COMMENT 'Datum an dem das Budget geplant wurde.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_BUDGET COMMENT 'Wert des Budgets für den einzelnen Budgettyp pro Gewerk.'
) COMMENT='Enthält die geplanten Budgets für die einzelnen Gewerke eines Projektes aus den Zentralbereichen'
 as 
    SELECT 
        mandant_id,
        projekt_nr,
        gewerk_id,
        budget_typ_cd,
        budget_version_name,
        dat_budget,
        wrg_id,
        betrag_budget

FROM DBP_DATA.ZB_PROJEKT_BUDGET ;
