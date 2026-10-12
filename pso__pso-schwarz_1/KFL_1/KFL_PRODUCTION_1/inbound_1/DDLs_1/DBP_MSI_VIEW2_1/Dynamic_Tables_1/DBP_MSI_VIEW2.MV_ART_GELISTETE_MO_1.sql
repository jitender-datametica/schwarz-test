CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_GELISTETE_MO_1
(
ART_ID,
MANDANT_ID,
LISTUNG_ID,
KJMO
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.art_id, 
v01.mandant_id, 
v01.listung_id, 
v02.kjmo

FROM
   (
   SELECT
   art_id, wup_id, dat_von, dat_bis, mandant_id, listung_id
   FROM dbp_view.v_art_wup_zu_per_1
   WHERE mandant_id = 1
   AND listung_id = 1
   AND nb_id = 0
   AND dat_bis = '9999-12-31'
   ) v01
INNER JOIN dbp_view.v_monat_1 v02
ON v02.kjmo BETWEEN TO_NUMBER(TO_CHAR(V01.DAT_VON, 'YYYYMM')) AND TO_NUMBER(TO_CHAR(V01.DAT_BIS,'YYYYMM'))
WHERE v02.akt_mo <= 0;
