create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_TAG(
	MANDANT_ID,
	ART_ID,
	DAT,
	ANZ_MAERKTE_DIS,
	ANZ_MAERKTE_KDIS
) as
SELECT
    marc.MANDANT_ID,
    marc.ART_ID,
    cal.dat,
    COUNT(DISTINCT CASE WHEN marc.kdis = 0 THEN marc.wup_id ELSE NULL END) AS anz_maerkte_dis,
    COUNT(DISTINCT CASE WHEN marc.kdis = 1 THEN marc.wup_id ELSE NULL END) AS anz_maerkte_kdis
FROM
    DBP_VIEW.V_tag cal
JOIN DBP_VIEW.V_ART_wup_status_per marc 
    ON cal.dat BETWEEN marc.dat_von AND marc.dat_bis
JOIN DBP_VIEW.V_ART_LIST_WUP_ZU_PER wlk1
    ON wlk1.mandant_id = marc.mandant_id
    AND wlk1.wup_id = marc.wup_id
    AND wlk1.nb_id = marc.nb_id
    AND wlk1.art_id = marc.art_id
    AND cal.dat BETWEEN wlk1.dat_von AND wlk1.dat_bis
JOIN DBP_VIEW.V_wup w
    ON wlk1.mandant_id = w.mandant_id
    AND wlk1.wup_id = w.wup_id
    AND wlk1.nb_id = w.nb_id
    AND w.nb_id = 0
    AND cal.dat BETWEEN w.dat_von AND w.dat_bis
WHERE
    cal.dat < CURRENT_DATE
    AND cal.akt_kj >= -2
GROUP BY
    marc.MANDANT_ID,
    marc.ART_ID,
    cal.dat;