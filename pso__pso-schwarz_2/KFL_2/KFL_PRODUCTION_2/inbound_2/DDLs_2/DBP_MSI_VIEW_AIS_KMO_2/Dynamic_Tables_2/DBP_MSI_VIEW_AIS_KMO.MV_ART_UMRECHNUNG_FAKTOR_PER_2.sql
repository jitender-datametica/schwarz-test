CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_UMRECHNUNG_FAKTOR_PER_2
-- Logik für KMO angepasst  - sschuecke 23.05.2018
(
  mandant_id
, altnv_menge_einh_id
, art_id
, dat_von
, bruttogew
, umrech_faktor
, gew_einh_id
, dat_bis
, laenge
, breite
, hoehe
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   mandant_id,
   altnv_menge_einh_id,
   art_id,
   dat_von,
   bruttogew,
   umrech_faktor,
   gew_einh_id,
   dat_bis,
   laenge,
   breite,
   hoehe
  FROM dbp_view.v_art_umrechnung_faktor_per_2
  WHERE mandant_id = 2
  AND dat_bis = '9999-12-31'
  AND TRIM(altnv_menge_einh_id) IN ('ST', 'KAR')
;