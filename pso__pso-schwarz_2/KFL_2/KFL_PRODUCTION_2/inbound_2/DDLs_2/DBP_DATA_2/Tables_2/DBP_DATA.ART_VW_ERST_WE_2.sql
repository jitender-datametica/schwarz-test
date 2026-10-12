--==============================================================
-- Table: art_vw_erst_we_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_vw_erst_we_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_VW_ERST_WE_2 (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   vw_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebsweges',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   dat_erst_we                         DATE             COMMENT 'Datum des ersten Wareneingangs',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_VW_ERST_WE PRIMARY KEY (art_id, vw_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP2 AIS - Erster Wareneingang pro Artikel_2 und Vertriebsweg';

