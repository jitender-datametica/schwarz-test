CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_BONUSKAUF_PROMOTIONSTYP_2(
	BONUSKAUF_PROMOTIONSTYP_ID,
	BONUSKAUF_PROMOTIONSTYP_DESC
) AS
--2024-10-30, AP0234408, SPEC0265659, dknop, initial
SELECT	
 COALESCE (bonuskauf_promotionstyp,'-1') AS bonuskauf_promotionstyp_id
,COALESCE (bonuskauf_promotionstyp,'STANDARD') AS bonuskauf_promotionstyp_desc
FROM	dbp_view.v_pmr_angebot_art_wup_zu_2
GROUP BY bonuskauf_promotionstyp

;