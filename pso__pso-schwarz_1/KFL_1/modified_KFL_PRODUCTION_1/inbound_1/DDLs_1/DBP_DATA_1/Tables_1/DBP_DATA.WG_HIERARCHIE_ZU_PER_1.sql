--==============================================================
-- Table: wg_hierarchie_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_hierarchie_zu_per_1
   generated from Powerdesigner on Dienstag, 6. Februar 2024 09:01:33
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WG_HIERARCHIE_ZU_PER_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   wg_hierarchie_ebene_id              INTEGER     NOT NULL COMMENT 'eindeutige ID der Ebene einer Warengruppenhierarchie',
   wg_hierarchie_id                    INTEGER     NOT NULL COMMENT 'ID der Warengruppen Hierarchie',
   wg_hierarchie_mutter_id             INTEGER     NOT NULL COMMENT 'ID des Elternelements',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode',
   dat_bis                             DATE             NOT NULL COMMENT 'Endedatum der Gültigkeit, bei aktuellen Sätzen = 31.12.9999',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WG_HIERARCHIE_ZU_PER PRIMARY KEY (mandant_id, arthiertyp_id, wg_hierarchie_ebene_id, wg_hierarchie_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Stammdaten der Warengruppenhierarchien';
