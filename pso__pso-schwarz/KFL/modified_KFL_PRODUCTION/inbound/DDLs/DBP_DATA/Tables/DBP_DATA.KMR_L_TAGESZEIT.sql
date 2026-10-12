--==============================================================
-- Table: kmr_l_tageszeit
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_tageszeit
   generated from Powerdesigner on Freitag, 17. Februar 2023 16:12:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_TAGESZEIT (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
   tageszeit_id                        INTEGER     NOT NULL DEFAULT -1 COMMENT 'Tageszeit-ID. Beinhaltet früh, mittel, oder spät. Quellfeld auditing_reserve_sel_auditing_00_id.',
   tageszeit_bez                       VARCHAR(80)      NOT NULL DEFAULT ' ' COMMENT 'Tageszeit-Bezeichnung. Beinhaltet früh, mittel, oder spät. Quellfeld auditing_reserve_sel_auditing_00_name.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_TAGESZEIT PRIMARY KEY (tageszeit_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the time of the day during which an audit is performed (Tageszeit). Does not include "Kurzchecks". Source view v_dwh_kl_data_auditing.';
