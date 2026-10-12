--==============================================================
-- Table: pmr_angebot_beschreibung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: pmr_angebot_beschreibung
   generated from Powerdesigner on Donnerstag, 8. Dezember 2022 09:49:07
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PMR_ANGEBOT_BESCHREIBUNG (
   angebot_id                          NUMBER(38,0)    NOT NULL COMMENT 'Ein Angebot (angebot_id; offer_id in einigen anderen Tabellen) ist Teil einer Werbeaktion / Promotion (aktion_id). Eine Promotion hat ein oder mehrere Angebote. Ein Angebot umfasst ein Produktset, das aus einem oder mehreren einzelnen Verkaufsartikeln besteht. Ein Produktset ist keine Ad-hoc-Kombination, sondern ein definiertes Set von Artikeln mit einem übergeordneten Artikel (Mutterartikel, Werbemutter). Beispielsweise könnte es eine Aktion geben für alle Maggi-Fix-Bio-Produkte in einem Angebot und alle Maggi-Fix-Produkte ohne Bio in einem zweiten Angebot.',
   angebot_beschreibung                VARCHAR(255)    COMMENT 'Angebotsbeschreibung, ein Freitextfeld das von einem Mitarbeiter gefüllt wird und keine allgemein definierte Struktur hat. Es können verschiedene Informationen abgelegt sein, wie z.B. Aktions- oder Angebotsbezeichnungen, Rabatt in Prozent, Artikel-IDs, etc.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PMR_ANGEBOT_BESCHREIBUNG PRIMARY KEY (angebot_id) NOT ENFORCED
)  COMMENT = 'SCM - This table contains offer descriptions.
             An offer (angebot_id; offer_id in some other tables) is part of a promotion (aktion_id). A promotion has one or more offers. An offer includes one product set which can have one or more individual sales items. A product set is not an ad-hoc combination but a defined set of items with a parent article (Mutterartikel, Werbemutter). For example, the promotion is for Maggi Fix with one offer for Maggi Fix Bio and a second offer for Maggi Fix excluding Bio because the latter are in a separate set. They would also have different parents.
             Offer descriptions are free text fields filled by employees and do not have a pre-defined strucure. They can contain several information pieces, i.e., promotion or offer names, price reduction percent, article IDs, etc.';
