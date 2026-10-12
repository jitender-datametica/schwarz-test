CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_auftragskategorie_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), auftragskategorie_id
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2'))
OPTIONS(DESCRIPTION = `LIS - AUFTRAGSKATEGORIEKENNZEICHEN INSTANDHALTUNG - LOOKUP TABLE FOR TYPES OF SERVICE AND MAINTENANCE ORDERS FOR INDUSTRIAL EQUIPMENT AND PLANTS.`)
AS SELECT mandant_id,
 auftragskategorie_id
FROM kfl_production_dbp_data.in_l_auftragskategorie_2;