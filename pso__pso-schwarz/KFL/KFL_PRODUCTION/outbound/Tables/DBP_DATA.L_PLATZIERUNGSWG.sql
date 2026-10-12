--==============================================================
-- Table: l_platzierungswg
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_platzierungswg
   generated from Powerdesigner on Montag, 19. Mai 2025 14:23:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_platzierungswg (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
platzierungswg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.'),
platzierungswg_nr STRING(10) COLLATE 'und:ci'
OPTIONS(description='Platzierungswarengruppe - nicht-numerischer Schlüssel aus dem Quellsystem.'),
primaere_platzierungswg_nr STRING(10)
OPTIONS(description='Nummer der primären Platzierungswarengruppe. Die primäre Platzierungswarengruppe gruppiert mehrere Platzierungswarengruppen für eine gemeinsame Betrachtung des Mengengerüsts.'),
mgg_gruppe_id BIGNUMERIC(38,0)
OPTIONS(description='ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.'),
sok_kategorie_id BIGNUMERIC(38,0)
OPTIONS(description='ID der SOK Kategorie. Fasst mehrere primäre Platzierungswarengruppen zu einer übergeordneten Berichtshierarchie-Ebene zusammen.'),
primaere_relevant_fg BIGNUMERIC(38,0)
OPTIONS(description='Der Abweichungsgrad MGG Mengengerüst wird nur für definierte Bereiche ermittelt. Relevant_fg = 1 bedeutet, dass diese primäre Platzierungswarengruppe dafür benötigt wird. Wird manuell gepflegt (VIS SOK).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, platzierungswg_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - WPL - WaSA Platzierungswarengruppen.');