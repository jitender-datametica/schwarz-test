--==============================================================
-- Table: ts_nfmd_proposed_decision_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_proposed_decision_2
   generated from Powerdesigner on Donnerstag, 24. März 2022 15:20:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_PROPOSED_DECISION_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   aktion_id                           VARCHAR(10)     NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
   art_id                              NUMBER(38,0)    NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   kjwo_ww                             NUMBER(38,0)    COMMENT 'Calendar_2 year-week when the promotion campaign started. Format JJJJWW',
   dwh_created_tmsp                    TIMESTAMP_NTZ   COMMENT 'timestamp when the record was created',
   user_id                             VARCHAR(255)    COMMENT 'AD name of the user who created the record',
   markdown_decision_id                NUMBER(38,0)    COMMENT 'Utilization decision ID - maintained via the frontend',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_PROPOSED_DECISION PRIMARY KEY (mandant_id, aktion_id, art_id) NOT ENFORCED
)  COMMENT = 'The proposal of decision for reduction of price is set for each combination of Article and PromotionCampaign in this table - populated by Frontend';
