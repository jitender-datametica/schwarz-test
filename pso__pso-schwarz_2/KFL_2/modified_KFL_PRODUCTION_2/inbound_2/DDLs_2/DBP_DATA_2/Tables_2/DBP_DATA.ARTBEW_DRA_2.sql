--==============================================================
-- Table: artbew_dra_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_dra_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_DRA_2 (
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   bewart_id                           INTEGER     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   dat                                 DATE             NOT NULL COMMENT 'Tagesdatum in der Form JJJJ-MM_2-TT',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Eindeutige Kennung einer Aktion. Kommt aus der Kassenschnittstelle',
   promo_fg                            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Das Promotion-Flag kennzeichnet einen Promotion-Artikel_2 (z.Bsp. 3 für 2)',
   ean_kasse                           NUMBER(29,0)     NOT NULL COMMENT 'von den Kassensystemen gelieferte EAN_2',
   menge                               NUMBER(29,3)     NOT NULL COMMENT 'Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)',
   wrg_2                                 VARCHAR(3)       NOT NULL COMMENT 'Währung, in der der Umsatz erzielt wurde',
   umsatz_netto                        NUMBER(29,4)     NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
   umsatz_mwst_betrag                  NUMBER(29,4)     NOT NULL COMMENT 'Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_2 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_DRA PRIMARY KEY (wup_id, mandant_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id, promo_fg, ean_kasse) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Hier sind die Umsätze von ca. 10 Märkten zu "Deutschland rundet auf" hinterlegt';

