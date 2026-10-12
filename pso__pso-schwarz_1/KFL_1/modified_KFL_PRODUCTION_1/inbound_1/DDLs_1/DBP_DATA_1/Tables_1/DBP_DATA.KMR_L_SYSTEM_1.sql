--==============================================================
-- Table: kmr_l_system_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_system_1
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:53:44
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_SYSTEM_1 (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
   amx_system_bez                      VARCHAR(20)      NOT NULL DEFAULT ' ' COMMENT 'Bezeichnung der unterschiedlichen AMX Systeme. Kein Quellfeld im View. Wird per Hand befüllt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_SYSTEM PRIMARY KEY (amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the different AMX source systems (Core vs. Unternehmenssicherheit). Source view v_dwh_kl_data_auditing.';
