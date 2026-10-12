DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ART_GP_WUP_ZU_PER_1;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_GP_WUP_ZU_PER_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner-ID (Lieferanten-ID).'),
WUP_ID INTEGER NOT NULL
OPTIONS(description='Der WUP_1 beinhaltet Märkte und Läger. WUP_1 = WarenUmschlagsPlatz, Mutter Wup_1-ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
NB_ID INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
DAT_VON DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode.'),
BEZUGSWEG_ID INTEGER NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel_1 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1).'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
EINKAUFSORGANISATION_ID INTEGER
OPTIONS(description='Aus EKORG. Die einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP_1 zusammen mit dem Attribut gp_id eindeutig zu identifizieren. 1000 = Warenlieferant, 5000 = Frischelieferant, 9000 = (?) könnte es auch geben.'),
DAT_BIS DATE OPTIONS(description='Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen: 9999-12-31.'),
EK_BRUTTO NUMERIC(18,4)
OPTIONS(description='Einkaufspreis brutto (Bedeutung vgl. Kalkulationsschema) aus ABRUT. Tatsächlicher Einkaufspreis. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
EK_NETTO NUMERIC(18,4) OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema), aus AKNET.'),
EK_NETTONETTO NUMERIC(18,4)
OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema), aus AKNNE.'),
EK_KAL_BASIS NUMERIC(18,4) OPTIONS(description='Kalkulationsbasis (Bedeutung vgl. Kalkulationsschema), aus EKKBA.'),
EK_MEP NUMERIC(18,4) OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema), aus MEPRE.'),
EINSTANDSPREIS NUMERIC(18,4)
OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema), aus LSEIN.\n            Ergibt sich aus dem Einkaufspreis netto einer Ware zuzüglich der Beschaffungskosten oder Bezugskosten und abzüglich der Minderungen, etwa durch Rabatt, Skonto, Bonus.'),
LOGISTIKKOSTENZUSCHLAG NUMERIC(18,4)
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist), aus LOKAU.'),
WRG_ID STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
KOMPONENTENMENGE NUMERIC(18,4)
OPTIONS(description='Menge des Inhalts bei strukturierten Artikeln (Display) - aber nicht Pfandartikeln. Bei nicht strukturierten Artikeln ist der Wert = 1. Die EK-Preise werden mit diesem Wert multipliziert, um zu einem Gesamt-EK pro Artikel_1 zu kommen. Aus KOMPMENG.'),
EK_BRUTTO_NRFB_RAB NUMERIC(18,4)
OPTIONS(description='Einkaufspreis brutto abzgl. nicht-rabattfähiger Betrag abzgl. Artikelrabatte, aus ABRNA. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
BONUSBASIS NUMERIC(18,4)
OPTIONS(description='In SAP auch AK-Netto-NRFB genannt. Aus ABONBA. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
BEZUGSNEBENKOSTEN NUMERIC(18,4) OPTIONS(description='Summe der Bezugsnebenkosten, aus BNK.'),
ZOLLWERT NUMERIC(9,4) OPTIONS(description='Zollwert, betrifft vor allem Importartikel. Aus ZOLLBA.'),
EK_NETTO_BNK NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten, aus AKBN. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
EK_NETTO_BNK_SACHK NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten, aus AKBNS. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
CYCLE_ID INTEGER
OPTIONS(description='Technisches Hilfsfeld. Zur Feststellung der Herkunft des Satzes (Loadfile, Datum).'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
EK_MEP_VOR_FWU NUMERIC(29,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen\"alten\" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
EK_BRUTTO_NORMAL NUMERIC(29,4)
OPTIONS(description='Einkaufspreis brutto ohne Aktionskonditionen (Bedeutung vgl. Kalkulationsschema). Aus EBRUT. Der Normalpreis / Listenpreis.'),
PRIMARY KEY (MANDANT_ID, GP_ID, WUP_ID, DAT_VON, BEZUGSWEG_ID, ART_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID
OPTIONS(description='TP2 AIS - Artikel_1 Geschäftspartner Markt Zuordnung.');