--==============================================================
-- Table: amx_abdeckung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_abdeckung_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_ABDECKUNG_2 (
   abdeckung_id                        INTEGER     NOT NULL COMMENT 'Eindeutige ID der Tabelle amx_abdeckung. Aus dem Quellfeld auditing_id',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   pruefung_id                         INTEGER     COMMENT 'Die eindeutige ID einer Prüfung aus dem Quellfeld auditing.id',
   berechneter_wert                    NUMBER(29,2)      COMMENT 'Automatisch berechneter Wert anhand der Gewichtung aus amx_frage_2',
   manueller_wert                      NUMBER(29,2)      COMMENT 'Manuell gesetzter Wert durch Prüfer',
   business_process_id                 INTEGER     COMMENT 'ID des Geschäftsprozesses.Verweis auf ein Prüffeld mit dem Typ Prozess. Referenz auf pruef_feld_id. Aus dem Quellfeld audit_universe.business_process_id bzw.audit_universe.id',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_ABDECKUNG PRIMARY KEY (abdeckung_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - audimex - Die Tabelle Abdeckung enthält den Jahresplan der Prüfungen. Aus der Quelle audimex.contains_pu';

