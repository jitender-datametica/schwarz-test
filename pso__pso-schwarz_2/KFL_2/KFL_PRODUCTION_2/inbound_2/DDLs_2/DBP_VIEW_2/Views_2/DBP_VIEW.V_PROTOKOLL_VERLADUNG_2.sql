CREATE OR REPLACE VIEW DBP_VIEW.V_PROTOKOLL_VERLADUNG_2 AS 
    SELECT 
         mandant_id
        ,tour_id
        ,handling_unit_id_ext
        ,datzeit_scan
        ,wup_id
        ,nb_id
        ,lagernummer_id
        ,kunde_id
        ,dat_scan
        ,zeit_scan
        ,versandeinheit_id
        ,lief_beleg_id
        ,dat_lief_soll
        ,arbeitsgebiet_id
        ,pruef_id
        ,gesamtgewicht_hu

FROM DBP_DATA.PROTOKOLL_VERLADUNG_2 ;