--==============================================================
-- Table: art_sm_vw_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_sm_vw_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_SM_VW_ZU_PER_1 (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   vw_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebsweges',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn des Gültigkeitszeitraums',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT',
   sm_id                               NUMBER(38,0)     NOT NULL COMMENT 'Sortimentsmodul ID. Es gibt 5 Sortimentsstufen, von 1 bis 5. -1: keine Sortimentsstufe zugeordnet',
   ksm_id                              VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Kaufland Sortimentsmodul, das in den KMO Ländern eingeführt wurde für parallele Listungen zu sm_id.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_SM_VW_ZU_PER PRIMARY KEY (art_id, vw_id, mandant_id, dat_von) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Zuordnung der Artikel_1 zu Sortimentsmodul und Vertriebsweg aus der Quelle mvke_1 - MULTISET';

