DROP TABLE IF EXISTS kfl_production_dbp_ods.ods_promotion_2;
CREATE OR REPLACE TABLE kfl_production_dbp_ods.ods_promotion_2 (
mandant_id INTEGER NOT NULL,
bon_id STRING(100) NOT NULL,
wup_id INTEGER NOT NULL,
bon_zeile INTEGER NOT NULL,
bonuskauf_id STRING(80) NOT NULL,
konditionsart_id STRING(16) NOT NULL,
promotion_lfd_nr INTEGER NOT NULL,
betrag_promo_brutto NUMERIC(18,4),
kl_art_id INTEGER,
start_bon_zeile DATETIME,
menge_promo NUMERIC(18,3),
umsatz_promo_brutto NUMERIC(18,4),
bon_dat DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP,
customer_promotion_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zeigt an ob es sich um eine_2 K Card Promotion handelt (1=wahr, 0=falsch)'),
promotion_art STRING(100)
OPTIONS(description='Zeigt an um welche Art_2 der Promotion es sich handelt (CUSTOMER = K Card, PERSONAL = K Card personalisiert, COMMON = nicht K Card gebunden)')
) CLUSTER BY mandant_id, bon_dat, wup_id
OPTIONS(description='ODS - Bon- Promotionsdaten aus den Kassensystemen. Dient als Quelle der Tabelle artbew_promotion_zu_2');