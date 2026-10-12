--==============================================================
-- Table: fipo_l_objekt_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_objekt_typ_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_OBJEKT_TYP_1 (
   fipo_objekt_typ_id                  INTEGER     NOT NULL COMMENT 'Eindeutige ID des FIPO-Opbjekttyps aus dem Quellfeld obt_id',
   fipo_objekt_typ_bez                 VARCHAR(50)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des FIP-Objekttyps, z.Bsp. Filiale, Gastro. Aus dem Quellfeld obt_bezeichnung',
   fipo_sap_vkorg                      VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Verkaufsorganisation des Objekttyps, z.Bsp. KLR. Aus dem Quellfeld obt_sap_vkorg',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_OBJEKT_TYP PRIMARY KEY (fipo_objekt_typ_id) NOT ENFORCED
)  COMMENT = 'FIPO - Lookup Tabelle der FIPO-Objekttypen';

