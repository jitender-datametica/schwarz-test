/* --------------------------------------------------------------------------------
   DDL for table: t_item_type_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_type_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_type_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEM_2 TYPE'),
src_mtart STRING(20)
OPTIONS(description='Artikelart-Code (SAP-Retail); SAP-Retail: t134.mtart; SAP-BW: t_bw_0itm_type_text.mtart'),
item_type_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Artikelart in Stiftungssprache; SAP-Retail: t134t.mtbez; SAP-BW: t_bw_0itm_type_text.txtlg'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (item_type_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. ITYP; Artikel_2 Art_2; Nebengruppierung des Atikels, die nicht zur Artikelhierarchie gehort             SAP-Retail: T134;              SAP-BW: t_bw_0matl_type_text;             ELWIS: t_r_pos_type_descr(?)');