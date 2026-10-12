CREATE OR REPLACE VIEW DBP_VIEW.V_WBS_MANDANT_AUSLIEFERUNGSGRUPPE_TAG_ZEITSLOTS_ZU_1 AS 
    SELECT 
        mandant_id
        ,auslieferungsgruppe_id
        ,wtag_id
        ,zeitslot_id


FROM DBP_DATA.wbs_mandant_auslieferungsgruppe_tag_zeitslots_zu_1 ;