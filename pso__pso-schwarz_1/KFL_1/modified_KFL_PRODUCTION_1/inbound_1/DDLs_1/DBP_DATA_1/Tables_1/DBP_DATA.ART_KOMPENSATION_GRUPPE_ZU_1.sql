--==============================================================
-- Table: art_kompensation_gruppe_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_kompensation_gruppe_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_KOMPENSATION_GRUPPE_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   komp_gruppe_id                      INTEGER     NOT NULL COMMENT 'ID der Kompensationsgruppe aus zcgnr',
   komp_kriterium_fg                   INTEGER     NOT NULL COMMENT 'Kompensationskriterium aus zcgadv. wenn = 0, dann Verpackungsinhalt gleich, wenn = 1,dann unterschiedlicher Verpackungsinhalt',
   komp_faktor                         NUMBER(29,2)      NOT NULL COMMENT 'Faktor (Gewichtung) des Artikels) aus factor. Ein Artikel_1 mit Faktor 2 wird z.Bsp. gegen zwei mit Faktor 1 aufgerechnet',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_KOMPENSATION_GRUPPE_ZU PRIMARY KEY (mandant_id, art_id, komp_gruppe_id, komp_kriterium_fg) NOT ENFORCED
)  COMMENT = 'WWC - Zuordnungstabelle Kompensationsartikel zu Kompensationsgruppe';

