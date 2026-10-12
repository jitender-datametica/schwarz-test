--==============================================================
-- Table: flw_besch_faktura
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_besch_faktura
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_BESCH_FAKTURA (
   faktura_beleg_id                    NUMBER(18,0)     NOT NULL COMMENT 'Faktura Belegnummer aus vbeln',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   dat_faktura                         DATE             NOT NULL COMMENT 'Fakturadatum aus SAP fkdat',
   dat_erstellung                      DATE             NOT NULL COMMENT 'Erstellungsdatum aus erdat',
   fakturaart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Fakturaart aus fkart',
   flw_vw_id                           NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebswegs aus vtweg',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   flw_kunde_id                        NUMBER(38,0)     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   faktura_status_kz                   VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT '0' COMMENT 'Buchhaltungsstatus des Fakturabelegs aus der SAP Quelle VBRK.RFBSK (z.B.  E, D, A, B, C ; Defaultwert 0)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_BESCH_FAKTURA PRIMARY KEY (faktura_beleg_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Fakturabelege Kopfdaten aus der SAP-Tabelle vbrk';

