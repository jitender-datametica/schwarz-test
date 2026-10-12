--==============================================================
-- Table: art_gp_wup_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_wup_zu_per
   generated from Powerdesigner on Donnerstag, 26. Januar 2023 10:30:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_GP_WUP_ZU_PER CLUSTER BY (MANDANT_ID) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner-ID (Lieferanten-ID).',
   wup_id                              INTEGER     NOT NULL COMMENT 'Der WUP beinhaltet Märkte und Läger. WUP = WarenUmschlagsPlatz, Mutter Wup-ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode.',
   bezugsweg_id                        INTEGER     NOT NULL COMMENT 'Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1).',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   einkaufsorganisation_id             INTEGER     COMMENT 'Aus EKORG. Die einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP zusammen mit dem Attribut gp_id eindeutig zu identifizieren. 1000 = Warenlieferant, 5000 = Frischelieferant, 9000 = (?) könnte es auch geben.',
   dat_bis                             DATE             COMMENT 'Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen: 9999-12-31.',
   ek_brutto                           NUMBER(29,4)     COMMENT 'Einkaufspreis brutto (Bedeutung vgl. Kalkulationsschema) aus ABRUT. Tatsächlicher Einkaufspreis. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.',
   ek_netto                            NUMBER(29,4)     COMMENT 'Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema), aus AKNET.',
   ek_nettonetto                       NUMBER(29,4)     COMMENT 'Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema), aus AKNNE.',
   ek_kal_basis                        NUMBER(29,4)     COMMENT 'Kalkulationsbasis (Bedeutung vgl. Kalkulationsschema), aus EKKBA.',
   ek_mep                              NUMBER(29,4)     COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema), aus MEPRE.',
   ek_mep_vor_fwu                      NUMBER(29,4)     COMMENT 'Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.',
   einstandspreis                      NUMBER(29,4)     COMMENT 'Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema), aus LSEIN.
            Ergibt sich aus dem Einkaufspreis netto einer Ware zuzüglich der Beschaffungskosten oder Bezugskosten und abzüglich der Minderungen, etwa durch Rabatt, Skonto, Bonus.',
   logistikkostenzuschlag              NUMBER(29,4)     COMMENT 'Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist), aus LOKAU.',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   komponentenmenge                    NUMBER(29,4)     COMMENT 'Menge des Inhalts bei strukturierten Artikeln (Display) - aber nicht Pfandartikeln. Bei nicht strukturierten Artikeln ist der Wert = 1. Die EK-Preise werden mit diesem Wert multipliziert, um zu einem Gesamt-EK pro Artikel zu kommen. Aus KOMPMENG.',
   ek_brutto_nrfb_rab                  NUMBER(29,4)     COMMENT 'Einkaufspreis brutto abzgl. nicht-rabattfähiger Betrag abzgl. Artikelrabatte, aus ABRNA. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.',
   bonusbasis                          NUMBER(29,4)     COMMENT 'In SAP auch AK-Netto-NRFB genannt. Aus ABONBA. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.',
   bezugsnebenkosten                   NUMBER(29,4)     COMMENT 'Summe der Bezugsnebenkosten, aus BNK.',
   zollwert                            NUMBER(29,4)      COMMENT 'Zollwert, betrifft vor allem Importartikel. Aus ZOLLBA.',
   ek_netto_bnk                        NUMBER(29,4)     COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten, aus AKBN. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.',
   ek_netto_bnk_sachk                  NUMBER(29,4)     COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten, aus AKBNS. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.',
   cycle_id                            INTEGER     COMMENT 'Technisches Hilfsfeld. Zur Feststellung der Herkunft des Satzes (Loadfile, Datum).',
   ek_brutto_normal                    NUMBER(29,4)     COMMENT 'Einkaufspreis brutto ohne Aktionskonditionen (Bedeutung vgl. Kalkulationsschema). Aus EBRUT. Der Normalpreis / Listenpreis.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GP_WUP_ZU_PER PRIMARY KEY (mandant_id, gp_id, wup_id, dat_von, bezugsweg_id, art_id) NOT ENFORCED
)  COMMENT = 'TP2 AIS - Artikel Geschäftspartner Markt Zuordnung.';
