--==============================================================
-- Table: art_bewertungskreis_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_bewertungskreis_per_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BEWERTUNGSKREIS_PER_2 CLUSTER BY (DAT_BIS) (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   bewertungskreis_id                  VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt. Aus bwkey
            
            ',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Satz Gültigkeit hat',
   preis_steuer_kz                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Preissteuerkennzeichen.S= S- Preis, V=GLD. Aus vprsv',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT
            ',
   dat_aenderung                       DATE             NOT NULL COMMENT 'Aenderungsdatum des Satzes im SAP Quellsystem.',
   zeit_aenderung                      NUMBER(38,0)     NOT NULL COMMENT 'Aenderungszeitpunkt des Satzes im Quellsystem.',
   gld                                 NUMBER(18,6)     NOT NULL COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Ist unabhängig vom preis_steuer_kz vorhanden. Aus verpr',
   standard_preis                      NUMBER(18,4)     NOT NULL COMMENT 'Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S). Aus stprs',
   menge_bestand_bme                   NUMBER(18,3)     NOT NULL COMMENT 'Gesamtbestand in Basismengeneinheiten aus dem Quellfeld lbkum',
   wert_bestand                        NUMBER(18,4)     NOT NULL COMMENT 'Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden. Aus salk3',
   vk_wert                             NUMBER(18,2)     NOT NULL COMMENT 'Zum Verkaufspreis bewerteter Bestand aus vksal',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BEWERTUNGSKREIS_PER PRIMARY KEY (mandant_id, bewertungskreis_id, art_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Diese Tabelle bildet den gleitenden Durchschnittspreis aus der SAP Tabelle MBEW ab - nur für Märkte - MULTISET';

