DROP TABLE IF EXISTS kfl_production_dbp_ods_archiv.ods_promotion;
CREATE OR REPLACE TABLE kfl_production_dbp_ods_archiv.ods_promotion (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land'),
bon_id STRING(25) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft'),
bon_zeile INTEGER NOT NULL,
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='ID der Promotion'),
konditionsart_id STRING(4) NOT NULL OPTIONS(description='ID der Konditions- bzw. Rabattart'),
promotion_lfd_nr INTEGER NOT NULL OPTIONS(description='Zusätzlicher Zähler beginnt nicht bei 1!'),
betrag_promo_brutto NUMERIC(29,4) OPTIONS(description='Promotionsbetrag'),
kl_art_id INTEGER OPTIONS(description='In der Promotion verkaufte Menge'),
start_bon_zeile DATETIME OPTIONS(description='Zeitstempel bei Beginn der Bewegung'),
menge_promo NUMERIC(29,3) OPTIONS(description='Promotionsmenge: TAG - ReferenceQuantity'),
umsatz_promo_brutto NUMERIC(29,4)
OPTIONS(description='Promotionsumsatz brutto - Berechnung: menge_promo x Stück VK - betrag_promo_brutto'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
customer_promotion_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zeigt an ob es sich um eine K Card Promotion handelt (1=wahr, 0=falsch)'),
promotion_art STRING(100)
OPTIONS(description='Zeigt an um welche Art der Promotion es sich handelt (CUSTOMER = K Card, PERSONAL = K Card personalisiert, COMMON = nicht K Card gebunden) '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) CLUSTER BY mandant_id, bon_dat, wup_id
OPTIONS(description='ODS - Bon- Promotionsdaten aus den Kassensystemen. Dient als Quelle der Tabelle artbew_promotion_zu');