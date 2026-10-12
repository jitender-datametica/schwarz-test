--==============================================================
-- Table: flw_l_input_material_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_input_material_typ
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_INPUT_MATERIAL_TYP (
   input_material_typ_id               VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des inputmaterials aus itypm. Z.Bsp. I = Input (Zukauf), A = Eingang (Vorstufe), N = Gesamt',
   input_material_typ_bez              VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Input Material Typs, z.Bsp. "Weiterverwendung"',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_INPUT_MATERIAL_TYP PRIMARY KEY (input_material_typ_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup-Tabelle der Input Materialtypen. Tabelle wird nicht über SST befüllt, sondern über die Fakten';

