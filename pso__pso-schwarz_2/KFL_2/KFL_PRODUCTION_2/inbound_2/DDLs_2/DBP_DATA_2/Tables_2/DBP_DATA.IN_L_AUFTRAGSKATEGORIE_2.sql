--==============================================================
-- Table: in_l_auftragskategorie_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_auftragskategorie_2
   generated from Powerdesigner on Freitag, 31. Mai 2024 08:58:40
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_AUFTRAGSKATEGORIE_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   auftragskategorie_id                NUMBER(38,0)     NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_AUFTRAGSKATEGORIE PRIMARY KEY (mandant_id, auftragskategorie_id) NOT ENFORCED
)  COMMENT = 'LIS - Auftragskategoriekennzeichen Instandhaltung - Lookup table for types of service and maintenance orders for industrial equipment and plants.';
