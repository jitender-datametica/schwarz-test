--==============================================================
-- Table: kampagne_kunde_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_kunde_1
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_KUNDE_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH.',
   kampagne_kunde_id                   VARCHAR(100)     NOT NULL COMMENT 'Vom Quellsystem generierte ID des Kunden (GUID). Es ist der Empfänger der von Kampagnen gesendeten Nachrichten.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_KUNDE PRIMARY KEY (mandant_id, kampagne_kunde_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält die Nutzer, bzw. Kunden, an die im Zuge von Marketingkampagnen Nachrichten geschickt werden. Sie dient dazu, die Empfänger von verschiedenen Kommunikationspunkten wie E-Mails, Push-Benachrichtigungen und SMS zu definieren und zu verwalten.';
