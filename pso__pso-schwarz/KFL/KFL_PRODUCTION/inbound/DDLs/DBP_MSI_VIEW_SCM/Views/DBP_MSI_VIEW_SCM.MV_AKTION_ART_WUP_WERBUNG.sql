CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_AKTION_ART_WUP_WERBUNG(
	AKTION_ID,
	MANDANT_ID,
	KJWO,
	DAT_VON,
	DAT_BIS,
	VK_AKTION_BRUTTO,
	ART_ID,
	WUP_ID,
	NB_ID,
	AKTIONSART_ID,
	AKTION_THEMA_ID
) AS
-- 19.07.2021 sanadze: SPEC0106469
--2024-08-02,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
SELECT
 v01.aktion_id
,v01.mandant_id
,v03.kjwo
,v01.dat_von
,v01.dat_bis
,v02.vk_aktion_brutto
,v02.art_id
--,v02.wup_id
--,COALESCE(CASE WHEN TRY_CAST(v02.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END, v02.wup_id) wup_id
,v05.aktuell_wup_id
,v02.nb_id
,v01.aktionsart_id
,v02.aktion_thema_id
FROM dbp_view.v_aktion   v01

LEFT JOIN dbp_view.v_aktion_art_wup_zu    v02
ON  v02.aktion_id = v01.aktion_id
AND v02.mandant_id = v01.mandant_id

LEFT JOIN dbp_view.v_wup v05
   ON v05.mandant_id = v01.mandant_id 
   --AND v05.wup_id = CASE WHEN TRY_CAST(v02.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v02.wup_id AS INTEGER) END
   AND v05.wup_id = v02.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

JOIN dbp_view.v_tag v03
ON (v01.dat_von = v03.dat)

WHERE --v01.preisaktiviert_fg = 1
--AND
v02.dat_sperrung IS NULL;