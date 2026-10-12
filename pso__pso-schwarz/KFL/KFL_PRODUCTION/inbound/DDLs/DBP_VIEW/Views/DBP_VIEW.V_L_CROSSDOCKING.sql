CREATE OR REPLACE VIEW DBP_VIEW.V_L_CROSSDOCKING (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,crossdocking_id                          COMMENT 'ID des Umschlagplatzs bzw. Cross Docking Orts.'
)
COMMENT = 'Lookuptabelle für den Kaufland definierten Umschlagplatz bzw. Cross-Docking-Ort,an den die Waren zuerst vom Lieferanten versendet werden. Am Cross-Docking-Ort erfolgt dann die Verteilung auf die Länder (VZ/Märkte).'
 AS 
    SELECT 
        mandant_id,
        crossdocking_id

FROM DBP_DATA.L_CROSSDOCKING ;