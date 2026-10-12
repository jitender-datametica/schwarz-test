--==============================================================
-- Table: amx_b_process_objekt_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_b_process_objekt_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_B_PROCESS_OBJEKT_ZU_1 (
   business_process_id                 NUMBER(38,0)     NOT NULL COMMENT 'ID des Geschäftsprozesses.Verweis auf ein Prüffeld mit dem Typ Prozess. Referenz auf pruef_feld_id. Aus dem Quellfeld audit_universe.business_process_id bzw.audit_universe.id',
   business_unit_id                    NUMBER(38,0)     NOT NULL COMMENT 'ID der organisatorischen Einheit.Verweis auf ein Prüffeld mit dem Typ Stelle.  Aus dem Quellfeld business_unit_id bzw. audit_universe.id',
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   risiko_wert                         NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Der Risikowert aus der Quellspalte audit_universe.risk_value',
   pruef_feld_typ_id                   NUMBER(38,0)     COMMENT 'Eindeutige ID eines Prüffeld-Typs aus der Quelle id',
   aktiv_fg                            NUMBER(38,0)     NOT NULL DEFAULT 1 COMMENT 'Flag zeigt an, ob das Prüffeld aktiv ist. Aus dem Quellfeld active',
   planbar_fg                          NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Dieses Feld unterscheidet Prüfungseinheiten von anderen Prüffeldern aus dem Quellfeld auditable',
   vorgabe_pruef_intervall             NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Vorgeschlagenes Prüfintervall in Monaten aus dem Quellfed sug_audit_interval',
   dat_vorgabe_naechst_pruef           DATE             COMMENT 'Startdatum für die nächste vorgeschlagene Prüfung eines Prüffeldes aus dem Quellfeld suggested_next_au. Dieser Wert berechnet sich automatisch aus dem Prüfintervall und der letzten Prüfung',
   audit_universe_id                   NUMBER(38,0),
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_B_PROCESS_OBJEKT_ZU PRIMARY KEY (business_process_id, business_unit_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - bildet n:m-Beziehung zwischen business_process und business_unit ab. Wird im DWH befüllt';

