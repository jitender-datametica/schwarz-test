create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_DT_PMR_COUNTS_1(
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	ART_ID,
	WUP_ID,
	NB_ID,
	WUP_COUNT_ANGEBOT,
	ART_COUNT_ANGEBOT
) target_lag = '1 hour' refresh_mode = AUTO initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_LOG
 as
 --2026-05-07, INC000879248, adding filter for listung
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
            v05bb.DAT_ANGEBOT_GUELTIG_VON AS dat_von,
            v05bb.DAT_ANGEBOT_GUELTIG_BIS AS dat_bis,
            v05b.angebot_nr AS angebot_id,
            v05b.art_id,
            v05b.wup_id,
            v05b.nb_id,
            COUNT(DISTINCT v05b.wup_id) OVER (PARTITION BY v05b.art_id, v05b.mandant_id, v05bb.DAT_ANGEBOT_GUELTIG_VON, v05bb.DAT_ANGEBOT_GUELTIG_BIS, v05b.angebot_nr) AS distinct_wup_count,
            COUNT(DISTINCT v05b.art_id) OVER (PARTITION BY v05b.mandant_id, v05bb.DAT_ANGEBOT_GUELTIG_VON, v05bb.DAT_ANGEBOT_GUELTIG_BIS, v05b.angebot_nr) AS distinct_art_count
        FROM 
            dbp_view.v_angebot_art_wup_zu_1 v05b
            JOIN dbp_view.v_angebot_1 v05bb
            ON v05b.mandant_id = v05bb.mandant_id
            AND v05b.angebot_nr = v05bb.angebot_nr
        WHERE 
            v05bb.DAT_ANGEBOT_GUELTIG_VON >= CURRENT_DATE AND angebot_geloescht_fg=0
            AND EXISTS (SELECT 1
FROM DBP_VIEW.V_ART_LIST_WUP_ZU_PER_1 V02
WHERE V02.DAT_VON <= v05bb.DAT_ANGEBOT_GUELTIG_VON 
AND V02.DAT_BIS  >= v05bb.DAT_ANGEBOT_GUELTIG_BIS
AND v05b.MANDANT_ID=V02.MANDANT_ID
AND v05b.WUP_ID=V02.WUP_ID
AND v05b.ART_ID=V02.ART_ID)
AND v05bb.angebot_typ_cd NOT IN ('ZAI','ZAIR','ZAIM')
AND v05bb.angebot_status_id = 6 
AND v05bb.transfer_status_id IN (3, 5, 6) 
        GROUP BY 
            v05b.mandant_id,  
            v05bb.DAT_ANGEBOT_GUELTIG_VON, 
            v05bb.DAT_ANGEBOT_GUELTIG_BIS,
            v05b.angebot_nr,
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
