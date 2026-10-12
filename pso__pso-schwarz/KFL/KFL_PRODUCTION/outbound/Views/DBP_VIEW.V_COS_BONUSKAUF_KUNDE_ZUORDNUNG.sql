CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cos_bonuskauf_kunde_zuordnung (mandant_id
OPTIONS(description='Land des Kundenwohnorts,(Mandant im DWH).'), bonuskauf_id
OPTIONS(description='Eindeutige ID einer Bonuskaufaktion z.Bsp. 700, aus bbynr.'), crm_kunde_id
OPTIONS(description='CRM-interne ID des Kunden.'), crm_cidaas_id
OPTIONS(description='Meldet sich Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.'),
kampagnen_id
OPTIONS(description='ID der Kampagne, zu der der zugewiesene (in Kaulfand-Card und App) Kunden- Coupon,gehört.'),
kampagnen_version_nr
OPTIONS(description='Versionnummer der Kampagne, zu der der zugewiesene (in Kaufland-Card und App) Kunden- Coupon,gehört.'),
dat_update OPTIONS(description='Timestamp, wann der Datensatz im Quellsystem zuletzt aktualisiert wurde.'),
bonuskauf_quell_name
OPTIONS(description='Die Quelltabelle des Coupons und stellt die Art und Weise der Zuweisung der Coupons dar."CouponCustomersRelationsRecoStationary" -  Coupons die per AI den Kunden zugewiesen werden. "CouponCustomersRelationsMca"- Neue Art und Weise Coupons (verschiedene Arten) auf schnelle Weise im System den Kunden zuzuweisen.'))
OPTIONS(DESCRIPTION = `Die Tabelle beinhaltet nur Informationen über Kunden-Coupons Zuweisung. Im Vergleich zu Tabelle cos_bonuskauf_kunde_zu, die im Gegenteil enthält alle Transaktionsbewegungen eines Coupons: Aktivieren, deaktivieren, kaufen, einlösen, Zuweisungen etc.`)
AS SELECT mandant_id,
 bonuskauf_id,
 crm_kunde_id,
 crm_cidaas_id,
 kampagnen_id,
 kampagnen_version_nr,
 dat_update,
 bonuskauf_quell_name
FROM kfl_production_dbp_data.cos_bonuskauf_kunde_zuordnung;