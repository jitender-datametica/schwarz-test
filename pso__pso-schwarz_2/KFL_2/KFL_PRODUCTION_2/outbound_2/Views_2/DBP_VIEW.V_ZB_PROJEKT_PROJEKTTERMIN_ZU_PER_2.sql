CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_projekttermin_zu_per_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
projekttermin_cd OPTIONS(description='Code des Projekttermins.'), dat_von
OPTIONS(description='Beginn der Gültigkeit, Teil der DWH-Historisierung.'), dat_bis
OPTIONS(description='Ende der Gültigkeit, Teil der DWH-Historisierung.'), dat_termin_ist
OPTIONS(description='Ist-Datum des Termins.'), dat_termin_prognose
OPTIONS(description='Prognostiziertes Datum des Termins.'))
OPTIONS(DESCRIPTION = `Zuordnungstabelle zwischen einem  Projekt aus den Zentralbereichen und allen darin vorhandenen Termine.`)
AS SELECT mandant_id,
 projekt_nr,
 projekttermin_cd,
 dat_von,
 dat_bis,
 dat_termin_ist,
 dat_termin_prognose
FROM kfl_production_dbp_data.zb_projekt_projekttermin_zu_per_2;