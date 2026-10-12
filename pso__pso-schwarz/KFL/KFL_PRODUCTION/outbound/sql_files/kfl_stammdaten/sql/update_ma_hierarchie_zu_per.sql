/*
###########################################################################
#  update archiv records
###########################################################################
*/


UPDATE ${KFL_SNFLK_COMMON_DBP_DATA}.ma_hierarchie_zu_per SET
    dat_bis = t2.dat_bis_,
    td_update = CURRENT_TIMESTAMP() FROM (SELECT
    ma_id_,
    ma_mutter_id_,
    dat_bis_
FROM (
    SELECT
        P.ma_id AS ma_id_,
        P.ma_mutter_id AS ma_mutter_id_,
        MAX(L.dat_bis) AS dat_bis_
    FROM ${KFL_SNFLK_COMMON_DBP_DATA}.ma_hierarchie_zu_per AS P
    INNER JOIN ${KFL_SNFLK_COMMON_DBP_DATA}.l_ma AS L ON P.ma_id = L.ma_id
    WHERE
        P.dat_bis = DATE '9999-12-31'
        AND P.ma_id IN (
            SELECT ma_id
            FROM (SELECT
                ma_id,
                MAX(dat_bis) AS max_dat_bis
            FROM ${KFL_SNFLK_COMMON_DBP_DATA}.l_ma
            GROUP BY ma_id) AS q
            WHERE max_dat_bis <> DATE '9999-12-31'
        )
    GROUP BY
        ma_id_,
        ma_mutter_id_
) AS q) AS t2
WHERE
    ma_hierarchie_zu_per.ma_id = t2.ma_id_ AND ma_hierarchie_zu_per.ma_mutter_id = t2.ma_mutter_id_ AND
    ma_hierarchie_zu_per.dat_bis = DATE '9999-12-31';


/*
###########################################################################
#  update archiv records
###########################################################################
*/


UPDATE ${KFL_SNFLK_COMMON_DBP_DATA}.ma_hierarchie_zu_per SET
    dat_bis = CURRENT_DATE("Europe/Berlin"),
    td_update = CURRENT_TIMESTAMP()
WHERE dat_bis = DATE '9999-12-31' AND (
    ma_id, ma_mutter_id) NOT IN (
    SELECT (ma_id, ma_mutter_id)
    FROM ${KFL_SNFLK_COMMON_DBP_LOAD}.ma_hierarchie_zu_per_temp
);
