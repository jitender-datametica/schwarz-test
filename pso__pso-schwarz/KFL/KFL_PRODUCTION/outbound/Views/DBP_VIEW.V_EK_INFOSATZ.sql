CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ek_infosatz (mandant_id OPTIONS(description='Mandant im DWH'),
ek_infosatz_id OPTIONS(description='Nummer des Infosatzes. Zusammen mit mandant_id eindeutiger Schluessel'), art_id
OPTIONS(description=' Artikel - Id'), gp_id OPTIONS(description='Geschaeftspartner - ID (Lieferanten - ID)'),
crossdocking_id OPTIONS(description='ID des Umschlagplatzs bzw. Cross Docking Orts.'), einkaufsorganisation_id
OPTIONS(description='Fuer verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
dat_erstellung
OPTIONS(description='Erstelldatum Infosatz. Bei mehreren Treffern gilt der Satz mit dem aktuellsten Datum'), gp_art_id
OPTIONS(description='Lieferanten-Artikelnummer'), dat_von OPTIONS(description='Lieferbar / gueltig-ab'), dat_bis
OPTIONS(description='Lieferbar / gueltig-bis'), regel_gp_fg OPTIONS(description='Flag für Regellieferanten'), loesch_fg
OPTIONS(description='Flag geloescht'), gp_teilsortiment_id OPTIONS(description='Teilsortiment aus SAP ltsnr'),
konditionsgruppe_id OPTIONS(description='Eindeutiger Schluessel der Konditionsgruppen beim Lieferanten.'), menge_einh_id
OPTIONS(description='Bestellmengeneinheit - nur gefüllt für DE (EINA PR1), leer für KMO'), apollo_ian
OPTIONS(description='EN long: Apollo Suppl - IANEN short: APO. S-IAN DE long: Apollo Lft - IANDE short: APO. L-IANTA Dynpro DE:Apollo Lft-IANTA Dynpro EN:Apollo Supp-IAN'))
OPTIONS(DESCRIPTION = `AIS_KMO- ARTIKEL-LIEFERANTENZUORDNUNG AUS DER SAP-TABELLE EINA. WIRD IM DWH VORLAEUFIG NUR FÜR KMO GENUTZT`)
AS SELECT mandant_id,
 ek_infosatz_id,
 art_id,
 gp_id,
 crossdocking_id,
 einkaufsorganisation_id,
 dat_erstellung,
 gp_art_id,
 dat_von,
 dat_bis,
 regel_gp_fg,
 loesch_fg,
 gp_teilsortiment_id,
 konditionsgruppe_id,
 menge_einh_id,
 apollo_ian
FROM kfl_production_dbp_data.ek_infosatz;