--==============================================================
-- Table: ts_nfmd_article_article_cluster_rel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_article_article_cluster_rel
   generated from Powerdesigner on Donnerstag, 24. März 2022 15:33:41
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_ARTICLE_CLUSTER_REL (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   aktion_id                           VARCHAR(10)     NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   article_cluster_id                  INTEGER    NOT NULL COMMENT 'ausgewaehltes Artikelcluster ID - Pflege uebers Frontend',
   kjwo_ww                             INTEGER    COMMENT 'Calendar year-week when the promotion campaign started. Format JJJJWW',
   dwh_created_tmsp                    TIMESTAMP_NTZ   COMMENT 'timestamp when the record was created',
   user_id                             VARCHAR(255)    COMMENT 'AD name of the user who created the comment',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_ARTICLE_ARTICLE_CLUSTER_REL PRIMARY KEY (mandant_id, aktion_id, art_id, article_cluster_id) NOT ENFORCED
)  COMMENT = 'Relattionship between articles and article clusters and promotion campaigns';
