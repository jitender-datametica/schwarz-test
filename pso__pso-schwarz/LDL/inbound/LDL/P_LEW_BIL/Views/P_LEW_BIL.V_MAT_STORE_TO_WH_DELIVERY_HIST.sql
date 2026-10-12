CREATE OR REPLACE VIEW p_lew_bil.v_mat_store_to_wh_delivery_hist
AS
/*
#DescStart#
#DescEnd#
*/
SELECT  s2w_final.client_id,
        s2w_final.loc_sid_store,
        s2w_final.mult_wh_err_fg,
        s2w_final.wh_with_itemgrp_err_fg,
        s2w_final.source_raw_info,
        s2w_final.loc_sid_wh_list,
        s2w_final.priority_list,
        s2w_final.loc_sid_wh_01,
        s2w_final.priority_01,
        s2w_final.loc_sid_wh_02,
        s2w_final.priority_02,
        s2w_final.loc_sid_wh_03,
        s2w_final.priority_03,
        s2w_final.loc_sid_wh_04,
        s2w_final.priority_04,
        s2w_final.loc_sid_wh_05,
        s2w_final.priority_05,
        s2w_final.loc_sid_wh_06,
        s2w_final.priority_06,
        s2w_final.loc_sid_wh_07,
        s2w_final.priority_07,
        s2w_final.loc_sid_wh_08,
        s2w_final.priority_08,
        s2w_final.loc_sid_wh_09,
        s2w_final.priority_09,
        s2w_final.loc_sid_wh_10,
        s2w_final.priority_10,
        s2w_final.deleted_fg,
        s2w_final.dwh_valid_from,
        s2w_final.dwh_valid_to,
        s2w_final.dwh_actual_fg,
        -- ungelöschte (aktive) Zuordnungssätze sind die Auswahlbasis für eine LAST-KNOWN-Darstellung.
        -- Zusätzlich gab es in der alten ORG_STORE_SKEY-Darstellung aus dem ELWIS-COEX-LAYER eine Filterung auf diejenigen Stores,
        -- welche auch einen direkten WAWI-NaturalKey aufwiesen. Reine SAP-Lokations wurden also nicht dargestellt.
        -- Da auch bereits zukünftig aktive Sätze in der Core-Tabelle geführt werden, sind diese bei LAST-KNOWN auszublenden.
        -- Um die Menge zur alten Darstellung komplett identisch halten zu können, wird hier die eigentlich nicht mehr zu vertretende Einschränkung vorgenommen
        -- und ein Flag zur Ermittlung der alten SKEY-Last-Known-Darstellung gebildet.
        -- Normalerweise braucht lediglich das Deleted-Flag herangezogen werden, um den letzten aktiven Satz via Row-Number() zu markieren.
        -- Es kann im untigen Nummerierungs- bzw. Markierungsausdruck bei Obsoletwerden des aus COEX nachgebauten Kombatibilitätsmarts durch das DELETED_FG ersetzt werden.
        case when s2w_final.deleted_fg=0
                        and dwh_valid_from <= current_date
                        and coalesce(store.src_orig_store_nr,0) <> 0
        then 0 else 1 end lastknown_fadeout_fg,
        -- Via Row_Number() werden die Einzelsätze nummeriert pro Gruppe ([valide Sätze] und [LOCATION]) absteigend nach dem Gültigkeitsstartdatum.
        -- Der jeweils jüngste Satz der Gruppe bekommt also die Nummer 1.
        case when row_number() over (partition by LASTKNOWN_FADEOUT_FG,
                                                        s2w_final.client_id,
                                                        s2w_final.loc_sid_store
                                        order by s2w_final.dwh_valid_from desc)
                    = 1 AND LASTKNOWN_FADEOUT_FG = 0 THEN 1 else 0
        end lastknown_fg
    from
    (select client_id,
            loc_sid_store,
            case when cnt_wh_same_prio>1 then 1 else 0 end mult_wh_err_fg,
            case when cnt_igrp>0 then 1 else 0 end wh_with_itemgrp_err_fg,
            nullif(loc_sid_wh_rawinfo_list,'') source_raw_info,
            nullif(loc_sid_wh_list,'') loc_sid_wh_list,
            nullif(priority_list,'') priority_list,
            nullifzero(TO_NUMBER(STRTOK(','||loc_sid_wh_list,',',1))) loc_sid_wh_01,
            nullif(TO_NUMBER(STRTOK(','||priority_list,',',1)), 0) priority_01,
            TO_NUMBER(STRTOK(','||loc_sid_wh_list,',',2)) loc_sid_wh_02,
            TO_NUMBER(STRTOK(','||priority_list,',',2)) priority_02,
            TO_NUMBER(STRTOK(','||loc_sid_wh_list,',',3)) loc_sid_wh_03,
            TO_NUMBER(STRTOK(','||priority_list,',',3)) priority_03,
            TO_NUMBER(STRTOK(','||loc_sid_wh_list,',',4)) loc_sid_wh_04,
            TO_NUMBER(STRTOK(','||priority_list,',',4)) priority_04,
            TO_NUMBER(STRTOK(','||loc_sid_wh_list,',',5)) loc_sid_wh_05,
            TO_NUMBER(STRTOK(','||priority_list,',',5)) priority_05,
            TO_NUMBER(STRTOK(','||loc_sid_wh_list,',',6)) loc_sid_wh_06,
            TO_NUMBER(STRTOK(','||priority_list,',',6)) priority_06,
            TO_NUMBER(STRTOK(','||loc_sid_wh_list,',',7)) loc_sid_wh_07,
            TO_NUMBER(STRTOK(','||priority_list,',',7)) priority_07,
            TO_NUMBER(STRTOK(','||loc_sid_wh_list,',',8)) loc_sid_wh_08,
            TO_NUMBER(STRTOK(','||priority_list,',',8)) priority_08,
            TO_NUMBER(STRTOK(','||loc_sid_wh_list,',',9)) loc_sid_wh_09,
            TO_NUMBER(STRTOK(','||priority_list,',',9)) priority_09,
            TO_NUMBER(STRTOK(','||loc_sid_wh_list,',',10)) loc_sid_wh_10,
            TO_NUMBER(STRTOK(','||priority_list,',',10)) priority_10,
            deleted_fg,
            dwh_valid_from,
            dwh_valid_to,
            case when current_date between dwh_valid_from and dwh_valid_to then 1 else 0 end dwh_actual_fg
        from
        (SELECT client_id,
                loc_sid_store,
                cnt_wh_same_prio,
                cnt_igrp,
                max_item_grp_cd,
                loc_sid_wh_rawinfo_list,
                loc_sid_wh_list,
                priority_list,
                deleted_fg,
                dwh_valid_from,
                COALESCE(MIN(dwh_valid_from) OVER (PARTITION BY client_id, loc_sid_store ORDER BY dwh_valid_from
                                                        ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)-1,
                            TO_DATE('30.12.9999','DD.MM.YYYY')  ) dwh_valid_to
            FROM (
                SELECT   client_id,
                        loc_sid_store,
                        cnt_wh_same_prio,
                        cnt_igrp,
                        max_item_grp_cd,
                        loc_sid_wh_rawinfo_list,
                        loc_sid_wh_list,
                        priority_list,
                        deleted_fg,
                        dwh_valid_from
                FROM p_lew_bil.v_mat0_store_to_wh_delivery_hist
                MINUS
                SELECT   client_id,
                        loc_sid_store,
                        cnt_wh_same_prio,
                        cnt_igrp,
                        max_item_grp_cd,
                        loc_sid_wh_rawinfo_list,
                        loc_sid_wh_list,
                        priority_list,
                        deleted_fg,
                        dwh_valid_to+1
                FROM p_lew_bil.v_mat0_store_to_wh_delivery_hist
                ) schrumpf
        ) schrumpfhist
        WHERE NOT(dwh_valid_to-dwh_valid_from=2958462 AND deleted_fg=1)
    ) s2w_final
    --Anhängen der "echten" Stores - ergo keiner Warehouses
    LEFT OUTER JOIN (SELECT * FROM p_lew_core_ac.v_location WHERE UPPER(wh_store_mark) = 'A') AS store
    ON s2w_final.client_id = store.client_id
        AND s2w_final.loc_sid_store = store.loc_sid;