CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.COS_BONUSKAUF_TAG_SUM (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
BONUSKAUF_ID STRING(20) NOT NULL OPTIONS(description='Eindeutige ID einer Bonuskaufaktion.'),
DAT DATE NOT NULL
OPTIONS(description='Datum im Format JJJJ-MM-TT. Dieses Datum gibt an, wann der Coupon aktiviert oder eingelöst wurde. Es wird aus dat_update in der Tabelle cos_bonuskauf_kunde_zu (berechnet Aktivierungen und Einlösungen) und bon_dat aus den Bondaten in der Tabelle ods_promotion abgeleitet. Im Falle einer eingelösten Coupon wird das Einlösungsdatum angezeigt, andernfalls das Aktivierungsdatum.'),
KAMPAGNEN_ID_LISTE_TXT STRING(2000)
OPTIONS(description='Komma-separierte Textliste von Kampagnen-IDs, die einer bestimmten bonuskauf_id zugeordnet sind.'),
COUPON_TYP_NAME STRING(20) DEFAULT 'Coupon' NOT NULL
OPTIONS(description='Beschreibt um welchen Coupontyp es sich handelt: Partner, Marktplatz, SMP, Coupon.'),
AKTION_TYP_NAME STRING(20) DEFAULT 'Normal' NOT NULL
OPTIONS(description='Beschreibt um welchen Aktionstyp es sich handelt: Gamification, Checkout, Kaufbar, Reco, Normal.'),
ANZ_ZIELGRUPPENGROESSE INTEGER OPTIONS(description='Gibt die Zielgruppengröße des Coupons an.'),
KANAL_LISTE_TXT STRING(256)
OPTIONS(description='Komma-separierte Textliste der Kommunikationskanäle, über die der Coupon bespielt wurde. Gilt aktuell nur für Partnercoupons. DBP_DATA.COS_BONUSKAUF.BONUSKAUF_PARTNER_FG = 1: App, Web, SSC (Self Service Cockpit), Marktplatz, Kampagne. Mehrfachauswahl ist möglich.'),
ANZ_PUNKTE_COUPON_BENOETIGT INTEGER
OPTIONS(description='Anzahl der Punkte die eingelöst werden müssen (erwerben) um den Coupon verwenden zu können.'),
ANZ_AKTIVIERUNGEN_KAUFBAR INTEGER OPTIONS(description='Gibt die Anzahl der Aktivierungen von kaufbaren Coupons wieder.'),
ANZ_AKTIVIERUNGEN_NICHT_KAUFBAR INTEGER
OPTIONS(description='Gibt die Anzahl der Aktivierungen von nicht-kaufbaren Coupons wieder.'),
ANZ_GESAMT_AKTIVIERUNGEN INTEGER OPTIONS(description='Gesamtanzahl der Aktivierungen.'),
RATE_AKTIVIERUNGSQUOTE NUMERIC(29,5)
OPTIONS(description='Berechnet sich aus der Gesamtanzahl der Aktivierungen / Zielgruppengroesse.'),
ANZ_EINLOESUNGEN_KAUFBAR INTEGER OPTIONS(description='Gibt die Anzahl der Einloesungen von kaufbaren Coupons wieder.'),
ANZ_EINLOESUNGEN_NICHT_KAUFBAR INTEGER
OPTIONS(description='Gibt die Anzahl der Einloesungen von nicht-kaufbaren Coupons wieder.'),
ANZ_GESAMT_EINLOESUNGEN INTEGER OPTIONS(description='Gesamtanzahl der Einloesungen.'),
RATE_EINLOESEQUOTE NUMERIC(29,5) OPTIONS(description='Berechnet sich aus den Gesamteinloesungen / Gesamtaktivierungen.'),
ANZ_GESAMT_PUNKTE_EINLOESUNGEN INTEGER
OPTIONS(description='Gesamtanzahl der eingelösten Punkte. Berechnet sich aus Anzahl Punkte Coupon benötigt * Anzahl Gesamteinloesungen.'),
ANZ_UNIQUE_KUNDEN INTEGER
OPTIONS(description='Anzahl der eindeutigen CRM-Kunden-IDs. Da eine bonuskauf_id mehrere Kampagnen besitzen kann, zählen hier die eindeutigen crm_kunden_ids im Gültigkeitszeitraum des Coupons.'),
BETRAG_BONUSKAUF_UMSATZ_BRUTTO NUMERIC(29,4)
OPTIONS(description='Der Bruttoumsatz der durch den Coupon generiert wurde.'),
BETRAG_BONUSKAUF_UMSATZ_BRUTTO_KONZ NUMERIC(29,4)
OPTIONS(description='Der Bruttoumsatz der durch den Coupon generiert wurde, in Konzernwaehrung zum Tageskurs.'),
BETRAG_BONUSKAUF_UMSATZ_NETTO NUMERIC(29,4) OPTIONS(description='Der Nettoumsatz der durch den Coupon generiert wurde.'),
BETRAG_BONUSKAUF_UMSATZ_NETTO_KONZ NUMERIC(29,4)
OPTIONS(description='Der Nettoumsatz der durch den Coupon generiert wurde, in Konzernwaehrung zum Tageskurs.'),
MENGE_BONUSKAUF_BME NUMERIC(29,3)
OPTIONS(description='Die Abverkaufsmenge die durch den Coupon generiert wurde. Es kann in Stück oder bei Gewichtsartikeln in KG sein.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, BONUSKAUF_ID, DAT) NOT ENFORCED
) OPTIONS(description='Couponaggregationstabelle zur Optimierung der Performance in EK Kunde');