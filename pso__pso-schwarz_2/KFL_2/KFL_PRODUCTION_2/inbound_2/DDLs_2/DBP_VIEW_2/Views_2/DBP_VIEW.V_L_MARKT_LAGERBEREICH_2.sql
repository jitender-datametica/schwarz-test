CREATE OR REPLACE VIEW DBP_VIEW.V_L_MARKT_LAGERBEREICH_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,markt_lagerbereich_id                    COMMENT 'Lagerbereich ID in der Filiale.'
)
COMMENT = 'Lookup-Tabelle für die Lagerbereichen in der Filiale. Wird manuell beladen. Z.B. 1=Nährmittel; 2=Konserven/Essig/Öl; usw.'
 AS 
    SELECT 
        mandant_id,
        markt_lagerbereich_id

FROM DBP_DATA.L_MARKT_LAGERBEREICH_2 ;