CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT0_STORE_TO_WH_DELIVERY_HIST
AS
/*
#DescStart#
#DescEnd#
*/
SELECT  client_id
        ,loc_sid_store
        ,COUNT(DISTINCT NULLIF(loc_sid_wh_vc,'')) cnt_wh_same_prio
        ,COUNT(DISTINCT NULLIF(NULLIF(item_grp_cd_vc,'(NO_IGRP)'),'')) cnt_igrp
        ,MAX(NULLIF(NULLIF(item_grp_cd_vc,'(NO_IGRP)'),'')) max_item_grp_cd
        ,TO_VARCHAR(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(TO_VARCHAR(LISTAGG(TRIM(loc_sid_wh_vc||item_grp_cd_vc)|| ',') WITHIN GROUP (ORDER BY order_crit) :: VARCHAR(500)), ' ', ''), ',,', ','), ',,', ','), ','), ',') :: VARCHAR(100)) loc_sid_wh_rawinfo_list
        ,TO_VARCHAR(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(TO_VARCHAR(LISTAGG(TRIM(loc_sid_wh_auswahl_vc)|| ',') WITHIN GROUP (ORDER BY order_crit) :: VARCHAR(100)),' ',''),',,',','),',,',','), ','), ',') :: VARCHAR(100)) loc_sid_wh_list
        ,TO_VARCHAR(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(TO_VARCHAR(LISTAGG(TRIM(priority_vc)|| ',') WITHIN GROUP (ORDER BY order_crit) :: VARCHAR(100)),' ',''),',,',','),',,',','), ','), ',') :: VARCHAR(100)) priority_list
        ,CASE WHEN NULLIF(loc_sid_wh_rawinfo_list,'') IS NULL THEN 1 ELSE MIN(deleted_fg) END deleted_fg
        ,schnitt_valid_from dwh_valid_from
        ,schnitt_valid_to dwh_valid_to
FROM (SELECT client_id
            ,loc_sid_store
            ,loc_sid_wh
            ,loc_sid_wh_vc
            ,item_grp_sid
            ,item_grp_cd_vc
            ,CASE WHEN loc_sid_wh<>loc_sid_wh_auswahl OR deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
                ELSE TRIM(TO_VARCHAR(loc_sid_wh_auswahl :: VARCHAR(6)))
            END loc_sid_wh_auswahl_vc
            ,CASE WHEN loc_sid_wh<>loc_sid_wh_auswahl OR deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
                ELSE TRIM(TO_VARCHAR(priority :: VARCHAR(6)))
            END priority_vc
            ,order_crit
            ,item_grp_cd
            ,priority
            ,deleted_fg
            ,dwh_valid_from
            ,dwh_valid_to
            ,schnitt_valid_from
            ,schnitt_valid_to
    FROM
        (
            SELECT  maintab.client_id
                    ,maintab.loc_sid_store
                    ,maintab.loc_sid_wh
                    -- ist der Quellsatz deleted oder ist kein WH angegeben, so gib einen Leerstring aus
                    -- ansonsten P[PRIO]-WH_SID:[LOC_SID_WH]
                    ,CASE WHEN maintab.deleted_fg = 1 OR loc_sid_wh = 0 THEN '' 
                        ELSE TO_VARCHAR('P'||TRIM(TO_VARCHAR(maintab.priority :: VARCHAR(6)))||'-WH_SID:'||TRIM(TO_VARCHAR(maintab.loc_sid_wh :: VARCHAR(6))) :: VARCHAR(15))
                    END loc_sid_wh_vc
                    ,maintab.item_grp_sid
                    -- ist der Quellsatz deleted oder ist kein WH angegeben, so gib einen Leerstring aus
                    -- ansonsten (IGRP:[item_grp_cd]) bzw (NO_IGRP)
                    ,CASE WHEN maintab.deleted_fg = 1 OR loc_sid_wh = 0 THEN '' 
                        ELSE CASE WHEN maintab.item_grp_cd='@ALL' THEN '(NO_IGRP)'
                                ELSE TO_VARCHAR(TRIM('(IGRP:'||TRIM(maintab.item_grp_cd))||')' :: VARCHAR(15))
                                END
                    END item_grp_cd_vc
                    -- Mehrdeutigkeiten der WH-Zuordnung zum Store sind aufgrund der Urschlüsseldefinition (STORE-WH-IGRP) in der Quelle als
                    -- zu historisierende Grundentität möglich und daher in gewisser Weise richtig. 
                    -- Aus Business-Sicht ist jedoch immer nur ein WH einem Store zugeordnet. 
                    -- Sind mehrere zur gleichen Zeit aktiv, so müssen sie sich in der Priorität unterscheiden.
                    -- Der Freiheitsgrad ITEM-GROUP wird baw. nicht verwendet und ist auch nicht zur Verwendung vorgesehen.
                    -- Da offensichtlich SAP kein Problem hat mit Mehrdeutigkeiten, die der Fachlichkeit widersprechen, gibt es eine 
                    -- typische Interpretationsregel für diese Fälle, die dann den Satz mit dem jüngten (aktuellsten) Aktivitätsstart auswählt.
                    -- Wir simulieren diese Auswahlregel an dieser Stelle.
                    ,MAX(loc_sid_wh) OVER (PARTITION BY maintab.client_id, maintab.loc_sid_store, maintab.priority, maintab.deleted_fg, intvls.dwh_valid_from 
                                            ORDER BY maintab.dwh_valid_from DESC, maintab.dwh_valid_to DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) loc_sid_wh_auswahl
                    ,TO_VARCHAR((999-priority) :: VARCHAR(3)) || TO_VARCHAR(maintab.active_from_dt::DATE, 'yyyymmdd') :: VARCHAR(8) || TO_VARCHAR(maintab.active_to_dt::DATE, 'yyyymmdd') :: VARCHAR(8) order_crit
                    ,maintab.item_grp_cd
                    ,maintab.priority
                    ,maintab.deleted_fg
                    ,maintab.dwh_valid_from
                    ,maintab.dwh_valid_to
                    ,intvls.dwh_valid_from schnitt_valid_from
                    ,intvls.dwh_valid_to schnitt_valid_to
            FROM p_lew_core_ac.v_store_to_wh_delivery_hist maintab
                INNER JOIN (
                            SELECT  client_id
                                    ,loc_sid_store
                                    ,dwh_valid_from
                                    ,COALESCE(MIN(dwh_valid_from) OVER (PARTITION BY client_id, loc_sid_store ORDER BY dwh_valid_from
                                                                        ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)-1,TO_DATE('99991231', 'yyyymmdd') ) dwh_valid_to
                            FROM (SELECT DISTINCT client_id,loc_sid_store, dwh_valid_from
                                    FROM p_lew_core_ac.v_store_to_wh_delivery_hist x
                                    UNION
                                    SELECT DISTINCT client_id, loc_sid_store, dwh_valid_to+1
                                    FROM p_lew_core_ac.v_store_to_wh_delivery_hist x
                                ) a
                            WHERE dwh_valid_from<>TO_DATE('99991231', 'yyyymmdd')
                            ) intvls
                    ON maintab.client_id = intvls.client_id
                        AND maintab.loc_sid_store = intvls.loc_sid_store
                        AND maintab.dwh_valid_from <= intvls.dwh_valid_to
                        AND maintab.dwh_valid_to >= intvls.dwh_valid_from
            ) main_transform
    ) weissnochnicht
GROUP BY client_id
         ,loc_sid_store
         ,schnitt_valid_from
         ,schnitt_valid_to;