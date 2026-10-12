--==============================================================
-- Table: art_wup_ordersatz_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_ordersatz_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_ORDERSATZ_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Betrieb',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikelnummer',
   dat_von                             DATE             NOT NULL COMMENT 'Datum gültig ab',
   dat_bis                             DATE             COMMENT 'Datum gültig bis',
   bezugsvorschrift_kz                 VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Bezugsvorschrift',
   bezugsquelle_kz                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Bezugsquelle',
   status_f_aenderungen_fg             NUMBER(38,0)     NOT NULL COMMENT 'Statusfeld F-Änderungen',
   kdis_zzsopomvke_fg                  NUMBER(38,0)     NOT NULL COMMENT 'KDIS durch ZZSOPO-MVKE_1',
   kdis_auslistungsprozess_fg          NUMBER(38,0)     NOT NULL COMMENT 'KDIS aus Auslistungsprozess',
   archivierungs_kz                    VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Archivierungskennzeichen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_ORDERSATZ PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_von) NOT ENFORCED
)  COMMENT = 'FLW - ZEK_1-Ordersatz - Pflege der Bezugswege auf Artikel_1-Markt-Ebene - SAP RET - ZEKORDERSATZ01_1';

