CREATE OR REPLACE VIEW kfl_production_dbp_view.v_markt_lagerbereich_spr_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), markt_lagerbereich_id
OPTIONS(description='ID des Lagerbereichs in der Filiale.'), spr_id
OPTIONS(description='ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'), markt_lagerbereich_bez
OPTIONS(description='Sprachabhängige Bezeichnung der Lagerbereichen in der Filiale.'))
OPTIONS(DESCRIPTION = `DIESE TABELLE ENTHÄLT DIE SPRACHABHÄNIGIGE BEZEICHNUNGEN DER LAGERBEREICHEN IN DER FILIALE. WIRD MANUELL BELADEN.`)
AS SELECT mandant_id,
 markt_lagerbereich_id,
 spr_id,
 markt_lagerbereich_bez
FROM kfl_production_dbp_data.markt_lagerbereich_spr_zu_2;