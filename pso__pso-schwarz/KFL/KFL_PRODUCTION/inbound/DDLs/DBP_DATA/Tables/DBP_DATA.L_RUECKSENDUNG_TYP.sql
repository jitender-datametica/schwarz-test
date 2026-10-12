--==============================================================
-- Table: l_ruecksendung_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ruecksendung_typ
   generated from Powerdesigner on Mittwoch, 26. Juni 2024 13:53:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_RUECKSENDUNG_TYP (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   ruecksendung_typ_kz                 VARCHAR(4)       NOT NULL COMMENT 'Code für die Art der Rücksendung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_RUECKSENDUNG_TYP PRIMARY KEY (mandant_id, ruecksendung_typ_kz) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für Rücksendungstypen.';
