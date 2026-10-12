--==============================================================
-- Table: wg_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_per
   generated from Powerdesigner on Freitag, 11. Oktober 2024 15:09:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WG_PER (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab welchem dieser Mehrwertsteuersatz gilt. Format ''YYYY-MM-DD''',
   lead_mwst_id                        INTEGER     NOT NULL COMMENT 'führende Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)',
   abt_id                              INTEGER     COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte ID''s, positive Werte: aus Stammdatensystem übernommen',
   dat_bis                             DATE             COMMENT 'Datum, bis zu welchem dieser Mehrwertsteuersatz gilt. Format ''YYYY-MM-DD''',
   owg_id                              INTEGER     NOT NULL DEFAULT -1 COMMENT 'ID der Oberwarengruppe',
   platzierungswg_id                   INTEGER     COMMENT 'Platzierungswarengruppe - im DWH generierter numerischer Schlüssel',
   werbeteam_cd                        VARCHAR(100)     COMMENT 'Code des Werbeteams',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WG_PER PRIMARY KEY (mandant_id, wg_id, arthiertyp_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP1 - TP2 - Warengruppe - Stufe in der Artikelhierarchie
             (ARTHIERTYP_ID nicht für PK benötigt)';
