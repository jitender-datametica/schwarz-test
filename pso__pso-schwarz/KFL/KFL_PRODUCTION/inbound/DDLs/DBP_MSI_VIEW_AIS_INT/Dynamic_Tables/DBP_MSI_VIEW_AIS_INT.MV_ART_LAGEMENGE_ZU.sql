CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ART_LAGEMENGE_ZU
(
mandant_id
, art_id
, lagemenge
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.mandant_id, 
   v01.art_id, 
   COALESCE(v02.lagemenge,1)

   FROM dbp_view.v_art v01
   LEFT OUTER JOIN
   (
   SELECT
   mandant_id, 
   art_id, 
   Cast(
   -- Runden durch CAST zu DECIMAL
   CAST(
   CAST(1 AS NUMBER(38,5)) /umrech_faktor AS DECIMAL (12,0))  AS INTEGER) AS lagemenge

   FROM dbp_view.v_art_umrechnung_faktor_per
   WHERE altnv_menge_einh_id = 'VST'
   AND dat_bis='9999-12-31'
   ) v02
   ON   v01.mandant_id =v02.mandant_id
   AND v01.art_id = v02.art_id;