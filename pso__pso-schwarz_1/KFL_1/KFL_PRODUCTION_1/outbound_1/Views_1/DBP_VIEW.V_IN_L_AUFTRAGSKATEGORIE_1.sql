CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_auftragskategorie_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), auftragskategorie_id
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'))
OPTIONS(DESCRIPTION = `LIS - AUFTRAGSKATEGORIEKENNZEICHEN INSTANDHALTUNG - LOOKUP TABLE FOR TYPES OF SERVICE AND MAINTENANCE ORDERS FOR INDUSTRIAL EQUIPMENT AND PLANTS.`)
AS SELECT mandant_id,
 auftragskategorie_id
FROM kfl_production_dbp_data.in_l_auftragskategorie_1;