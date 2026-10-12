CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_MHD_WERBENACHVERMARKTUNG (
	MANDANT_ID,
	WUP_ID,
	ART_ID,
	KJWO,
	WERBE_TYP_ID,
	MIN_LFDAT,
	MIN_MHD,
	NB_ID
) AS
 --20220929 dknop: AP0135037_SPEC0157981 adding avq_relevant_fg  = 1
 --20221028, changing to COALESCE(wkw.avq_relevant_fg,1)
 --20231122, nwag, limit to last 2 yrs - cost opt.
 --2024-08-06,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
SELECT t.mandant_id
    --,wup_id
    --,CASE WHEN TRY_CAST(t.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END wup_id 
    ,v05.aktuell_wup_id wup_id 
    ,art_id
    ,kjwo
    ,werbe_typ_id
    ,dat_lief_soll AS min_lfdat
    ,dat_haltbarkeit AS min_mhd
    ,0 AS nb_id
FROM (
        SELECT wkw.mandant_id
            ,wkw.wup_id
            ,wkw.art_id
            ,wkw.kjwo
            ,wkw.werbe_typ_id
            ,bld.dat_lief_soll
            ,bld.dat_haltbarkeit
            ,ROW_NUMBER() OVER (
                PARTITION BY wkw.mandant_id
                ,wkw.wup_id
                ,wkw.art_id
                ,wkw.kjwo
                ,wkw.werbe_typ_id
                ,a.dat_von
                ,a.dat_bis
                ORDER BY bld.dat_lief_soll ASC NULLS LAST
                ,bld.dat_haltbarkeit ASC NULLS LAST
            ) AS row_num
        FROM dbp_view.v_werbung_kennzahlen_woche wkw
            JOIN dbp_view.v_aktion_art_wup_zu aaw ON wkw.mandant_id = aaw.mandant_id
            AND wkw.art_id = aaw.art_id
            AND wkw.wup_id = aaw.wup_id
            AND aaw.dat_sperrung IS NULL
            AND aaw.dat_preisaktiviert >= '1900-01-01'
            AND aaw.wrg_id IS NOT NULL
            JOIN dbp_view.v_aktion a ON a.mandant_id = aaw.mandant_id
            AND a.aktion_id = aaw.aktion_id
            AND wkw.kjwo = a.kjwo_von
            LEFT OUTER JOIN (
                SELECT stpo.mandant_id
                ,stpo.art_id AS art_id
                ,mast.art_id AS art_id_display
                FROM dbp_view.v_stueckliste mast
                    JOIN dbp_view.v_stueckliste_det stpo ON mast.mandant_id = stpo.mandant_id
                    AND mast.stueckliste_id = stpo.stueckliste_id
                    AND mast.stueckliste_verwendung_id = 3
                    AND stpo.stueckliste_typ_id = 'M'
            ) stl ON wkw.mandant_id = stl.mandant_id
            AND wkw.art_id = stl.art_id
            LEFT OUTER JOIN (
                SELECT bl.mandant_id
                ,bl.wup_id
                ,bld.art_id
                ,bl.dat_lief_soll
                ,bld.dat_haltbarkeit
                FROM dbp_view.v_besch_lief bl
                    JOIN dbp_view.v_besch_lief_det bld ON bld.mandant_id = bl.mandant_id
                    AND bl.lief_beleg_id = bld.lief_beleg_id
                    AND bl.dat_lief_soll = bld.dat_lief_soll
                WHERE lief_typ_id IN ('YM', 'YU', 'YNOT', 'NL', 'ZLFI', 'ZLCC')
            ) bld ON bld.mandant_id = wkw.mandant_id
            AND bld.dat_lief_soll BETWEEN a.dat_von -7 AND a.dat_bis -- bugfix + erweiterung displays 09.06.2020 [nw]
            AND bld.wup_id = wkw.wup_id
            AND bld.art_id = COALESCE(stl.art_id_display, wkw.art_id)
       WHERE COALESCE(wkw.avq_relevant_fg,1)=1
       AND wkw.kjwo IN (SELECT kjwo FROM dbp_view.v_tag WHERE akt_kj BETWEEN -2 AND 1 GROUP BY kjwo)
       ) t
INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = t.mandant_id
   --AND v05.wup_id = CASE WHEN TRY_CAST(t.wup_id  AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(t.wup_id  AS INTEGER) END
   AND v05.wup_id = t.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))
       
WHERE row_num = 1;