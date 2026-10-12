CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.mv_besch_lief
-- 2021-10-06, AP0103346, SPEC0124027, dknop, initial, copy from LIS
-- 2021-10-18, dknop, formatting adjustments
AS
SELECT
 v01.dat_lief_soll
,CASE WHEN TRY_CAST(v01.kunde_id AS INTEGER) = 0 THEN NULL
ELSE TRY_CAST(v01.kunde_id AS INTEGER) END AS kunde_id
,CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id
 ELSE v01.mandant_id_kunde END AS mandant_id_kunde
,v01.lief_beleg_id
,CAST(v01.lief_pal_typ_id AS CHAR(2)) AS lief_pal_typ_id
,v01.lief_typ_id
,v01.mandant_id
,v01.nb_id
,v01.verkaufsorganisation_id
,v01.versandstelle_id
,v01.vertr_beleg_typ_id
,v01.wup_id
,v01.kj
,CASE WHEN TRY_CAST(v01.auftraggeber_id AS INTEGER) = 0 THEN NULL
 ELSE Cast(TRY_CAST(v01.auftraggeber_id AS INTEGER) AS VARCHAR (10)) END AS auftraggeber_id
,v01.anzahl_packstueck
,v01.werbeware_id
,v01.cd_kz
,v01.wup_id_cd
,v01.lagernummer_id
,v01.wg_verkett_fg
,v01.wg_verkett_lief
,v01.gp_id
,v01.we_status_id
,v02. wup_id AS vz_wup_id
--Damit das Attribut Verteilzentrum auch ein nb_id bekommt
,-111 AS vz_nb_id
--v01.dat_aktion
FROM dbp_view.v_besch_lief v01
LEFT JOIN dbp_view.v_l_lagernummer v02
ON v01.mandant_id = v02.mandant_id
AND v01.lagernummer_id = v02.lagernummer_id
;