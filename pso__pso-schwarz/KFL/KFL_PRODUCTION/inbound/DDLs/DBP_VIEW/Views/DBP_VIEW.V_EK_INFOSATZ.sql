CREATE OR REPLACE VIEW DBP_VIEW.V_EK_INFOSATZ (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,ek_infosatz_id                           COMMENT 'Nummer des Infosatzes. Zusammen mit mandant_id eindeutiger Schluessel'
  ,art_id                                   COMMENT ' Artikel - Id'
  ,gp_id                                    COMMENT 'Geschaeftspartner - ID (Lieferanten - ID)'
  ,crossdocking_id                          COMMENT 'ID des Umschlagplatzs bzw. Cross Docking Orts.'
  ,einkaufsorganisation_id                  COMMENT 'Fuer verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'
  ,dat_erstellung                           COMMENT 'Erstelldatum Infosatz. Bei mehreren Treffern gilt der Satz mit dem aktuellsten Datum'
  ,gp_art_id                                COMMENT 'Lieferanten-Artikelnummer'
  ,dat_von                                  COMMENT 'Lieferbar / gueltig-ab'
  ,dat_bis                                  COMMENT 'Lieferbar / gueltig-bis'
  ,regel_gp_fg                              COMMENT 'Flag für Regellieferanten'
  ,loesch_fg                                COMMENT 'Flag geloescht'
  ,gp_teilsortiment_id                      COMMENT 'Teilsortiment aus SAP ltsnr'
  ,konditionsgruppe_id                      COMMENT 'Eindeutiger Schluessel der Konditionsgruppen beim Lieferanten.'
  ,menge_einh_id                            COMMENT 'Bestellmengeneinheit - nur gefüllt für DE (EINA PR1), leer für KMO'
  ,apollo_ian                               COMMENT 'EN long: Apollo Suppl - IANEN short: APO. S-IAN DE long: Apollo Lft - IANDE short: APO. L-IANTA Dynpro DE:Apollo Lft-IANTA Dynpro EN:Apollo Supp-IAN'
)
COMMENT = 'AIS_KMO- Artikel-Lieferantenzuordnung aus der SAP-Tabelle EINA. Wird im DWH vorlaeufig nur für KMO genutzt'
 AS 
    SELECT 
        mandant_id,
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

FROM DBP_DATA.EK_INFOSATZ ;