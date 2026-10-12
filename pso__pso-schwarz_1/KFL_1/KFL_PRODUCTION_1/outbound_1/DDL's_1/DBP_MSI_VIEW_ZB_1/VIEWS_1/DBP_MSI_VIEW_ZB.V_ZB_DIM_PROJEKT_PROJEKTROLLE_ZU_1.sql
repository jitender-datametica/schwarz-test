CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_zb_dim_projekt_projektrolle_zu_1 (mandant_id
OPTIONS(description='MANDANT_1 IM DWH'), projekt_nr OPTIONS(description='EINDEUTIGE CODE DES PROJEKTES AUS EPPM. '),
projektrolle_cd OPTIONS(description='EINDEUTIGE ID DER PROJEKTROLLE.'), mitarbeiter_name
OPTIONS(description='NAME DES MITARBEITERS DER ZUM AKTUELLEN ZEITPUNKT DIE ROLLE INNERHALB DES PROJEKTES AUSÜBT.'))
OPTIONS(DESCRIPTION = `ZUORDNUNGSTABELLE ZWISCHEN EINEM  PROJEKT AUS DEN ZENTRALBEREICHEN UND ALLE DARIN AUSGEÜBTEN PROJEKTROLLEN.`)
AS SELECT mandant_id,
 projekt_nr,
 projektrolle_cd,
 mitarbeiter_name
FROM kfl_production_dbp_data.zb_projekt_projektrolle_zu_1;