CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_auftragskategorie_spr_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), spr_id OPTIONS(description='ID der Sprache'), auftragskategorie_id
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2'), auftragskategorie_bez
OPTIONS(description='Bezeichnung für Equipment in Großbuchstaben'))
OPTIONS(DESCRIPTION = `LIS - AUFTRAGSKATEGORIEKENNZEICHEN INSTANDHALTUNG - TRANSLATIONS TABLE FOR TYPES OF SERVICE AND MAINTENANCE ORDERS FOR INDUSTRIAL EQUIPMENT AND PLANTS.`)
AS SELECT mandant_id,
 spr_id,
 auftragskategorie_id,
 auftragskategorie_bez
FROM kfl_production_dbp_data.in_auftragskategorie_spr_zu_2;