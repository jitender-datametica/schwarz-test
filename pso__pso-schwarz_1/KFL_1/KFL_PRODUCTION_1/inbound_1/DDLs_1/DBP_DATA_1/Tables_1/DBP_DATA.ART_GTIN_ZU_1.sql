--==============================================================
-- Table: art_gtin_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gtin_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_GTIN_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   altnv_menge_einh_id                 VARCHAR(3)       NOT NULL COMMENT 'Mengeneinheit für Anzeige',
   lfd_nr                              NUMBER(38,0)     NOT NULL COMMENT 'Laufende Nummer',
   gtin_id                             NUMBER(26,0)     NOT NULL COMMENT 'Global Trade Item_1 Number (GTIN)',
   gtin_typ_kz                         VARCHAR(2)       NOT NULL COLLATE 'en-ci' DEFAULT '  ' COMMENT 'Nummerntyp der Global Trade Item_1 Number (z.B. G1 = Hersteller GTIN)',
   haupt_gtin_fg                       NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Kennzeichen Haupt-GTIN (x=1)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GTIN_ZU PRIMARY KEY (mandant_id, art_id, altnv_menge_einh_id, lfd_nr) NOT ENFORCED
)  COMMENT = 'EK-INT - Zuordnungstabelle GTIN (Global Trade Item_1 Number) zum Artikel_1 in SAP PR1 - MEAN_1';

