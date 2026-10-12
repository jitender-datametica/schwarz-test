CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_LBS_ZEK_SEC_ART_ZU_1
(
	ART_ID,
	MANDANT_ID,
	ZEK_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
art2gp.art_id, 
art2gp.mandant_id, 
gp2zek.zek_id

FROM dbp_view.v_art_gp_zu_per_1 art2gp
INNER JOIN dbp_view.v_gp_1 gp2zek
ON art2gp.gp_id = gp2zek.gp_id AND
   art2gp.mandant_id = gp2zek.mandant_id AND
   art2gp.dat_bis = '9999-12-31' AND
   gp2zek.dat_bis = '9999-12-31' AND
   art2gp.mandant_id = 1 AND
   gp2zek.mandant_id = 1;