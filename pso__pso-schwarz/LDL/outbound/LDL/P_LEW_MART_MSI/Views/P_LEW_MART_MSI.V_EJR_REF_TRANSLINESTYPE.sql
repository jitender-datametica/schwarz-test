CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_ref_translinestype (translinestype_id, transline_ref, transline_desc,
transline_sdesc, document_desc, transline_desc_en, transline_sdesc_en, document_tlt_desc_en, transline_xml_ref,
transline_comment, language_id) AS SELECT translinestype_id,
 transline_ref,
 transline_desc,
 transline_sdesc,
  CASE
  WHEN translinestype_id IN ('110', '210', '306', '307', '850', '855') OR translinestype_id BETWEEN '400' AND '799'
  THEN transline_sdesc
  ELSE NULL
  END AS document_desc,
 'N/A' AS transline_desc_en,
 'N/A' AS transline_sdesc_en,
 'N/A' AS document_tlt_desc_en,
 transline_xml_ref,
 transline_comment,
 language_id
FROM ldl_p_lew_mart_msi.t_msi_ejr_ref_translinestype AS TLT
UNION DISTINCT
SELECT transactiontype_id AS translinestype_id,
 trans_ref AS transline_ref,
 trans_desc AS transline_desc,
 trans_desc AS transline_sdesc,
  CASE
  WHEN transactiontype_id IN ('400', '405', '410', '415', '420', '465')
  THEN trans_desc
  ELSE NULL
  END AS document_desc,
 'N/A' AS trans_desc_en,
 'N/A' AS trans_sdesc_en,
 'N/A' AS document_tlt_desc_en,
 'N/A' AS transline_xml_ref,
 'N/A' AS transline_comment,
 language_id
FROM ldl_p_lew_mart_msi.t_msi_ejr_ref_transactiontype AS TTY
WHERE NOT EXISTS (SELECT 1
  FROM ldl_p_lew_mart_msi.t_msi_ejr_ref_translinestype AS TLX
  WHERE TTY.transactiontype_id = translinestype_id);