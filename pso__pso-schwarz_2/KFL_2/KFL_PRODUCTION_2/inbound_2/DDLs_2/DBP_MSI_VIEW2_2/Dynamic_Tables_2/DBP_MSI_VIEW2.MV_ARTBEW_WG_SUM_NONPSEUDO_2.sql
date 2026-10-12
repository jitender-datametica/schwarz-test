CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ARTBEW_WG_SUM_NONPSEUDO_2
(
	ART_ID,
	VK_MENGE,
	DAT,
	MANDANT_ID,
	NB_ID,
	WG_ART_FG,
	WUP_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
c.art_id,
SUM(CAST(menge AS NUMBER(38,5))),
dat,
a.mandant_id,
nb_id,
wg_art_fg,
wup_id

FROM dbp_view.v_art_2 a
INNER JOIN dbp_view.v_artbew_2 c
ON a.art_id=c.art_id
WHERE a.wg_art_fg = 0
AND a.mandant_id = 1
GROUP BY 1,3,4,5,6,7;