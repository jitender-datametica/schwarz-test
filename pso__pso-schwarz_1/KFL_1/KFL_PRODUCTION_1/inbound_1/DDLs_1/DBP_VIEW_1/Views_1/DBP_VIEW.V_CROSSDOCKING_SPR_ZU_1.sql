CREATE OR REPLACE VIEW DBP_VIEW.V_CROSSDOCKING_SPR_ZU_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH.'
  ,crossdocking_id                          COMMENT 'ID des Umschlagplatzs bzw. Cross Docking Orts.'
  ,spr_id                                   COMMENT 'ID der Sprache. Referenz zu der Tabelle spr.'
  ,crossdocking_bez                         COMMENT 'Sprachabhängig Kurzbezeichnung des Umschlagplatzs bzw. Cross-Docking-Orts. Bsp "Wien Plattform" -  Lieferanten im Frische Bereich liefert an die Wien Plattform. Diese verteilt die Lieferung auf die Länder (VZ/Märkte). Weitere Cross Docking Orte sind noch nicht bekannt.(Stand: 24.03.2025)'
)
COMMENT = 'Sprachabhängige Bezeichnungen des Cross Docking Orts.'
 AS 
    SELECT 
        mandant_id,
        crossdocking_id,
        spr_id,
        crossdocking_bez

FROM DBP_DATA.CROSSDOCKING_SPR_ZU_1 ;