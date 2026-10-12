--==============================================================
-- Table: csr_produktgruppe_art_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: csr_produktgruppe_art_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CSR_PRODUKTGRUPPE_ART_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   csr_produktgruppe_id                NUMBER(38,0)     NOT NULL COMMENT 'ID der CSR-Produktgruppe (bspw. Food-Eigenmarken)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CSR_PRODUKTGRUPPE_ART_ZU PRIMARY KEY (mandant_id, art_id, csr_produktgruppe_id) NOT ENFORCED
)  COMMENT = 'AIS - Zuordnungstabelle Artikel_1 zu CSR-Produktgruppe';

