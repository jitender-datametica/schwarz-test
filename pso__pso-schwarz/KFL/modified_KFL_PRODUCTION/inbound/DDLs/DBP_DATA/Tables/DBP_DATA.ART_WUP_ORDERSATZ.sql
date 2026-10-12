--==============================================================
-- Table: art_wup_ordersatz
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_ordersatz
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_ORDERSATZ (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Betrieb',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnummer',
   dat_von                             DATE             NOT NULL COMMENT 'Datum gültig ab',
   dat_bis                             DATE             COMMENT 'Datum gültig bis',
   bezugsvorschrift_kz                 VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Bezugsvorschrift',
   bezugsquelle_kz                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Bezugsquelle',
   status_f_aenderungen_fg             INTEGER     NOT NULL COMMENT 'Statusfeld F-Änderungen',
   kdis_zzsopomvke_fg                  INTEGER     NOT NULL COMMENT 'KDIS durch ZZSOPO-MVKE',
   kdis_auslistungsprozess_fg          INTEGER     NOT NULL COMMENT 'KDIS aus Auslistungsprozess',
   archivierungs_kz                    VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Archivierungskennzeichen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_ORDERSATZ PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_von) NOT ENFORCED
)  COMMENT = 'FLW - ZEK-Ordersatz - Pflege der Bezugswege auf Artikel-Markt-Ebene - SAP RET - ZEKORDERSATZ01';

