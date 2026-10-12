CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_ANALYTICS_ADVERT_MEDIUM

(
  client_id
, anl_advert_medium_sid      /*  version in analytics tables, until we unify everything */
, advert_medium
, advert_medium_sort_val
, advert_medium_group_sid
, advert_medium_group
, advert_medium_group_sort_val
, advert_medium_ignore_fg
, advert_medium_delete_fg
)
AS
(
SELECT
Med.client_id                                                                                           AS client_id
,Med.adv_medium_sid                                                                                      AS anl_advert_medium_sid
--CAST ( COALESCE ( Med.adv_medium_descr, 'Sonstige') AS VARCHAR ( 100 ) )     AS advert_medium
,TO_CHAR ( COALESCE ( Med.adv_medium_descr, 'Sonstige') )                                                 AS advert_medium
,Med.adv_medium_sort_val                                                                                 AS advert_medium_sort_val
,MedHist.adv_medium_grp_sid                                                                              AS advert_medium_group_sid
,MedGroup.adv_medium_grp_descr                                                                           AS advert_medium_group
,MedGroup.adv_medium_grp_sort_val                                                                        AS advert_medium_group_sort_val
,MedHist.adv_medium_ignore_fg                                                                            AS advert_medium_ignore_fg
,MedHist.adv_medium_delete_fg                                                                            AS advert_medium_delete_fg
FROM 
    p_lew_mart_pit_onprem.t_advert_medium Med

    INNER JOIN p_lew_mart_pit_onprem.t_advert_medium_hist MedHist
        ON  Med.client_id         =    MedHist.client_id
        AND Med.adv_medium_sid    =    MedHist.adv_medium_sid
        AND CURRENT_DATE() BETWEEN MedHist.dwh_valid_from AND MedHist.dwh_valid_to    /*  at the moment they are all valid (@ToDo: figure out why!) */
    
    INNER JOIN p_lew_mart_pit_onprem.t_advert_medium_group MedGroup
        ON  MedHist.client_id             =    MedGroup.client_id
        AND MedHist.adv_medium_grp_sid    =    MedGroup.adv_medium_grp_sid
);