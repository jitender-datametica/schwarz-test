CREATE OR REPLACE VIEW DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZUORDNUNG_1 (
   mandant_id                               COMMENT 'Land_1 des Kundenwohnorts,(Mandant_1 im DWH).'
  ,bonuskauf_id                             COMMENT 'Eindeutige ID einer Bonuskaufaktion z.Bsp. 700, aus bbynr.'
  ,crm_kunde_id                             COMMENT 'CRM-interne ID des Kunden.'
  ,crm_cidaas_id                            COMMENT 'Meldet sich Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.'
  ,kampagnen_id                             COMMENT 'ID der Kampagne_1, zu der der zugewiesene (in Kaulfand-Card und App) Kunden- Coupon,gehört.'
  ,kampagnen_version_nr                     COMMENT 'Versionnummer der Kampagne_1, zu der der zugewiesene (in Kaufland-Card und App) Kunden- Coupon,gehört.'
  ,dat_update                               COMMENT 'Timestamp, wann der Datensatz im Quellsystem zuletzt aktualisiert wurde.'
  ,bonuskauf_quell_name                     COMMENT 'Die Quelltabelle des Coupons und stellt die Art_1 und Weise der Zuweisung der Coupons dar.
"CouponCustomersRelationsRecoStationary" -  Coupons die per AI den Kunden zugewiesen werden. 
"CouponCustomersRelationsMca"- Neue Art_1 und Weise Coupons (verschiedene Arten) auf schnelle Weise im System den Kunden zuzuweisen.'
)
COMMENT = 'Die Tabelle beinhaltet nur Informationen über Kunden-Coupons Zuweisung. Im Vergleich zu Tabelle cos_bonuskauf_kunde_zu_1, die im Gegenteil enthält alle Transaktionsbewegungen eines Coupons: Aktivieren, deaktivieren, kaufen, einlösen, Zuweisungen etc.'
 AS 
    SELECT 
        mandant_id,
        bonuskauf_id,
        crm_kunde_id,
        crm_cidaas_id,
        kampagnen_id,
        kampagnen_version_nr,
        dat_update,
        bonuskauf_quell_name

FROM DBP_DATA.COS_BONUSKAUF_KUNDE_ZUORDNUNG_1 ;