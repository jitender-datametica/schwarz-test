CREATE OR REPLACE TABLE kfl_production_dbp_data.cos_bonuskauf_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='Eindeutige ID einer Bonuskaufaktion, z.Bsp. 700 aus bbynr.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
bonuskauf_name STRING(200) OPTIONS(description='Coupon Name.'),
bonuskauf_typ STRING(4)
OPTIONS(description='Coupon Promotionsart / typ - für Reco wird immer ZAI zurückgegeben außer für RO und MD da wird es ZAIR oder ZAIM sein.'),
bonuskauf_kategorie_bez STRING(10) OPTIONS(description='Coupon Kategorie - Discount = 1 oder BonusBuy = 2.'),
gamification_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag: Ist Gamification.'),
bonuskauf_rabatt_wert NUMERIC(29,4) OPTIONS(description='Rabatt Wert.'),
bonuskauf_rabatt_prozent NUMERIC(9,2) OPTIONS(description='Rabatt (%).'),
anz_punkte_zu_zahlend INTEGER OPTIONS(description='Punkte die für einen kaufbaren Coupon gezahlt werden müssen.'),
wg_id INTEGER OPTIONS(description='Warengruppe.'),
dat_von TIMESTAMP NOT NULL OPTIONS(description='Gültigkeitsdatum von.'),
dat_bis TIMESTAMP NOT NULL OPTIONS(description='Gültigkeitsdatum bis.'),
bonuskauf_bez STRING(200) OPTIONS(description='Coupon Beschreibung.'),
max_einloesung INTEGER OPTIONS(description='Max. Einlösung.'),
aktiv_loyalty_gesamt_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag: Zielgruppe alle Kunden.'),
voraktiviert_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag: Voraktiviert.'),
aktiv_loyalty_digital_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag: Zielgruppe digitale Kunden.'),
aktiv_loyalty_physisch_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag: Zielgruppe physische Kunden.'),
anz_max_einkauf INTEGER OPTIONS(description='Max Anzahl für Einkauf.'),
anz_min_artikel INTEGER OPTIONS(description='Min Anzahl für Artikel.'),
min_umsatz_bedingung NUMERIC(29,4) OPTIONS(description='Coupon mit Bedingung, Mindestumsatz.'),
min_umsatz_artikel NUMERIC(29,4) OPTIONS(description='Min Umsatz.'),
min_umsatz_bedingung_transaktion NUMERIC(29,4)
OPTIONS(description='Coupon mit Bedingung, Mindestumsatz pro Transaktion.'),
dat_von_bedingung TIMESTAMP
OPTIONS(description='Startzeit der Bedingung. Für den Zeitraum in dem man die Couponbedingung erfüllen muss um den Coupon zu erhalten. Z.B. bei\"kauf drei Packungen Haribo und bekomme beim nächsten Einkauf 2€ geschenkt\" bezieht sich der Zeitraum der Bedingung auf den Kauf der 3 Packungen.'),
dat_bis_bedingung TIMESTAMP
OPTIONS(description='Endzeit der Bedingung. Für den Zeitraum in dem man die Couponbedingung erfüllen muss um den Coupon zu erhalten. Z.B. bei\"kauf drei Packungen Haribo und bekomme beim nächsten Einkauf 2€ geschenkt\" bezieht sich der Zeitraum der Bedingung auf den Kauf der 3 Packungen.'),
mindestfrequenz_bedingung INTEGER OPTIONS(description='Coupon mit Bedingung, Mindestfrequenz.'),
anz_min_kauf_bby_artikel INTEGER OPTIONS(description='Menge der BonusBuy Artikel_2 die gekauft werden müssen.'),
anz_min_zahlen_bby_artikel INTEGER OPTIONS(description='Menge der BonusBuy Artikel_2 die gezahlt werden müssen.'),
gratis_menge_bby INTEGER OPTIONS(description='Menge der BonusBuy Artikel_2 die es umsonst gibt.'),
zuweisung_neukunde_fg INTEGER NOT NULL OPTIONS(description='Flag: Zugewiesen an Neukunden.'),
anz_top_kunden INTEGER OPTIONS(description='Top X Kunden.'),
anz_aktuelle_kunden INTEGER OPTIONS(description='Aktuelle X Kunden.'),
bonuskauf_deaktivieren_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag: Coupon deaktivierbar.'),
umsatz_aktivierung_brutto NUMERIC(29,4)
OPTIONS(description='Umsatz der generiert werden muss für die Couponaktivierung.'),
bonuskauf_regel STRING(20) OPTIONS(description='Regel für Coupons.'),
kauf_mit_punkte_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag: Kann man den Coupon für Punkte kaufen.'),
konditionsart_id STRING(4) OPTIONS(description='Konditionstyp.'),
bonuskauf_promotionstyp STRING(4) OPTIONS(description='Promotionstyp.'),
geschaeftsvorfall_id STRING(2) OPTIONS(description='Geschäftsvorfall.'),
vk_brutto NUMERIC(29,4) OPTIONS(description='Standardpreis.'),
vk_aktion_brutto_loyalty NUMERIC(29,4) OPTIONS(description='Promotionspreis Loyalty.'),
betrag_promo_prozent NUMERIC(29,4) OPTIONS(description='Betrag der gespart wurde.'),
vk_aktion_brutto NUMERIC(29,4) OPTIONS(description='Promotionspreis.'),
bonuskauf_partner_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag: Partner-Coupon - Zeigt an ob es ein Partner-Coupon ist.'),
bonuskauf_smp_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag: Zeigt, ob der Coupon ein SMP (Schwarz Media Plattform) Coupon ist.'),
nur_marktplatz_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag: Zeigt, ob der Coupon ein Marktplatzcoupon ist.'),
bonuskauf_anbieter_name STRING(256) OPTIONS(description='Name des Partners der den Coupon bereitstellt.'),
bonuskauf_code_generierung_typ_id INTEGER
OPTIONS(description='Couponcode Typ (PCCodeTypeCode = 1, dann individueller Code oder PCCodeTypeCode = 2, dann generischer Code)'),
bonuskauf_code_typ_id INTEGER
OPTIONS(description='Code Typ (PCDisplayTypeCode = 1, dann QR Code; PCDisplayTypeCode = 2, dann Bar Code; PCDisplayTypeCode = 3, dann Text; PCDisplayTypeCode = 4, dann Link; PCDisplayTypeCode = 5, dann K Card)'),
sichtbar_in_app_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag, dass anzeigt ob der Partnercoupon in der App sichtbar ist'),
sichtbar_in_web_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag, dass anzeigt ob der Partnercoupon im Web sichtbar ist'),
sichtbar_in_ssc_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag, dass anzeigt ob der Partnercoupon im Web 2.0 sichtbar ist'),
sichtbar_in_marktplatz_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag, dass anzeigt ob der Partnercoupon im Marktplatz sichtbar ist'),
sichtbar_in_kampagne_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag, dass anzeigt ob der Partnercoupon in der Kampagne_2 sichtbar ist'),
bonuskauf_vorteilsregeln_txt STRING(256)
OPTIONS(description='Inhaltliche Beschreibung des Partnercoupons. Ist ein Freitextfeld'),
bonuskauf_konditionen_txt STRING(256) OPTIONS(description='Vorteile des Partnercoupons. Ist ein Freitextfeld.'),
datzeit_von_extern_einloesung TIMESTAMP
OPTIONS(description='Start-Einlösedatum des Partnercoupons beim Partneranbieter. Für Coupons von Fremdanbietern (Partnern), welche ab diesem Zeitpunkt nur extern über sie eingelöst werden können. Kann nach dem DAT_VON liegen, da Coupons schon vorher dem Kunden angezeigt werden können.'),
datzeit_bis_extern_einloesung TIMESTAMP
OPTIONS(description='End-Einlösedatum des Partnercoupons beim Partneranbieter. Für Coupons von Fremdanbietern (Partnern), welche bis zu  diesem Zeitpunkt nur extern über sie eingelöst werden können.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bonuskauf_id) NOT ENFORCED
) OPTIONS(description='Customer Coupon Assignments');