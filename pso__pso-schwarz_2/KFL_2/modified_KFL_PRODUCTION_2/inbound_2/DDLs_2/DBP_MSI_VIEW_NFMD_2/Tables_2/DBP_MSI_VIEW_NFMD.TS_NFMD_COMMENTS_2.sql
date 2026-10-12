--==============================================================
-- Table: ts_nfmd_comments_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_comments_2
   generated from Powerdesigner on Dienstag, 26. April 2022 19:53:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_COMMENTS_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   aktion_id                           VARCHAR(10)     NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   kjwo_ww                             INTEGER    COMMENT 'Calendar_2 year-week when the promotion campaign started. Format JJJJWW',
   user_id                             VARCHAR(255)    COMMENT 'AD name of the user who created the record',
   comment_txt                         VARCHAR(255)    COMMENT 'text of the comment',
   dwh_created_tmsp                    TIMESTAMP_NTZ   COMMENT 'timestamp when the record was created',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_COMMENTS PRIMARY KEY (mandant_id, aktion_id, art_id) NOT ENFORCED
)  COMMENT = 'The comments on  the utilization decision are stored in this table (per combination of  Article  and  PromotionCampaign) . 
             The comments can be created both in the first step of the exploitation decision and in the second step of the Markdown decision.';
