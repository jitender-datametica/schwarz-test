CREATE OR REPLACE VIEW DBP_VIEW.V_L_WERBEFLAECHENABSCHNITT_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,werbeflaechenabschnitt_id                COMMENT 'ID des Werbeflächenabschnitts'
  ,werbeflaechenabschnitt_avq_prio_nr       COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenabschnitte bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenabschnitte mit der gleichen ID werden zusammengefasst.'
)
COMMENT = 'Lookup-Tabelle für den Werbeflächenabschnitt. Aus ZPMR_WBM_ABSBEZ(SAP P11). Enthält sowohl die Werbeflächenabschnitts-Bezeichnungen aus SAP, als auch die Bezeichnungen zur Priorisierung der Abverkaufsquote (AVQ).
Der Werbeflächenabschnitt gibt an, in welchem Abschnitt eines Bereichs das Angebot_2 abgebildet ist (z.B. TOPLEFT1 = oben links auf der Seite im Prospekt).'
 AS 
    SELECT 
        mandant_id,
        werbeflaechenabschnitt_id,
        werbeflaechenabschnitt_avq_prio_nr

FROM DBP_DATA.L_WERBEFLAECHENABSCHNITT_2 ;