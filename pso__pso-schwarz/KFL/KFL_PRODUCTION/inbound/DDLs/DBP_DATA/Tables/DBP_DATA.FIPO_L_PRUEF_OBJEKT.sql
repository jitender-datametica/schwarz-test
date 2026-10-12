--==============================================================
-- Table: fipo_l_pruef_objekt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_pruef_objekt
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_PRUEF_OBJEKT (
   fipo_pruef_objekt_id                NUMBER(38,0)     NOT NULL COMMENT 'eindeutige ID eines Prüfobjekts aus dem Quellfeld pob_id',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   fipo_objekt_typ_id                  NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID des FIPO-Opbjekttyps aus dem Quellfeld obt_id',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_PRUEF_OBJEKT PRIMARY KEY (fipo_pruef_objekt_id) NOT ENFORCED
)  COMMENT = 'FIPO - Tabelle der FIPO Pruefobjekte aus Quelle pruefobjekte';

