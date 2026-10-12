CREATE OR REPLACE VIEW DBP_VIEW.V_IN_L_AUFTRAGSKATEGORIE_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,auftragskategorie_id                     COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'
)
COMMENT = 'LIS - Auftragskategoriekennzeichen Instandhaltung - Lookup table for types of service and maintenance orders for industrial equipment and plants.'
 AS 
    SELECT 
        mandant_id,
        auftragskategorie_id

FROM DBP_DATA.IN_L_AUFTRAGSKATEGORIE_1;