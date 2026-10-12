/* --------------------------------------------------------------------------------
   DDL for table: t_unit_of_measurement
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_UNIT_OF_MEASUREMENT (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   uom_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key UNIT OF MEASUREMENT',
   src_msehi                           VARCHAR(20)      COMMENT 'Masseinheit; SAP-Retail: t006.msehi; SAP-BW: t_bw_z_ds_t006.msehi',
   uom_sid_family                      NUMBER(38,0)     COMMENT 'Masseinheitenfamilie; FK auf UNIT OF MEASUREMENT; SAP-Retail: t006.famunit; SAP-BW: t_bw_z_ds_t006.famunit',
   uom_name                            VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Masseinheiten-Beschreibung in Stiftungssprache; SAP-Retail: t006a.msehl; SAP-BW: t_bw_z_ds_t006a.msehl',
   uom_iso_cd                          VARCHAR(20)      COMMENT 'Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode',
   uom_cd_family                       VARCHAR(20)      COMMENT 'Masseinheitenfamilie; SAP-Retail: t006.famunit; SAP-BW: t_bw_z_ds_t006.famunit',
   numerator_conv_si                   NUMBER(38,0)     COMMENT 'Zaehler zur Umrechnung in SI-Einheit; SAP-Retail: t006.zaehl; SAP-BW: t_bw_z_ds_t006 zaehl',
   denominator_conv_si                 NUMBER(38,0)     COMMENT 'Nenner zur Umrechnung in SI-Einheit; SAP-Retail: t006.nennr; SAP-BW: t_bw_z_ds_t006.nennr',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_UNIT_OF_MEASUREMENT PRIMARY KEY (uom_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. UOFM; Masseinheiten; 
             SAP-Retail-Tabelle: t006 & t006a;
             SAP-BW: t_bw_z_ds_t006 & t_bw_z_ds_t006a;
             ELWIS: t_s_uom;
             WAWI: ';

