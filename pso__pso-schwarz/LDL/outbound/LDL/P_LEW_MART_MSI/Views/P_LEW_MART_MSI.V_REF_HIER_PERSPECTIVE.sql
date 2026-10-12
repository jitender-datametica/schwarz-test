CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_hier_perspective (perspective_id, perspective_desc, web_doc_uid,
mobile_doc_uid, iphone_doc_uid, web_image_link, mobile_image_link, iphone_image_link) AS SELECT perspective_id,
 perspective_desc,
 web_doc_uid,
 mobile_doc_uid,
 iphone_doc_uid,
 web_image_link,
 mobile_image_link,
 iphone_image_link
FROM ldl_p_lew_mart_msi.t_msi_ref_hier_perspective;