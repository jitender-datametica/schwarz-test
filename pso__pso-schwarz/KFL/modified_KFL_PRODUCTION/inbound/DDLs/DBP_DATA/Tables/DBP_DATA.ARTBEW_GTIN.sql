--==============================================================
-- Table: artbew_gtin
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_gtin
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_GTIN CLUSTER BY (
     MANDANT_ID,
     DAT 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Markt',
   dat                                 DATE             NOT NULL COMMENT 'Datum, Format YYYY-MM-DD',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   bewart_id                           INTEGER     NOT NULL COMMENT '1001 AF, 1002 SA',
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Aktionsnummer wie von den Kassen gemeldet (bei Kassensystem POSITION über Stammdaten angereichert)',
   promo_fg                            INTEGER     NOT NULL COMMENT 'Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2)',
   ean_kasse                           NUMBER(29,0)     NOT NULL COMMENT 'von den Kassensystemen gelieferte EAN',
   herst_id                            INTEGER     COMMENT 'Hersteller fall abweichend zum Lieferanten',
   mwst_id                             INTEGER     NOT NULL COMMENT 'Schlüssel des Mehrwertsteuersatzes',
   wrg                                 VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Währung, in der der Umsatz erzielt wurde',
   menge                               NUMBER(29,3)     COMMENT 'Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)',
   umsatz_netto                        NUMBER(29,4)     COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
   diff_umsatz_netto_konz              NUMBER(29,4)     COMMENT 'von der Konzernwährung abweichender Umsatz netto',
   umsatz_mwst_betrag                  NUMBER(29,4)     COMMENT 'Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.',
   diff_umsatz_mwst_betrag_konz        NUMBER(29,4)     COMMENT 'von der Konzernwährung abweichender Mehrwertsteuerbetrag',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_GTIN PRIMARY KEY (mandant_id, wup_id, dat, art_id, gp_id, bewart_id, aktion_id, promo_fg, ean_kasse) NOT ENFORCED
)  COMMENT = 'Aggregat aus Bons aller Länder (auch für POSITION statt WPUUMS). Benötigt für Marktforschungsinstitute, die Abverkäufe auf Ebene GTIN brauchen. Tabelle nicht mehr relevant wenn Umstellung auf KPOS ausgerollt.';

