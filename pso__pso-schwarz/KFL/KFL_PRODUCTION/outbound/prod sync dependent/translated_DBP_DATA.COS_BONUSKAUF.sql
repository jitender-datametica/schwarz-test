CREATE OR REPLACE TABLE kfl_production_dbp_data.cos_bonuskauf (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='Eindeutige ID einer Bonuskaufaktion, z.Bsp. 700 aus bbynr.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
bonuskauf_name STRING(200) OPTIONS(description='Coupon Name.'),
bonuskauf_typ STRING(4)
OPTIONS(description='Coupon Promotionsart / typ - für Reco wird immer ZAI zurückgegeben außer für RO und MD da wird es ZAIR oder ZAIM sein.'),
bonuskauf_kategorie_bez STRING(10) OPTIONS(description='Coupon Kategorie - Discount = 1 oder BonusBuy = 2.'),
gamification_fg INTEGER DEFAULT -1 NOT NULL OPTIONS(description='Flag: Ist Gamification.'),
bonuskauf_rabatt_wert NUMERIC(29,4) OPTIONS(description='Rabatt Wert.'),
bonuskauf_rabatt_prozent NUMERIC(29,2) OPTIONS(description='Rabatt (%).'),
anz_punkte_zu_zahlend INTEGER OPTIONS(description='Punkte die für einen kaufbaren Coupon gezahlt werden müssen.'),
wg_id INTEGER OPTIONS(description='Warengruppe.'),
dat_von DATETIME NOT NULL OPTIONS(description='Gültigkeitsdatum von.'),
dat_bis DATETIME NOT NULL OPTIONS(description='Gültigkeitsdatum bis.'),
bonuskauf_bez STRING(200) OPTIONS(description='Coupon Beschreibung.'),
max_einloesung INTEGER OPTIONS(description='Max. Einlösung.'),
aktiv_loyalty_gesamt_fg INTEGER DEFAULT -1 NOT NULL OPTIONS(description='Flag: Zielgruppe alle Kunden.'),
voraktiviert_fg INTEGER DEFAULT -1 NOT NULL OPTIONS(description='Flag: Voraktiviert.'),
aktiv_loyalty_digital_fg INTEGER DEFAULT -1 NOT NULL OPTIONS(description='Flag: Zielgruppe digitale Kunden.'),
aktiv_loyalty_physisch_fg INTEGER DEFAULT -1 NOT NULL OPTIONS(description='Flag: Zielgruppe physische Kunden.'),
anz_max_einkauf INTEGER OPTIONS(description='Max Anzahl für Einkauf.'),
anz_min_artikel INTEGER OPTIONS(description='Min Anzahl für Artikel.'),
min_umsatz_bedingung NUMERIC(29,4) OPTIONS(description='Coupon mit Bedingung, Mindestumsatz.'),
min_umsatz_artikel NUMERIC(29,4) OPTIONS(description='Min Umsatz.'),
min_umsatz_bedingung_transaktion NUMERIC(29,4)
OPTIONS(description='Coupon mit Bedingung, Mindestumsatz pro Transaktion.'),
dat_von_bedingung DATETIME
OPTIONS(description='Startzeit der Bedingung. Für den Zeitraum in dem man die Couponbedingung erfüllen muss um den Coupon zu erhalten. Z.B. bei\""kauf drei Packungen Haribo und bekomme beim nächsten Einkauf 2€ geschenkt\"" bezieht sich der Zeitraum der Bedingung auf den Kauf der 3 Packungen.'),
dat_bis_bedingung DATETIME
OPTIONS(description='Endzeit der Bedingung. Für den Zeitraum in dem man die Couponbedingung erfüllen muss um den Coupon zu erhalten. Z.B. bei\""kauf drei Packungen Haribo und bekomme beim nächsten Einkauf 2€ geschenkt\"" bezieht sich der Zeitraum der Bedingung auf den Kauf der 3 Packungen.'),
mindestfrequenz_bedingung INTEGER OPTIONS(description='Coupon mit Bedingung, Mindestfrequenz.'),
anz_min_kauf_bby_artikel INTEGER OPTIONS(description='Menge der BonusBuy Artikel die gekauft werden müssen.'),
anz_min_zahlen_bby_artikel INTEGER OPTIONS(description='Menge der BonusBuy Artikel die gezahlt werden müssen.'),
gratis_menge_bby INTEGER OPTIONS(description='Menge der BonusBuy Artikel die es umsonst gibt.'),
zuweisung_neukunde_fg INTEGER NOT NULL OPTIONS(description='Flag: Zugewiesen an Neukunden.'),
anz_top_kunden INTEGER OPTIONS(description='Top X Kunden.'),
anz_aktuelle_kunden INTEGER OPTIONS(description='Aktuelle X Kunden.'),
bonuskauf_deaktivieren_fg INTEGER DEFAULT -1 NOT NULL OPTIONS(description='Flag: Coupon deaktivierbar.'),
umsatz_aktivierung_brutto NUMERIC(29,4)
OPTIONS(description='Umsatz der generiert werden muss für die Couponaktivierung.'),
bonuskauf_regel STRING(20) OPTIONS(description='Regel für Coupons.'),
kauf_mit_punkte_fg INTEGER DEFAULT -1 NOT NULL OPTIONS(description='Flag: Kann man den Coupon für Punkte kaufen.'),
konditionsart_id STRING(4) OPTIONS(description='Konditionstyp.'),
bonuskauf_promotionstyp STRING(4) OPTIONS(description='Promotionstyp.'),
geschaeftsvorfall_id STRING(2) OPTIONS(description='Geschäftsvorfall.'),
vk_brutto NUMERIC(29,4) OPTIONS(description='Standardpreis.'),
vk_aktion_brutto_loyalty NUMERIC(29,4) OPTIONS(description='Promotionspreis Loyalty.'),
betrag_promo_prozent NUMERIC(29,4) OPTIONS(description='Betrag der gespart wurde.'),
vk_aktion_brutto NUMERIC(29,4) OPTIONS(description='Promotionspreis.'),
bonuskauf_partner_fg INTEGER DEFAULT -1 NOT NULL
OPTIONS(description='Flag: Partner-Coupon - Zeigt an ob es ein Partner-Coupon ist.'),
bonuskauf_smp_fg INTEGER DEFAULT -1 NOT NULL
OPTIONS(description='Flag: Zeigt, ob der Coupon ein SMP (Schwarz Media Plattform) Coupon ist.'),
nur_marktplatz_fg INTEGER DEFAULT -1 NOT NULL
OPTIONS(description='Flag: Zeigt, ob der Coupon ein Marktplatzcoupon ist.'),
bonuskauf_anbieter_name STRING(256) OPTIONS(description='Name des Partners der den Coupon bereitstellt.'),
bonuskauf_code_generierung_typ_id INTEGER
OPTIONS(description='Couponcode Typ (PCCodeTypeCode = 1, dann individueller Code oder PCCodeTypeCode = 2, dann generischer Code)'),
bonuskauf_code_typ_id INTEGER
OPTIONS(description='Code Typ (PCDisplayTypeCode = 1, dann QR Code; PCDisplayTypeCode = 2, dann Bar Code; PCDisplayTypeCode = 3, dann Text; PCDisplayTypeCode = 4, dann Link; PCDisplayTypeCode = 5, dann K Card)'),
sichtbar_in_app_fg INTEGER DEFAULT -1 NOT NULL
OPTIONS(description='Flag, dass anzeigt ob der Partnercoupon in der App sichtbar ist'),
sichtbar_in_web_fg INTEGER DEFAULT -1 NOT NULL
OPTIONS(description='Flag, dass anzeigt ob der Partnercoupon im Web sichtbar ist'),
sichtbar_in_ssc_fg INTEGER DEFAULT -1 NOT NULL
OPTIONS(description='Flag, dass anzeigt ob der Partnercoupon im Web 2.0 sichtbar ist'),
sichtbar_in_marktplatz_fg INTEGER DEFAULT -1 NOT NULL
OPTIONS(description='Flag, dass anzeigt ob der Partnercoupon im Marktplatz sichtbar ist'),
sichtbar_in_kampagne_fg INTEGER DEFAULT -1 NOT NULL
OPTIONS(description='Flag, dass anzeigt ob der Partnercoupon in der Kampagne sichtbar ist'),
bonuskauf_vorteilsregeln_txt STRING(256)
OPTIONS(description='Inhaltliche Beschreibung des Partnercoupons. Ist ein Freitextfeld'),
bonuskauf_konditionen_txt STRING(256) OPTIONS(description='Vorteile des Partnercoupons. Ist ein Freitextfeld.'),
datzeit_von_extern_einloesung DATETIME
OPTIONS(description='Start-Einlösedatum des Partnercoupons beim Partneranbieter. Für Coupons von Fremdanbietern (Partnern), welche ab diesem Zeitpunkt nur extern über sie eingelöst werden können. Kann nach dem DAT_VON liegen, da Coupons schon vorher dem Kunden angezeigt werden können.'),
datzeit_bis_extern_einloesung DATETIME
OPTIONS(description='End-Einlösedatum des Partnercoupons beim Partneranbieter. Für Coupons von Fremdanbietern (Partnern), welche bis zu  diesem Zeitpunkt nur extern über sie eingelöst werden können.'),
bonuskauf_status_id INTEGER
OPTIONS(description='Gibt den Status des Coupons an.  0 = inaktiv, 1 = aktiv, 2 = widerruft, bzw. inactive, active, revoked respektiv '),
bonuskauf_kategorie_id INTEGER
OPTIONS(description='Gibt die Kategorie des Coupons an, z.B. 1 = Einkaufswagen, 2 = Warengruppe, 3 = Artikel, bzw. Shopping Cart, Product Group, Article respektiv'),
angebot_nr STRING(256) OPTIONS(description='Entspricht der angebot_nr aus PMR (dbp_data.angebot)'),
aktiv_eingeschraenkt_kunde_fg INTEGER
OPTIONS(description='Gibt an ob ein Coupon nur für eine bestimmte Kundengruppen bekommt. '),
checkout_bonuskauf_fg INTEGER
OPTIONS(description='Ein Checkout Coupon ist ein Coupon, der nach einem Einkauf bereitgestellt wird. Dieser wird auf den Bon gedruckt. '),
bonuskauf_bedingung_fg INTEGER
OPTIONS(description='Ein Coupon der erst frerigeschalten wird bzw. verwendet werden kann, wenn bestimmte Bedingungen erfüllt sind ,z.B. Kaufe für 100€ im Monat ein'),
daily_suprise_fg INTEGER
OPTIONS(description='Ein Daily Suprise Coupon ist ein zeitliche begrenzte Aktion. Innerhalb diesen Zeitraums wird die Aktion am Tag bereitgestellt um Einkaufsanreize zu setzen. '),
extern_gamification_fg INTEGER
OPTIONS(description='Externe Gamification beziehen sich auf Coupons bei dem der Kunde mit Spielen oder sonstige interaktive Herausforderungen auf einer externen Plattform (Social Media, Partnerwebseiten etc.) teilnehmen kann. Dieser Coupon kann dann eingelöst werden. '),
sorry_fg INTEGER
OPTIONS(description='Ist ein Entschuldigungscoupon das vom Kundenservice proaktiv bereitgestellt wird, z.B. wenn Kunde eine ngeative Erfahrung hat (technische Defekte, verspätete Lieferung...)'),
mca_zuweisung_fg INTEGER OPTIONS(description='Ob der Coupon über MCA zugewiesen wird (Mass Coupon Assignment). '),
kampagne_zuweisung_fg INTEGER
OPTIONS(description='Ob der Coupon über eine Journey (Kampagne) zugewiesen wird. Dbp_data.kampagne.kampagne_id'),
marken_fg INTEGER
OPTIONS(description='Gibt an ob es sich um einen Markencoupon handelt bzw. ob sich die Promotion nur auf eine bestimmte Markt beschränkt. '),
wettbewerber_fg INTEGER OPTIONS(description='Gibt an ob es sich um ein Coupon von einem Wettbewerber handelt'),
csr_fg INTEGER OPTIONS(description='Gibt an ob es sich um einen CSR (Corporate Social Resposibility) Coupon handelt'),
loyalty_artikel_fg INTEGER OPTIONS(description='Gibt an ob es sich um ein Loyalty Artikel Coupon handelt'),
super_coupon_fg INTEGER
OPTIONS(description='Coupon wird zu einem Super Coupon mit diesem Flag. Es bekommt eine andere Darstellung in der App für den Kunden. Das highlighted den Coupon. '),
xtra_coupon_fg INTEGER OPTIONS(description='Gibt an ob es sich um ein Xtra Coupon handelt'),
prioritaet_coupon_fg INTEGER
OPTIONS(description='Gibt an ob der Coupon in der Übersicht an obersten Stelle zu sehen ist'),
bonuskauf_subkategorie_reihenfolge_nr INTEGER
OPTIONS(description='Ist die Reihenfolge in der die Kategorie in der App angezeigt wird'),
bonuskauf_subkategorie_id STRING(200) OPTIONS(description='Liefert die ID der Kategorie'),
bonuskauf_subkategorie_bez STRING(200)
OPTIONS(description='Liefert die Bezeichnung einer Coupon Kategorie. Ist abhängig von der bonuskauf_kategorie_id+bonuskauf_id+mandant_id'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bonuskauf_id) NOT ENFORCED
) OPTIONS(description='Customer Coupon Assignments');