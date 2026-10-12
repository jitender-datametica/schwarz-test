CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_STORE_OPEN_HOURS_BASE_2
/*
#DescStart#
#$Revision: 7220 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    country_lidl_cd
    , client_id
    , orig_store_nr
    , loc_sid_store
    , open_time_mo_nrm
    , open_time_tu_nrm
    , open_time_we_nrm
    , open_time_th_nrm
    , open_time_fr_nrm
    , open_time_sa_nrm
    , open_time_su_nrm
    , open_time_mo
    , open_time_tu
    , open_time_we
    , open_time_th
    , open_time_fr
    , open_time_sa
    , open_time_su
)
AS
SELECT
country_lidl_cd,
client_id,
orig_store_nr,
loc_sid_store,
open_time_mo_nrm,
open_time_tu_nrm,
open_time_we_nrm,
open_time_th_nrm,
open_time_fr_nrm,
open_time_sa_nrm,
open_time_su_nrm,
open_time_mo,
open_time_tu,
open_time_we,
open_time_th,
open_time_fr,
open_time_sa,
open_time_su
FROM p_lew_mart_wfm.v_store_open_hours_base_2
;


