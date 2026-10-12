CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WG_ART_AUSLIEFERUNGSGRUPPE_PER_1(
	MANDANT_ID,
	AUSLIEFERUNGSGRUPPE_ID
) AS
--2025-08-22, NSR5468127, dknop, initial
   SELECT DISTINCT v01.mandant_id
      ,v01.auslieferungsgruppe_id
    FROM DBP_VIEW.v_art_auslieferungsgruppe_per_1 v01
    
    UNION
       SELECT DISTINCT v01.mandant_id
      ,v01.auslieferungsgruppe_id
    FROM DBP_VIEW.v_wg_auslieferungsgruppe_per_1 v01
;