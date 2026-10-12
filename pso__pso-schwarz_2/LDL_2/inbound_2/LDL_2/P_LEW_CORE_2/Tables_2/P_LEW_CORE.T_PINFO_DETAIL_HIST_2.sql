/* --------------------------------------------------------------------------------
   DDL for table: t_pinfo_detail_hist_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PINFO_DETAIL_HIST_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   pinfo_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Einkaufsinfosatz-Header; FK auf PINFO HEADER; SAP-Retail: eine.infnr',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Betrieb; FK auf LOCATION_2; SAP-Retail: eine.werks; SAP-BW: zlex_v_bw_eine.werks',
   pur_org_sid                         NUMBER(38,0)     NOT NULL COMMENT 'Einkaufsorganisation; FK auf PURCHASE ORG; SAP-Retail: eine.ekorg; SAP-BW: zlex_v_bw_eine.ekorg',
   brand_sid                           NUMBER(38,0)     COMMENT 'Marke; FK auf BRAND_2; SAP-Retail: eine.zzbrand; SAP-BW: zlex_v_bw_eine.zzbrand',
   pinfo_type_cd                       VARCHAR(20)      NOT NULL COMMENT 'Typ des Einkaufsinfosatzes; SAP-Retail: eine.esokz; SAP-BW: zlex_v_bw_eine.esokz; eLWIS: t_s_einfo_cond.einfo_type',
   incoterm_1                          VARCHAR(20)      COMMENT 'Incoterm Teil 1; SAP-Retail: eine.inco1; SAP-BW: zlex_v_bw_eine.inco1; eLWIS: t_s_einfo_cond.inco_terms_1_cd',
   incoterm_2                          VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Incoterm Teil 2; SAP-Retail: eine.inco2; SAP-BW: zlex_v_bw_eine.inco2; eLWIS: t_s_einfo_cond.inco_terms_2_cd',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Pinfo-Detail ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen; SAP-Retail: eine.loekz',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PINFO_DETAIL_HIST PRIMARY KEY (pinfo_sid, loc_sid, pur_org_sid, pinfo_type_cd, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PINDH;Einkaufsinfosatz - Einkaufsorganisationsdaten;
             SAP-Retail: eine_2;
             SAP-BW: zlex_v_bw_eine;
             ELWIS: t_s_einfo_cond';

