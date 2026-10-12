--==============================================================
-- Table: pmr_angebot_beschreibung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: pmr_angebot_beschreibung_2
   generated from Powerdesigner on Donnerstag, 8. Dezember 2022 09:49:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pmr_angebot_beschreibung_2 (
angebot_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ein Angebot_2 (angebot_id; offer_id in einigen anderen Tabellen) ist Teil einer Werbeaktion / Promotion (aktion_id). Eine_2 Promotion hat ein oder mehrere Angebote. Ein Angebot_2 umfasst ein Produktset, das aus einem oder mehreren einzelnen Verkaufsartikeln besteht. Ein Produktset ist keine Ad-hoc-Kombination, sondern ein definiertes Set von Artikeln mit einem übergeordneten Artikel_2 (Mutterartikel, Werbemutter). Beispielsweise könnte es eine_2 Aktion_2 geben für alle Maggi-Fix-Bio-Produkte in einem Angebot_2 und alle Maggi-Fix-Produkte ohne Bio in einem zweiten Angebot.'),
angebot_beschreibung STRING(255)
OPTIONS(description='Angebotsbeschreibung, ein Freitextfeld das von einem Mitarbeiter gefüllt wird und keine allgemein definierte Struktur hat. Es können verschiedene Informationen abgelegt sein, wie z.B. Aktions- oder Angebotsbezeichnungen, Rabatt in Prozent, Artikel_2-IDs, etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (angebot_id) NOT ENFORCED
)
OPTIONS(description='SCM - This table contains offer descriptions.             An offer (angebot_id; offer_id in some other tables) is part of a promotion (aktion_id). A promotion has one or more offers. An offer includes one product set which can have one or more individual sales_2 items. A product set is not an ad-hoc combination but a defined set of items with a parent article (Mutterartikel, Werbemutter). For example, the promotion is for Maggi Fix with one offer for Maggi Fix Bio and a second offer for Maggi Fix excluding Bio because the latter are in a separate set. They would also have different parents.             Offer descriptions are free text fields filled by employees and do not have a pre-defined strucure. They can contain several information pieces, i.e., promotion or offer names, price reduction percent, article IDs, etc.');