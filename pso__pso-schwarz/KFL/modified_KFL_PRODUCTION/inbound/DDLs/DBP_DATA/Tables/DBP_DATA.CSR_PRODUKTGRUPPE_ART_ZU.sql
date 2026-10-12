--==============================================================
-- Table: csr_produktgruppe_art_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: csr_produktgruppe_art_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CSR_PRODUKTGRUPPE_ART_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   csr_produktgruppe_id                INTEGER     NOT NULL COMMENT 'ID der CSR-Produktgruppe (bspw. Food-Eigenmarken)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CSR_PRODUKTGRUPPE_ART_ZU PRIMARY KEY (mandant_id, art_id, csr_produktgruppe_id) NOT ENFORCED
)  COMMENT = 'AIS - Zuordnungstabelle Artikel zu CSR-Produktgruppe';

