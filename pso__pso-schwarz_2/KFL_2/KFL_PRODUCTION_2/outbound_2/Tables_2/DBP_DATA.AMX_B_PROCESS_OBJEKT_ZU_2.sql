--==============================================================
-- Table: amx_b_process_objekt_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_b_process_objekt_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_b_process_objekt_zu_2 (
business_process_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Geschäftsprozesses.Verweis auf ein Prüffeld mit dem Typ Prozess. Referenz auf pruef_feld_id. Aus dem Quellfeld audit_universe.business_process_id bzw.audit_universe.id'),
business_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der organisatorischen Einheit.Verweis auf ein Prüffeld mit dem Typ Stelle.  Aus dem Quellfeld business_unit_id bzw. audit_universe.id'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
risiko_wert BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Der Risikowert aus der Quellspalte audit_universe.risk_value'),
pruef_feld_typ_id BIGNUMERIC(38,0) OPTIONS(description='Eindeutige ID eines Prüffeld-Typs aus der Quelle id'),
aktiv_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='Flag zeigt an, ob das Prüffeld aktiv ist. Aus dem Quellfeld active'),
planbar_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Dieses Feld unterscheidet Prüfungseinheiten von anderen Prüffeldern aus dem Quellfeld auditable'),
vorgabe_pruef_intervall BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Vorgeschlagenes Prüfintervall in Monaten aus dem Quellfed sug_audit_interval'),
dat_vorgabe_naechst_pruef DATE
OPTIONS(description='Startdatum für die nächste vorgeschlagene Prüfung eines Prüffeldes aus dem Quellfeld suggested_next_au. Dieser Wert berechnet sich automatisch aus dem Prüfintervall und der letzten Prüfung'),
audit_universe_id BIGNUMERIC(38,0),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (business_process_id, business_unit_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - bildet n:m-Beziehung zwischen business_process und business_unit ab. Wird im DWH befüllt');