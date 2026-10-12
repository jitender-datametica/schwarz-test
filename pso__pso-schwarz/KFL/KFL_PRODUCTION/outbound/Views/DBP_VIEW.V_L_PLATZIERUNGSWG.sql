CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_platzierungswg (mandant_id OPTIONS(description='Mandant im DWH.'),
platzierungswg_id OPTIONS(description='Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.'),
platzierungswg_nr OPTIONS(description='Platzierungswarengruppe - nicht-numerischer Schlüssel aus dem Quellsystem.'),
primaere_platzierungswg_nr
OPTIONS(description='Nummer der primären Platzierungswarengruppe. Die primäre Platzierungswarengruppe gruppiert mehrere Platzierungswarengruppen für eine gemeinsame Betrachtung des Mengengerüsts.'),
mgg_gruppe_id
OPTIONS(description='ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.'),
sok_kategorie_id
OPTIONS(description='ID der SOK Kategorie. Fasst mehrere primäre Platzierungswarengruppen zu einer übergeordneten Berichtshierarchie-Ebene zusammen.'),
primaere_relevant_fg
OPTIONS(description='Der Abweichungsgrad MGG Mengengerüst wird nur für definierte Bereiche ermittelt. Relevant_fg = 1 bedeutet, dass diese primäre Platzierungswarengruppe dafür benötigt wird. Wird manuell gepflegt (VIS SOK).'))
OPTIONS(DESCRIPTION = `TP2_AIS - WPL - WASA PLATZIERUNGSWARENGRUPPEN.`) AS SELECT mandant_id,
 platzierungswg_id,
 platzierungswg_nr,
 primaere_platzierungswg_nr,
 mgg_gruppe_id,
 sok_kategorie_id,
 primaere_relevant_fg
FROM kfl_production_dbp_data.l_platzierungswg;