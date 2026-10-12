create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WBS_GEWICHTE_TAG_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	AKTION_ID,
	DAT_VON,
	DAT_BIS,
	KATEGORIE,
	ANZAHL_FAELLE,
	GEWICHT_TAG1,
	GEWICHT_TAG5,
	GEWICHT_TAG3,
	GEWICHT_TAG2,
	GEWICHT_TAG4,
	GEWICHT_TAG11,
	GEWICHT_TAG10,
	GEWICHT_TAG9,
	GEWICHT_TAG8,
	GEWICHT_TAG7,
	GEWICHT_TAG6,
	GEWICHT_TAG14,
	GEWICHT_TAG13,
	GEWICHT_TAG12,
	REFERENZIERT_FG,
	WBS_LEVEL,
	WBS_LEVEL_ID
) as 



SELECT 
         v01.mandant_id
        
        ,COALESCE(v05.aktuell_wup_id,v01.wup_id) AS wup_id 
        
        ,v01.nb_id
        ,art_id
        ,aktion_id
        ,v01.dat_von
        ,v01.dat_bis
        ,kategorie
        ,anzahl_faelle
        ,gewicht_tag1
        ,gewicht_tag5
        ,gewicht_tag3
        ,gewicht_tag2
        ,gewicht_tag4
        ,gewicht_tag11
        ,gewicht_tag10
        ,gewicht_tag9
        ,gewicht_tag8
        ,gewicht_tag7
        ,gewicht_tag6
        ,gewicht_tag14
        ,gewicht_tag13
        ,gewicht_tag12
        ,referenziert_fg
        ,wbs_level
        ,wbs_level_id

FROM DBP_VIEW.V_WBS_GEWICHTE_TAG_2 v01
LEFT JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = v01.mandant_id
   AND v05.wup_id = v01.wup_id
   AND v05.nb_id = 0;