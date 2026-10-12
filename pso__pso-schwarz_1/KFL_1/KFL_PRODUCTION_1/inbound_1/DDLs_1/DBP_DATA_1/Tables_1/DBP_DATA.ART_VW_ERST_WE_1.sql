--==============================================================
-- Table: art_vw_erst_we_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_vw_erst_we_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_VW_ERST_WE_1 (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   vw_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebsweges',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   dat_erst_we                         DATE             COMMENT 'Datum des ersten Wareneingangs',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_VW_ERST_WE PRIMARY KEY (art_id, vw_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP2 AIS - Erster Wareneingang pro Artikel_1 und Vertriebsweg';

