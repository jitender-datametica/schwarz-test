CREATE OR REPLACE VIEW DBP_VIEW.V_L_WERBEMITTEL_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,werbemittelkanal_id                      COMMENT 'Werbemittel Art_2 ID - medium through which the advertisement is shown (paper, digital)'
  ,werbemittel_id                           COMMENT 'Werbemittel - on what item_2 the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)'
  ,werbemittel_avq_prio_nr                  COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbemittel bei der Berechnung der Abverkaufsquote (AVQ). Werbemittel mit der gleichen ID werden zusammengefasst.'
)
COMMENT = 'Lookup-Tabelle für die Werbemittel, in denen die Werbung geschaltet wird (z.B. Online, Prospekt,...). Aus SAP P11. Die Tabelle enthält zudem Bezeichnungen zur Priorisierung der Abverkaufsquote (AVQ).'
 AS 
    SELECT 
        mandant_id,
        werbemittelkanal_id,
        werbemittel_id,
        werbemittel_avq_prio_nr

FROM DBP_DATA.L_WERBEMITTEL_2 ;