CREATE OR REPLACE VIEW DBP_VIEW.V_L_ROHSTOFF_GRUPPE_TYP_1 (
   rohstoff_gruppe_typ_id                   COMMENT 'ID des Gruppierungstyps eines Rohstoffs.'
  ,rohstoff_gruppe_typ_bez                  COMMENT 'Bezeichnung des Gruppierungstyps eines Rohstoffs.'
)
COMMENT = 'Lookup Tabelle für Gruppierungstyp eines Rohstoffs - KFL Kategorie, KFL Subkategorie, MINTEC Kategorie, MINTEC Subkategorie'
 AS 
    SELECT 
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_typ_bez

FROM DBP_DATA.L_ROHSTOFF_GRUPPE_TYP_1 ;