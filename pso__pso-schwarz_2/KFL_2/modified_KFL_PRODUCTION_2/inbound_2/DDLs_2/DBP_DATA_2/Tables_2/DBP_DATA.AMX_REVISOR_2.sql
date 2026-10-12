--==============================================================
-- Table: amx_revisor_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_revisor_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_REVISOR_2 (
   revisor_id                          INTEGER     NOT NULL COMMENT ' Revisor wurde aus Datenschutzgründen ausgebaut und darf nicht ohne Rücksprache mit SBIT wieder eingebaut werden. Eindeutige ID des Prüfers aus dem Quellfeld autitor.id',
   revisor_anrede                      VARCHAR(40)      NOT NULL DEFAULT ' ' COMMENT 'Anrede aus dem Quellfeld salutation',
   revisor_nachname                    VARCHAR(40)      NOT NULL DEFAULT ' ' COMMENT 'Nachname aus dem Quellfeld lastname',
   revisor_vorname                     VARCHAR(40)      NOT NULL DEFAULT ' ' COMMENT 'Vorname aus dem Quellfeld firstname',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_REVISOR PRIMARY KEY (revisor_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Revisor wurde aus Datenschutzgründen ausgebaut und darf nicht ohne Rücksprache mit SBIT wieder eingebaut werden. Die Tabelle amx_pruefer enthält die  Stammdaten der Prüfer Aus der Quelle audimex.auditor';

