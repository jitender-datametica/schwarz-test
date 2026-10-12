CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_MARKTABSCHRIFTEN_REGALACHSE_2
(
	MANDANT_ID,
	WUP_ID,
	ABSCHRIFTENART_ID,
	NB_ID,
	DAT,
	WOCHE_ID,
	ART_ID,
	FBB_NR,
	FACHBODEN_NR,
	FACHBODEN_POS,
	ABSCHRIFTENBETRAG_NETTO
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.mandant_id, 
v01.wup_id, 
v01.abschriftart_id, 
v01.nb_id, 
v01.dat, 
v01.woche_id, 
v01.art_id, 
r.fbb_nr, 
r.fachboden_nr, 
r.fachboden_pos, 
CASE WHEN v01.abschriftbetrag_netto > 0 THEN CAST (v01.abschriftbetrag_netto AS NUMBER(38,5)) * r.kapazitaet_faktor END AS abschriftenbetrag_netto

FROM dbp_view.v_marktabschriften_2 v01
INNER JOIN dbp_view.v_regalachse_akt_2 r
ON v01.art_id = r.art_id AND
v01.mandant_id = r.mandant_id AND
v01.wup_id = r.wup_id AND
v01.nb_id =r.nb_id
WHERE v01.mandant_id = 1;
