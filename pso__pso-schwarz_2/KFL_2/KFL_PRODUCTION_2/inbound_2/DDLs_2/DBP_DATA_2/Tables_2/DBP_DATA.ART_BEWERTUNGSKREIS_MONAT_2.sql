--==============================================================
-- Table: art_bewertungskreis_monat_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_bewertungskreis_monat_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BEWERTUNGSKREIS_MONAT_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   bewertungskreis_id                  VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt  ',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   gjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Geschäftsjahresmonat',
   preis_steuer_kz                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Preissteuerkennzeichen.S= S- Preis, V=GLD',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   gld                                 NUMBER(18,6)     NOT NULL COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände',
   standard_preis                      NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S)',
   menge_bestand_bme                   NUMBER(18,3)     NOT NULL COMMENT 'Gesamtbestand in Basismengeneinheiten',
   wert_bestand                        NUMBER(18,4)     NOT NULL COMMENT 'Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden',
   vk_wert                             NUMBER(18,2)     NOT NULL COMMENT 'Zum Verkaufspreis bewerteter Bestand',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BEWERTUNGSKREIS_MONAT PRIMARY KEY (mandant_id, bewertungskreis_id, art_id, gjmo) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Diese Tabelle enthält historisierte und korrigierte Daten auf monatlicher Ebene aus der SAP Tabelle mbew - MULTISET';

