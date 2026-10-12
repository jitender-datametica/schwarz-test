CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods_archiv.ods_promotion_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land_2'),
bon_id STRING(25) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft'),
bon_zeile BIGNUMERIC(38,0) NOT NULL,
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='ID der Promotion'),
konditionsart_id STRING(4) NOT NULL OPTIONS(description='ID der Konditions- bzw. Rabattart'),
promotion_lfd_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zusätzlicher Zähler beginnt nicht bei 1!'),
betrag_promo_brutto NUMERIC(18,4) OPTIONS(description='Promotionsbetrag'),
kl_art_id BIGNUMERIC(38,0) OPTIONS(description='In der Promotion verkaufte Menge'),
start_bon_zeile TIMESTAMP OPTIONS(description='Zeitstempel bei Beginn der Bewegung'),
menge_promo NUMERIC(18,3) OPTIONS(description='Promotionsmenge: TAG_2 - ReferenceQuantity'),
umsatz_promo_brutto NUMERIC(18,4)
OPTIONS(description='Promotionsumsatz brutto - Berechnung: menge_promo x Stück VK_2 - betrag_promo_brutto'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
customer_promotion_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zeigt an ob es sich um eine_2 K Card Promotion handelt (1=wahr, 0=falsch)'),
promotion_art STRING(100)
OPTIONS(description='Zeigt an um welche Art_2 der Promotion es sich handelt (CUSTOMER = K Card, PERSONAL = K Card personalisiert, COMMON = nicht K Card gebunden) '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) CLUSTER BY mandant_id, bon_dat, wup_id
OPTIONS(description='ODS - Bon- Promotionsdaten aus den Kassensystemen. Dient als Quelle der Tabelle artbew_promotion_zu_2');