CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_projektphase_zu_per_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
projektphase_id OPTIONS(description='ID der Projektphase'), dat_von
OPTIONS(description='Beginn der Gültigkeit, Teil der DWH-Historisierung.'), dat_bis
OPTIONS(description='Ende der Gültigkeit, Teil der DWH-Historisierung.'), projektphase_status_id
OPTIONS(description='ID des Status_1 der Projektphase.'), projektphase_aktiv_fg
OPTIONS(description='Kennzeichen, ob die Phase aktuell aktiv im Projekt ist (1) oder nicht (2).'))
OPTIONS(DESCRIPTION = `Zuordnungstabelle zwischen einem Projekt aus den Zentralbereichen und den möglichen Projektphasen`)
AS SELECT mandant_id,
 projekt_nr,
 projektphase_id,
 dat_von,
 dat_bis,
 projektphase_status_id,
 projektphase_aktiv_fg
FROM kfl_production_dbp_data.zb_projekt_projektphase_zu_per_1;