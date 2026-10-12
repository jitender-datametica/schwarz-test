--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_log
--(
--mandant_id
--,wup_id
--,nb_id
--,art_id
--,gjmo
--)
--SELECT
--t1.mandant_id
--,t1.wup_id
--,t1.nb_id
--,t1.art_id
--,MIN(COALESCE(t2.gjmo,m.gjmo)) _gjmo
--FROM
--(SELECT
--mandant_id
--,wup_id
--,nb_id
--,art_id
--,gjmo
--,gjmo_bis
--,menge_lgbest_erp_frei_bme
--,menge_lgbest_erp_umlag_bme
--,menge_lgbest_erp_qual_bme
--,menge_lgbest_erp_nf_charge_bme
--,menge_lgbest_erp_gesp_bme
--,menge_lgbest_erp_ret_gesp_bme
--FROM KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.bestand_erp_monat_tmp
--WHERE nb_id = 0
--AND (mandant_id, wup_id, art_id, gjmo_bis) IN
--(SELECT mandant_id, wup_id, art_id, gjmo_bis
--FROM KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.bestand_mardh_tmp
--WHERE lade_kz = 0
--AND nb_id = 0
--)
--) t1
--INNER JOIN
--KFL_PRODUCTION.${DWH_COMMON_DBX_DATA}.monat m
--ON  m.gjmo BETWEEN t1.gjmo AND t1.gjmo_bis
--AND m.akt_mo BETWEEN -2 AND 0
--
--LEFT OUTER JOIN
--KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.bestand_mardh_tmp1_1 t2
--ON  t1.mandant_id = t2.mandant_id
--AND t1.wup_id     = t2.wup_id
--AND t1.nb_id      = t2.nb_id
--AND t1.art_id     = t2.art_id
--AND m.gjmo BETWEEN t2.gjmo AND t2.gjmo_bis
--WHERE t1.menge_lgbest_erp_frei_bme      - COALESCE (t2.menge_lgbest_erp_frei_bme     , 0.) <> 0.
--OR t1.menge_lgbest_erp_umlag_bme     - COALESCE (t2.menge_lgbest_erp_umlag_bme    , 0.) <> 0.
--OR t1.menge_lgbest_erp_qual_bme      - COALESCE (t2.menge_lgbest_erp_qual_bme     , 0.) <> 0.
--OR t1.menge_lgbest_erp_nf_charge_bme - COALESCE (t2.menge_lgbest_erp_nf_charge_bme, 0.) <> 0.
--OR t1.menge_lgbest_erp_gesp_bme      - COALESCE (t2.menge_lgbest_erp_gesp_bme     , 0.) <> 0.
--OR t1.menge_lgbest_erp_ret_gesp_bme  - COALESCE (t2.menge_lgbest_erp_ret_gesp_bme , 0.) <> 0.
--
--HAVING (t1.mandant_id, t1.wup_id, t1.nb_id, t1.art_id, _gjmo) NOT IN
--(SELECT mandant_id, wup_id, nb_id, art_id, gjmo
--FROM KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_log
--)
--GROUP BY 1,2,3,4
--;
--
--Comment from validation checker
--error line 61 at position 0 unexpected 'GROUP'.
-- ^^^> GROUP BY 1,2,3,4
--translated statement


INSERT INTO dbp_etl.vis_monat_bestand_wg_log (
    mandant_id, wup_id, nb_id, gjmo, art_id
)
(
    SELECT
        t1.mandant_id,
        t1.wup_id,
        t1.nb_id,
        MIN(COALESCE(T2.gjmo, M.gjmo)) AS `_gjmo`,
        t1.art_id
    FROM (
        SELECT
            mandant_id,
            wup_id,
            nb_id,
            art_id,
            gjmo,
            gjmo_bis,
            menge_lgbest_erp_frei_bme,
            menge_lgbest_erp_umlag_bme,
            menge_lgbest_erp_qual_bme,
            menge_lgbest_erp_nf_charge_bme,
            menge_lgbest_erp_gesp_bme,
            menge_lgbest_erp_ret_gesp_bme
        FROM dbp_etl.bestand_erp_monat_tmp
        WHERE
            nb_id = 0
            AND (
                mandant_id, wup_id, art_id, gjmo_bis) IN (
                SELECT (mandant_id, wup_id, art_id, gjmo_bis)
                FROM dbp_etl.bestand_mardh_tmp
                WHERE
                    lade_kz = 0
                    AND nb_id = 0
            )
    ) AS t1
    INNER JOIN
        dbp_data.monat AS M
        ON M.gjmo BETWEEN t1.gjmo AND t1.gjmo_bis AND M.akt_mo BETWEEN -2 AND 0

    LEFT JOIN dbp_etl.bestand_mardh_tmp1_1 AS T2
        ON
            t1.mandant_id = T2.mandant_id AND t1.wup_id = T2.wup_id
            AND t1.nb_id = T2.nb_id
            AND t1.art_id = T2.art_id
            AND M.gjmo BETWEEN T2.gjmo AND T2.gjmo_bis
    WHERE
        t1.menge_lgbest_erp_frei_bme
        - COALESCE(T2.menge_lgbest_erp_frei_bme, 0)
        <> 0
        OR t1.menge_lgbest_erp_umlag_bme
        - COALESCE(T2.menge_lgbest_erp_umlag_bme, 0)
        <> 0
        OR t1.menge_lgbest_erp_qual_bme
        - COALESCE(T2.menge_lgbest_erp_qual_bme, 0)
        <> 0
        OR t1.menge_lgbest_erp_nf_charge_bme
        - COALESCE(T2.menge_lgbest_erp_nf_charge_bme, 0)
        <> 0
        OR t1.menge_lgbest_erp_gesp_bme
        - COALESCE(T2.menge_lgbest_erp_gesp_bme, 0)
        <> 0
        OR t1.menge_lgbest_erp_ret_gesp_bme
        - COALESCE(T2.menge_lgbest_erp_ret_gesp_bme, 0)
        <> 0
    GROUP BY
        t1.mandant_id,
        t1.wup_id,
        t1.nb_id,
        t1.art_id
    HAVING
        (t1.mandant_id, t1.wup_id, t1.nb_id, t1.art_id, `_gjmo`) NOT IN (
            SELECT
                (mandant_id, wup_id, nb_id, art_id, gjmo
                )
            FROM dbp_etl.vis_monat_bestand_wg_log
        )
);
