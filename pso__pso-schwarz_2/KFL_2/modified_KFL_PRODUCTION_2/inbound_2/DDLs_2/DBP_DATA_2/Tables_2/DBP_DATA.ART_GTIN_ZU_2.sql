--==============================================================
-- Table: art_gtin_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gtin_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_GTIN_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   altnv_menge_einh_id                 VARCHAR(3)       NOT NULL COMMENT 'Mengeneinheit für Anzeige',
   lfd_nr                              INTEGER     NOT NULL COMMENT 'Laufende Nummer',
   gtin_id                             INTEGER     NOT NULL COMMENT 'Global Trade Item_2 Number (GTIN)',
   gtin_typ_kz                         VARCHAR(2)       NOT NULL COLLATE 'en-ci' DEFAULT '  ' COMMENT 'Nummerntyp der Global Trade Item_2 Number (z.B. G1 = Hersteller GTIN)',
   haupt_gtin_fg                       INTEGER     NOT NULL DEFAULT 0 COMMENT 'Kennzeichen Haupt-GTIN (x=1)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GTIN_ZU PRIMARY KEY (mandant_id, art_id, altnv_menge_einh_id, lfd_nr) NOT ENFORCED
)  COMMENT = 'EK-INT - Zuordnungstabelle GTIN (Global Trade Item_2 Number) zum Artikel_2 in SAP PR1 - MEAN_2';

