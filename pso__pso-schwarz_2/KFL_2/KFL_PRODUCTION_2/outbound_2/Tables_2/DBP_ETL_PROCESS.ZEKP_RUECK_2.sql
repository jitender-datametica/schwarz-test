DROP TABLE IF EXISTS kfl_production_dbp_etl_process.zekp_rueck_2;
CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.zekp_rueck_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner-ID (Lieferanten-ID).'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der WUP_2 beinhaltet Märkte und Läger. WUP_2 = WarenUmschlagsPlatz, Mutter Wup_2-ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode.'),
bezugsweg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel_2 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1).'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
einkaufsorganisation_id BIGNUMERIC(38,0)
OPTIONS(description='Aus EKORG. Die einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP_2 zusammen mit dem Attribut gp_id eindeutig zu identifizieren. 1000 = Warenlieferant, 5000 = Frischelieferant, 9000 = (?) könnte es auch geben.'),
dat_bis DATE OPTIONS(description='Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen: 9999-12-31.'),
ek_brutto NUMERIC(18,4)
OPTIONS(description='Einkaufspreis brutto (Bedeutung vgl. Kalkulationsschema) aus ABRUT. Tatsächlicher Einkaufspreis. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
ek_netto NUMERIC(18,4) OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema), aus AKNET.'),
ek_nettonetto NUMERIC(18,4)
OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema), aus AKNNE.'),
ek_kal_basis NUMERIC(18,4) OPTIONS(description='Kalkulationsbasis (Bedeutung vgl. Kalkulationsschema), aus EKKBA.'),
ek_mep NUMERIC(18,4) OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema), aus MEPRE.'),
einstandspreis NUMERIC(18,4)
OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema), aus LSEIN.\n            Ergibt sich aus dem Einkaufspreis netto einer Ware zuzüglich der Beschaffungskosten oder Bezugskosten und abzüglich der Minderungen, etwa durch Rabatt, Skonto, Bonus.'),
logistikkostenzuschlag NUMERIC(18,4)
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist), aus LOKAU.'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
komponentenmenge NUMERIC(18,4)
OPTIONS(description='Menge des Inhalts bei strukturierten Artikeln (Display) - aber nicht Pfandartikeln. Bei nicht strukturierten Artikeln ist der Wert = 1. Die EK-Preise werden mit diesem Wert multipliziert, um zu einem Gesamt-EK pro Artikel_2 zu kommen. Aus KOMPMENG.'),
ek_brutto_nrfb_rab NUMERIC(18,4)
OPTIONS(description='Einkaufspreis brutto abzgl. nicht-rabattfähiger Betrag abzgl. Artikelrabatte, aus ABRNA. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
bonusbasis NUMERIC(18,4)
OPTIONS(description='In SAP auch AK-Netto-NRFB genannt. Aus ABONBA. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
bezugsnebenkosten NUMERIC(18,4) OPTIONS(description='Summe der Bezugsnebenkosten, aus BNK.'),
zollwert NUMERIC(9,4) OPTIONS(description='Zollwert, betrifft vor allem Importartikel. Aus ZOLLBA.'),
ek_netto_bnk NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten, aus AKBN. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
ek_netto_bnk_sachk NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten, aus AKBNS. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
cycle_id BIGNUMERIC(38,0)
OPTIONS(description='Technisches Hilfsfeld. Zur Feststellung der Herkunft des Satzes (Loadfile, Datum).'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
ek_mep_vor_fwu BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen\""alten\"" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
ek_brutto_normal BIGNUMERIC(38,4)
OPTIONS(description='Einkaufspreis brutto ohne Aktionskonditionen (Bedeutung vgl. Kalkulationsschema). Aus EBRUT. Der Normalpreis / Listenpreis.'),
PRIMARY KEY (mandant_id, gp_id, wup_id, dat_von, bezugsweg_id, art_id) NOT ENFORCED
) CLUSTER BY mandant_id;