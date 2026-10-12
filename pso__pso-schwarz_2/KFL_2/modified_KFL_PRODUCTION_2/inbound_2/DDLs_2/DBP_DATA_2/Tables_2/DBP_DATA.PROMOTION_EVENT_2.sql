--==============================================================
-- Table: promotion_event_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: promotion_event_2
   generated from Powerdesigner on Dienstag, 21. Januar 2025 17:13:56
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PROMOTION_EVENT_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   promotion_event_id                  INTEGER     NOT NULL COMMENT 'ID des Promotion Events.',
   dat_promotion_event_gueltig_von     DATE             NOT NULL COMMENT 'Datum, ab dem das Promotion Event gültig ist.',
   dat_promotion_event_gueltig_bis     DATE             NOT NULL COMMENT 'Datum, bis das Promotion Event gültig ist.',
   werbemittel_id                      INTEGER     NOT NULL COMMENT 'ID des Werbemittels',
   werbemittelkanal_id                 INTEGER     NOT NULL COMMENT 'ID des Werbemittelkanals',
   werbethema_id                       INTEGER     COMMENT 'ID des Werbethemas',
   werbeflaechenthema_cd               VARCHAR(50)      COMMENT 'Code des Werbeflaechenthemas',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PROMOTION_EVENT PRIMARY KEY (mandant_id, promotion_event_id) NOT ENFORCED
)  COMMENT = 'Tabelle enthält Stammdaten zum promotion event. Ein Promotion Event kann mehrere Angebote zu einer Werbung über einem Werbemittel zusammenfassen.';
