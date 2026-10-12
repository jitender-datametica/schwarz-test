CREATE OR REPLACE VIEW DBP_VIEW.V_IN_L_AUFTRAGSKATEGORIE_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,auftragskategorie_id                     COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2'
)
COMMENT = 'LIS - Auftragskategoriekennzeichen Instandhaltung - Lookup table for types of service and maintenance orders for industrial equipment and plants.'
 AS 
    SELECT 
        mandant_id,
        auftragskategorie_id

FROM DBP_DATA.IN_L_AUFTRAGSKATEGORIE_2;