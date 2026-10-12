--==============================================================
-- Table: artbew_dra
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_dra
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_DRA (
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   bewart_id                           NUMBER(38,0)     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   dat                                 DATE             NOT NULL COMMENT 'Tagesdatum in der Form JJJJ-MM-TT',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Eindeutige Kennung einer Aktion. Kommt aus der Kassenschnittstelle',
   promo_fg                            NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2)',
   ean_kasse                           NUMBER(26,0)     NOT NULL COMMENT 'von den Kassensystemen gelieferte EAN',
   menge                               NUMBER(18,3)     NOT NULL COMMENT 'Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)',
   wrg                                 VARCHAR(3)       NOT NULL COMMENT 'Währung, in der der Umsatz erzielt wurde',
   umsatz_netto                        NUMBER(18,4)     NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
   umsatz_mwst_betrag                  NUMBER(18,4)     NOT NULL COMMENT 'Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_DRA PRIMARY KEY (wup_id, mandant_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id, promo_fg, ean_kasse) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Hier sind die Umsätze von ca. 10 Märkten zu "Deutschland rundet auf" hinterlegt';

