CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WUP_LAGEREINHEIT_PER_1
AS
SELECT
t01.lagereinheit_id
,t01.mandant_id
,t02.dat_zeit
,t01.lagernummer_id
,t01.lagertyp_id
,t01.wup_id
,t01.nb_id
,t01.dat_letzte_bewegung
,t01.spurnummer
,t01.lager_einheiten_typ
,COALESCE(t03.bsf_virtuell_fg,0) AS bsf_virtuell_id
FROM dbp_view.v_wup_lagereinheit_per_1 t01
JOIN dbp_msi_view3.mv_tag_stunde_1 t02
ON t02.dat_zeit >= t01.datzeit_von AND t02.dat_zeit < t01.datzeit_bis
LEFT OUTER JOIN dbp_view.v_wup_lagernummer_bsflaeche_virtuell_per_1 t03
ON t01.mandant_id=t03.mandant_id AND t01.wup_id=t03.wup_id AND t01.lagernummer_id=t03.lagernummer_id AND t01.spurnummer = t03.bsflaeche_id
AND t02.dat between t03.dat_von and t03.dat_bis
WHERE t02.dat_zeit <=CURRENT_DATE;