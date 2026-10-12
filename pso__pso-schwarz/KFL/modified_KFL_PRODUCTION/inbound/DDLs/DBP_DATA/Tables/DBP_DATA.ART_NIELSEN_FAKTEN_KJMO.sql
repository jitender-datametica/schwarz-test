--==============================================================
-- Table: art_nielsen_fakten_kjmo
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_fakten_kjmo
   generated from Powerdesigner on Donnerstag, 15. September 2022 14:51:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_NIELSEN_FAKTEN_KJMO (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   kjmo                                INTEGER    NOT NULL COMMENT 'Monat eines Kalenderjahres, Format JJJJMM',
   nielsen_market_id                   INTEGER    NOT NULL COMMENT 'ID des "markets" (wird im DWH vergeben abgeleitet aus Nielsen (markets.tag))',
   art_nielsen_id                      INTEGER    NOT NULL COMMENT 'Artikel-ID aus Nielsen',
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
   menge_verkaufseinheiten_normiert    NUMBER(29,4)    COMMENT 'Aberverkaufsmenge Nielsen normiert auf angegebene Einheit.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_NIELSEN_FAKTEN_KJMO PRIMARY KEY (mandant_id, kjmo, nielsen_market_id, art_nielsen_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Sortimentstool - Integration der Rohdaten aus Nielsen zur Nachvollziehbarkeit auf Monatsbasis - aufgrund der Datenquellenbeschaffenheit keine ETL-Lösung möglich, um Daten integriert im Core-DWH abzulegen - keine Integritätsgarantie.
             Für Kroatien kommen Daten in Wochen statt im Monat, weshalb der PK nicht stimmt und es mehrere Zeilen pro mandant_id = 6, kjmo, nielsen_market_id und art_nielsen_id gibt. Dieser Sachverhalt wird für die weitere Aggregation zu tupel_mat(_quarantaene) berücksichtigt und dementsprechend kalkuliert.';
