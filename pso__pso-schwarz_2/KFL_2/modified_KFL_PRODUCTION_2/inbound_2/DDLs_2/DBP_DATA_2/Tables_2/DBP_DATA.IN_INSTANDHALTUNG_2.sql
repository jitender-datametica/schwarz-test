--==============================================================
-- Table: in_instandhaltung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_instandhaltung_2
   generated from Powerdesigner on Freitag, 31. Mai 2024 09:13:23
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_INSTANDHALTUNG_2 (
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   instandhaltung_leistungsart_id      VARCHAR(3)       NOT NULL COLLATE 'en-ci' DEFAULT '   ' COMMENT 'Instandhaltungs-Leistungsart aus dem Quellfeld ilart',
   in_kunde_id                         INTEGER     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   qual_meldung_id                     INTEGER     NOT NULL COMMENT 'ID der Qualitätsmeldung aus qmnum',
   tp_objekt_id                        INTEGER     COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2',
   auftragskategorie_id                INTEGER     COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2',
   wart_plan_id                        INTEGER     COMMENT 'Wartungsplan',
   wart_plan_abruf_id                  INTEGER     COMMENT 'Nummer des Wartungsplanabrufes',
   wart_plan_pos_id                    INTEGER     COMMENT 'Wartungsposition aus dem Wartungsplan',
   dat_bezug                           DATE             COMMENT 'Bezugsdatum des Instandhaltungsplan(IH)-Auftrages',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_INSTANDHALTUNG PRIMARY KEY (auftrag_id, mandant_id) NOT ENFORCED
)  COMMENT = 'LIS - Instandhaltung aus der Quelle SAP Industrie afih.
             Table IN_AUFTRAG_2 has ALL types of orders (header table) whereas IN_INSTANDHALTUNG_2 only contains additional information for orders regarding maintenance and  repair 
             A record in IN_ INSTANDHALTUNG always has a corresponding record in IN_AUFTRAG_2';
