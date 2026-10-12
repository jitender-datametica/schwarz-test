create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_WUP_LAGEREINHEIT_PER_2(
	LAGEREINHEIT_ID,
	MANDANT_ID,
	DAT_ZEIT,
	LAGERNUMMER_ID,
	LAGERTYP_ID,
	WUP_ID,
	NB_ID,
	DAT_LETZTE_BEWEGUNG,
	SPURNUMMER,
	LAGER_EINHEITEN_TYP,
	BSF_VIRTUELL_ID
) as
SELECT
t01.lagereinheit_id
,t01.mandant_id
,t02.dat_zeit
,t01.lagernummer_id
,t01.lagertyp_id
,t01.wup_id
,t01.nb_id
,t01.dat_letzte_bewegung
,t01.spurnummer
,t01.lager_einheiten_typ
,COALESCE(t03.bsf_virtuell_fg,0) AS bsf_virtuell_id
FROM dbp_view.v_wup_lagereinheit_per_2 t01
JOIN DBP_MSI_VIEW3_MATERIALIZED.mv_tag_stunde_2 t02
ON t02.dat_zeit >= t01.datzeit_von AND t02.dat_zeit < t01.datzeit_bis
LEFT OUTER JOIN dbp_view.v_wup_lagernummer_bsflaeche_virtuell_per_2 t03
ON t01.mandant_id=t03.mandant_id AND t01.wup_id=t03.wup_id AND t01.lagernummer_id=t03.lagernummer_id AND t01.spurnummer = t03.bsflaeche_id
AND t02.dat between t03.dat_von and t03.dat_bis
WHERE t02.dat_zeit <=CURRENT_DATE;