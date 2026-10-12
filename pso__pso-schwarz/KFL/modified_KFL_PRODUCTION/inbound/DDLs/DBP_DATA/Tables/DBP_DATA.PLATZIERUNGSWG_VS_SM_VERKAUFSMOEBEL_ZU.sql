--==============================================================
-- Table: platzierungswg_vs_sm_verkaufsmoebel_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: platzierungswg_vs_sm_verkaufsmoebel_zu
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:47:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PLATZIERUNGSWG_VS_SM_VERKAUFSMOEBEL_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   platzierungswg_id                   INTEGER     NOT NULL COMMENT 'Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.',
   vs_id                               INTEGER     NOT NULL COMMENT 'ID der Vertriebsschiene',
   sm_id                               INTEGER     NOT NULL COMMENT 'Sortimentsmodul ID. Gibt die Sortimentsgröße an.',
   verkaufsmoebel_id                   INTEGER     NOT NULL COMMENT 'ID des Verkaufsmöbels - Ein Verkaufsmöbel ist der Gegenstand auf / in dem die Artikel in der Filiale verkauft werden.',
   menge_soll_flaeche                  NUMBER(29,3)     COMMENT 'Gibt die Soll-Größe der Verkaufsfläche an.',
   flaeche_einh_id                     VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Einheit der Soll-Größe der Verkaufsfläche.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PLATZIERUNGSWG_VS_SM_VERKAUFSMOEBEL_ZU PRIMARY KEY (mandant_id, platzierungswg_id, verkaufsmoebel_id, sm_id, vs_id) NOT ENFORCED
)  COMMENT = 'Zuordnung von Platzierungswarengruppe zu den Sortimentsgrößen, Verkaufsmöbel und den einzelnen Vertriebsregionen.';
