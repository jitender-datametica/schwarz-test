--==============================================================
-- Table: art_art_gruppe_flw
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_art_gruppe_flw
   generated from Powerdesigner on Mittwoch, 30. November 2022 14:51:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_ART_GRUPPE_FLW (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH.',
   art_id                              INTEGER    NOT NULL COMMENT 'Artikel ID, Input: Artikel - Id einschließlich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   art_gruppe_id                       VARCHAR(5)      COMMENT 'ID der Artikel-Gruppierung (System generiert im DWH).',
   art_gruppe_bez                      VARCHAR(40)     COMMENT 'Artikelgruppe Bezeichnung.',
   art_klasse_id                       VARCHAR(5)      COMMENT 'Artikelklasse ID.',
   art_klasse_bez                      VARCHAR(40)     COMMENT 'Artikelklasse Bezeichnung.',
   art_rohstoff_id                     VARCHAR(5)      COMMENT 'Artikelrohstoff ID.',
   art_rohstoff_bez                    VARCHAR(40)     COMMENT 'Artikelrohstoff Bezeichnung.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_ART_GRUPPE_FLW PRIMARY KEY (mandant_id, art_id) NOT ENFORCED
)  COMMENT = 'Zuordnung Artikel zu Artikelgruppe, -klasse und Rohostoff';
