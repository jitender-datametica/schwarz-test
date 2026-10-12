/* --------------------------------------------------------------------------------
   DDL for table: t_map_lang_spras_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------



CREATE TABLE IF NOT EXISTS p_lew_core.t_map_lang_spras_1 (
language_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Language_id aus WAWI; entspricht CLIENT_ID (1=AT, 7=INTEGER , 23=DE, etc.)'),
language_iso_cd STRING(20) NOT NULL
OPTIONS(description='Pseudo-Iso-CD: entspricht dem Country_1-Code (AT, DE, INTEGER , etc.)'),
language_desc STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='in WAWI hinterlagte Sprachenbezeichnung'),
sap_spras STRING(20) OPTIONS(description='SAP-Feld SPRAS (einstellig)'),
sap_lang_cd STRING(20) OPTIONS(description='SAP-Feld LANGU (zweistellig)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (language_id) NOT ENFORCED
)
OPTIONS(description='''$Revision: 0000 $. Tabelle zur Ubersetzung der language_id zur sap_spras;
             Inhalt wird manuell gepflegt;
             Basis: x_data.t_ref_language, x_core_data.t_r_lang_map, x_core_data.t_r_lang_map_mis''');


