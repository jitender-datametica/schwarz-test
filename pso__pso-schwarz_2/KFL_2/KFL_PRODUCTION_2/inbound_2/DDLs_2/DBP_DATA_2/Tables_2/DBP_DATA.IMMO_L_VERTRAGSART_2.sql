--==============================================================
-- Table: immo_l_vertragsart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_vertragsart_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_L_VERTRAGSART_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   vertragsart_id                      NUMBER(38,0)     NOT NULL COMMENT 'Vertragsart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_L_VERTRAGSART PRIMARY KEY (mandant_id, vertragsart_id) NOT ENFORCED
)  COMMENT = 'IMMO - Art_2 des Vermietungsvertrags  - SAP REFX - TIV2F';
