CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ITEM_ECLIENT_1
(
     effective_client_id
,          item_sid
,          client_id
,          luxembourg_fg
,          lang_sid
,          item_mstr_sid
,          orig_item_nr
,          case_size
,          dat_valid_from
,          item_name
,          item_description
)
AS
(SELECT
Ic.effective_client_id    AS effective_client_id
,Ic.item_sid               AS item_sid
,Ic.client_id              AS client_id
,Ic.luxembourg_fg          AS luxembourg_fg
,Ic.lang_sid               AS lang_sid
,Ic.item_mstr_sid          AS item_mstr_sid
,Ic.orig_item_nr           AS orig_item_nr
,Ic.case_size              AS case_size
,Ic.dat_valid_from         AS dat_valid_from
,Ic.item_name              AS item_name
,Ic.item_description       AS item_description
FROM p_lew_mart_pit_onprem.t_pit_item_eclient_1        AS Ic
);