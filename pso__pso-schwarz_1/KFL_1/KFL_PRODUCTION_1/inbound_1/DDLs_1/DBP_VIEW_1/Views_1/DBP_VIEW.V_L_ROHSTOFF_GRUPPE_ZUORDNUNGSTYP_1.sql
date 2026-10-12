CREATE OR REPLACE VIEW DBP_VIEW.V_L_ROHSTOFF_GRUPPE_ZUORDNUNGSTYP_1 (
   rohstoff_gruppe_zuordnungstyp_id         COMMENT 'ID der Zurodnungstyp zwischen Rohstoffgruppen.'
  ,rohstoff_gruppe_zuordnungstyp_bez        COMMENT 'Bezeichnung des Zuordnungstyps zwischen Rohstoffgruppen.'
)
COMMENT = 'Lookup Tabelle für Zurodnungstyp zwischen Rohstoffgruppen.(ZB: Zuordnung zwischen KFL Kategorie und KFL Subkategorie..)'
 AS 
    SELECT 
        rohstoff_gruppe_zuordnungstyp_id,
        rohstoff_gruppe_zuordnungstyp_bez

FROM DBP_DATA.L_ROHSTOFF_GRUPPE_ZUORDNUNGSTYP_1 ;