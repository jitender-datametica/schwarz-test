--==============================================================
-- Table: kmr_l_feststellung_gewichtung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_feststellung_gewichtung
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:30:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_FESTSTELLUNG_GEWICHTUNG (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   feststellung_gewichtung_id          INTEGER     NOT NULL DEFAULT -1 COMMENT 'Gewichtung-ID. Quellfeld issue_weight_id.',
   feststellung_gewichtung_bez         VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Gewichtung-Bezeichnung. Quellfeld issue_weight_name.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_FESTSTELLUNG_GEWICHTUNG PRIMARY KEY (feststellung_gewichtung_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the weight / importance of the issue (light, medium, heavy). Does not contain "Kurzchecks". Source view v_dwh_kl_data_issue.';
