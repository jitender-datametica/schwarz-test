/* #DescStart#
#$Revision: 7172 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_store_open_hours_1 (
    country_lidl_cd, 
    orig_store_nr, 
    weekday, 
    open_from,
    open_until) 
AS SELECT country_lidl_cd,
 orig_store_nr,
 weekday,
 open_from,
 open_until
FROM ldl_p_lew_mart_wfm.v_store_open_hours_1;