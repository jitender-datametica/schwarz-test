CREATE OR REPLACE VIEW DBP_VIEW.V_L_PLATZIERUNGSWG_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH.'
  ,platzierungswg_id                        COMMENT 'Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.'
  ,platzierungswg_nr                        COMMENT 'Platzierungswarengruppe - nicht-numerischer Schlüssel aus dem Quellsystem.'
  ,primaere_platzierungswg_nr               COMMENT 'Nummer der primären Platzierungswarengruppe. Die primäre_1 Platzierungswarengruppe gruppiert mehrere Platzierungswarengruppen für eine_1 gemeinsame Betrachtung des Mengengerüsts.'
  ,mgg_gruppe_id                            COMMENT 'ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.'
  ,sok_kategorie_id                         COMMENT 'ID der SOK Kategorie. Fasst mehrere primäre_1 Platzierungswarengruppen zu einer übergeordneten Berichtshierarchie-Ebene zusammen.'
  ,primaere_relevant_fg                     COMMENT 'Der Abweichungsgrad MGG Mengengerüst wird nur für definierte Bereiche ermittelt. Relevant_fg = 1 bedeutet, dass diese primäre_1 Platzierungswarengruppe dafür benötigt wird. Wird manuell gepflegt (VIS SOK).'
)
COMMENT = 'TP2_AIS - WPL - WaSA Platzierungswarengruppen.'
 AS 
    SELECT 
        mandant_id,
        platzierungswg_id,
        platzierungswg_nr,
        primaere_platzierungswg_nr,
        mgg_gruppe_id,
        sok_kategorie_id,
        primaere_relevant_fg

FROM DBP_DATA.L_PLATZIERUNGSWG_1 ;