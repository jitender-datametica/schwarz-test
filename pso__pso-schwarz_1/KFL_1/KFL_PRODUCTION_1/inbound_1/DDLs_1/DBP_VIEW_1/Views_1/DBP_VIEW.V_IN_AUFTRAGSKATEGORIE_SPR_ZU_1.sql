CREATE OR REPLACE VIEW DBP_VIEW.V_IN_AUFTRAGSKATEGORIE_SPR_ZU_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,auftragskategorie_id                     COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'
  ,auftragskategorie_bez                    COMMENT 'Bezeichnung für Equipment in Großbuchstaben'
)
COMMENT = 'LIS - Auftragskategoriekennzeichen Instandhaltung - Translations table for types of service and maintenance orders for industrial equipment and plants.'
 AS 
    SELECT 
        mandant_id,
        spr_id,
        auftragskategorie_id,
        auftragskategorie_bez

FROM DBP_DATA.IN_AUFTRAGSKATEGORIE_SPR_ZU_1 ;