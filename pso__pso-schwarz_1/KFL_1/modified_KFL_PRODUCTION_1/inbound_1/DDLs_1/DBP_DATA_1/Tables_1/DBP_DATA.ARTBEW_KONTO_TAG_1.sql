--==============================================================
-- Table: artbew_konto_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_konto_tag_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_KONTO_TAG_1 (
   konto_id                            INTEGER     NOT NULL COMMENT 'Nummer des Kontos',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt
            ',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   bewart_id                           INTEGER     NOT NULL COMMENT 'Hier ist nur bewart_1 1006 drin - Tageskorrektur',
   dat                                 DATE             NOT NULL COMMENT 'Tagesdatum',
   umsatz_brutto                       NUMBER(29,2)     NOT NULL COMMENT 'Bruttoumsatz in Originalwaehrung',
   umsatz_netto                        NUMBER(29,2)     NOT NULL COMMENT 'Umsatz bereinigt um Mehrwertsteuer in Originalwaehrung',
   umsatz_wrg                          VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Waehrung des Originalumsatzes',
   umsatz_brutto_konz                  NUMBER(29,2)     NOT NULL COMMENT 'Bruttoumsatz in Konzernwaehrung',
   umsatz_netto_konz                   NUMBER(29,2)     NOT NULL COMMENT 'Umsatz bereinigt um Mehrwertsteuer in Konzernwaehrung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_KONTO_TAG PRIMARY KEY (konto_id, arthiertyp_id, mandant_id, wup_id, nb_id, bewart_id, dat) NOT ENFORCED
)  COMMENT = 'TP1_MIS - Sicherungstabelle fuer Kontoumsaetze taeglich Umsnetto_1';

