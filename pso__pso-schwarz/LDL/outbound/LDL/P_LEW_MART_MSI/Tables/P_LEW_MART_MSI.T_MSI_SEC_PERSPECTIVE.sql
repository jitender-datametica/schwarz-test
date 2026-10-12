CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_sec_perspective (
perspective_id BIGNUMERIC(38,0) NOT NULL,
perspective_desc STRING(255) COLLATE 'und:ci' NOT NULL,
web_doc_uid STRING(255) COLLATE 'und:ci',
mobile_doc_uid STRING(255) COLLATE 'und:ci',
iphone_doc_uid STRING(255) COLLATE 'und:ci',
web_image_link STRING(255) COLLATE 'und:ci',
mobile_image_link STRING(255) COLLATE 'und:ci',
iphone_image_link STRING(255) COLLATE 'und:ci'
);