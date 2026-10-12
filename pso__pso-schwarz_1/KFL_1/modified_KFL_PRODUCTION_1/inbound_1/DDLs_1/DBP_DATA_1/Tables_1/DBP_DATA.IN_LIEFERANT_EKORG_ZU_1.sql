--==============================================================
-- Table: in_lieferant_ekorg_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_lieferant_ekorg_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_LIEFERANT_EKORG_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   in_lief_id                          INTEGER     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   einkaufsorganisation_id             INTEGER     NOT NULL COMMENT 'Einkaufsorganisation aus ekorg',
   loesch_fg                           INTEGER     NOT NULL COMMENT 'Zentrale Löschvormerkung für Stammsatz aus loevm',
   ek_sperr_fg                         INTEGER     NOT NULL COMMENT 'zentral vergebene Einkaufssperre aus sperm',
   einkaeufer_grp_id                   VARCHAR(3)       COLLATE 'en-ci' COMMENT 'ID der Einkäufergruppe aus ekgr',
   zahlungsziel_id                     VARCHAR(4)       COLLATE 'en-ci' COMMENT 'ID der Zahlungsbedingung. Z.Bsp. 3030 = 30Tage, 3%',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_LIEFERANT_EKORG_ZU PRIMARY KEY (in_lief_id, einkaufsorganisation_id, mandant_id) NOT ENFORCED
)  COMMENT = 'BIS - Zuordnung Lieferant zu Einkaufsorganisation aus lfm1_1';
