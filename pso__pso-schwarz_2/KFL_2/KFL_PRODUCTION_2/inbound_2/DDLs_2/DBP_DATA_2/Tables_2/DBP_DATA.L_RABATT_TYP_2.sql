--==============================================================
-- Table: l_rabatt_typ_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rabatt_typ_2
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:40:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_RABATT_TYP_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   rabatt_typ_id                       NUMBER(38,0)     NOT NULL COMMENT 'ID des Rabatt Typs. Gibt die Art_2 des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_RABATT_TYP PRIMARY KEY (mandant_id, rabatt_typ_id) NOT ENFORCED
)  COMMENT = 'Lookuptabelle der möglichen Arten des gewährten Rabattes.';
