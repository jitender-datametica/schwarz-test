CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_SCM.MV_DT_PMR_COUNTS_2(
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	ART_ID,
	WUP_ID,
	NB_ID,
	WUP_COUNT_ANGEBOT,
	ART_COUNT_ANGEBOT
) TARGET_LAG = '60 minutes'
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG
 AS
  SELECT 
        v05bb.mandant_id,
        v05bb.dat_von,
        v05bb.dat_bis,
        v05bb.art_id,
        v05bb.wup_id,
        v05bb.nb_id,
        LISTAGG(distinct_wup_count, '|') WITHIN GROUP (ORDER BY distinct_wup_count) AS wup_count_angebot,
        LISTAGG(distinct_art_count, '|') WITHIN GROUP (ORDER BY distinct_art_count) AS art_count_angebot
    FROM (
        SELECT 
            v05b.mandant_id,
            v05b.dat_von,
            v05b.dat_bis,
            v05b.angebot_id,
            v05b.art_id,
            v05b.wup_id,
            v05b.nb_id,
            COUNT(DISTINCT v05b.wup_id) OVER (PARTITION BY v05b.art_id, v05b.mandant_id, v05b.dat_von, v05b.dat_bis, v05b.angebot_id) AS distinct_wup_count,
            COUNT(DISTINCT v05b.art_id) OVER (PARTITION BY v05b.mandant_id, v05b.dat_von, v05b.dat_bis, v05b.angebot_id) AS distinct_art_count
        FROM 
            dbp_view.v_pmr_angebot_art_wup_zu_2 v05b
        WHERE 
            v05b.dat_von >= CURRENT_DATE
        GROUP BY 
            v05b.mandant_id,  
            v05b.dat_von, 
            v05b.dat_bis,
            v05b.angebot_id,
            v05b.art_id,
            v05b.wup_id,
            v05b.nb_id
    ) v05bb
    GROUP BY 
        v05bb.mandant_id,
        v05bb.dat_von,
        v05bb.dat_bis,
        v05bb.art_id,
        v05bb.wup_id,
        v05bb.nb_id
;