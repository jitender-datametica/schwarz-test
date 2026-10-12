CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_SCM.MV_DT_BONUSKAUF_PROMOTIONTYP_AGG_1(
	MANDANT_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	DAT_VON,
	DAT_BIS,
	BONUSKAUF_PROMOTIONSTYP_AGG
) TARGET_LAG = '60 minutes'
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG
 AS
  SELECT 
        v05a.mandant_id, 
        v05a.art_id, 
        v05a.wup_id, 
        v05a.nb_id, 
        v05a.dat_von, 
        v05a.dat_bis,
        LISTAGG(DISTINCT v05a.bonuskauf_promotionstyp, ', ') WITHIN GROUP (ORDER BY v05a.bonuskauf_promotionstyp) AS bonuskauf_promotionstyp_agg
    FROM 
        dbp_view.v_pmr_angebot_art_wup_zu_1 v05a
    WHERE 
        v05a.dat_von >= CURRENT_DATE
    GROUP BY 
        v05a.mandant_id, 
        v05a.art_id, 
        v05a.wup_id, 
        v05a.nb_id, 
        v05a.dat_von, 
        v05a.dat_bis
;