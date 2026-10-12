CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_KOLLIFAKTOR_2
(
	MANDANT_ID,
	ART_ID,
	UMRECH_FAKTOR
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.mandant_id, 
v01.art_id, 
COALESCE(v02.umrech_faktor, 1)

FROM
   (
   SELECT
   art_id, 
   mandant_id, 
   ausg_menge_einh_id

   FROM dbp_view.v_art_vorschlagswert_per_2
   WHERE dat_bis = '9999-12-31'
   )  v01
   LEFT JOIN

   (
   SELECT
   art_id, 
   mandant_id, 
   altnv_menge_einh_id, 
   umrech_faktor

   FROM dbp_view.v_art_umrechnung_faktor_per_2
   WHERE dat_bis = '9999-12-31'
   ) v02
   ON
   v01.art_id = v02.art_id AND
   v01.mandant_id = v02.mandant_id AND
   v01.ausg_menge_einh_id = v02.altnv_menge_einh_id
   WHERE v01.mandant_id = 1;
