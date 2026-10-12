CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_budget (mandant_id OPTIONS(description='Mandant im DWH'),
projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '), gewerk_id
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), budget_typ_cd
OPTIONS(description='Code des Budget Typs. (A1 = Budget bei Freigabe, A2 = Aktuelles Budget)'), budget_version_name
OPTIONS(description='Name der aktuellen Version des Budgets.'), dat_budget
OPTIONS(description='Datum an dem das Budget geplant wurde.'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_budget
OPTIONS(description='Wert des Budgets für den einzelnen Budgettyp pro Gewerk.'))
OPTIONS(DESCRIPTION = `Enthält die geplanten Budgets für die einzelnen Gewerke eines Projektes aus den Zentralbereichen`)
AS SELECT mandant_id,
 projekt_nr,
 gewerk_id,
 budget_typ_cd,
 budget_version_name,
 dat_budget,
 wrg_id,
 betrag_budget
FROM kfl_production_dbp_data.zb_projekt_budget;