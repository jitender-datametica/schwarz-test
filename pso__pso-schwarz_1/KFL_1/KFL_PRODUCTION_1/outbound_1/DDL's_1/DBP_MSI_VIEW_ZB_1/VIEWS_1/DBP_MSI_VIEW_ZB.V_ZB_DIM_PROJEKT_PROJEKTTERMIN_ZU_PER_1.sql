CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_zb_dim_projekt_projekttermin_zu_per_1 (mandant_id
OPTIONS(description='MANDANT_1 IM DWH'), projekt_nr OPTIONS(description='EINDEUTIGE CODE DES PROJEKTES AUS EPPM. '),
projekttermin_cd OPTIONS(description='CODE DES PROJEKTTERMINS.'), dat_von
OPTIONS(description='BEGINN DER GÜLTIGKEIT, TEIL DER DWH-HISTORISIERUNG.'), dat_bis
OPTIONS(description='ENDE DER GÜLTIGKEIT, TEIL DER DWH-HISTORISIERUNG.'), dat_termin_ist
OPTIONS(description='IST-DATUM DES TERMINS.'), dat_termin_prognose
OPTIONS(description='PROGNOSTIZIERTES DATUM DES TERMINS.'))
OPTIONS(DESCRIPTION = `ZUORDNUNGSTABELLE ZWISCHEN EINEM  PROJEKT AUS DEN ZENTRALBEREICHEN UND ALLEN DARIN VORHANDENEN TERMINE.`)
AS SELECT mandant_id,
 projekt_nr,
 projekttermin_cd,
 dat_von,
 dat_bis,
 dat_termin_ist,
 dat_termin_prognose
FROM kfl_production_dbp_data.zb_projekt_projekttermin_zu_per_1;