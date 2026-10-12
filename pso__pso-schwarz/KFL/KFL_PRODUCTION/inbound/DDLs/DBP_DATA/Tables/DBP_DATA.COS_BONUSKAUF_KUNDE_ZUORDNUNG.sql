--==============================================================
-- Table: cos_bonuskauf_kunde_zuordnung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuskauf_kunde_zuordnung
   generated from Powerdesigner on Montag, 27. Oktober 2025 13:36:35
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COS_BONUSKAUF_KUNDE_ZUORDNUNG (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Land des Kundenwohnorts,(Mandant im DWH).',
   bonuskauf_id                        VARCHAR(20)      NOT NULL COMMENT 'Eindeutige ID einer Bonuskaufaktion z.Bsp. 700, aus bbynr.',
   crm_kunde_id                        VARCHAR(144)     NOT NULL COMMENT 'CRM-interne ID des Kunden.',
   crm_cidaas_id                       VARCHAR(120)     NOT NULL DEFAULT '-9999' COMMENT 'Meldet sich Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.',
   kampagnen_id                        VARCHAR(120)      COMMENT 'ID der Kampagne, zu der der zugewiesene (in Kaulfand-Card und App) Kunden- Coupon,gehört.',
   kampagnen_version_nr                NUMBER(38,0)     COMMENT 'Versionnummer der Kampagne, zu der der zugewiesene (in Kaufland-Card und App) Kunden- Coupon,gehört.',
   dat_update                          TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp, wann der Datensatz im Quellsystem zuletzt aktualisiert wurde.',
   bonuskauf_quell_name                VARCHAR(50)      NOT NULL COMMENT 'Die Quelltabelle des Coupons und stellt die Art und Weise der Zuweisung der Coupons dar.
            "CouponCustomersRelationsRecoStationary" -  Coupons die per AI den Kunden zugewiesen werden. 
            "CouponCustomersRelationsMca"- Neue Art und Weise Coupons (verschiedene Arten) auf schnelle Weise im System den Kunden zuzuweisen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COS_BONUSKAUF_KUNDE_ZUORDNUNG PRIMARY KEY (mandant_id, bonuskauf_id, crm_kunde_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle beinhaltet nur Informationen über Kunden-Coupons Zuweisung. Im Vergleich zu Tabelle cos_bonuskauf_kunde_zu, die im Gegenteil enthält alle Transaktionsbewegungen eines Coupons: Aktivieren, deaktivieren, kaufen, einlösen, Zuweisungen etc.';
