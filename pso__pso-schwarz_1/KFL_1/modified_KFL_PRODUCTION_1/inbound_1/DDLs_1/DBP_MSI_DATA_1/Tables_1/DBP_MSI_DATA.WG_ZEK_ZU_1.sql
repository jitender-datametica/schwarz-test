--==============================================================
-- Table: wg_zek_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_zek_zu_1
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:14:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.WG_ZEK_ZU_1 (
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   zek_id                              VARCHAR(3)       NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WG_ZEK_ZU PRIMARY KEY (wg_id, arthiertyp_id, mandant_id, zek_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO - alle Warengruppen, die zu sehen ein Zentraleinkäufer berechtigt ist - MULTISET';
