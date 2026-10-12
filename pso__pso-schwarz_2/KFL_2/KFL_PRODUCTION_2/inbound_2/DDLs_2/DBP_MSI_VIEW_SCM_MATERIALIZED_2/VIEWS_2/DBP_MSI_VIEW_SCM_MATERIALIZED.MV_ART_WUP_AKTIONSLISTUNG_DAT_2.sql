create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_WUP_AKTIONSLISTUNG_DAT_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT,
	AKTIONSLISTUNG_FG
) as
SELECT
aws.mandant_id, 
aws.wup_id, 
aws.nb_id, 
aws.art_id, 
t.dat, 
coalesce(aktionslistung_fg,0) AS aktionslistung_fg
FROM dbp_view.v_art_list_wup_zu_per_2 aws

JOIN dbp_view.v_tag_2 t 
ON 
t.dat BETWEEN aws.dat_von 
AND aws.dat_bis

LEFT JOIN 
(
SELECT
a.mandant_id,
wup_id, 
art_id ,
t.dat,
1 as aktionslistung_fg
FROM dbp_view.v_aktion_art_wup_zu_2 aaw 
JOIN dbp_view.v_aktion_2 a
ON a.aktion_id=aaw.aktion_id
AND a.mandant_id=aaw.mandant_id 
JOIN dbp_view.v_tag_2 t 
ON 
t.dat BETWEEN a.dat_von 
AND a.dat_bis
WHERE
--ausland
((a.mandant_id<> 1 AND dat_preisaktiviert <> '1900-01-01' AND vk_aktion_brutto > 0 )
OR
--de 
(a.mandant_id = 1 AND dat_sperrung IS NULL)) GROUP BY 1,2,3,4,5
) al ON  al.mandant_id=aws.mandant_id AND al.wup_id= aws.wup_id AND al.art_id=aws.art_id AND t.dat = al.dat
WHERE aws.nb_id=0;