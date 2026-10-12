CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ITM_ITEM_DESC_ACT_1	
/*
#DescStart#	
#$Revision: 6928 $, $LastChangedBy: mueding $	
#SubjectAreas#: Artikelstamm, SAP, WAWI	
#DescEnd#	
*/	
(	
   client_id	
  ,item_id	
  ,item_desc	
  ,orig_item_nr	
  ,language_id	
)	
AS	
   SELECT	
      itm.client_id,	
   itm.item_sid AS item_id,	
   Coalesce(descr.item_descr, descr_stiftung.item_descr) AS item_desc,	
   Cast(Coalesce(itm_s.src_matnr, itm.src_matnr, itm.src_orig_item_nr) AS DECIMAL(18,0)) AS orig_item_nr,	
   lang.language_id	
   FROM p_lew_core_ac.v_item_1 itm	
   INNER JOIN p_lew_core_ac.v_client_1 cli	
   ON cli.client_id = itm.client_id	
   INNER JOIN p_lew_core_ac.v_country_1 ctry	
   ON cli.country_sid = ctry.country_sid	
   OR ctry.src_country_lidl_cd = 'INT' -- Stiftung	
	
   INNER JOIN p_lew_core_ac.v_report_language_1 rlang	
   ON ctry.lang_sid = rlang.lang_sid	
   INNER JOIN p_lew_core_ac.v_map_lang_spras_1 lang	
   ON Trim(lang.sap_lang_cd) = Trim(rlang.iso_cd)	
   AND Trim(ctry.src_country_lidl_cd) = Trim(language_iso_cd)	
   LEFT OUTER JOIN p_lew_core_ac.v_item_1 itm_s	
   ON itm.client_id = itm_s.client_id	
   AND itm.item_sid_config = itm_s.item_sid	
   LEFT OUTER JOIN p_lew_core_ac.v_item_descr_1 descr	
   ON itm.client_id = descr.client_id	
   AND Coalesce(itm_s.item_sid, itm.item_sid) = descr.item_sid	
   AND rlang.lang_sid = descr.lang_sid	
   LEFT OUTER JOIN p_lew_core_ac.v_item_descr_1 descr_stiftung	
   ON itm.client_id = descr_stiftung.client_id	
   AND Coalesce(itm_s.item_sid, itm.item_sid) = descr_stiftung.item_sid	
   AND descr_stiftung.lang_cd = '@'	
	
 -- nur numerische Artikel_1 oder WAWI	
 WHERE	
   TRY_CAST(itm.src_matnr AS DECIMAL(20)) IS NOT NULL	
   OR itm.src_matnr IS NULL	
;