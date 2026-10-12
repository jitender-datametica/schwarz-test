CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_WUPCAL_MONAT as
                 -- 2009-03-12
                 -- Faktview : Kundenzahlen pro Immobilie auf  Basis wupcal
                 -- Kunden pro Markt (gemappt auf Immo-Objekt)
                 -- 2009KW17 Erweiterung immo_objekt
                 -- 2010KW33 Umlenken des Joins auf immo_objekt_per WENN Wup-Nachbildung DANN (immo_objekt_bez = wup_id) SONST (immo_objekt_id = immo_objekt_id)
                 -- 20130627 :Umstellung auf wupcal, bedingt duch Abschaltung MIS (wupcal_mo_sum)

                 SELECT
                 io.mandant_id,
                 io.immo_objekt_id,
                 wc.wup_id,
                 wc.gj,
                 wc.kjmo,
                 wc.anzahl_oeff_tage,
                 wc.bonanzahl  anzahl_kunden
       FROM dbp_view.v_ivs_immo_objekt_per io
                 LEFT JOIN (
                 SELECT
                 wc0.mandant_id,
                 wc0.wup_id,
                 zeit0.gj,
                 zeit0.kjmo,
                 SUM(offen) AS anzahl_oeff_tage,
                 SUM(wc0.bonanzahl) AS bonanzahl
       FROM dbp_view.v_wupcal  wc0

                 JOIN dbp_view.v_tag  zeit0
                 ON wc0.dat = zeit0.dat

                 WHERE wc0.nb_id = 0

                 GROUP BY
                 wc0.mandant_id
                 , wc0.wup_id
                 , zeit0.gj
                 , zeit0.kjmo
                 ) wc
                 ON  wc.wup_id = io.immo_objekt_bez
                 AND wc.mandant_id = io.mandant_id

                 WHERE io.dat_bis = '9999-12-31';