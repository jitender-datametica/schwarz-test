CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_SUPPLIER_EKS_HIST_2
/*****************************************************************************************
* Jens Thole (c) 05.07.2018
* Erstellung der historisierten Zielstruktur, die nun nur noch Suppliergranular ist. die vorher im Core vorhandenen Granularität (SUP, EKS)
* wird projiziert auf den Supplier_2, indem die in jedem Zeitintervall vorkommenden Kombinationen als Liste erstellt weird.
* Zudem, werden die ersten 10 EKS-Nummern in Feldern pivotiert.
*
* Es wird der in V_MAT0 gebildete Schalter MAP_TYPE (MULTIPLE|UNIQUE|NOT RELEVANT) benutzt ,
* um die Verarbeitung zu splitten und die aufwendige Listenbildung nur für die Zeilen durchzuführen, die dies auch benötigen.
* So kann der Prozeß viel leichtgewichtiger bzgl CPU-LAst aufgebaut werden.
*****************************************************************************************/
AS
SELECT
    client_id
    ,sup_sid
    ,eks_no_list
    ,eks_no_01
    ,eks_no_02
    ,eks_no_03
    ,eks_no_04
    ,eks_no_05
    ,eks_no_06
    ,eks_no_07
    ,eks_no_08
    ,eks_no_09
    ,eks_no_10
    ,deleted_fg
    ,(DATEADD('day',1,schnitt_peri_start)) AS dwh_valid_from
    ,schnitt_peri_end AS dwh_valid_to
    -- TODO: check if one day has to be substracted (PERIOD datatype makes last day exclusive)                ..
 ,CASE
        WHEN CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to THEN 1
        ELSE 0
    END dwh_actual_fg
FROM
    (
    SELECT
        client_id
        ,sup_sid
        ,eks_no_list
        ,eks_no_01
        ,eks_no_02
        ,eks_no_03
        ,eks_no_04
        ,eks_no_05
        ,eks_no_06
        ,eks_no_07
        ,eks_no_08
        ,eks_no_09
        ,eks_no_10
        ,deleted_fg
        ,MIN(schnitt_peri_start) AS schnitt_peri_start
        ,MAX(schnitt_peri_end) AS schnitt_peri_end
    FROM
        (
        SELECT
            *
            ,SUM(group_start_flag) OVER (PARTITION BY client_id
            ,sup_sid
            ,eks_no_list
            ,eks_no_01
            ,eks_no_02
            ,eks_no_03
            ,eks_no_04
            ,eks_no_05
            ,eks_no_06
            ,eks_no_07
            ,eks_no_08
            ,eks_no_09
            ,eks_no_10
            ,deleted_fg
        ORDER BY
            schnitt_peri_start ROWS UNBOUNDED PRECEDING) AS group_id
        FROM
            (
            SELECT
                client_id
                ,sup_sid
                ,eks_no_list
                ,eks_no_01
                ,eks_no_02
                ,eks_no_03
                ,eks_no_04
                ,eks_no_05
                ,eks_no_06
                ,eks_no_07
                ,eks_no_08
                ,eks_no_09
                ,eks_no_10
                ,deleted_fg
                ,schnitt_peri_start
                ,schnitt_peri_end
                ,(CASE
                    WHEN schnitt_peri_start <= LAG(schnitt_peri_end) OVER (PARTITION BY client_id
                    ,sup_sid
                    ,eks_no_list
                    ,eks_no_01
                    ,eks_no_02
                    ,eks_no_03
                    ,eks_no_04
                    ,eks_no_05
                    ,eks_no_06
                    ,eks_no_07
                    ,eks_no_08
                    ,eks_no_09
                    ,eks_no_10
                    ,deleted_fg
                ORDER BY
                    schnitt_peri_start
                    ,schnitt_peri_end) THEN 0
                    ELSE 1
                END) AS group_start_flag
            FROM
                (
                SELECT
                    client_id
                    ,sup_sid
                    ,eks_no_list
                    ,NULLIFZERO(TO_NUMBER(STRTOK(',' || eks_no_list, ',', 1))) eks_no_01
                    ,TO_NUMBER(STRTOK(',' || eks_no_list, ',', 2)) eks_no_02
                    ,TO_NUMBER(STRTOK(',' || eks_no_list, ',', 3)) eks_no_03
                    ,TO_NUMBER(STRTOK(',' || eks_no_list, ',', 4)) eks_no_04
                    ,TO_NUMBER(STRTOK(',' || eks_no_list, ',', 5)) eks_no_05
                    ,TO_NUMBER(STRTOK(',' || eks_no_list, ',', 6)) eks_no_06
                    ,TO_NUMBER(STRTOK(',' || eks_no_list, ',', 7)) eks_no_07
                    ,TO_NUMBER(STRTOK(',' || eks_no_list, ',', 8)) eks_no_08
                    ,TO_NUMBER(STRTOK(',' || eks_no_list, ',', 9)) eks_no_09
                    ,TO_NUMBER(STRTOK(',' || eks_no_list, ',', 10)) eks_no_10
                    ,deleted_fg
                    ,schnitt_peri_start
                    ,schnitt_peri_end
                FROM
                    (
                    SELECT
                        client_id
                        ,sup_sid
                        ,TO_VARCHAR(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(TO_VARCHAR(LISTAGG(TRIM(eks_vc)|| ',') :: VARCHAR(100)), ' ', ''), ',,', ','), ',,', ','), ','), ',') :: VARCHAR(100)) eks_no_list
                        ,MIN(deleted_fg) deleted_fg
                        ,schnitt_peri_start
                        ,schnitt_peri_end
                    FROM
                        p_lew_bil.v_mat0_supplier_eks_hist_2
                    WHERE
                        map_type = 'MULTIPLE'
                    GROUP BY
                        client_id
                        ,sup_sid
                        ,schnitt_peri_start
                        ,schnitt_peri_end ) multi_rows
            UNION ALL
                SELECT
                    client_id
                    ,sup_sid
                    ,TO_VARCHAR(NULLIF((eks_vc),'') :: VARCHAR(100)) eks_no_list
                    ,NULLIFZERO(TRY_TO_NUMBER(eks_vc)) eks_no_01
                    ,TO_NUMBER(NULL) eks_no_02
                    ,TO_NUMBER(NULL) eks_no_03
                    ,TO_NUMBER(NULL) eks_no_04
                    ,TO_NUMBER(NULL) eks_no_05
                    ,TO_NUMBER(NULL) eks_no_06
                    ,TO_NUMBER(NULL) eks_no_07
                    ,TO_NUMBER(NULL) eks_no_08
                    ,TO_NUMBER(NULL) eks_no_09
                    ,TO_NUMBER(NULL) eks_no_10
                    ,CASE
                        WHEN NULLIF(eks_vc,'') IS NULL THEN 1
                        ELSE deleted_fg
                    END deleted_fg
                    ,schnitt_peri_start
                    ,schnitt_peri_end
                FROM
                    p_lew_bil.v_mat0_supplier_eks_hist_2 unq_rows
                WHERE
                    map_type = 'UNIQUE' ) g1 ) g2 ) g3
    GROUP BY
        client_id
        ,sup_sid
        ,eks_no_list
        ,eks_no_01
        ,eks_no_02
        ,eks_no_03
        ,eks_no_04
        ,eks_no_05
        ,eks_no_06
        ,eks_no_07
        ,eks_no_08
        ,eks_no_09
        ,eks_no_10
        ,deleted_fg
        ,group_id) tmprl_schrumpf
WHERE
    NOT(dwh_valid_to-dwh_valid_from = 2958462
    AND deleted_fg = 1);
