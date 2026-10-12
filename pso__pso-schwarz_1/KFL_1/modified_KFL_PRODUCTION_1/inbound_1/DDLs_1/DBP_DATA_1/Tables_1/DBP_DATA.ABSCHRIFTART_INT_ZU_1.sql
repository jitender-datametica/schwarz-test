--==============================================================
-- Table: abschriftart_int_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_int_zu_1
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFTART_INT_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   abschriftart_id                     INTEGER     NOT NULL COMMENT 'Abschriftenart  -  numerisch',
   abschriftart_int_id                 INTEGER     NOT NULL COMMENT 'ID Einheitliche Abschriftart KL international (z.B. -1=Werbeabschriften)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFTART_INT_ZU PRIMARY KEY (mandant_id, abschriftart_id, abschriftart_int_id) NOT ENFORCED
)  COMMENT = 'VIS - Mapping-Tabelle nationale Abschrftenarten zu der iEinheitlichen Abschriftenarten KL international';

