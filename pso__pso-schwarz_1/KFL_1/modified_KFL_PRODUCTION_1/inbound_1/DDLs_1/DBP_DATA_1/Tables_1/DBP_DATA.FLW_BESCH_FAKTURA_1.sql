--==============================================================
-- Table: flw_besch_faktura_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_besch_faktura_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_BESCH_FAKTURA_1 (
   faktura_beleg_id                    INTEGER     NOT NULL COMMENT 'Faktura Belegnummer aus vbeln',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   dat_faktura                         DATE             NOT NULL COMMENT 'Fakturadatum aus SAP fkdat',
   dat_erstellung                      DATE             NOT NULL COMMENT 'Erstellungsdatum aus erdat',
   fakturaart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Fakturaart aus fkart',
   flw_vw_id                           INTEGER     NOT NULL COMMENT 'ID des Vertriebswegs aus vtweg',
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   flw_kunde_id                        INTEGER     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   faktura_status_kz                   VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT '0' COMMENT 'Buchhaltungsstatus des Fakturabelegs aus der SAP Quelle VBRK.RFBSK (z.B.  E, D, A, B, C ; Defaultwert 0)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_BESCH_FAKTURA PRIMARY KEY (faktura_beleg_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Fakturabelege Kopfdaten aus der SAP-Tabelle vbrk';

