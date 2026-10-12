--==============================================================
-- Table: csr_produktgruppe_art_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: csr_produktgruppe_art_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CSR_PRODUKTGRUPPE_ART_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   csr_produktgruppe_id                INTEGER     NOT NULL COMMENT 'ID der CSR-Produktgruppe (bspw. Food-Eigenmarken)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CSR_PRODUKTGRUPPE_ART_ZU PRIMARY KEY (mandant_id, art_id, csr_produktgruppe_id) NOT ENFORCED
)  COMMENT = 'AIS - Zuordnungstabelle Artikel_2 zu CSR-Produktgruppe';

