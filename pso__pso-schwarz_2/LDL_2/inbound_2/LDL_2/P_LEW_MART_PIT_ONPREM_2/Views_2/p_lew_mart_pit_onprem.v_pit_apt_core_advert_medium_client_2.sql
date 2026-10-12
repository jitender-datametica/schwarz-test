CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_CORE_ADVERT_MEDIUM_CLIENT_2

(
  client_id
, advert_medium
, deleted_fg
)
AS
(SELECT
Apt.client_id::INTEGER                                              AS client_id
,CASE
   WHEN Apt.advertising_medium_cd = '' THEN 'empty'::VARCHAR(100)
   ELSE
     Apt.advertising_medium_cd::VARCHAR(100)
 END                                                                AS advert_medium
,MIN ( Apt.deleted_fg )                                              AS deleted_fg
FROM p_lew_mart_pit_onprem.v_pit_apt_core_item_promotion_medium_2 Apt
GROUP BY 1, 2
);