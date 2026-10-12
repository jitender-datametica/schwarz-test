CREATE OR REPLACE VIEW DBP_VIEW.V_ROHSTOFF_GRUPPE_1 (
   rohstoff_gruppe_typ_id                   COMMENT 'ID des Gruppierungstyps eines Rohstoffs.'
  ,rohstoff_gruppe_name                     COMMENT 'Name der Gruppe_1 eines Rohstoffs nach Gruppierungstyp.'
  ,rohstoff_gruppe_kurz_name                COMMENT 'Abkürzung der Rohstoffsgruppe name.'
)
COMMENT = 'Gruppe_1 eines Rohstoffs nach Gruppierungstyp.'
 AS 
    SELECT 
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name,
        rohstoff_gruppe_kurz_name

FROM DBP_DATA.ROHSTOFF_GRUPPE_1 ;