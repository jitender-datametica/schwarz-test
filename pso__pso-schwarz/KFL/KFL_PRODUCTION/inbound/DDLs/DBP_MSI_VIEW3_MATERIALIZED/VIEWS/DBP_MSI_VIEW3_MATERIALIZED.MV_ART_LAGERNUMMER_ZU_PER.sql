create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ART_LAGERNUMMER_ZU_PER(
	MANDANT_ID,
	LAGERNUMMER_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	LAGER_BEREICH_KZ,
	EINLAGER_TYP_KZ,
	LAGER_EINHEITEN_TYP,
	KAPAZITAET_VERBRAUCH,
	DAT
) as
  -- 2022-07-14, AP0125093, SPEC0155049, dknop, filtering out EWM lagernummer
  -- 2022-08-01, AP0125093, SPEC0155049, dknop, correction of filter

   SELECT
    v01.mandant_id
   ,v01.lagernummer_id
   ,v01.art_id
   ,v01.wup_id
   ,v01.nb_id
   ,v01.lager_bereich_kz
   ,v01.einlager_typ_kz
   ,v01.lager_einheiten_typ
   ,v01.kapazitaet_verbrauch
   ,v02.dat
    FROM dbp_view.v_art_lagernummer_zu_per v01

LEFT JOIN (SELECT mandant_id, wup_id, nb_id, lagernummer_id, MIN(dat) AS dat FROM dbp_msi_data.ts_lagerort_ewm_dat GROUP BY mandant_id, wup_id, nb_id, lagernummer_id) v03
ON v01.mandant_id = v03.mandant_id
 AND v01.wup_id = v03.wup_id
 AND v01.nb_id = v03.nb_id
 AND v01.lagernummer_id = v03.lagernummer_id

JOIN dbp_view.v_tag v02
ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
AND v02.dat < COALESCE(v03.dat, CAST ('9999-12-31' AS DATE))

WHERE -- EWM Lagernummern ausfiltern! - Erweiterung mit jedem Go-Live erforderlich!
  ( v03.mandant_id IS NULL OR NOT  v02.dat >= v03.dat);