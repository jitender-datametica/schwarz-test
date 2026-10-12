CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEMGROUP_INT AS
SELECT
   client.country_cd                          AS country_iso_cd
  ,Cast(igi.src_itemgrp_int_cd AS BIGINT)     AS itemgroup_int_id
  ,CASE WHEN Substr(igi_descr.item_grp_int_descr,1,1)IN ('1','2','3','4','5','6','7','8','9','0')
        THEN Substr(igi_descr.item_grp_int_descr , Position(' ' IN igi_descr.item_grp_int_descr)+1)
        ELSE igi_descr.item_grp_int_descr
   END                                        AS itemgroup_int_desc
  ,mapp.language_id                           AS language_id
FROM p_lew_core_ac.v_itemgroup_international igi

INNER JOIN p_lew_core_ac.v_itemgroup_international_descr AS igi_descr
   ON igi.client_id = igi_descr.client_id
   AND igi.item_grp_int_sid = igi_descr.item_grp_int_sid

INNER JOIN p_lew_core_ac.v_client AS client
   ON igi.client_id = client.client_id

-- Mapping der language_id ist nur über src_spras möglich (sap_lang_cd und lang_cd stimmen nicht überein)
INNER JOIN p_lew_core_ac.v_report_language AS rlang
   ON igi_descr.lang_sid = rlang.lang_sid

-- Filterung auf sap_spras und src_spras
INNER JOIN p_lew_core_ac.v_map_lang_spras AS mapp
   ON mapp.sap_spras = rlang.src_spras

WHERE (mapp.language_id = igi.client_id OR mapp.language_id = 7)
  AND Cast(igi.src_itemgrp_int_cd AS BIGINT) > 0
;