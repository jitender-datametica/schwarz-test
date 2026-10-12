CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_LIL_FEDSTATE_US
(
      client_id
    , region_sid
    , fedstate_cd
    , valid_from
    , valid_to
    , active_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
SELECT
      client_id
    , region_sid
    , fedstate_cd
    , valid_from
    , valid_to
    , active_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM p_lew_process_mstr.t_lil_fedstate_us;