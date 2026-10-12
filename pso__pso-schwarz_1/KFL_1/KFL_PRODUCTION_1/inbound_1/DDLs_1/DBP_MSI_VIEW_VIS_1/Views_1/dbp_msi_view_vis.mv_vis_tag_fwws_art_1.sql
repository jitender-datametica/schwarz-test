CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_vis_tag_fwws_art_1(
    MANDANT_ID,
	NB_ID,
	WUP_ID,
	ART_ID,
	DAT,
	DISPOMERKMAL,
	DISPONENT_ID,
	ARTIKEL_EXC209_FG,
	ARTIKEL_EXC214_FG,
	TAGESARTIKEL_FG,
	BESTANDSARTIKEL_FG,
	ALLE_ART_O_KDIS_FG,
	ALLE_ART_FG,
	AUTODISPO_FG_12,
	BEZUGSWEG_ID,
	AUTODISPO_FG,
	DISPO_1014_FG,
	ART_EXC252_FG,
	ART_EXC252_7D_FG,
	BESTAND_MENGE_FG,
	MAX_KAPA_FILTER
) AS
  
    -- FAKT
    -- 2020-10-07 snik1809 SPEC0081619
    -- 2020-12-01 ssch0611 : Review, moved MaxKapa from art_wup_zu_per_1, AP0047448_SPEC0095251
    -- 2021-02-23 ssch0661 : New Extensions. Join Exception 252, Join Marktbestand - AP0047448
    -- 2021-03-11 ssch0611 : Logic on day level, second exc252, removed listung - AP0047448
    -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

SELECT
    fwws.mandant_id,
    fwws.nb_id,
    wup.aktuell_wup_id                                                                          AS wup_id,
    fwws.art_id,
    fwws.dat,
    fwws.dispomerkmal,
    fwws.disponent_id,
    fwws.artikel_exc209_fg,
    fwws.artikel_exc214_fg,
    fwws.tagesartikel_fg,
    fwws.bestandsartikel_fg,
    fwws.alle_art_o_kdis_fg,
    fwws.alle_art_fg,
    fwws.autodispo_fg_12,
    fwws.bezugsweg_id,
    /* MaxKapa on day level (all 5 filters required)*/
    fwws.autodispo_fg,
    CASE
    WHEN fwws.dispomerkmal IN ('10', '14') THEN 1
    ELSE 0 END::BYTEINT                                                                         AS dispo_1014_fg,
    CASE
    WHEN exc.pruef_id = 252 THEN 1
    ELSE 0 END::BYTEINT                                                                         AS art_exc252_fg,
    CASE
    WHEN exc7d.pruef_id = 252 THEN 1
    ELSE 0 END::BYTEINT                                                                         AS art_exc252_7d_fg,
    CASE
    WHEN mbe.menge_lgbest_erp_frei_bme > 0 THEN 1
    ELSE 0 END::BYTEINT                                                                         AS bestand_menge_fg,
    autodispo_fg * dispo_1014_fg * art_exc252_fg * art_exc252_7d_fg * bestand_menge_fg::BYTEINT AS max_kapa_filter -- new content

FROM dbp_msi_v_view.v_vis_tag_fwws_art_1  fwws -- Wrong on ENTW

 -- Exception 252 (7d offset)
LEFT JOIN dbp_view.v_ausnahme_1  exc7d
ON (fwws.dat - 7) = exc7d.dat_plan
AND fwws.mandant_id = exc7d.mandant_id AND fwws.wup_id = exc7d.wup_id AND fwws.art_id = exc7d.art_id
AND exc7d.pruef_id IN (252) AND exc7d.z_arbeitsgebiet_id = 0

 -- Exception 252 (no offset)
LEFT JOIN dbp_view.v_ausnahme_1  exc
ON fwws.dat = exc.dat_plan
AND fwws.mandant_id = exc.mandant_id AND fwws.wup_id = exc.wup_id AND fwws.art_id = exc.art_id
AND exc.pruef_id IN (252) AND exc.z_arbeitsgebiet_id = 0

 -- Bestand (Menge)
LEFT JOIN dbp_view.v_marktbestand_erp_1  mbe
ON fwws.dat = mbe.dat
AND fwws.mandant_id = mbe.mandant_id AND fwws.wup_id = mbe.wup_id AND fwws.art_id = mbe.art_id
AND mbe.menge_lgbest_erp_frei_bme > 0

INNER JOIN dbp_view.v_wup_1 wup_1
ON fwws.mandant_id = wup.mandant_id AND fwws.wup_id = wup.wup_id
;
