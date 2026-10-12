--==============================================================
-- Table: art_zek_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_zek_zu
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:03:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.ART_ZEK_ZU (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   zek_id                              VARCHAR(3)       NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_ZEK_ZU PRIMARY KEY (art_id, mandant_id, zek_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO - alle Artikel, die zu sehen ein Zentraleinkäufer berechtigt ist - MULTISET';
