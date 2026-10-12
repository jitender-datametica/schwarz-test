CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTBEW_STUECKLISTE_ZU_2 (
ART_ID INTEGER NOT NULL OPTIONS(description='ID der Artikelnummer per Stueckliste_2 mit Referenz zur Tabelle art_2'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Nummer des Marktes'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT DATE NOT NULL OPTIONS(description='Datum des Abverkaufs, Format YYYY-MM_2-DD'),
KOMPONENTE_ART_ID INTEGER NOT NULL
OPTIONS(description='Artikelnummer der Stuecklistenkomponente mit referenz zur Tabelle art_2'),
STUECKLISTE_ID INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Stueckliste_2'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
UMSATZ_NETTO NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag. Anteil aus Abverkauf auf Basis EKN1'),
UMSATZ_MWST_BETRAG NUMERIC(18,4) NOT NULL
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_2 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
MENGE NUMERIC(18,3) NOT NULL
OPTIONS(description='berechneter Wert aus Menge Abverkauf * Menge Komponente * Umrechnungsfaktor'),
EK_BRUTTO NUMERIC(18,4) OPTIONS(description='Einkaufspreis brutto (bedeutung vgl. Kalkulationsschema).'),
EK_NETTO NUMERIC(18,4) OPTIONS(description='Einkaufspreis netto (bedeutung vgl. Kalkulationsschema).'),
EK_NETTONETTO NUMERIC(18,4) OPTIONS(description='Einkaufspreis nettonetto ((Bedeutung vgl. Kalkulationsschema).'),
EK_KAL_BASIS NUMERIC(18,4) OPTIONS(description='Kalkulationsbasis ((Bedeutung vgl. Kalkulationsschema).'),
EK_MEP NUMERIC(18,4) OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema).'),
EINSTANDSPREIS NUMERIC(18,4) OPTIONS(description='Kaufland Einstandspreis ((Bedeutung vgl. Kalkulationsschema).'),
LOGKOSTENZUSCHLAG NUMERIC(18,4)
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)'),
EK_NETTO_BNK NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'),
EK_NETTO_BNK_SACHK NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten(Bedeutung vgl. Kalkulationsschema).'),
BQ_FINDUNG_ID INTEGER NOT NULL OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess.'),
UMRECHNUNGSKURS NUMERIC(29,5) NOT NULL
OPTIONS(description='Umrechnungskurs zur Umrechnung Landeswährung in Euro. Wird aus der Tabelle kurs_2 angereichert'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
EK_MEP_VOR_FWU NUMERIC(29,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen\"alten\" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
BONUSBASIS NUMERIC(29,4)
OPTIONS(description='Die Bonusbasis bildet für Artikel_2 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA'),
UMRECHNUNGSKURS_HIST NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '),
UMRECH_FAKTOR BIGNUMERIC(29,22) DEFAULT 1 NOT NULL
OPTIONS(description='Umrechnungsfaktor für die Komponenten in einem VK_2-Set.'),
MENGE_KOMPONENTE_IN_VK_SET NUMERIC(18,5)
OPTIONS(description='Gewichstwert in der Mengeneinheit der Komponente in der Stückliste bzw. Verkaufsset (VK_2-Set) anteilig ihrer Menge.'),
PRIMARY KEY (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT, KOMPONENTE_ART_ID) NOT ENFORCED
)
OPTIONS(description='AIS KMO - Hier werden die Stuecklistenartikel aus artbew_2 in ihre Positionen aufgeloest, um diese detailliert auswerten zu koennen.');