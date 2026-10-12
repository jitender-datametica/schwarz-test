--==============================================================
-- Table: art_nielsen_fakten_kjmo_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_fakten_kjmo_2
   generated from Powerdesigner on Donnerstag, 15. September 2022 14:51:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_NIELSEN_FAKTEN_KJMO_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   kjmo                                NUMBER(38,0)    NOT NULL COMMENT 'Monat_2 eines Kalenderjahres, Format JJJJMM',
   nielsen_market_id                   NUMBER(38,0)    NOT NULL COMMENT 'ID des "markets_2" (wird im DWH vergeben abgeleitet aus Nielsen (markets.tag_2))',
   art_nielsen_id                      NUMBER(38,0)    NOT NULL COMMENT 'Artikel_2-ID aus Nielsen',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   umsatz_brutto                       NUMBER(18,4)    COMMENT 'Bruttoumsatz aus Nielsen',
   umsatz_brutto_af                    NUMBER(18,4)    COMMENT 'Bruttoumsatz aktionsfrei aus Nielsen',
   umsatz_brutto_sa                    NUMBER(18,4)    COMMENT 'Bruttoumsatz Sonderaktion aus Nielsen',
   menge                               NUMBER(18,3)    COMMENT 'Menge aus Nielsen',
   menge_af                            NUMBER(18,3)    COMMENT 'Menge aktionsfrei aus Nielsen',
   menge_sa                            NUMBER(18,3)    COMMENT 'Menge Sonderaktion aus Nielsen',
   distr_num                           NUMBER(18,4)    COMMENT 'Numerische Distribution.',
   distr_gew                           NUMBER(18,4)    COMMENT 'Gewichtete Distribution.',
   anz_maerkte                         NUMBER(38,0)    COMMENT 'Anzahl der Märkte im Marktsegment',
   menge_verkaufseinheiten_normiert    NUMBER(38,4)    COMMENT 'Aberverkaufsmenge Nielsen normiert auf angegebene Einheit.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_NIELSEN_FAKTEN_KJMO PRIMARY KEY (mandant_id, kjmo, nielsen_market_id, art_nielsen_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Sortimentstool - Integration der Rohdaten aus Nielsen zur Nachvollziehbarkeit auf Monatsbasis - aufgrund der Datenquellenbeschaffenheit keine ETL-Lösung möglich, um Daten integriert im Core-DWH abzulegen - keine Integritätsgarantie.
             Für Kroatien kommen Daten in Wochen statt im Monat_2, weshalb der PK nicht stimmt und es mehrere Zeilen pro mandant_id = 6, kjmo, nielsen_market_id und art_nielsen_id gibt. Dieser Sachverhalt wird für die weitere Aggregation zu tupel_mat_2(_quarantaene) berücksichtigt und dementsprechend kalkuliert.';
