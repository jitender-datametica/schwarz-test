/* --------------------------------------------------------------------------------
   DDL for table: t_map_lang_spras_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MAP_LANG_SPRAS_2 (
   language_id                         NUMBER(38,0)     NOT NULL COMMENT 'Language_id aus WAWI; entspricht CLIENT_ID (1=AT, 7=INT, 23=DE, etc.)',
   language_iso_cd                     VARCHAR(20)      NOT NULL COMMENT 'Pseudo-Iso-CD: entspricht dem Country_2-Code (AT, DE, INT, etc.)',
   language_desc                       VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'in WAWI hinterlagte Sprachenbezeichnung',
   sap_spras                           VARCHAR(20)      COMMENT 'SAP-Feld SPRAS (einstellig)',
   sap_lang_cd                         VARCHAR(20)      COMMENT 'SAP-Feld LANGU (zweistellig)',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MAP_LANG_SPRAS PRIMARY KEY (language_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Tabelle zur Ubersetzung der language_id zur sap_spras;
             Inhalt wird manuell gepflegt;
             Basis: x_data.t_ref_language, x_core_data.t_r_lang_map, x_core_data.t_r_lang_map_mis';

