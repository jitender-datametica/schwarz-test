--==============================================================
-- Table: angebot_promotion_event_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_promotion_event_zu_1
   generated from Powerdesigner on Donnerstag, 27. Februar 2025 11:10:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANGEBOT_PROMOTION_EVENT_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   angebot_nr                          VARCHAR(50)      NOT NULL COMMENT 'Numerische oder Alphanumerische Nummer des Angebots',
   promotion_event_id                  INTEGER     NOT NULL COMMENT 'ID des Promotion Events.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANGEBOT_PROMOTION_EVENT_ZU PRIMARY KEY (mandant_id, promotion_event_id, angebot_nr) NOT ENFORCED
)  COMMENT = 'Beziehungstabelle zwischen dem Promotion Event und den Angeboten. Ein Angebot_1 kann einem oder mehreren Promotion Events zugeordnet sein. Ein Promotion Event besteht aus einem oder mehreren Angeboten.';
