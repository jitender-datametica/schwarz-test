CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_HANDLING_UNIT
-- 13.12.2011 srom, Anforderung 543542
-- 25.05.2012 srom, Anforderung 563003, netto_vol_ladung
-- 29.04.2014 srom, Anforderung 584957, menge_handling_kolli_orig
-- 02.11.2016 srom: AP0006317, SPEC0013463 hu_status_id, hu_stellplatz_faktor
-- 17.01.2018 hmue: AP0012522, SPEC0027715 brtvol_ladung_gedeckelt  
-- 05.12.2019 baranowska: AP0041558, SPEC0066698 kj_lief_beleg
( mandant_id
, system_id
, nb_id
, wup_id
, handling_unit_id
, packmittel_typ
, hu_gew_einh_id
, hu_vol_einh_id
, lagernummer_id
, packmittelart_id
, mat_gru_packmittel
, versandstelle_id
, gewicht_ladung
, gewicht_eigen
, netto_vol_ladung
, vol_eigen
, versandeinheit_id
, handling_unit_id_ext
, lief_beleg_id
, anzahl_stellplatz
, menge_gefahrgut
, brtvol_ladung
, brtgew_ladung
, menge_handling_kolli_orig
, hu_status_id
, hu_stellplatz_faktor
, brtvol_ladung_gedeckelt
, traegertyp_bez
, kj_lief_beleg
)
AS
   SELECT
    v01.mandant_id, v01.system_id, v01.nb_id, v01.wup_id, v01.handling_unit_id, v01.packmittel_typ, v01.hu_gew_einh_id, v01.hu_vol_einh_id, v01.lagernummer_id, v01.packmittelart_id, v01.mat_gru_packmittel, v01.versandstelle_id, v01.gewicht_ladung, v01.gewicht_eigen, v01.vol_ladung AS netto_vol_ladung, v01.vol_eigen, v01.versandeinheit_id, v01.handling_unit_id_ext, v01.lief_beleg_id, CASE WHEN v01.versandeinheit_id IN (-1,1) THEN v01.anzahl_stellplatz ELSE 0 END AS anzahl_stellplatz, v01.menge_gefahrgut, v01.brtvol_ladung, v01.brtgew_ladung, v01.menge_handling_kolli_orig, v01.hu_status_id, v01.hu_stellplatz_faktor, v01.brtvol_ladung_gedeckelt, CASE WHEN v01.versandeinheit_id NOT IN (1,-1) THEN 'AUFGEPACKT'
   WHEN v01.versandeinheit_id = -1 THEN 'NORMAL'
   WHEN v01.versandeinheit_id = 1 THEN 'TRÄGER'
END AS traegertyp_bez, v01.kj_lief_beleg

   FROM dbp_view.v_handling_unit v01
   WHERE (v01.kj_lief_beleg = -1 OR v01.kj_lief_beleg >= year(current_timestamp) - 2)
;