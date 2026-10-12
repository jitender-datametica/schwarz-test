--==============================================================
-- Table: angebot_werbemittel_promotion_event_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_werbemittel_promotion_event_zu_1
   generated from Powerdesigner on Donnerstag, 20. März 2025 17:37:49
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANGEBOT_WERBEMITTEL_PROMOTION_EVENT_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   angebot_nr                          VARCHAR(50)      NOT NULL COMMENT 'Numerische oder Alphanumerische Nummer des Angebots',
   werbemittel_id                      INTEGER     NOT NULL COMMENT 'ID des Werbemittels',
   werbemittelkanal_id                 INTEGER     NOT NULL COMMENT 'ID des Werbemittelkanals',
   promotion_event_id                  INTEGER     NOT NULL COMMENT 'ID des Promotion Events.',
   werbeflaechenabschnitt_name         VARCHAR(100)     NOT NULL COMMENT 'Name des Werbeflaechenabschnitts.',
   werbemittel_bez                     VARCHAR(200)     COMMENT 'Bezeichnung des Werbemittels',
   werbemittelkanal_bez                VARCHAR(200)     COMMENT 'Bezeichnung des Werbemittelkanals.',
   werbethema_id                       INTEGER     COMMENT 'ID des Werbethemas',
   werbethema_bez                      VARCHAR(200)     NOT NULL COMMENT 'Bezeichnung des Werbethemas',
   werbeflaechenthema_cd               VARCHAR(50)      COMMENT 'Code des Werbeflaechenthemas',
   werbeflaechenthema_bez              VARCHAR(200)     NOT NULL COMMENT 'Bezeichnung des Werbeflaechenthemas',
   werbeposition_nr                    INTEGER     COMMENT 'Nummer der Position des Angebots innerhalb des Werbeflachenabschnitts.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANGEBOT_WERBEMITTEL_PROMOTION_EVENT_ZU PRIMARY KEY (mandant_id, angebot_nr, werbemittel_id, werbemittelkanal_id, promotion_event_id, werbeflaechenabschnitt_name) NOT ENFORCED
)  COMMENT = 'Zuordnungstabelle zwischen einem Angebot_1, dem Werbemittel und Event. Beinhaltet Informationen wo Angebote eines Events beworben werden. Die Tabelle wird zusätzlich zur promotion event Tabelle benötigt, da es auch Angebote ohne Event geben kann, die Informationen zum Werbemittel, Werbethema, etc. beinhalten. ';
