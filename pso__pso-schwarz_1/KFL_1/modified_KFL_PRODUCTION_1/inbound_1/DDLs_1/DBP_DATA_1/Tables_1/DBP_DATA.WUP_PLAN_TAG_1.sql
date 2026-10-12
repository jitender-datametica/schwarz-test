--==============================================================
-- Table: wup_plan_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_plan_tag_1
   generated from Powerdesigner on Dienstag, 25. März 2025 13:14:32
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_PLAN_TAG_1 (
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   dat                                 DATE             NOT NULL COMMENT 'Datum',
   plan_tag_fg                         INTEGER     COMMENT 'Wenn die Daten bereits in der SST auf der Ebene wup_1 und Tag_1 geliefert wurden: 1, sonst  0',
   umsatz_netto_plan                   NUMBER(29,2)     COMMENT 'geplanter Nettoumsatz',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   umsatz_netto_plan_extern            NUMBER(29,2)     COMMENT 'umsatz_netto_plan_extern. Upload aus Excel',
   menge_absatz_ohne_pfand_plan        NUMBER(29,3)     COMMENT 'Geplante Anzahl der zu verkaufenden Artikel_1 (ohne Pfand-Artikel_1) auf  Ebene Filiale/Tag.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUP_PLAN_TAG PRIMARY KEY (wup_id, nb_id, mandant_id, dat) NOT ENFORCED
)  COMMENT = 'VIS - Planwerte pro Markt und Tag_1';
