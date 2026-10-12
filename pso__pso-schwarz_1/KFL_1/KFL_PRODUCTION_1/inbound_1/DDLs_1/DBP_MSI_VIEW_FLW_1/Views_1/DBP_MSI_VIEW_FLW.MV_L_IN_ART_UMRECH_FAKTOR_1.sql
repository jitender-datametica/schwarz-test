CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_ART_UMRECH_FAKTOR_1
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 07.10.2014 TWIE: auch reine Retailartikel umrechnen

(
in_art_id
,mandant_id
,umrech_faktor_kg
,umrech_faktor_st
)
AS
   SELECT
   v01.flw_art_id AS in_art_id, v01.mandant_id, CASE
   --BME ist bereits KG
   WHEN v01.basismenge_einh_id = 'KG' THEN CAST(1.00 AS NUMBER(38,5))

   ELSE
   CASE
   -- Umrechnungsfaktor fuer KG bzw. NULL falls keinen gepflegt ist
   WHEN v01.flw_art_id >= 0 THEN CAST(v02.umrech_faktor AS NUMBER(38,5))
   WHEN v01.flw_art_id < 0 THEN CAST(v04.umrech_faktor AS NUMBER(38,5))
   END
   END umrech_faktor_kg, CASE
   --BME ist bereits ST
   WHEN v01.basismenge_einh_id = 'ST' THEN CAST(1.00 AS NUMBER(38,5))

   ELSE
   CASE
   -- Umrechnungsfaktor fuer ST bzw. NULL falls keinen gepflegt ist
   WHEN v01.flw_art_id >= 0 THEN CAST(v03.umrech_faktor AS NUMBER(38,5))
   WHEN v01.flw_art_id < 0 THEN CAST(v05.umrech_faktor AS NUMBER(38,5))
   END
   END umrech_faktor_st

   FROM dbp_msi_view_flw.mv_l_in_art_1 v01     -- MARA_1 + Retailartikel

   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_1 v02
   ON v01.flw_art_id              =  v02.flw_art_id
   AND v01.mandant_id         =  v02.mandant_id
   --Umrechnungsfaktor fuer 'KG'
   AND v02.altnv_menge_einh_id  = 'KG'
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_1 v03
   ON v01.flw_art_id = v03.flw_art_id
   AND v01.mandant_id         =  v03.mandant_id
   --Umrechnungsfaktor fuer 'ST'
   AND v03.altnv_menge_einh_id  = 'ST'
   LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_1 v04
   ON v01.mandant_id   = v04.mandant_id
   AND v01.art_id = v04.art_id
   --Umrechnungsfaktor fuer 'KG'
   AND v04.altnv_menge_einh_id = 'KG'
   AND v04.dat_bis = '9999-12-31'    
   LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_1 v05
   ON v01.mandant_id   = v05.mandant_id
   AND v01.art_id = v05.art_id
   --Umrechnungsfaktor fuer 'ST'
   AND v05.altnv_menge_einh_id = 'ST'
   AND v05.dat_bis = '9999-12-31';