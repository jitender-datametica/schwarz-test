--==============================================================
-- Table: cos_bonuskauf_kunde_zuordnung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuskauf_kunde_zuordnung
   generated from Powerdesigner on Montag, 27. Oktober 2025 13:36:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cos_bonuskauf_kunde_zuordnung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Land des Kundenwohnorts,(Mandant im DWH).'),
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='Eindeutige ID einer Bonuskaufaktion z.Bsp. 700, aus bbynr.'),
crm_kunde_id STRING(144) NOT NULL OPTIONS(description='CRM-interne ID des Kunden.'),
crm_cidaas_id STRING(120) DEFAULT '-9999' NOT NULL
OPTIONS(description='Meldet sich Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.'),
kampagnen_id STRING(120)
OPTIONS(description='ID der Kampagne, zu der der zugewiesene (in Kaulfand-Card und App) Kunden- Coupon,gehört.'),
kampagnen_version_nr BIGNUMERIC(38,0)
OPTIONS(description='Versionnummer der Kampagne, zu der der zugewiesene (in Kaufland-Card und App) Kunden- Coupon,gehört.'),
dat_update TIMESTAMP NOT NULL
OPTIONS(description='Timestamp, wann der Datensatz im Quellsystem zuletzt aktualisiert wurde.'),
bonuskauf_quell_name STRING(50) NOT NULL
OPTIONS(description='Die Quelltabelle des Coupons und stellt die Art und Weise der Zuweisung der Coupons dar.            "CouponCustomersRelationsRecoStationary" -  Coupons die per AI den Kunden zugewiesen werden.             "CouponCustomersRelationsMca"- Neue Art und Weise Coupons (verschiedene Arten) auf schnelle Weise im System den Kunden zuzuweisen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bonuskauf_id, crm_kunde_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle beinhaltet nur Informationen über Kunden-Coupons Zuweisung. Im Vergleich zu Tabelle cos_bonuskauf_kunde_zu, die im Gegenteil enthält alle Transaktionsbewegungen eines Coupons: Aktivieren, deaktivieren, kaufen, einlösen, Zuweisungen etc.');