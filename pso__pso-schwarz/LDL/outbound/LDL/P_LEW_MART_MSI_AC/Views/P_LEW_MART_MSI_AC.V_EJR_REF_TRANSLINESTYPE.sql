CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_ref_translinestype (translinestype_id, transline_ref, transline_desc
, transline_sdesc, document_desc, transline_desc_en, transline_sdesc_en, document_tlt_desc_en, transline_xml_ref,
transline_comment, language_id) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_ref_translinestype;