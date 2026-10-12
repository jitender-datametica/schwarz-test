--==============================================================
-- Table: bewart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bewart_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEWART_2 (
   bewart_id                           NUMBER(38,0)     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEWART PRIMARY KEY (bewart_id) NOT ENFORCED
)  COMMENT = 'Enthält alle Bewegungsarten';

