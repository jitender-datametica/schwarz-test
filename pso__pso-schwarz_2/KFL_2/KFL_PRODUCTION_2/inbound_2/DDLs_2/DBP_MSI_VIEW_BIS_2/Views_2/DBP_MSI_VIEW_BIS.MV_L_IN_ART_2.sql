CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_IN_ART_2
-- 03.12.2012 shog: initial
-- 19.02.2015 twie: einkaeufer_int_id heißt in Tabelle jetzt einkaeufer_bis_int_id
-- 28.07.2015 twie: Dummyartikel -1 aufgenommen
-- 20170802 ttez: Um die Spalte Status_kz erweitert
(
mandant_id
, in_art_id
, in_art_nr
, basismenge_einh_id
, artikelart_id
, best_menge_einh_id
, einkaeufer_int_id
, in_wg_id
,status_kz
)
AS
   SELECT
   v01.mandant_id,
   v01.in_art_id,
   v01.in_art_nr,
   v01.basismenge_einh_id,
   v01.artikelart_id,
   v01.best_menge_einh_id,
   v01.einkaeufer_bis_int_id AS einkaeufer_int_id,
   v01.in_wg_id,
   v01.status_kz
   FROM dbp_view.v_in_art_2 v01

   WHERE v01.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')
   OR SUBSTR( in_art_nr, 1, 1) = 'W'
   OR in_art_id = -1
;