--==============================================================
-- Table: artbew_stueckliste_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_stueckliste_zu_1
   generated from Powerdesigner on Freitag, 21. März 2025 12:38:25
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_STUECKLISTE_ZU_1 (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Artikelnummer per Stueckliste_1 mit Referenz zur Tabelle art_1',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Nummer des Marktes',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'Datum des Abverkaufs, Format YYYY-MM_1-DD',
   komponente_art_id                   NUMBER(38,0)     NOT NULL COMMENT 'Artikelnummer der Stuecklistenkomponente mit referenz zur Tabelle art_1',
   stueckliste_id                      NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID der Stueckliste_1',
   umrech_faktor                       NUMBER(38,22)    NOT NULL DEFAULT 1 COMMENT 'Umrechnungsfaktor für die Komponenten in einem VK_1-Set.',
   menge_komponente_in_vk_set          NUMBER(18,5)     DEFAULT NULL COMMENT 'Gewichstwert in der Mengeneinheit der Komponente in der Stückliste bzw. Verkaufsset (VK_1-Set) anteilig ihrer Menge.',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   umsatz_netto                        NUMBER(18,4)     NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag. Anteil aus Abverkauf auf Basis EKN1',
   umsatz_mwst_betrag                  NUMBER(18,4)     NOT NULL COMMENT 'Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_1 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.',
   menge                               NUMBER(18,3)     NOT NULL COMMENT 'berechneter Wert aus Menge Abverkauf * Menge Komponente * Umrechnungsfaktor',
   ek_brutto                           NUMBER(18,4)     COMMENT 'Einkaufspreis brutto (bedeutung vgl. Kalkulationsschema).',
   ek_netto                            NUMBER(18,4)     COMMENT 'Einkaufspreis netto (bedeutung vgl. Kalkulationsschema).',
   ek_nettonetto                       NUMBER(18,4)     COMMENT 'Einkaufspreis nettonetto ((Bedeutung vgl. Kalkulationsschema).',
   ek_kal_basis                        NUMBER(18,4)     COMMENT 'Kalkulationsbasis ((Bedeutung vgl. Kalkulationsschema).',
   ek_mep                              NUMBER(18,4)     COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema).',
   ek_mep_vor_fwu                      NUMBER(38,4)     COMMENT 'Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.',
   einstandspreis                      NUMBER(18,4)     COMMENT 'Kaufland Einstandspreis ((Bedeutung vgl. Kalkulationsschema).',
   logkostenzuschlag                   NUMBER(18,4)     COMMENT 'Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)',
   ek_netto_bnk                        NUMBER(18,4)     COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).',
   ek_netto_bnk_sachk                  NUMBER(18,4)     COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten(Bedeutung vgl. Kalkulationsschema).',
   bq_findung_id                       NUMBER(38,0)     NOT NULL COMMENT 'ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess.',
   umrechnungskurs                     NUMBER(38,5)     NOT NULL COMMENT 'Umrechnungskurs zur Umrechnung Landeswährung in Euro. Wird aus der Tabelle kurs_1 angereichert',
   umrechnungskurs_hist                NUMBER(38,5)     NOT NULL DEFAULT 0 COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_1 ',
   bonusbasis                          NUMBER(38,4)     COMMENT 'Die Bonusbasis bildet für Artikel_1 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_STUECKLISTE_ZU PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat, komponente_art_id) NOT ENFORCED
)  COMMENT = 'AIS KMO - Hier werden die Stuecklistenartikel aus artbew_1 in ihre Positionen aufgeloest, um diese detailliert auswerten zu koennen.';
