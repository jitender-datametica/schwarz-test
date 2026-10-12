CREATE OR REPLACE VIEW DBP_VIEW.V_IN_INSTANDHALTUNG_2 (
   auftrag_id                               COMMENT 'Auftragsnummer aus aufnr'
  ,mandant_id                               COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen'
  ,instandhaltung_leistungsart_id           COMMENT 'Instandhaltungs-Leistungsart aus dem Quellfeld ilart'
  ,in_kunde_id                              COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP'
  ,qual_meldung_id                          COMMENT 'ID der Qualitätsmeldung aus qmnum'
  ,tp_objekt_id                             COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2'
  ,auftragskategorie_id                     COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2'
  ,wart_plan_id                             COMMENT 'Wartungsplan'
  ,wart_plan_abruf_id                       COMMENT 'Nummer des Wartungsplanabrufes'
  ,wart_plan_pos_id                         COMMENT 'Wartungsposition aus dem Wartungsplan'
  ,dat_bezug                                COMMENT 'Bezugsdatum des Instandhaltungsplan(IH)-Auftrages'
)
COMMENT = 'LIS - Instandhaltung aus der Quelle SAP Industrie afih.
Table IN_AUFTRAG_2 has ALL types of orders (header table) whereas IN_INSTANDHALTUNG_2 only contains additional information for orders regarding maintenance and  repair 
A record in IN_ INSTANDHALTUNG always has a corresponding record in IN_AUFTRAG_2'
 AS 
    SELECT 
        auftrag_id,
        mandant_id,
        instandhaltung_leistungsart_id,
        in_kunde_id,
        qual_meldung_id,
        tp_objekt_id,
        auftragskategorie_id,
        wart_plan_id,
        wart_plan_abruf_id,
        wart_plan_pos_id,
        dat_bezug

FROM DBP_DATA.IN_INSTANDHALTUNG_2 ;