--==============================================================
-- Table: art_uwg_nielsen_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_uwg_nielsen_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_UWG_NIELSEN_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   kl_uwg_id                           NUMBER(38,0)     NOT NULL COMMENT 'ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_UWG_NIELSEN_ZU PRIMARY KEY (mandant_id, art_id, kl_uwg_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Mappingtabelle Kaufland-Artikel_1 zu  Kaufland Unterwarengruppen für Nielsen';

