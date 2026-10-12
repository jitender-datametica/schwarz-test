CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_APT_CORE_ITEM_PROMOTION_MEDIUM_2
(
     client_id

,          item_sid

,          promotion_dt

,          advertising_medium_cd

,          advertising_medium_pos

,          deleted_fg

,          dwh_load_id

,          dwh_created

,          dwh_updated
)
AS
(SELECT
Acipm.client_id                 AS client_id
,Acipm.item_sid                  AS item_sid
,Acipm.promotion_dt              AS promotion_dt
,Acipm.advertising_medium_cd     AS advertising_medium_cd
,Acipm.advertising_medium_pos    AS advertising_medium_pos
,Acipm.deleted_fg                AS deleted_fg
,Acipm.dwh_load_id               AS dwh_load_id
,Acipm.dwh_created               AS dwh_created
,Acipm.dwh_updated               AS dwh_updated
FROM p_lew_mart_pit_onprem.v_pit_apt_core_item_promotion_medium_2        AS Acipm
);