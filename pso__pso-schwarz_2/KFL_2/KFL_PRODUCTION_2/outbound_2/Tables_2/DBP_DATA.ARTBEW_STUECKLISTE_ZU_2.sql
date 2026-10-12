--==============================================================
-- Table: artbew_stueckliste_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_stueckliste_zu_2
   generated from Powerdesigner on Freitag, 21. März 2025 12:38:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_stueckliste_zu_2 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Artikelnummer per Stueckliste_2 mit Referenz zur Tabelle art_2'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Marktes'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='Datum des Abverkaufs, Format YYYY-MM_2-DD'),
komponente_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikelnummer der Stuecklistenkomponente mit referenz zur Tabelle art_2'),
stueckliste_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID der Stueckliste_2'),
umrech_faktor BIGNUMERIC(38,22) DEFAULT 1 NOT NULL
OPTIONS(description='Umrechnungsfaktor für die Komponenten in einem VK_2-Set.'),
menge_komponente_in_vk_set NUMERIC(18,5) DEFAULT NULL
OPTIONS(description='Gewichstwert in der Mengeneinheit der Komponente in der Stückliste bzw. Verkaufsset (VK_2-Set) anteilig ihrer Menge.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
umsatz_netto NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag. Anteil aus Abverkauf auf Basis EKN1'),
umsatz_mwst_betrag NUMERIC(18,4) NOT NULL
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_2 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
menge NUMERIC(18,3) NOT NULL
OPTIONS(description='berechneter Wert aus Menge Abverkauf * Menge Komponente * Umrechnungsfaktor'),
ek_brutto NUMERIC(18,4) OPTIONS(description='Einkaufspreis brutto (bedeutung vgl. Kalkulationsschema).'),
ek_netto NUMERIC(18,4) OPTIONS(description='Einkaufspreis netto (bedeutung vgl. Kalkulationsschema).'),
ek_nettonetto NUMERIC(18,4) OPTIONS(description='Einkaufspreis nettonetto ((Bedeutung vgl. Kalkulationsschema).'),
ek_kal_basis NUMERIC(18,4) OPTIONS(description='Kalkulationsbasis ((Bedeutung vgl. Kalkulationsschema).'),
ek_mep NUMERIC(18,4) OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema).'),
ek_mep_vor_fwu BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
einstandspreis NUMERIC(18,4) OPTIONS(description='Kaufland Einstandspreis ((Bedeutung vgl. Kalkulationsschema).'),
logkostenzuschlag NUMERIC(18,4)
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)'),
ek_netto_bnk NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'),
ek_netto_bnk_sachk NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten(Bedeutung vgl. Kalkulationsschema).'),
bq_findung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess.'),
umrechnungskurs BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Umrechnungskurs zur Umrechnung Landeswährung in Euro. Wird aus der Tabelle kurs_2 angereichert'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '),
bonusbasis BIGNUMERIC(38,4)
OPTIONS(description='Die Bonusbasis bildet für Artikel_2 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat, komponente_art_id) NOT ENFORCED
)
OPTIONS(description='AIS KMO - Hier werden die Stuecklistenartikel aus artbew_2 in ihre Positionen aufgeloest, um diese detailliert auswerten zu koennen.');