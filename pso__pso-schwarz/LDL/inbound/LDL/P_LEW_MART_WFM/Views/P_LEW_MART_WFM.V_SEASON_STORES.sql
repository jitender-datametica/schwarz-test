CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_SEASON_STORES
(
   iso_cd
  ,aspect_id
  ,wh_id
  ,wh_desc
  ,store_id
  ,store_desc
 )
AS

   SELECT  str.iso_cd,
   str.aspect_id,
   str.wh_id,
   whm.wh_desc,
   str.store_id,
   str.store_desc
   FROM (

           (
               SELECT  cli.country_cd              AS iso_cd,
   str.aspect_id               AS aspect_id,
   stw.orig_wh_nr              AS wh_id,
   str.src_orig_store_nr       AS store_id,
   str.store_desc              AS store_desc,
   stw.loc_sid_wh              AS loc_sid_wh
               FROM p_lew_bil_ac.v_org_store_merge str
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse stw
   ON str.loc_sid_store_move_to = stw.loc_sid_store
   AND CURRENT_DATE BETWEEN stw.dwh_valid_from AND stw.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_client AS cli
   ON str.client_id = cli.client_id
   WHERE str.aspect_id = 1
)
UNION ALL
(
   SELECT  cli.country_cd              AS iso_cd,
   str.aspect_id               AS aspect_id,
   wh.src_wh_id                AS wh_id,
   str.src_orig_store_nr       AS store_id,
   str.store_desc              AS store_desc,
   str.loc_sid_wh              AS loc_sid_wh
               FROM p_lew_bil_ac.v_org_store_merge str
   INNER JOIN p_lew_bil_ac.v_warehouse wh
   ON str.loc_sid_wh = wh.loc_sid_wh
   AND CURRENT_DATE BETWEEN wh.dwh_valid_from AND wh.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_client AS cli
   ON str.client_id = cli.client_id
   WHERE str.aspect_id = 2
)

) AS str
   INNER JOIN p_lew_core_ac.v_wawi_org_wh_merge_act whm
   ON str.loc_sid_wh = whm.wh_loc_sid
   AND str.aspect_id = whm.aspect_id
;