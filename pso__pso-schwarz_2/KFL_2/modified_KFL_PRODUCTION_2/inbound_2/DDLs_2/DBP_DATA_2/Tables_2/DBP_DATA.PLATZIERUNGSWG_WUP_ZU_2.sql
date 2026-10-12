--==============================================================
-- Table: platzierungswg_wup_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: platzierungswg_wup_zu_2
   generated from Powerdesigner on Donnerstag, 8. Mai 2025 23:24:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PLATZIERUNGSWG_WUP_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   platzierungswg_id                   INTEGER     NOT NULL COMMENT 'Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.',
   wup_id                              INTEGER     NOT NULL COMMENT 'ID Warenumschlagsplatz, ID der Filiale.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   sm_id                               INTEGER     COMMENT 'Sortimentsmodul ID. Gibt die Sortimentsgröße der Platzierungswarengruppe in der Filiale an.',
   anz_artikel                         INTEGER     COMMENT 'Gibt die Anzahl der Artikel_2 in der Filiale für die Platzierungswarengruppe an.',
   menge_soll_flaeche_regio            NUMBER(29,3)     COMMENT 'Gibt die SOLL-Größe der Verkaufsflächen rein regionaler Sortimente an.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PLATZIERUNGSWG_WUP_ZU PRIMARY KEY (mandant_id, platzierungswg_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'Zuordnungen der Platzierungswarengruppe zur Filiale.';
