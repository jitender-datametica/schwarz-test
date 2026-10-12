/* --------------------------------------------------------------------------------
   DDL for table: t_packaging_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PACKAGING_TYPE_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   pack_type_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PACKAGING TYPE',
   src_zz_pack_type                    VARCHAR(20)      COMMENT 'Verpackungstyp-Code; SAP-Retail: zlax008_cust4.zz_pack_type; SAP-BW: t_bw_z_ds_zlax008_cust4t.zz_pack_type',
   pack_type_name                      VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung des Verpackungstyps in Stiftuungssprache; SAP-Retail: zlax008_cust4t.description; SAP-BW: t_bw_z_ds_zlax008_cust4t.description',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PACKAGING_TYPE PRIMARY KEY (pack_type_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PCKT; Verpackungstyp; z.B. "Dose", "Eimer", "Kiste", "Lose", etc.
             SAP-Retail: zlax008_cust4;
             SAP-BW: t_bw_z_ds_zlax008_cust4t;
             ELWIS: t_r_itm_package_type;
             WAWI: t_ref_itm_logist_unit';

