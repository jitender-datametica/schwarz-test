CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_cos_bonuskauf_tag_sum_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), bonuskauf_id OPTIONS(description='Eindeutige ID einer Bonuskaufaktion.'), dat
OPTIONS(description='Datum im Format JJJJ-MM_2-TT. Dieses Datum gibt an, wann der Coupon aktiviert oder eingelöst wurde. Es wird aus dat_update in der Tabelle cos_bonuskauf_kunde_zu_2 (berechnet Aktivierungen und Einlösungen) und bon_dat aus den Bondaten in der Tabelle ods_promotion_2 abgeleitet. Im Falle einer eingelösten Coupon wird das Einlösungsdatum angezeigt, andernfalls das Aktivierungsdatum.'),
kampagnen_id_liste_txt
OPTIONS(description='Komma-separierte Textliste von Kampagnen-IDs, die einer bestimmten bonuskauf_id zugeordnet sind.'),
coupon_typ_name
OPTIONS(description='Beschreibt um welchen Coupontyp es sich handelt: Partner, Marktplatz, SMP, Coupon.'),
aktion_typ_name
OPTIONS(description='Beschreibt um welchen Aktionstyp es sich handelt: Gamification, Checkout, Kaufbar, Reco, Normal.'),
anz_zielgruppengroesse OPTIONS(description='Gibt die Zielgruppengröße des Coupons an.'), kanal_liste_txt
OPTIONS(description='Komma-separierte Textliste der Kommunikationskanäle, über die der Coupon bespielt wurde. Gilt aktuell nur für Partnercoupons. DBP_DATA.COS_BONUSKAUF.BONUSKAUF_PARTNER_FG = 1: App, Web, SSC (Self Service Cockpit), Marktplatz, Kampagne. Mehrfachauswahl ist möglich.'),
anz_punkte_coupon_benoetigt
OPTIONS(description='Anzahl der Punkte die eingelöst werden müssen (erwerben) um den Coupon verwenden zu können.'),
anz_aktivierungen_kaufbar OPTIONS(description='Gibt die Anzahl der Aktivierungen von kaufbaren Coupons wieder.'),
anz_aktivierungen_nicht_kaufbar
OPTIONS(description='Gibt die Anzahl der Aktivierungen von nicht-kaufbaren Coupons wieder.'), anz_gesamt_aktivierungen
OPTIONS(description='Gesamtanzahl der Aktivierungen.'), rate_aktivierungsquote
OPTIONS(description='Berechnet sich aus der Gesamtanzahl der Aktivierungen / Zielgruppengroesse.'),
anz_einloesungen_kaufbar OPTIONS(description='Gibt die Anzahl der Einloesungen von kaufbaren Coupons wieder.'),
anz_einloesungen_nicht_kaufbar
OPTIONS(description='Gibt die Anzahl der Einloesungen von nicht-kaufbaren Coupons wieder.'), anz_gesamt_einloesungen
OPTIONS(description='Gesamtanzahl der Einloesungen.'), rate_einloesequote
OPTIONS(description='Berechnet sich aus den Gesamteinloesungen / Gesamtaktivierungen.'), anz_gesamt_punkte_einloesungen
OPTIONS(description='Gesamtanzahl der eingelösten Punkte. Berechnet sich aus Anzahl Punkte Coupon benötigt * Anzahl Gesamteinloesungen.'),
anz_unique_kunden
OPTIONS(description='Anzahl der eindeutigen CRM-Kunden-IDs. Da eine_2 bonuskauf_id mehrere Kampagnen besitzen kann, zählen hier die eindeutigen crm_kunden_ids im Gültigkeitszeitraum des Coupons.'),
betrag_bonuskauf_umsatz_brutto OPTIONS(description='Der Bruttoumsatz der durch den Coupon generiert wurde.'),
betrag_bonuskauf_umsatz_brutto_konz
OPTIONS(description='Der Bruttoumsatz der durch den Coupon generiert wurde, in Konzernwaehrung zum Tageskurs.'),
betrag_bonuskauf_umsatz_netto OPTIONS(description='Der Nettoumsatz der durch den Coupon generiert wurde.'),
betrag_bonuskauf_umsatz_netto_konz
OPTIONS(description='Der Nettoumsatz der durch den Coupon generiert wurde, in Konzernwaehrung zum Tageskurs.'),
menge_bonuskauf_bme
OPTIONS(description='Die Abverkaufsmenge die durch den Coupon generiert wurde. Es kann in Stück oder bei Gewichtsartikeln in KG sein.'))
OPTIONS(DESCRIPTION = `COUPONAGGREGATIONSTABELLE ZUR OPTIMIERUNG DER PERFORMANCE IN EK KUNDE`) AS SELECT mandant_id,
 bonuskauf_id,
 dat,
 kampagnen_id_liste_txt,
 coupon_typ_name,
 aktion_typ_name,
 anz_zielgruppengroesse,
 kanal_liste_txt,
 anz_punkte_coupon_benoetigt,
 anz_aktivierungen_kaufbar,
 anz_aktivierungen_nicht_kaufbar,
 anz_gesamt_aktivierungen,
 rate_aktivierungsquote,
 anz_einloesungen_kaufbar,
 anz_einloesungen_nicht_kaufbar,
 anz_gesamt_einloesungen,
 rate_einloesequote,
 anz_gesamt_punkte_einloesungen,
 anz_unique_kunden,
 betrag_bonuskauf_umsatz_brutto,
 betrag_bonuskauf_umsatz_brutto_konz,
 betrag_bonuskauf_umsatz_netto,
 betrag_bonuskauf_umsatz_netto_konz,
 menge_bonuskauf_bme
FROM kfl_production_dbp_msi_data.cos_bonuskauf_tag_sum_2;