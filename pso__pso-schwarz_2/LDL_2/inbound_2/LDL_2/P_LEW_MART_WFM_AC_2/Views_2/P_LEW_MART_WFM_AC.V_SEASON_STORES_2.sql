CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_SEASON_STORES_2
/*
#DescStart#
#$Revision: 10691 $, $LastChangedBy: dcamerzan $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    iso_cd
  , aspect_id
  , wh_id
  , wh_desc
  , store_id
  , store_desc
)
AS
   SELECT
       iso_cd,
   aspect_id,
   wh_id,
   wh_desc,
   store_id,
   store_desc
  FROM p_lew_mart_wfm.v_season_stores_2
;