--==============================================================
-- Table: in_auftragskategorie_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftragskategorie_spr_zu_2
   generated from Powerdesigner on Freitag, 31. Mai 2024 08:59:36
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_AUFTRAGSKATEGORIE_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   auftragskategorie_id                NUMBER(38,0)     NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2',
   auftragskategorie_bez               VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung für Equipment in Großbuchstaben',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_AUFTRAGSKATEGORIE_SPR_ZU PRIMARY KEY (mandant_id, auftragskategorie_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS - Auftragskategoriekennzeichen Instandhaltung - Translations table for types of service and maintenance orders for industrial equipment and plants.';
