CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_promotion_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
bon_id STRING(100) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
bon_zeile BIGNUMERIC(38,0) NOT NULL,
bonuskauf_id STRING(80) NOT NULL,
konditionsart_id STRING(16) NOT NULL,
promotion_lfd_nr BIGNUMERIC(38,0) NOT NULL,
betrag_promo_brutto NUMERIC(18,4),
kl_art_id BIGNUMERIC(38,0),
start_bon_zeile DATETIME,
menge_promo NUMERIC(18,3),
umsatz_promo_brutto NUMERIC(18,4),
bon_dat DATE NOT NULL,
customer_promotion_fg BIGNUMERIC DEFAULT 0 NOT NULL
OPTIONS(description='Zeigt an ob es sich um eine_1 K Card Promotion handelt (1=wahr, 0=falsch)'),
promotion_art STRING(100)
OPTIONS(description='Zeigt an um welche Art_1 der Promotion es sich handelt (CUSTOMER = K Card, PERSONAL = K Card personalisiert, COMMON = nicht K Card gebunden)'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, bon_dat, wup_id
OPTIONS(description='ODS - Bon- Promotionsdaten aus den Kassensystemen. Dient als Quelle der Tabelle artbew_promotion_zu_1');