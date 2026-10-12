--==============================================================
-- Table: wup_plan_tag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_plan_tag
   generated from Powerdesigner on Dienstag, 25. März 2025 13:14:32
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_PLAN_TAG (
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   dat                                 DATE             NOT NULL COMMENT 'Datum',
   plan_tag_fg                         NUMBER(38,0)     COMMENT 'Wenn die Daten bereits in der SST auf der Ebene wup und Tag geliefert wurden: 1, sonst  0',
   umsatz_netto_plan                   NUMBER(18,2)     COMMENT 'geplanter Nettoumsatz',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   umsatz_netto_plan_extern            NUMBER(18,2)     COMMENT 'umsatz_netto_plan_extern. Upload aus Excel',
   menge_absatz_ohne_pfand_plan        NUMBER(38,3)     COMMENT 'Geplante Anzahl der zu verkaufenden Artikel (ohne Pfand-Artikel) auf  Ebene Filiale/Tag.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUP_PLAN_TAG PRIMARY KEY (wup_id, nb_id, mandant_id, dat) NOT ENFORCED
)  COMMENT = 'VIS - Planwerte pro Markt und Tag';
