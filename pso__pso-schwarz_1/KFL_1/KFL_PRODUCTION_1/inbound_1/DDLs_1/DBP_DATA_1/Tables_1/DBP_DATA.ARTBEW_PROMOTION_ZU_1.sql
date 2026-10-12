--==============================================================
-- Table: artbew_promotion_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_promotion_zu_1
   generated from Powerdesigner on Dienstag, 28. Januar 2025 16:46:54
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_PROMOTION_ZU_1 (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT ',
   bonuskauf_id                        VARCHAR(20)      NOT NULL COMMENT 'In SAP vergebene ID, leider nur wahrscheinlich numerisch',
   konditionsart_id                    VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschlüssel der Konditionsart.',
   ean_kasse                           NUMBER(26,0)     NOT NULL DEFAULT 0 COMMENT 'von den Kassensystemen gelieferte EAN_1',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   betrag_promo_netto                  NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Um die Mehrwertsteuer verminderter Promotionsbetrag',
   betrag_mwst                         NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mehrwertsteuerbetrag des Promotionsbetrags',
   umrechnungskurs                     NUMBER(38,5)     NOT NULL COMMENT 'Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs_1 angereichert',
   umrechnungskurs_hist                NUMBER(38,5)     NOT NULL DEFAULT 0 COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_1 ',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   menge_promo                         NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'abverkaufte Menge',
   umsatz_promo_netto                  NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Um die Mehrwertsteuer verminderter Promotionsumsatz',
   umsatz_mwst                         NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mehrwertsteuerbetrag des Promotionsumsatzes',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_PROMOTION_ZU PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat, bonuskauf_id, konditionsart_id, ean_kasse) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Hier werden Promotionen gespeichert - Zusatztabelle zu artbew_1';
