--==============================================================
-- Table: art_kompensation_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_kompensation_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_KOMPENSATION_1 (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   komp_basismenge_einh_id             VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Mengeneinheit des Kompensationsartikels. Kann abweichend von der normalen Mengeneinheit sein. Aus meins',
   art_id_ref                          NUMBER(38,0)     COMMENT 'Artkel ID DWH - Kompensationsgruppe Referenzartikel',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_KOMPENSATION PRIMARY KEY (art_id, mandant_id) NOT ENFORCED
)  COMMENT = 'WWC - Kompensationsartikel aus der Quelle zminvco_ar. Tabelle wird zunächst separat angelegt, die Attribute gehören aber prinzipiell in die Tabelle art_1';

