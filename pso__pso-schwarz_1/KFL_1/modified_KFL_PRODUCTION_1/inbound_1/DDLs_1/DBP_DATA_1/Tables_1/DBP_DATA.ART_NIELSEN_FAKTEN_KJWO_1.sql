--==============================================================
-- Table: art_nielsen_fakten_kjwo_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_fakten_kjwo_1
   generated from Powerdesigner on Donnerstag, 15. September 2022 14:51:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_NIELSEN_FAKTEN_KJWO_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   kjwo                                INTEGER    NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   nielsen_market_id                   INTEGER    NOT NULL COMMENT 'ID des "markets_1" (wird im DWH vergeben abgeleitet aus Nielsen (markets.tag_1))',
   art_nielsen_id                      INTEGER    NOT NULL COMMENT 'Artikel_1-ID aus Nielsen',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   umsatz_brutto                       NUMBER(29,4)    COMMENT 'Bruttoumsatz aus Nielsen',
   umsatz_brutto_af                    NUMBER(29,4)    COMMENT 'Bruttoumsatz aktionsfrei aus Nielsen',
   umsatz_brutto_sa                    NUMBER(29,4)    COMMENT 'Bruttoumsatz Sonderaktion aus Nielsen',
   menge                               NUMBER(29,3)    COMMENT 'Menge aus Nielsen',
   menge_af                            NUMBER(29,3)    COMMENT 'Menge aktionsfrei aus Nielsen',
   menge_sa                            NUMBER(29,3)    COMMENT 'Menge Sonderaktion aus Nielsen',
   distr_num                           NUMBER(29,4)    COMMENT 'Numerische Distribution.',
   distr_gew                           NUMBER(29,4)    COMMENT 'Gewichtete Distribution.',
   anz_maerkte                         INTEGER    COMMENT 'Anzahl der Märkte im Marktsegment',
   distr_num_4_wo                      NUMBER(29,4)    COMMENT 'Numerische Distribution gerechnet auf 4 Wochen (genauer als wöchentlich bei Langsamdrehern).',
   distr_gew_4_wo                      NUMBER(29,4)    COMMENT 'Gewichtete Distribution gerechnet auf 4 Wochen (genauer als wöchentlich bei Langsamdrehern).',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_NIELSEN_FAKTEN_KJWO PRIMARY KEY (mandant_id, kjwo, nielsen_market_id, art_nielsen_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Sortimentstool - Integration der Rohdaten aus Nielsen zur Nachvollziehbarkeit auf Wochenbasis - aufgrund der Datenquellenbeschaffenheit keine ETL-Lösung möglich, um Daten integriert im Core-DWH abzulegen - keine Integritätsgarantie.';
