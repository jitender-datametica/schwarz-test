CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_STATUS_2
(
      src_country_lidl_cd
    , item_status
    , item_status_desc
    , language_id
)
AS
   SELECT
        cntry.src_country_lidl_cd,
   itm_stat.item_status,
   itm_stat.item_status_desc,
   itm_stat.language_id
   FROM p_lew_core_ac.v_wawi_ref_item_status_2 itm_stat
   JOIN p_lew_core_ac.v_country_2 cntry
   ON itm_stat.client_id = cntry.country_sid
   WHERE itm_stat.language_id = itm_stat.client_id
     /* After consultation with WFM all records with src_country_lidl_cd "INT" are to be excluded */
     AND cntry.src_country_lidl_cd <> 'INT'
;