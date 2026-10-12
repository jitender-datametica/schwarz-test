CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_instandhaltung_1 (auftrag_id
OPTIONS(description='Auftragsnummer aus aufnr'), mandant_id
OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'), instandhaltung_leistungsart_id
OPTIONS(description='Instandhaltungs-Leistungsart aus dem Quellfeld ilart'), in_kunde_id
OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'), qual_meldung_id
OPTIONS(description='ID der Qualitätsmeldung aus qmnum'), tp_objekt_id
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'), auftragskategorie_id
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'), wart_plan_id
OPTIONS(description='Wartungsplan'), wart_plan_abruf_id OPTIONS(description='Nummer des Wartungsplanabrufes'),
wart_plan_pos_id OPTIONS(description='Wartungsposition aus dem Wartungsplan'), dat_bezug
OPTIONS(description='Bezugsdatum des Instandhaltungsplan(IH)-Auftrages'))
OPTIONS(DESCRIPTION = `LIS - INSTANDHALTUNG AUS DER QUELLE SAP INDUSTRIE AFIH.TABLE IN_AUFTRAG_1 HAS ALL TYPES OF ORDERS (HEADER TABLE) WHEREAS IN_INSTANDHALTUNG_1 ONLY CONTAINS ADDITIONAL INFORMATION FOR ORDERS REGARDING MAINTENANCE AND  REPAIR A RECORD IN IN_ INSTANDHALTUNG ALWAYS HAS A CORRESPONDING RECORD IN IN_AUFTRAG_1`)
AS SELECT auftrag_id,
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
FROM kfl_production_dbp_data.in_instandhaltung_1;