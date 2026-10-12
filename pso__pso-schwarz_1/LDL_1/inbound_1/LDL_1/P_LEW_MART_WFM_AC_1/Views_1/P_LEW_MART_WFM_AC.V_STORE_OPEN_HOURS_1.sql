CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_STORE_OPEN_HOURS_1
/*
#DescStart#
#$Revision: 7172 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    country_lidl_cd
    , orig_store_nr
    , weekday
    , open_from
    , open_until
)
AS
SELECT
country_lidl_cd,
orig_store_nr,
weekday,
open_from,
open_until
FROM p_lew_mart_wfm.v_store_open_hours_1
;


