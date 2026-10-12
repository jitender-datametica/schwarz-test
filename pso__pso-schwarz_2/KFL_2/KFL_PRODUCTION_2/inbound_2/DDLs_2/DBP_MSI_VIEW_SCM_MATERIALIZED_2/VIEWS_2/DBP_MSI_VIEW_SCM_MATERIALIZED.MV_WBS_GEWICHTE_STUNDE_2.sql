create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WBS_GEWICHTE_STUNDE_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	AKTION_ID,
	DAT_VON,
	DAT_BIS,
	ANZAHL_FAELLE,
	ANZAHL_FAELLE_IM_KORRIDOR,
	KORRIDOR_LEVEL,
	KATEGORIE,
	MENGE_MAX,
	MENGE_MIN,
	MENGE_AVG_21TAGE,
	ANTEIL_ZEITFENSTER1,
	ANTEIL_ZEITFENSTER2,
	REFERENZIERT_FG,
	WBS_LEVEL,
	WBS_LEVEL_ID
) as 


    SELECT 
         v01.mandant_id
       
       
        ,v05.aktuell_wup_id wup_id 
        ,v01.nb_id
        ,art_id
        ,aktion_id
        ,v01.dat_von
        ,v01.dat_bis
        ,anzahl_faelle
        ,anzahl_faelle_im_korridor
        ,korridor_level
        ,kategorie
        ,menge_max
        ,menge_min
        ,menge_avg_21tage
        ,anteil_zeitfenster1
        ,anteil_zeitfenster2
        ,referenziert_fg
        ,wbs_level
        ,wbs_level_id

FROM DBP_VIEW.V_WBS_GEWICHTE_STUNDE_2 v01
INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = v01.mandant_id
   
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0));