--==============================================================
-- Table: l_hydra_zeitart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_hydra_zeitart_2
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:15:39
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_HYDRA_ZEITART_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   zeitart_id                          VARCHAR(3)       NOT NULL COMMENT 'Zeitart, z.B. GRP , ZL',
   zeitart_bez                         VARCHAR(30)      COMMENT 'Bezeichnung der Zeitart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_HYDRA_ZEITART PRIMARY KEY (mandant_id, zeitart_id) NOT ENFORCED
)  COMMENT = 'Work Performance measurement type -  group, individual
             We do not have translations in different languages. We have only a description in this table and no _SPR_ZU table';
