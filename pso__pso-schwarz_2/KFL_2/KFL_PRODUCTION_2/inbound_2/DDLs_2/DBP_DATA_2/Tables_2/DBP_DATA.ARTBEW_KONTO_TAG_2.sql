--==============================================================
-- Table: artbew_konto_tag_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_konto_tag_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_KONTO_TAG_2 (
   konto_id                            NUMBER(38,0)     NOT NULL COMMENT 'Nummer des Kontos',
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt
            ',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   bewart_id                           NUMBER(38,0)     NOT NULL COMMENT 'Hier ist nur bewart_2 1006 drin - Tageskorrektur',
   dat                                 DATE             NOT NULL COMMENT 'Tagesdatum',
   umsatz_brutto                       NUMBER(18,2)     NOT NULL COMMENT 'Bruttoumsatz in Originalwaehrung',
   umsatz_netto                        NUMBER(18,2)     NOT NULL COMMENT 'Umsatz bereinigt um Mehrwertsteuer in Originalwaehrung',
   umsatz_wrg                          VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Waehrung des Originalumsatzes',
   umsatz_brutto_konz                  NUMBER(18,2)     NOT NULL COMMENT 'Bruttoumsatz in Konzernwaehrung',
   umsatz_netto_konz                   NUMBER(18,2)     NOT NULL COMMENT 'Umsatz bereinigt um Mehrwertsteuer in Konzernwaehrung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_KONTO_TAG PRIMARY KEY (konto_id, arthiertyp_id, mandant_id, wup_id, nb_id, bewart_id, dat) NOT ENFORCED
)  COMMENT = 'TP1_MIS - Sicherungstabelle fuer Kontoumsaetze taeglich Umsnetto_2';

