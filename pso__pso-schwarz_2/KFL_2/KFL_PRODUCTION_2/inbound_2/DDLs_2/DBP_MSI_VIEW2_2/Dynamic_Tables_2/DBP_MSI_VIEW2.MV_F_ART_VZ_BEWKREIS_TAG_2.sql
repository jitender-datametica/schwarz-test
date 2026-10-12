CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_F_ART_VZ_BEWKREIS_TAG_2
(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT,
	PREIS_STEUER_KZ,
	WRG_ID,
	GP_ID,
	GLD,
	STANDARD_PREIS,
	VZ_MENGE_BESTAND_BME,
	VZ_WERT_BESTAND,
	VZ_VK_WERT
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
t1.mandant_id                    AS mandant_id, 
t2.wup_id                        AS wup_id, 
t2.nb_id                         AS nb_id, 
t1.art_id                        AS art_id, 
t1.dat_gld                       AS dat, 
t1.preis_steuer_kz               AS preis_steuer_kz, 
t1.wrg_id                        AS wrg_id, 
t3.gp_id                         AS gp_id, 
t1.gld                           AS gld, 
t1.standard_preis                AS standard_preis, 
t1.menge_bestand_bme             AS vz_menge_bestand_bme, 
t1.wert_bestand                  AS vz_wert_bestand, 
t1.vk_wert                       AS vz_vk_wert

FROM dbp_view.v_art_bewertungskreis_tag_2 t1_2
INNER JOIN dbp_view.v_wup_2 t2
ON t1.bewertungskreis_id = t2.bewertungskreis_id
AND t1.mandant_id = t2.mandant_id
INNER JOIN dbp_view.v_art_gp_zu_per_2 t3
ON  t1.art_id = t3.art_id
AND t1.mandant_id = t3.mandant_id
AND t1.dat_gld BETWEEN t3.dat_von AND t3.dat_bis

WHERE t2.nb_id = -111
AND  t1.mandant_id =1;
