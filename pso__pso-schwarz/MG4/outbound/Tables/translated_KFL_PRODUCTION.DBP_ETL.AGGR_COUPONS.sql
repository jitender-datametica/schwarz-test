CREATE OR REPLACE TABLE kfl_production_dbp_etl.aggr_coupons (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='Eindeutige ID einer Bonuskaufaktion.'),
kampagnen_id_liste_txt STRING(2000)
OPTIONS(description='Komma-separierte Textliste von Kampagnen-IDs, die einer bestimmten bonuskauf_id zugeordnet sind.'),
coupon_typ_name STRING(20) DEFAULT 'Coupon' NOT NULL
OPTIONS(description='Beschreibt um welchen Coupontyp es sich handelt: Partner, Marktplatz, SMP, Coupon.'),
aktion_typ_name STRING(20) DEFAULT 'Normal' NOT NULL
OPTIONS(description='Beschreibt um welchen Aktionstyp es sich handelt: Gamification, Checkout, Kaufbar, Reco, Normal.'),
anz_zielgruppengroesse INTEGER OPTIONS(description='Gibt die Zielgruppengröße des Coupons an.'),
kanal_liste_txt STRING(256)
OPTIONS(description='Komma-separierte Textliste der Kommunikationskanäle, über die der Coupon bespielt wurde. Gilt aktuell nur für Partnercoupons. DBP_DATA.COS_BONUSKAUF.BONUSKAUF_PARTNER_FG = 1: App, Web, SSC (Self Service Cockpit), Marktplatz, Kampagne. Mehrfachauswahl ist möglich.'),
anz_punkte_coupon_benoetigt INTEGER
OPTIONS(description='Anzahl der Punkte die eingelöst werden müssen (erwerben) um den Coupon verwenden zu können.'),
anz_aktivierungen_kaufbar INTEGER OPTIONS(description='Gibt die Anzahl der Aktivierungen von kaufbaren Coupons wieder.'),
anz_aktivierungen_nicht_kaufbar INTEGER
OPTIONS(description='Gibt die Anzahl der Aktivierungen von nicht-kaufbaren Coupons wieder.'),
anz_gesamt_aktivierungen INTEGER OPTIONS(description='Gesamtanzahl der Aktivierungen.'),
rate_aktivierungsquote NUMERIC(29,5)
OPTIONS(description='Berechnet sich aus der Gesamtanzahl der Aktivierungen / Zielgruppengroesse.'),
anz_einloesungen_kaufbar INTEGER OPTIONS(description='Gibt die Anzahl der Einloesungen von kaufbaren Coupons wieder.'),
anz_einloesungen_nicht_kaufbar INTEGER
OPTIONS(description='Gibt die Anzahl der Einloesungen von nicht-kaufbaren Coupons wieder.'),
anz_gesamt_einloesungen INTEGER OPTIONS(description='Gesamtanzahl der Einloesungen.'),
rate_einloesequote NUMERIC(29,5) OPTIONS(description='Berechnet sich aus den Gesamteinloesungen / Gesamtaktivierungen.'),
anz_gesamt_punkte_einloesungen INTEGER
OPTIONS(description='Gesamtanzahl der eingelösten Punkte. Berechnet sich aus Anzahl Punkte Coupon benötigt * Anzahl Gesamteinloesungen.'),
anz_unique_kunden INTEGER
OPTIONS(description='Anzahl der eindeutigen CRM-Kunden-IDs. Da eine bonuskauf_id mehrere Kampagnen besitzen kann, zählen hier die eindeutigen crm_kunden_ids im Gültigkeitszeitraum des Coupons.'),
betrag_bonuskauf_umsatz_brutto NUMERIC(29,4)
OPTIONS(description='Der Bruttoumsatz der durch den Coupon generiert wurde.'),
betrag_bonuskauf_umsatz_brutto_konz NUMERIC(29,4)
OPTIONS(description='Der Bruttoumsatz der durch den Coupon generiert wurde, in Konzernwaehrung zum Tageskurs.'),
betrag_bonuskauf_umsatz_netto NUMERIC(29,4) OPTIONS(description='Der Nettoumsatz der durch den Coupon generiert wurde.'),
betrag_bonuskauf_umsatz_netto_konz NUMERIC(29,4)
OPTIONS(description='Der Nettoumsatz der durch den Coupon generiert wurde, in Konzernwaehrung zum Tageskurs.'),
menge_bonuskauf_bme NUMERIC(29,3)
OPTIONS(description='Die Abverkaufsmenge die durch den Coupon generiert wurde. Es kann in Stück oder bei Gewichtsartikeln in KG sein.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bonuskauf_id) NOT ENFORCED
) OPTIONS(description='Couponaggregationstabelle zur Optimierung der Performance in EK Kunde');